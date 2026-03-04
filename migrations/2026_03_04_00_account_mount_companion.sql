ALTER TABLE `account_companion` DROP PRIMARY KEY, ADD PRIMARY KEY (`account_id`, `companion`);
ALTER TABLE `account_mount` DROP PRIMARY KEY, ADD PRIMARY KEY (`account_id`, `mount`);
