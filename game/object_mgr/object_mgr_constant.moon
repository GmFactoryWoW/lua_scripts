module "Game", package.seeall
export ObjectMgrConstant

ObjectMgrConstant = {
    QUERY: {
        PLAYER_FLAGS: {
            DELETE: "DELETE FROM `335_prod_ale`.`characters_data` WHERE `guid` = %d;"
            SELECT: "SELECT `flags` FROM `335_prod_ale`.`characters_data` WHERE `guid` = %d;"
            INSERT: "INSERT INTO `335_prod_ale`.`characters_data` VALUES (%d, %d) ON DUPLICATE KEY UPDATE `flags` = %d;"
        }
        ACCOUNT_MOUNT: {
            SELECT: "SELECT `mount` FROM `335_prod_ale`.`account_mount` WHERE account_id = %d;"
            INSERT: "INSERT IGNORE INTO `335_prod_ale`.`account_mount` VALUES (%d, %d);"
        }
        ACCOUNT_COMPANION: {
            SELECT: "SELECT `companion` FROM `335_prod_ale`.`account_companion` WHERE account_id = %d;"
            INSERT: "INSERT IGNORE INTO `335_prod_ale`.`account_companion` VALUES (%d, %d);"
        }
    }
}
