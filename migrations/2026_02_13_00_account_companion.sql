DROP TABLE IF EXISTS `account_companion`;

CREATE TABLE `account_companion` (
  `account_id` int NOT NULL,
  `companion` int NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
