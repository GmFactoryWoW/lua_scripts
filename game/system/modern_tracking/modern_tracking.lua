-- ============================================================================
-- MODULE CONFIGURATION
-- ============================================================================

local Tracking = {}

Tracking.Addon = {
    Prefix = "Tracking",
    Functions = {
        [1] = "OnTrackingClientRequestHasAura",
    }
}

-- ============================================================================
-- HELPERS
-- ============================================================================

local function ToNumber(value, fallback)
    local number = tonumber(value)

    if number == nil then
        return fallback or 0
    end

    return number
end

local function BoolToNumber(value)
    if value then
        return 1
    end

    return 0
end

local function Send(player, responseId, ...)
    if not player then
        return false
    end

    player:SendServerResponse(Tracking.Addon.Prefix, responseId, ...)
    return true
end

-- ============================================================================
-- CLIENT REQUEST HANDLERS
-- ============================================================================

function OnTrackingClientRequestHasAura(player, arg_table)
    if not player then
        return false
    end

    if type(arg_table) ~= "table" then
        Send(player, 1, 0, 0)
        return false
    end

    local spellId = ToNumber(arg_table[1], 0)

    if spellId <= 0 then
        Send(player, 1, 0, 0)
        return false
    end

    local hasAura = player:HasAura(spellId)

    Send(
        player,
        1,
        spellId,
        BoolToNumber(hasAura)
    )

    return true
end

-- ============================================================================
-- INITIALIZATION
-- ============================================================================

RegisterClientRequests(Tracking.Addon)

print("[Tracking] Tracking module loaded")

return Tracking