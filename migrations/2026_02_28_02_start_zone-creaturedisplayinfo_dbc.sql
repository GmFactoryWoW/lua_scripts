DELETE FROM `creaturedisplayinfo_dbc` WHERE `ID` IN(100140, 100160);
INSERT INTO `creaturedisplayinfo_dbc` (`ID`, `ModelID`, `SoundID`, `ExtendedDisplayInfoID`, `CreatureModelScale`, `CreatureModelAlpha`, `TextureVariation_1`, `TextureVariation_2`, `TextureVariation_3`, `PortraitTextureName`, `BloodLevel`, `BloodID`, `NPCSoundID`, `ParticleColorID`, `CreatureGeosetData`, `ObjectEffectPackageID`) VALUES
(100140, 10140, 0, 0, 1, 255, NULL, NULL, NULL, NULL, -1, 0, 0, 0, 0, 0),
(100160, 10160, 0, 0, 1, 255, NULL, NULL, NULL, NULL, -1, 0, 0, 0, 0, 0);
