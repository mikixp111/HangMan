DROP TABLE IF EXISTS `player_themes`;
CREATE TABLE `player_themes` (
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_0` int DEFAULT NULL,
  `id_1` int DEFAULT NULL,
  `id_2` int DEFAULT NULL,
  `id_3` int DEFAULT NULL,
  `id_4` int DEFAULT NULL,
  `id_5` int DEFAULT NULL,
  `id_6` int DEFAULT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;