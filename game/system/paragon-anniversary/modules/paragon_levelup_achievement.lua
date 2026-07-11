--[[
    Paragon Level-Up Achievement Module

    Provides automatic achievement assignment when players gain Paragon levels
    and when their Paragon data is loaded at login.

    Features:
    - Assigns achievements for Paragon levels at specific intervals:
        * Every 10 levels up to level 100
        * Every 25 levels from 125 to 500
    - Grants missing achievements when the player logs in
    - Grants all missed achievements when multiple levels are gained at once
    - Ensures each achievement is granted only once
    - Uses O(1) lookup for achievements via a table

    Architecture:
    - _InitAchievementTable: Generates the achievement table with appropriate intervals
    - AssignMissingAchievements: Grants every missing achievement reached by the player
    - OnParagonLevelChanged: Checks achievements when the Paragon level increases
    - OnPlayerStatLoad: Checks achievements when Paragon data is loaded at login

    Registered mediator events:
    - OnParagonLevelChanged: Reacts to Paragon level changes
    - OnPlayerStatLoad: Reacts to Paragon data loading during login

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

--- Initializes the achievement table for Paragon levels.
--- Levels 10..100 -> every 10.
--- Levels 125..500 -> every 25.
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

_InitAchievementTable()

-- ============================================================================
-- ACHIEVEMENT ASSIGNMENT
-- ============================================================================

--- Grants every missing achievement reached by the player's Paragon level.
---
--- @param player Player The player receiving the achievements
--- @param paragon_level number Current Paragon level
local function AssignMissingAchievements(player, paragon_level)
    for level = 10, 100, 10 do
        local achievementID = Achievements[level]

        if paragon_level >= level
            and achievementID
            and not player:HasAchieved(achievementID)
        then
            player:SetAchievement(achievementID)
        end
    end

    for level = 125, 500, 25 do
        local achievementID = Achievements[level]

        if paragon_level >= level
            and achievementID
            and not player:HasAchieved(achievementID)
        then
            player:SetAchievement(achievementID)
        end
    end
end

-- ============================================================================
-- PARAGON LEVEL-UP HANDLER
-- ============================================================================

--- Handles Paragon level changes and assigns missing achievements.
---
--- When a player gains Paragon levels, this function checks all milestone-based
--- achievements and grants any that have been reached but not yet unlocked.
---
--- @param player Player The player object that leveled up
--- @param _ Paragon The Paragon instance
--- @param old_level number Previous Paragon level
--- @param new_level number New Paragon level
local function OnParagonLevelChanged(player, _, old_level, new_level)
    if new_level > old_level then
        AssignMissingAchievements(player, new_level)
    end
end

-- ============================================================================
-- PLAYER LOGIN HANDLER
-- ============================================================================

--- Checks and grants missing Paragon achievements when player data is loaded.
---
--- This event is triggered after the player's Paragon data has been loaded
--- during login, ensuring that all achievements corresponding to the current
--- Paragon level are present.
---
--- @param player Player The connected player
--- @param paragon Paragon The loaded Paragon instance
--- @return Paragon The unchanged Paragon instance
local function OnPlayerStatLoad(player, paragon)
    AssignMissingAchievements(player, paragon:GetLevel())

    return paragon
end

-- ============================================================================
-- EVENT REGISTRATION
-- ============================================================================

Mediator.Register("OnParagonLevelChanged", OnParagonLevelChanged)
Mediator.Register("OnPlayerStatLoad", OnPlayerStatLoad)

-- ============================================================================
-- MODULE INITIALIZATION
-- ============================================================================

print("[Paragon] Paragon Anniversary Level Achievements module loaded")