--[[
    Paragon Level-Up Achievement Module

    Provides automatic achievement assignment when players gain Paragon levels.

    Features:
    - Assigns achievements for Paragon levels at specific intervals:
        * Every 10 levels up to level 100
        * Every 25 levels from 125 to 500
    - Ensures each achievement is granted only once
    - Uses O(1) lookup for achievements via a table

    Architecture:
    - _InitAchievementTable: Generates the achievement table with appropriate intervals
    - OnParagonLevelChanged: Assigns achievement when player levels up

    Registered mediator events:
    - OnParagonLevelChanged: Reacts to Paragon level changes

    @module paragon_levelup_achievements
    @author Paragon Team
    @license AGL v3
]]

local Config = require("paragon_config")
local Constants = require("paragon_constant")

local sf = string.format

local Achievements = {}
local BASE_ACHIEVEMENT_ID = 5000

-- ============================================================================
-- ACHIEVEMENT TABLE INITIALIZATION
-- ============================================================================

--- Initializes the achievement table for Paragon levels
--- Levels 10..100 -> every 10
--- Levels 125..500 -> every 25
local function _InitAchievementTable()
    local achievementID = BASE_ACHIEVEMENT_ID

    for level = 10, 100, 10 do
        Achievements[level] = achievementID
        achievementID = achievementID + 1
    end

    for level = 125, 500, 25 do
        Achievements[level] = achievementID
        achievementID = achievementID + 1
    end
end

-- Initialize table at module load
_InitAchievementTable()

-- ============================================================================
-- PARAGON LEVEL-UP HANDLER
-- ============================================================================

--- Handles Paragon level changes and assigns achievements.
---
--- When a player gains Paragon levels, this function checks for milestone-based
--- achievements and grants any that have been reached but not yet unlocked.
---
--- This ensures that if a player skips levels (e.g., gains multiple levels at once),
--- all missed milestone achievements are still granted.
---
--- Mediator Event: OnParagonLevelChanged
---
--- @param player Player The player object that leveled up
--- @param _ Paragon The paragon instance (unused)
--- @param old_level number Previous Paragon level
--- @param new_level number New Paragon level
local function OnParagonLevelChanged(player, _, old_level, new_level)
    if new_level > old_level then
        for level = 10, 100, 10 do
            if new_level >= level and Achievements[new_level] and and not player:HasAchieved(Achievements[level]) then
                player:SetAchievement(Achievements[level])
            end
        end

        for level = 125, 500, 25 do
            if new_level >= level and Achievements[new_level] and and not player:HasAchieved(Achievements[level]) then
                player:SetAchievement(Achievements[level])
            end
        end
    end
end

-- Register for Paragon level change events
Mediator.Register("OnParagonLevelChanged", OnParagonLevelChanged)

-- ============================================================================
-- MODULE INITIALIZATION
-- ============================================================================

print("[Paragon] Paragon Anniversary Level Achievements module loaded")