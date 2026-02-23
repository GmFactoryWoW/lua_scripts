module "Game", package.seeall
export ObjectMgrConstant

ObjectMgrConstant = {
    QUERY: {
        PLAYER_FLAGS: {
            DELETE: "DELETE FROM `acore_ale`.`characters_data` WHERE `guid` = %d;"
            SELECT: "SELECT `flags` FROM `acore_ale`.`characters_data` WHERE `guid` = %d;"
            INSERT: "INSERT INTO `acore_ale`.`characters_data` VALUES (%d, %d) ON DUPLICATE KEY UPDATE `flags` = %d;"
        }
        ACCOUNT_MOUNT: {
            SELECT: "SELECT `mount` FROM `acore_ale`.`account_mount` WHERE account_id = %d;"
            INSERT: "INSERT IGNORE INTO `acore_ale`.`account_mount` VALUES (%d, %d);"
        }
        ACCOUNT_COMPANION: {
            SELECT: "SELECT `companion` FROM `acore_ale`.`account_companion` WHERE account_id = %d;"
            INSERT: "INSERT IGNORE INTO `acore_ale`.`account_companion` VALUES (%d, %d);"
        }
    }
}
