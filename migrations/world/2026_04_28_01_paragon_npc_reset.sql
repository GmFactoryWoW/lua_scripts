DELETE FROM `creature_template` WHERE `entry` = 600002;
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `speed_swim`, `speed_flight`, `detection_range`, `rank`, `dmgschool`, `DamageModifier`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES
(600002, 0, 0, 0, 0, 0, 'Orakel des Échos', 'Purificateur des chemins Paragon', 'Interact', 0, 1, 1, 0, 35, 1, 1, 1.14286, 1, 1, 20, 0, 0, 1, 0, 0, 1, 1, 1, 6, 32768, 0, 0, 0, 1611661328, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 0, 0, 1, 0, '', NULL);

DELETE FROM `creature_template_model` WHERE `CreatureID` = 600002;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`) VALUES
(600002, 0, 18303, 1, 1, NULL);

DELETE FROM `creature` WHERE `id1` = 600002;
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`, `CreateObject`, `Comment`) VALUES
-- Hurlevent
(NULL, 600002, 0, 0, 0, 0, 0, 1, 1, 0, -8543.67, 565.977, 101.813, 0.861927, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', NULL, 0, NULL),
-- Forgefer
(NULL, 600002, 0, 0, 0, 0, 0, 1, 1, 0, -4616.92, -1073.72, 501.394, 3.27309, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', NULL, 0, NULL),
-- Darnassus
(NULL, 600002, 0, 0, 1, 0, 0, 1, 1, 0, 10126.5, 2515.39, 1289.76, 2.94447, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', NULL, 0, NULL),
-- Exodar
(NULL, 600002, 0, 0, 530, 0, 0, 1, 1, 0, -3863.61, -11396.5, -104.944, 0.442264, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', NULL, 0, NULL),
-- Orgrimmar
(NULL, 600002, 0, 0, 1, 0, 0, 1, 1, 0, 1798.48, -4305.09, -11.3459, 5.18287, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', NULL, 0, NULL),
-- Pitons du Tonnerre
(NULL, 600002, 0, 0, 1, 0, 0, 1, 1, 0, -1039.15, 223.164, 136.411, 5.50782, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', NULL, 0, NULL),
-- Fossoyeuse
(NULL, 600002, 0, 0, 0, 0, 0, 1, 1, 0, 1430.79, 377.495, -84.9804, 1.52858, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', NULL, 0, NULL),
-- Lune d'argent
(NULL, 600002, 0, 0, 530, 0, 0, 1, 1, 0, 9872.94, -7521.59, 19.7368, 1.77047, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', NULL, 0, NULL),
-- Shattrath
(NULL, 600002, 0, 0, 530, 0, 0, 1, 1, 0, -1623.21, 5477.99, -13.1737, 2.23287, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', NULL, 0, NULL),
-- Dalaran
(NULL, 600002, 0, 0, 571, 0, 0, 1, 1, 0, 5777.71, 571.271, 613.734, 1.80344, 300, 0, 0, 42, 0, 0, 0, 0, 0, '', NULL, 0, NULL);

DELETE FROM `npc_text` WHERE `ID` BETWEEN 600002 AND 600013;
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES
(600002, 'Les échos de tes choix résonnent encore à travers les trames du Paragon... mais rien n''est immuable.$B$BSi tu le souhaites, je peux purifier ton chemin, effacer les traces du passé et te permettre d''arpenter à nouveau ces voies selon ta volonté.$B$BRéfléchis bien... car une fois les échos dissipés, il te faudra tout reconstruire.', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
(600003, 'Les échos de tes choix sont encore trop faibles pour être altérés… ton chemin n’est pas encore pleinement tracé.$B$BReviens lorsque ton expérience aura renforcé les trames du Paragon. Alors, peut-être, pourrai-je intervenir.', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
-- Hurlevent
(600004, 'Vous cherchez à réinitialiser vos voies Paragon ? L''Orakel des Échos pourra vous aider.$B$BVous le trouverez dans la Ruelle du Coupe-gorge, dans le Quartier des nains.', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
-- Forgeger
(600005, 'Ah, vous voulez remettre vos voies Paragon à zéro ? L''Orakel des Échos s''occupe de ça.$B$BDirection la Caverne lugubre. Et faites attention où vous mettez les pieds.', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
-- Darnassus
(600006, 'Les voies que vous avez empruntées peuvent être réécrites, tout comme la nature suit son éternel cycle.$B$BL''Orakel des Échos veille au sein de l''Enclave cénarienne, au bas du chemin en spirale de l''arbre de l''ouest.$B$BAllez à sa rencontre si vous souhaitez redéfinir votre destinée.', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
-- Exodar
(600007, 'La Lumière nous enseigne que chaque chemin peut être purifié, et chaque erreur transcendée.$B$BL''Orakel des Échos vous attend dans le Hall de cristal de l''Exodar.$B$BAllez à lui, et laissez votre destinée être façonnée à nouveau.', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
-- Orgrimmar
(600008, 'Tu veux changer ta voie Paragon ? Alors fais-le sans hésiter.$B$BL''Orakel des Échos t''attend dans la Faille de l''ombre, à Orgrimmar.$B$BVa à lui... et forge ton destin à nouveau.', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
-- Pitons du Tonnerre
(600009, 'Les chemins que nous empruntons ne sont jamais figés… les esprits nous enseignent qu''il est toujours possible de retrouver l''équilibre.$B$BL''Orakel des Échos veille sur la Cime des Esprits, à Pitons du Tonnerre.$B$BVa à lui si tu souhaites redéfinir ta voie, et marche à nouveau en harmonie avec ton destin.', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
-- Fossoyeuse
(600010, 'Vous souhaitez altérer vos voies Paragon ? Intéressant… peu ont votre audace.$B$BL''Orakel des Échos poursuit ses travaux dans l''Apothicarium, sous Fossoyeuse.$B$BAllez à lui… et voyez ce qu''il reste de votre potentiel une fois disséqué.', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
-- Lune d'argent
(600011, 'La maîtrise de soi implique de savoir abandonner les voies imparfaites.$B$BL''Orakel des Échos vous attend sur la Place des Pérégrins, à Lune-d''argent.$B$BAllez à lui… et façonnez à nouveau votre puissance selon votre véritable potentiel.', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
-- Shattrath
(600012, 'À Shattrath, toutes les voies peuvent être réévaluées à la lumière de l''équilibre.$B$BL''Orakel des Échos se tient dans la Ville basse, sur le perchoir des Skettis.$B$BAllez à lui si vous souhaitez redéfinir votre chemin.', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL),
-- Dalaran
(600013, 'Même les plus grands arcanistes savent que certaines voies méritent d''être réécrites.$B$BL''Orakel des Échos officie dans les égouts de Dalaran, au sein du Cercle des volontés.$B$BSi vous cherchez à redéfinir votre maîtrise, allez à lui en toute connaissance de cause.', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL);

DELETE FROM `points_of_interest` WHERE `ID` BETWEEN 10000 AND 10009;
INSERT INTO `points_of_interest` (`ID`, `PositionX`, `PositionY`, `Icon`, `Flags`, `Importance`, `Name`) VALUES
-- Hurlevent
(10000, -8543.67, 565.97, 7, 99, 0, 'Purificateur des points Paragon'),
-- Forgefer
(10001, -4616.92, -1073.72, 7, 99, 0, 'Purificateur des points Paragon'),
-- Darnassus
(10002, 10126.5, 2515.39, 7, 99, 0, 'Purificateur des points Paragon'),
-- Exodar
(10003, -3863.61, -11396.5, 7, 99, 0, 'Purificateur des points Paragon'),
-- Orgrimmar
(10004, 1798.48, -4305.09, 7, 99, 0, 'Purificateur des points Paragon'),
-- Pitons du Tonnerre
(10005, -1039.15, 223.164, 7, 99, 0, 'Purificateur des points Paragon'),
-- Fossoyeuse
(10006, 1430.79, 377.495, 7, 99, 0, 'Purificateur des points Paragon'),
-- Lune d'argent
(10007, 9872.94, -7521.59, 7, 99, 0, 'Purificateur des points Paragon'),
-- Shattrath
(10008, -1623.21, 5477.99, 7, 99, 0, 'Purificateur des points Paragon'),
-- Dalaran
(10009, 5777.71, 571.271, 7, 99, 0, 'Purificateur des points Paragon');

DELETE FROM `gossip_menu` WHERE `MenuID` BETWEEN 600004 AND 600013;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
-- Hurlevent
(600004, 600004),
-- Forgefer
(600005, 600005),
-- Darnassus
(600006, 600006),
-- Exodar
(600007, 600007),
-- Orgrimmar
(600008, 600008),
-- Pitons du Tonnerre
(600009, 600009),
-- Fossoyeuse
(600010, 600010),
-- Lune d'argent
(600011, 600011),
-- Shattrath
(600012, 600012),
-- Dalaran
(600013, 600013);

DELETE FROM `gossip_menu_option` WHERE `ActionPoiID` BETWEEN 10000 AND 10009;
-- Hurlevent
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
SELECT
    ct.gossip_menu_id,
    COALESCE(MAX(gmo.OptionID), -1) + 1,
    0,
    'Purificateur des points Paragon',
    0,
    1,
    1,
    600004,
    10000,
    0,
    0,
    '',
    0,
    0
FROM `creature_template` ct
     LEFT JOIN `gossip_menu_option` gmo ON gmo.MenuID = ct.gossip_menu_id
WHERE ct.entry = 68
GROUP BY ct.gossip_menu_id;

-- Forgefer
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
SELECT
    ct.gossip_menu_id,
    COALESCE(MAX(gmo.OptionID), -1) + 1,
    0,
    'Purificateur des points Paragon',
    0,
    1,
    1,
    600005,
    10001,
    0,
    0,
    '',
    0,
    0
FROM `creature_template` ct
     LEFT JOIN `gossip_menu_option` gmo ON gmo.MenuID = ct.gossip_menu_id
WHERE ct.entry = 5595
GROUP BY ct.gossip_menu_id;

-- Darnassus
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
SELECT
    ct.gossip_menu_id,
    COALESCE(MAX(gmo.OptionID), -1) + 1,
    0,
    'Purificateur des points Paragon',
    0,
    1,
    1,
    600006,
    10002,
    0,
    0,
    '',
    0,
    0
FROM `creature_template` ct
     LEFT JOIN `gossip_menu_option` gmo ON gmo.MenuID = ct.gossip_menu_id
WHERE ct.entry = 4262
GROUP BY ct.gossip_menu_id;

-- Exodar
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
SELECT
    ct.gossip_menu_id,
    COALESCE(MAX(gmo.OptionID), -1) + 1,
    0,
    'Purificateur des points Paragon',
    0,
    1,
    1,
    600007,
    10003,
    0,
    0,
    '',
    0,
    0
FROM `creature_template` ct
     LEFT JOIN `gossip_menu_option` gmo ON gmo.MenuID = ct.gossip_menu_id
WHERE ct.entry = 16733
GROUP BY ct.gossip_menu_id;

-- Orgrimmar
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
SELECT
    ct.gossip_menu_id,
    COALESCE(MAX(gmo.OptionID), -1) + 1,
    0,
    'Purificateur des points Paragon',
    0,
    1,
    1,
    600008,
    10004,
    0,
    0,
    '',
    0,
    0
FROM `creature_template` ct
     LEFT JOIN `gossip_menu_option` gmo ON gmo.MenuID = ct.gossip_menu_id
WHERE ct.entry = 3296
GROUP BY ct.gossip_menu_id;

-- Pitons du Tonnerre
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
SELECT
    ct.gossip_menu_id,
    COALESCE(MAX(gmo.OptionID), -1) + 1,
    0,
    'Purificateur des points Paragon',
    0,
    1,
    1,
    600009,
    10005,
    0,
    0,
    '',
    0,
    0
FROM `creature_template` ct
     LEFT JOIN `gossip_menu_option` gmo ON gmo.MenuID = ct.gossip_menu_id
WHERE ct.entry = 3084
GROUP BY ct.gossip_menu_id;

-- Fossoyeuse
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
SELECT
    ct.gossip_menu_id,
    COALESCE(MAX(gmo.OptionID), -1) + 1,
    0,
    'Purificateur des points Paragon',
    0,
    1,
    1,
    600010,
    10006,
    0,
    0,
    '',
    0,
    0
FROM `creature_template` ct
     LEFT JOIN `gossip_menu_option` gmo ON gmo.MenuID = ct.gossip_menu_id
WHERE ct.entry = 36213
GROUP BY ct.gossip_menu_id;

-- Lune d'argent
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
SELECT
    ct.gossip_menu_id,
    COALESCE(MAX(gmo.OptionID), -1) + 1,
    0,
    'Purificateur des points Paragon',
    0,
    1,
    1,
    600011,
    10007,
    0,
    0,
    '',
    0,
    0
FROM `creature_template` ct
     LEFT JOIN `gossip_menu_option` gmo ON gmo.MenuID = ct.gossip_menu_id
WHERE ct.entry = 16222
GROUP BY ct.gossip_menu_id;

-- Shattrath
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
SELECT
    ct.gossip_menu_id,
    COALESCE(MAX(gmo.OptionID), -1) + 1,
    0,
    'Purificateur des points Paragon',
    0,
    1,
    1,
    600012,
    10008,
    0,
    0,
    '',
    0,
    0
FROM `creature_template` ct
     LEFT JOIN `gossip_menu_option` gmo ON gmo.MenuID = ct.gossip_menu_id
WHERE ct.entry = 19687
GROUP BY ct.gossip_menu_id;

-- Dalaran
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
SELECT
    ct.gossip_menu_id,
    COALESCE(MAX(gmo.OptionID), -1) + 1,
    0,
    'Purificateur des points Paragon',
    0,
    1,
    1,
    600013,
    10009,
    0,
    0,
    '',
    0,
    0
FROM `creature_template` ct
     LEFT JOIN `gossip_menu_option` gmo ON gmo.MenuID = ct.gossip_menu_id
WHERE ct.entry = 32686
GROUP BY ct.gossip_menu_id;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
SELECT
    ct.gossip_menu_id,
    COALESCE(MAX(gmo.OptionID), -1) + 1,
    0,
    'Purificateur des points Paragon',
    0,
    1,
    1,
    600013,
    10009,
    0,
    0,
    '',
    0,
    0
FROM `creature_template` ct
     LEFT JOIN `gossip_menu_option` gmo ON gmo.MenuID = ct.gossip_menu_id
WHERE ct.entry = 32727
GROUP BY ct.gossip_menu_id;
