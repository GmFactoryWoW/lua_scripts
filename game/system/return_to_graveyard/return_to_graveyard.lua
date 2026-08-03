-- ============================================================================
-- RETURN TO GRAVEYARD - SERVER
-- AzerothCore + mod-ale
-- ============================================================================

local ReturnToGraveyard = {}

ReturnToGraveyard.Addon = {
    Prefix = "ReturnToGraveyard",
    Functions = {
        [1] = "OnClientRequestReturnToGraveyard",
    }
}

local REQUEST_COOLDOWN_SECONDS = 2
local LastRequestTime = {}

local function Error(message, ...)
    local ok, formatted = pcall(string.format, message, ...)
    print("[ReturnToGraveyard][ERROR] " .. (ok and formatted or tostring(message)))
end

local function SendResponse(player, success, message)
    if not player or not player.SendServerResponse then
        return false
    end

    player:SendServerResponse(
        ReturnToGraveyard.Addon.Prefix,
        1,
        success and 1 or 0,
        message or ""
    )

    return true
end

local function GetPlayerGuidLow(player)
    return player and player.GetGUIDLow and player:GetGUIDLow() or nil
end

local function IsPlayerGhost(player)
    return player
        and player.GetCorpse
        and player:GetCorpse() ~= nil
end

local function IsRateLimited(player)
    local guid = GetPlayerGuidLow(player)

    if not guid then
        return true
    end

    local now = os.time()
    local previous = LastRequestTime[guid]

    if previous and now - previous < REQUEST_COOLDOWN_SECONDS then
        return true
    end

    LastRequestTime[guid] = now
    return false
end

local function CallRepopAtGraveyard(player)
    if type(player.RepopAtGraveyard) ~= "function" then
        return false, "Le binding ALE player:RepopAtGraveyard() n'existe pas."
    end

    local ok, result = pcall(function()
        return player:RepopAtGraveyard()
    end)

    if not ok then
        return false, tostring(result)
    end

    return true, "Téléportation effectuée."
end

function OnClientRequestReturnToGraveyard(player)
    if not player then
        return false
    end

    if IsRateLimited(player) then
        SendResponse(player, false, "Veuillez patienter avant de réessayer.")
        return false
    end

    if not IsPlayerGhost(player) then
        SendResponse(player, false, "Le personnage n'est pas un fantôme.")
        return false
    end

    local success, message = CallRepopAtGraveyard(player)

    if not success then
        Error("%s", message)
        SendResponse(player, false, message)
        return false
    end

    SendResponse(player, true, message)
    return true
end

if type(RegisterClientRequests) == "function" then
    RegisterClientRequests(ReturnToGraveyard.Addon)
else
    Error("RegisterClientRequests n'existe pas.")
end

print("[ReturnToGraveyard] Module loaded")

return ReturnToGraveyard