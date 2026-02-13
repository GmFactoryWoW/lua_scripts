DROP TABLE IF EXISTS `characters_data`;

CREATE TABLE `characters_data` (
  `guid` int NOT NULL,
  `flags` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
