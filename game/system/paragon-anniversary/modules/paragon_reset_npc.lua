--[[
    Paragon Anniversary Reset NPC
]]

local Config = require("paragon_config")
local Repository = require("paragon_repository")
local ParagonHook = require("paragon_hook")

local ResetNpc = {}

local GOSSIP_ICON_CHAT = 0
local GOSSIP_SENDER_MAIN = 0
local GOSSIP_ACTION_RESET = 1

local ADDON_PREFIX = "ParagonAnniversary"

local function OnAfterMigrationExecute(_)
    -- Insert default spell ID for level-up animation (Spell ID: 64785)
    CharDBExecute(sf(
        "INSERT IGNORE INTO %s.paragon_config (field, value) VALUES ('PARAGON_RESET_NPC_ENTRY', '64785');",
        Constants.DB_NAME
    ))
end

local function GetResetNpcEntry()
    return tonumber(Config:GetByField("PARAGON_RESET_NPC_ENTRY")) or 0
end

local function SyncClient(player, paragon)
    player:SendServerResponse(ADDON_PREFIX, 4, paragon:GetPoints())

    local categories = Config:GetCategories()
    if categories then
        for category_id, category in pairs(categories) do
            if category.statistics then
                for stat_id, _ in pairs(category.statistics) do
                    player:SendServerResponse(ADDON_PREFIX, 5, {
                        id = stat_id,
                        value = paragon:GetStatValue(stat_id),
                        category = category_id
                    })
                end
            end
        end
    end
end

local function ResetParagonPoints(player)
    local paragon = player:GetData("Paragon")
    if not paragon then
        player:SendBroadcastMessage("Vos données Paragon ne sont pas encore chargées.")
        return false
    end

    -- Retire les bonus actuellement appliqués.
    if ParagonHook.UpdatePlayerStatistics then
        ParagonHook.UpdatePlayerStatistics(player, paragon, false)
    end

    -- Reset mémoire + BDD.
    paragon:ResetStatistics()
    Repository:DeleteParagonCharacterStats(paragon:GetGuid())

    -- Sauvegarde l'état propre.
    paragon:Save()
    player:SetData("Paragon", paragon)

    -- Réapplique l'état vide, puis resynchronise le client.
    if ParagonHook.UpdatePlayerStatistics then
        ParagonHook.UpdatePlayerStatistics(player, paragon, true)
    end

    SyncClient(player, paragon)

    player:SendBroadcastMessage("Vos points Paragon Anniversary ont été réinitialisés.")
    return true
end

function ResetNpc.OnGossipHello(event, player, creature)
    player:GossipClearMenu()
    player:GossipMenuAddItem(
        GOSSIP_ICON_CHAT,
        "Je souhaite réinitialiser mes points Paragon Anniversary",
        GOSSIP_SENDER_MAIN,
        GOSSIP_ACTION_RESET
    )
    player:GossipSendMenu(1, creature)
end

function ResetNpc.OnGossipSelect(event, player, creature, sender, intid, code, menu_id)
    if intid == GOSSIP_ACTION_RESET then
        ResetParagonPoints(player)
    end

    player:GossipComplete()
end

local npc_entry = GetResetNpcEntry()
if npc_entry > 0 then
    RegisterCreatureGossipEvent(npc_entry, 1, ResetNpc.OnGossipHello)
    RegisterCreatureGossipEvent(npc_entry, 2, ResetNpc.OnGossipSelect)
end

return ResetNpc