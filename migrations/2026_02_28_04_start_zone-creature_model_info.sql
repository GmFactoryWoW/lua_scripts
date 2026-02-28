DELETE FROM `creature_model_info` WHERE `DisplayID` IN(100140, 100160);
INSERT INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `Gender`, `DisplayID_Other_Gender`, `VerifiedBuild`, `scale`, `model_id`) VALUES
(100140, 0, 0, 2, 0, NULL, NULL, NULL),
(100160, 0, 0, 2, 0, NULL, NULL, NULL);
