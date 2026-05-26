DELETE FROM `creature_template_model` WHERE `CreatureID` IN(600000, 600001);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(600000, 0, 100140, 1, 1, NULL),
(600001, 0, 100160, 1, 1, NULL);
