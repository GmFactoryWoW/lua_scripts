DROP TABLE IF EXISTS `account_mount`;

CREATE TABLE `account_mount` (
  `account_id` int NOT NULL,
  `mount` int NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
