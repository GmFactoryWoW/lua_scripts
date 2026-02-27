DROP TABLE IF EXISTS `account_currency`;

CREATE TABLE `account_currency`(
    `account` INT NOT NULL,
    `currency` INT NOT NULL,
    `count` INT NOT NULL DEFAULT 0,
    PRIMARY KEY (`account`, `currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;