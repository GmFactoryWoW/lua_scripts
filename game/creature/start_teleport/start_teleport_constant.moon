module "Game", package.seeall
export StartTeleportConstant

StartTeleportConstant = {
    RACE: {
        ALLIANCE: {
            [1]: true
            [3]: true
            [4]: true
            [7]: true
            [11]: true
        }
        HORDE: {
            [2]: true
            [5]: true
            [6]: true
            [8]: true
            [10]: true
        }
        MASK: {
            ALLIANCE: 1101
            HORDE: 690
        }
    }

    SHARED_SPAWNS: { [7]: 3, [8]: 2 },

    QUERY: {
        SELECT: "SELECT `race`, `map`, `position_x`, `position_y`, `position_z`, `orientation` FROM `playercreateinfo` WHERE `class` = 1 || `class` = 2 GROUP BY `race`;"
    }

    NPC_ENTRY: { ALLIANCE: 197, HORDE: 10176 }
}
