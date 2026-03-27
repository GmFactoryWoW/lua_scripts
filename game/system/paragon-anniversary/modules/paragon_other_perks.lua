--[[
    @module paragon_other_perks
    @author Paragon Team
    @license AGL v3
]]

local Config = require("paragon_config")
local Constants = require("paragon_constant")

local function OnPlayerLootMoney(event, player, amount)
    local has_aura = player:HasAura(Constants.STATISTICS.AURA.GOLD)
    if (has_aura) then
        local aura = player:GetAura(Constants.STATISTICS.AURA.GOLD)
        if (not aura) then return false end

        local stack_amount = aura:GetStackAmount()
        local bonus_amount = amount * (stack_amount / 100)
        if (bonus_amount > 0.99) then
            player:ModifyMoney(bonus_amount)
        end
    end
end
RegisterPlayerEvent(37, OnPlayerLootMoney)

print("[Paragon] Paragon Anniversary Perks bonus module loaded")
