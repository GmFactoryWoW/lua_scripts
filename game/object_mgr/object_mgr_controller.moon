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