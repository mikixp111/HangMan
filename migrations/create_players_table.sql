DROP TABLE IF EXISTS `players`;
CREATE TABLE `players` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `wins` int DEFAULT NULL,
  `losses` int DEFAULT NULL,
  `current_theme_id` int DEFAULT NULL,
  `current_skin_id` int DEFAULT NULL,
  `current_hat_id` int DEFAULT NULL,
  `coins` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;