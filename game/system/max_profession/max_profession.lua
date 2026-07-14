-- ============================================================================
-- MODULE CONFIGURATION
-- ============================================================================

local Professions = {}

Professions.Addon = {
    Prefix = "Professions",
    Functions = {
        [1] = "OnClientRequestMaxPrimaryTradeSkill",
    }
}

-- ============================================================================
-- HELPERS
-- ============================================================================

local function Send(player, responseId, ...)
    if not player then
        return false
    end

    player:SendServerResponse(Professions.Addon.Prefix, responseId, ...)
    return true
end

-- ============================================================================
-- CLIENT REQUEST HANDLERS
-- ============================================================================

function OnClientRequestMaxPrimaryTradeSkill(player, arg_table)
    if not player then
        return false
    end

    local maxProfessions = tonumber(GetConfigValue("MaxPrimaryTradeSkill")) or 2

    Send(player, 1, maxProfessions)

    return true
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================

RegisterClientRequests(Professions.Addon)

print("[Professions] Module loaded")

return Professions