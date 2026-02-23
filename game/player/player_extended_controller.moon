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
        return

    -- Companion : MiscValueB == 41 + Effect 28
    effect_misc_value_b = spell_info\GetEffectMiscValueB 0
    if effect_misc_value_b == 41 and spell_info\HasEffect(28)
        unless account\HasCompanion spell_id
            account\AddCompanion spell_id
        return
RegisterPlayerEvent 44, OnLearnSpell

--- Reloads PlayerExtended for all online players on Lua state open.
--- @param event number Event ID (33 = SERVER_EVENT_ON_LUA_STATE_OPEN)
OnLuaStateOpen = (event) ->
    Game.StartTeleport.GetInstance!

    for _, player in pairs(GetPlayersInWorld!)
        OnPlayerLogin 3, player
RegisterServerEvent 33, OnLuaStateOpen

--- Saves PlayerExtended for all online players on Lua state close.
--- @param event number Event ID (16 = SERVER_EVENT_ON_LUA_STATE_CLOSE)
OnLuaStateClose = (event) ->
    for _, player in pairs(GetPlayersInWorld!)
        OnPlayerLogout 4, player
RegisterServerEvent 16, OnLuaStateClose
