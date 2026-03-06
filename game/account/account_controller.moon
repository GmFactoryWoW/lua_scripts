OnMediatorPlayerReady = (player) ->
    account = player\GetAccount!
    return unless account

    for companion, _ in pairs account\GetCompanions!
        unless player\HasSpell companion
            player\LearnSpell companion

    for mount, _ in pairs account\GetMounts!
        unless player\HasSpell mount
            skill_value = player\GetSkillValue 762
            OnPlayerUpdateSkill 62, player, 762, skill_value, skill_value, 0, skill_value

    for currency_key, count in pairs account\GetCurrencies!
        switch currency_key
            when Game.ObjectMgrConstant.ENUM.CURRENCY_TYPE.HONOR
                player\SetHonorPoints count
            when Game.ObjectMgrConstant.ENUM.CURRENCY_TYPE.ARENA
                player\SetArenaPoints count
            when Game.ObjectMgrConstant.ENUM.CURRENCY_TYPE.GOLD
                player\SetCoinage count
            else
                player\AddItem currency_key, count, false
Mediator.Register "player:ready", OnMediatorPlayerReady

OnMediatorPlayerBeforeLogout = (player) ->
    account = player\GetAccount!
    return unless account

    ObjectMgr = Game.ObjectMgr.GetInstance!

    account\SetCurrency Game.ObjectMgrConstant.ENUM.CURRENCY_TYPE.HONOR, player\GetHonorPoints!
    account\SetCurrency Game.ObjectMgrConstant.ENUM.CURRENCY_TYPE.ARENA, player\GetArenaPoints!
    account\SetCurrency Game.ObjectMgrConstant.ENUM.CURRENCY_TYPE.GOLD, player\GetCoinage!

    currency_list = ObjectMgr\GetCurrencyList!
    if currency_list
        for currency_id, _ in pairs(currency_list)
            if player\HasItem currency_id
                count = player\GetItemCount currency_id
                account\SetCurrency currency_id, count
                player\RemoveItem currency_id, count
Mediator.Register "player:before_logout", OnMediatorPlayerBeforeLogout

OnMediatorCanAddMount = (player, spell_id) ->
    account = player\GetAccount!
    return unless account

    unless account\HasMount spell_id
        account\AddMount spell_id
Mediator.Register "player:can_add_mount", OnMediatorCanAddMount

OnMediatorCanAddCompanion = (player, spell_id) ->
    account = player\GetAccount!
    return unless account

    unless account\HasCompanion spell_id
        account\AddCompanion spell_id
Mediator.Register "player:can_add_companion", OnMediatorCanAddCompanion

OnMediatorCanLearnMount = (player, new_value, sorted_mounts) ->
    account = player\GetAccount!
    return unless account
    for _, mount in pairs(sorted_mounts)
        if mount.RequiredSkillRank <= new_value and (account\HasMount(mount.Spell))
            unless player\HasSpell mount.Spell
                player\LearnSpell(mount.Spell)
Mediator.Register "player:can_learn_mount", OnMediatorCanLearnMount