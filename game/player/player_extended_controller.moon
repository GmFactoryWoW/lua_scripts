--- Handles PlayerExtended lifecycle: login, logout, character deletion,
--- spell learning (mounts/companions), and server reload events.
--- Publishes Mediator events: "player:ready", "player:logout".

--- Loads PlayerExtended data asynchronously on player login.
--- Publishes "player:ready" once all data is available.
--- @param event number Event ID (3 = PLAYER_EVENT_ON_LOGIN)
--- @param player Player The player logging in
export OnPlayerLogin = (event, player) ->
    guid_low = player\GetGUIDLow!
    account_id = player\GetAccountId!

    Game.PlayerExtended guid_low, account_id, (player_extended) ->
        player_guid = GetPlayerGUID guid_low
        return unless player_guid

        pobject = GetPlayerByGUID player_guid
        return unless pobject

        pobject\SetData "PlayerExtended", player_extended
        Mediator.On "player:ready", { arguments: { pobject } }
RegisterPlayerEvent 3, OnPlayerLogin

--- Saves PlayerExtended data and cleans up on player logout.
--- Publishes "player:logout" before saving.
--- @param event number Event ID (4 = PLAYER_EVENT_ON_LOGOUT)
--- @param player Player The player logging out
export OnPlayerLogout = (event, player) ->
    Mediator.On "player:logout", { arguments: { player } }
    player\Save!
RegisterPlayerEvent 4, OnPlayerLogout

--- Saves account currencies and removes them from inventory before logout.
--- Publishes "player:before_logout" before saving.
--- @param event number Event ID (74 = PLAYER_EVENT_ON_BEFORE_LOGOUT)
--- @param player Player The player about to log out
export OnPlayerBeforeLogout = (event, player) ->
    Mediator.On "player:before_logout", { arguments: { player } }
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
OnPlayerLearnSpell = (event, player, spell_id) ->
    Mediator.On "player:learn_spell", { arguments: { player, spell_id } }

    spell_info = GetSpellInfo spell_id
    return unless spell_info

    -- Mount : Speed aura (32) + Mount aura (78)
    if spell_info\HasAura(32) and spell_info\HasAura(78)
        Mediator.On "player:can_add_mount", { arguments: { player, spell_id } }
        return

    -- Companion : MiscValueB == 41 + Effect 28
    effect_misc_value_b = spell_info\GetEffectMiscValueB 0
    if effect_misc_value_b == 41 and spell_info\HasEffect 28
        Mediator.On "player:can_add_companion", { arguments: { player, spell_id } }
        return
RegisterPlayerEvent 44, OnPlayerLearnSpell

--- Automatically learns mounts when the required skill rank is reached.
--- Checks for skill ID 762 (Riding) and compares new skill rank to mount requirements
--- @param event number Event ID (12 = PLAYER_EVENT_ON_UPDATE_SKILL)
--- @param player Player The player updating the skill
--- @param skill_id number The updated skill ID
--- @param value number The new skill value
--- @param max number The maximum skill value
--- @param step number The skill step (0-4)
--- @param new_value number The new skill value after the update
export OnPlayerUpdateSkill = (event, player, skill_id, value, max, step, new_value) ->
    Mediator.On "player:update_skill", { arguments: { player, skill_id, value, max, step, new_value } }

    return unless skill_id == 762
    ObjectMgr = Game.ObjectMgr.GetInstance!

    -- Sorted mounts by required skill rank, add newly available ones
    sorted_mounts = ObjectMgr\GetSorted(ObjectMgr\GetMountList! or {}, (a, b) -> a.RequiredSkillRank < b.RequiredSkillRank)
    Mediator.On "player:can_learn_mount", { arguments: { player, new_value, sorted_mounts } }
RegisterPlayerEvent 62, OnPlayerUpdateSkill
