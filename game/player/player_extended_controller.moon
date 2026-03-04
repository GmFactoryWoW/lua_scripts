--- Handles PlayerExtended lifecycle: login, logout, character deletion,
--- spell learning (mounts/companions), and server reload events.
--- Publishes Mediator events: "player:ready", "player:logout".

--- Loads PlayerExtended data asynchronously on player login.
--- Publishes "player:ready" once all data is available.
--- @param event number Event ID (3 = PLAYER_EVENT_ON_LOGIN)
--- @param player Player The player logging in
OnPlayerLogin = (event, player) ->
    guid_low = player\GetGUIDLow!
    account_id = player\GetAccountId!

    Game.PlayerExtended guid_low, account_id, (player_extended) ->
        player_guid = GetPlayerGUID guid_low
        return unless player_guid

        pobject = GetPlayerByGUID player_guid
        return unless pobject

        pobject\SetData "PlayerExtended", player_extended
        Mediator\On "player:ready", pobject

        account = pobject\GetAccount!
        return unless account

        for companion, _ in pairs(account\GetCompanions!)
            unless pobject\HasSpell companion
                pobject\LearnSpell companion

        for mount, _ in pairs(account\GetMounts!)
            unless pobject\HasSpell mount
                skill_value = pobject\GetSkillValue 762
                OnUpdateSkill 62, pobject, 762, skill_value, skill_value, 0, skill_value

        for currency, count in pairs(account\GetCurrencies!)
            unless pobject\HasItem currency
                pobject\AddItem currency, count
RegisterPlayerEvent 3, OnPlayerLogin

--- Saves PlayerExtended data and cleans up on player logout.
--- Publishes "player:logout" before saving.
--- @param event number Event ID (4 = PLAYER_EVENT_ON_LOGOUT)
--- @param player Player The player logging out
OnPlayerLogout = (event, player) ->
    Mediator\On "player:logout", player
    ext = player\GetData "PlayerExtended"
    if ext
        ext\Save!
        player\SetData "PlayerExtended", nil
RegisterPlayerEvent 4, OnPlayerLogout

--- Saves account currencies and removes them from inventory before logout.
--- Publishes "player:beforeLogout" before saving.
--- @param event number Event ID (74 = PLAYER_EVENT_ON_BEFORE_LOGOUT)
--- @param player Player The player about to log out
OnPlayerBeforeLogout = (event, player) ->
    Mediator\On "player:beforeLogout", player
    account = player\GetAccount!
    if account
        for currency_id, count in pairs(account\GetCurrencies!)
            if player\HasItem currency_id
                count = player\GetItemCount currency_id
                account\SetCurrency currency_id, count
                player\RemoveItem currency_id, count
RegisterPlayerEvent 74, OnPlayerBeforeLogout

--- Deletes persistent player flags when a character is deleted.
--- @param event number Event ID (2 = PLAYER_EVENT_ON_CHARACTER_DELETE)
--- @param guid number The deleted character's GUID
OnCharacterDelete = (event, guid) ->
    Game.ObjectMgr.GetInstance!\DeletePlayerFlags guid
RegisterPlayerEvent 2, OnCharacterDelete

--- Detects newly learned mounts and companions, adds them to account.
--- Mounts: identified by Speed aura (32) + Mount aura (78).
--- Companions: identified by EffectMiscValueB == 41 + Effect 28.
--- @param event number Event ID (44 = PLAYER_EVENT_ON_LEARN_SPELL)
--- @param player Player The player learning the spell
--- @param spell_id number The learned spell ID
OnLearnSpell = (event, player, spell_id) ->
    ext = player\GetData "PlayerExtended"
    return unless ext

    account = ext\GetAccount!
    return unless account

    spell_info = GetSpellInfo spell_id
    return unless spell_info

    -- Mount : Speed aura (32) + Mount aura (78)
    if spell_info\HasAura(32) and spell_info\HasAura(78)
        unless account\HasMount spell_id
            account\AddMount spell_id

    -- Companion : MiscValueB == 41 + Effect 28
    effect_misc_value_b = spell_info\GetEffectMiscValueB 0
    print effect_misc_value_b == 41 and spell_info\HasEffect 28
    if effect_misc_value_b == 41 and spell_info\HasEffect 28
        unless account\HasCompanion spell_id
            account\AddCompanion spell_id
RegisterPlayerEvent 44, OnLearnSpell

--- Automatically learns mounts when the required skill rank is reached.
--- Checks for skill ID 762 (Riding) and compares new skill rank to mount requirements
--- @param event number Event ID (12 = PLAYER_EVENT_ON_UPDATE_SKILL)
--- @param player Player The player updating the skill
--- @param skill_id number The updated skill ID
--- @param value number The new skill value
--- @param max number The maximum skill value
--- @param step number The skill step (0-4)
--- @param new_value number The new skill value after the update
OnUpdateSkill = (event, player, skill_id, value, max, step, new_value) ->
    return unless skill_id == 762
    ext = player\GetData "PlayerExtended"
    return unless ext

    account = ext\GetAccount!
    return unless account

    ObjectMgr = Game.ObjectMgr.GetInstance!

    -- Sorted mounts by required skill rank, add newly available ones
    sorted_mounts = ObjectMgr\GetSorted(ObjectMgr\GetMountList! or {}, (a, b) -> a.RequiredSkillRank < b.RequiredSkillRank)
    for _, mount in pairs(sorted_mounts)
        if mount.RequiredSkillRank <= new_value and not player:HasMount(mount.Spell)
            player\LearnSpell(mount.Spell)
RegisterPlayerEvent 62, OnUpdateSkill

--- Reloads PlayerExtended for all online players on Lua state open.
--- @param event number Event ID (33 = SERVER_EVENT_ON_LUA_STATE_OPEN)
OnLuaStateOpen = (event) ->
    Game.StartTeleport.GetInstance!
    ObjectMgr = Game.ObjectMgr.GetInstance!

    ObjectMgr\LoadCurrencyItems!
    ObjectMgr\MapMountItems!

    for _, player in pairs(GetPlayersInWorld!)
        OnPlayerLogin 3, player
RegisterServerEvent 33, OnLuaStateOpen

--- Saves PlayerExtended for all online players on Lua state close.
--- @param event number Event ID (16 = SERVER_EVENT_ON_LUA_STATE_CLOSE)
OnLuaStateClose = (event) ->
    for _, player in pairs(GetPlayersInWorld!)
        OnPlayerBeforeLogout 74, player
        OnPlayerLogout 4, player
RegisterServerEvent 16, OnLuaStateClose
