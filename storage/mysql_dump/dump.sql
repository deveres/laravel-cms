/*
MySQL Backup
Database: laravel_cms_7
Backup Time: 2021-01-28 14:20:12
*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `laravel_cms_7`.`admin_config`;
DROP TABLE IF EXISTS `laravel_cms_7`.`admin_menu`;
DROP TABLE IF EXISTS `laravel_cms_7`.`admin_operation_log`;
DROP TABLE IF EXISTS `laravel_cms_7`.`admin_permissions`;
DROP TABLE IF EXISTS `laravel_cms_7`.`admin_permissions_categories`;
DROP TABLE IF EXISTS `laravel_cms_7`.`admin_role_menu`;
DROP TABLE IF EXISTS `laravel_cms_7`.`admin_role_permissions`;
DROP TABLE IF EXISTS `laravel_cms_7`.`admin_role_users`;
DROP TABLE IF EXISTS `laravel_cms_7`.`admin_roles`;
DROP TABLE IF EXISTS `laravel_cms_7`.`admin_user_permissions`;
DROP TABLE IF EXISTS `laravel_cms_7`.`admin_users`;
DROP TABLE IF EXISTS `laravel_cms_7`.`failed_jobs`;
DROP TABLE IF EXISTS `laravel_cms_7`.`label_cats`;
DROP TABLE IF EXISTS `laravel_cms_7`.`label_langs`;
DROP TABLE IF EXISTS `laravel_cms_7`.`labels`;
DROP TABLE IF EXISTS `laravel_cms_7`.`laravel_exceptions`;
DROP TABLE IF EXISTS `laravel_cms_7`.`migrations`;
DROP TABLE IF EXISTS `laravel_cms_7`.`mod_images`;
DROP TABLE IF EXISTS `laravel_cms_7`.`mod_news`;
DROP TABLE IF EXISTS `laravel_cms_7`.`mod_news_i18n`;
DROP TABLE IF EXISTS `laravel_cms_7`.`mod_seo`;
DROP TABLE IF EXISTS `laravel_cms_7`.`mod_seo_i18n`;
DROP TABLE IF EXISTS `laravel_cms_7`.`password_resets`;
DROP TABLE IF EXISTS `laravel_cms_7`.`sessions`;
DROP TABLE IF EXISTS `laravel_cms_7`.`system_modules`;
DROP TABLE IF EXISTS `laravel_cms_7`.`users`;
CREATE TABLE `admin_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'general',
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_config_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `admin_menu` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL DEFAULT '0',
  `order` int NOT NULL DEFAULT '0',
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uri` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permission` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `icon_color` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#FFFFFF',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `admin_operation_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `method` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `input` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_operation_log_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `admin_permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `http_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `http_path` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cat_id` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_permissions_name_unique` (`name`),
  UNIQUE KEY `admin_permissions_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `admin_permissions_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `admin_role_menu` (
  `role_id` int NOT NULL,
  `menu_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_role_menu_role_id_menu_id_index` (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `admin_role_permissions` (
  `role_id` int NOT NULL,
  `permission_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_role_permissions_role_id_permission_id_index` (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `admin_role_users` (
  `role_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_role_users_role_id_user_id_index` (`role_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `admin_roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_roles_name_unique` (`name`),
  UNIQUE KEY `admin_roles_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `admin_user_permissions` (
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `admin_user_permissions_user_id_permission_id_index` (`user_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `admin_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `label_cats` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL DEFAULT '0',
  `alias` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ord` int NOT NULL DEFAULT '0',
  `state` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `label_langs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ord` int NOT NULL DEFAULT '0',
  `state` int NOT NULL DEFAULT '0',
  `default` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `label_langs_alias_unique` (`alias`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `labels` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL DEFAULT '0',
  `label` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_1` text COLLATE utf8mb4_unicode_ci,
  `value_2` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `laravel_exceptions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `line` int NOT NULL,
  `trace` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `query` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `cookies` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `mod_images` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int unsigned DEFAULT '0',
  `module` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `main` int unsigned DEFAULT '0',
  `path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alt` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `mod_news` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `log_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comments_enabled` tinyint unsigned NOT NULL DEFAULT '0',
  `state` tinyint unsigned NOT NULL DEFAULT '0',
  `lock_alias` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `mod_news_i18n` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `row_id` int unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(550) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `introtext` varchar(550) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci,
  `seo_h1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_title` text COLLATE utf8mb4_unicode_ci,
  `seo_keywords` text COLLATE utf8mb4_unicode_ci,
  `seo_description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_news_i18n_row_id_locale_unique` (`row_id`,`locale`),
  KEY `mod_news_i18n_locale_index` (`locale`),
  CONSTRAINT `mod_news_i18n_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `label_langs` (`alias`) ON UPDATE CASCADE,
  CONSTRAINT `mod_news_i18n_row_id_foreign` FOREIGN KEY (`row_id`) REFERENCES `mod_news` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `mod_seo` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `log_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` tinyint unsigned NOT NULL DEFAULT '0',
  `lock_alias` tinyint unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `mod_seo_i18n` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `row_id` int unsigned NOT NULL,
  `locale` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `introtext` varchar(550) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci,
  `seo_h1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seo_title` text COLLATE utf8mb4_unicode_ci,
  `seo_keywords` text COLLATE utf8mb4_unicode_ci,
  `seo_description` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mod_seo_i18n_row_id_locale_unique` (`row_id`,`locale`),
  KEY `mod_seo_i18n_locale_index` (`locale`),
  CONSTRAINT `mod_seo_i18n_locale_foreign` FOREIGN KEY (`locale`) REFERENCES `label_langs` (`alias`) ON UPDATE CASCADE,
  CONSTRAINT `mod_seo_i18n_row_id_foreign` FOREIGN KEY (`row_id`) REFERENCES `mod_seo` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  UNIQUE KEY `sessions_id_unique` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `system_modules` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int NOT NULL DEFAULT '0',
  `key` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `path` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon_color` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '#FFFFFF',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` tinyint NOT NULL DEFAULT '1',
  `module_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `system_modules_state_index` (`state`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
BEGIN;
LOCK TABLES `laravel_cms_7`.`admin_config` WRITE;
DELETE FROM `laravel_cms_7`.`admin_config`;
INSERT INTO `laravel_cms_7`.`admin_config` (`id`,`name`,`value`,`description`,`created_at`,`updated_at`,`category`) VALUES (1, 'enable_log', '0', 'Включает логирование1', '2021-01-26 16:09:14', '2021-01-27 12:43:15', 'system');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`admin_menu` WRITE;
DELETE FROM `laravel_cms_7`.`admin_menu`;
INSERT INTO `laravel_cms_7`.`admin_menu` (`id`,`parent_id`,`order`,`title`,`icon`,`uri`,`permission`,`created_at`,`updated_at`,`icon_color`) VALUES (1, 0, 1, 'Index', 'fa-bar-chart', '/', NULL, NULL, '2021-01-26 18:49:33', '#ffffff'),(2, 0, 14, 'Админ', 'fa-tasks', NULL, NULL, NULL, '2021-01-26 23:03:54', '#ffffff'),(3, 2, 15, 'Users', 'fa-users', 'auth/users', NULL, NULL, '2021-01-26 23:03:54', '#FFFFFF'),(4, 2, 16, 'Roles', 'fa-user', 'auth/roles', NULL, NULL, '2021-01-26 23:03:54', '#FFFFFF'),(5, 41, 20, 'Permission', 'fa-ban', 'auth/permissions', NULL, NULL, '2021-01-26 23:03:54', '#FFFFFF'),(6, 2, 17, 'Menu', 'fa-bars', 'auth/menu', NULL, NULL, '2021-01-26 23:03:54', '#FFFFFF'),(7, 2, 21, 'Operation log', 'fa-history', 'auth/logs', NULL, NULL, '2021-01-26 23:03:54', '#FFFFFF'),(8, 41, 19, 'Permission Categories', 'fa-clone', '/auth/permissions-cat', NULL, '2021-01-26 12:40:33', '2021-01-26 23:03:54', '#FFFFFF'),(10, 0, 7, 'Опции', 'fa-toggle-on', 'config', NULL, '2021-01-26 13:26:40', '2021-01-26 23:03:54', '#ffffff'),(11, 0, 8, 'Модули', 'fa-cubes', NULL, NULL, '2018-01-19 12:48:15', '2021-01-26 23:03:54', '#FFFFFF'),(12, 11, 9, 'Модули', 'fa-cubes', '/modules', NULL, '2018-01-19 12:48:15', '2021-01-26 23:03:54', '#FFFFFF'),(36, 0, 23, 'Helpers', 'fa-gears', NULL, NULL, '2021-01-26 14:39:49', '2021-01-26 23:03:54', '#ffffff'),(37, 36, 24, 'Scaffold', 'fa-keyboard-o', 'helpers/scaffold', NULL, '2021-01-26 14:39:49', '2021-01-26 23:03:54', '#FFFFFF'),(38, 36, 25, 'Database terminal', 'fa-database', 'helpers/terminal/database', NULL, '2021-01-26 14:39:49', '2021-01-26 23:03:54', '#FFFFFF'),(39, 36, 26, 'Laravel artisan', 'fa-terminal', 'helpers/terminal/artisan', NULL, '2021-01-26 14:39:49', '2021-01-26 23:03:54', '#FFFFFF'),(40, 36, 27, 'Routes', 'fa-list-alt', 'helpers/routes', NULL, '2021-01-26 14:39:49', '2021-01-26 23:03:54', '#FFFFFF'),(41, 2, 18, 'Permission', 'fa-ban', NULL, NULL, '2021-01-26 18:18:01', '2021-01-26 23:03:54', '#ffffff'),(42, 0, 22, 'Инструменты', 'fa-anchor', NULL, NULL, '2021-01-26 18:21:31', '2021-01-26 23:03:54', '#ffffff'),(43, 0, 6, 'Настройки', 'fa-anchor', NULL, NULL, '2021-01-26 18:22:19', '2021-01-26 23:03:54', '#ffffff'),(47, 0, 10, 'Мультиязычность', 'fa-amazon', NULL, NULL, '2021-01-26 18:49:50', '2021-01-26 23:03:54', '#ff7901'),(48, 47, 11, 'Языки', 'fa-amazon', '/langs', NULL, '2021-01-26 18:49:50', '2021-01-26 23:03:54', '#FFFFFF'),(49, 47, 12, 'Метки', 'fa-bookmark', '/langs_labels', NULL, '2021-01-26 18:49:50', '2021-01-26 23:03:54', '#FFFFFF'),(50, 47, 13, 'Категории меток', 'fa-copy', '/langs_cats', NULL, '2021-01-26 18:49:50', '2021-01-26 23:03:54', '#FFFFFF'),(51, 0, 4, 'SEO', 'fa-compass', '', NULL, '2021-01-26 21:25:29', '2021-01-26 23:03:54', '#FFFFFF'),(52, 51, 5, 'SEO', 'fa-compass', '/seo', NULL, '2021-01-26 21:25:29', '2021-01-26 23:03:54', '#FFFFFF'),(53, 0, 28, 'Backup', 'fa-copy', 'backup', NULL, '2021-01-26 21:49:18', '2021-01-26 23:03:54', '#FFFFFF'),(54, 0, 29, 'Log viewer', 'fa-database', 'logs', NULL, '2021-01-26 21:51:30', '2021-01-26 23:03:54', '#FFFFFF'),(55, 0, 30, 'Media manager', 'fa-file', 'media', NULL, '2021-01-26 21:53:13', '2021-01-26 23:03:54', '#FFFFFF'),(56, 0, 31, 'PHP info', 'fa-exclamation', 'phpinfo', NULL, '2021-01-26 21:55:15', '2021-01-26 23:03:54', '#FFFFFF'),(57, 0, 32, 'Scheduling', 'fa-clock-o', 'scheduling', NULL, '2021-01-26 22:00:22', '2021-01-26 23:03:54', '#FFFFFF'),(58, 0, 33, 'ComposerViewer', 'fa-gears', 'composer-viewer', NULL, '2021-01-26 22:01:58', '2021-01-26 23:03:54', '#FFFFFF'),(59, 0, 34, 'EnvManager', 'fa-gears', 'env-manager', NULL, '2021-01-26 22:05:06', '2021-01-26 23:03:54', '#FFFFFF'),(60, 0, 35, 'Api tester', 'fa-sliders', 'api-tester', NULL, '2021-01-26 22:06:27', '2021-01-26 23:03:54', '#FFFFFF'),(61, 0, 2, 'Новости', 'fa-newspaper-o', '', NULL, '2021-01-26 23:03:22', '2021-01-26 23:03:54', '#FFFFFF'),(62, 61, 3, 'Новости', 'fa-navicon', '/news', NULL, '2021-01-26 23:03:22', '2021-01-26 23:03:54', '#FFFFFF'),(63, 0, 36, 'Exception Reporter', 'fa-bug', 'exceptions', NULL, '2021-01-28 11:55:56', '2021-01-28 11:55:56', '#FFFFFF');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`admin_operation_log` WRITE;
DELETE FROM `laravel_cms_7`.`admin_operation_log`;
INSERT INTO `laravel_cms_7`.`admin_operation_log` (`id`,`user_id`,`path`,`method`,`ip`,`input`,`created_at`,`updated_at`) VALUES (1, 1, 'admin', 'GET', '192.168.10.1', '[]', '2021-01-26 11:18:41', '2021-01-26 11:18:41'),(2, 1, 'admin', 'GET', '192.168.10.1', '[]', '2021-01-26 11:23:11', '2021-01-26 11:23:11'),(3, 1, 'admin/auth/users', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 11:23:16', '2021-01-26 11:23:16'),(4, 1, 'admin/auth/roles', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 11:23:24', '2021-01-26 11:23:24'),(5, 1, 'admin/auth/roles', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 11:23:26', '2021-01-26 11:23:26'),(6, 1, 'admin/auth/permissions', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 11:23:27', '2021-01-26 11:23:27'),(7, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 11:23:34', '2021-01-26 11:23:34'),(8, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '[]', '2021-01-26 11:26:06', '2021-01-26 11:26:06'),(9, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '[]', '2021-01-26 11:27:51', '2021-01-26 11:27:51'),(10, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '[]', '2021-01-26 11:51:12', '2021-01-26 11:51:12'),(11, 1, 'admin/auth/users', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 11:51:38', '2021-01-26 11:51:38'),(12, 1, 'admin/auth/users/1/edit', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 11:51:42', '2021-01-26 11:51:42'),(13, 1, 'admin/auth/users/1', 'PUT', '192.168.10.1', '{\"username\":\"admin\",\"name\":\"Administrator\",\"password\":\"$2y$10$LsvHsnN3u6fcOJon16.HVeZ5tXzUmBkOftkDukgRtVTs1HBXW5w5m\",\"password_confirmation\":\"$2y$10$LsvHsnN3u6fcOJon16.HVeZ5tXzUmBkOftkDukgRtVTs1HBXW5w5m\",\"roles\":[\"1\",null],\"permissions\":[null],\"_token\":\"Whag2hxoBb9sRs6K7BBcZsKmlo8q7fRQfbmUCqVn\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/laravel-cms-7.dev\\/admin\\/auth\\/users\"}', '2021-01-26 11:51:58', '2021-01-26 11:51:58'),(14, 1, 'admin/auth/users', 'GET', '192.168.10.1', '[]', '2021-01-26 11:51:58', '2021-01-26 11:51:58'),(15, 1, 'admin/auth/users/1/edit', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 11:52:02', '2021-01-26 11:52:02'),(16, 1, 'admin/auth/users/1', 'PUT', '192.168.10.1', '{\"username\":\"admin\",\"name\":\"Administrator\",\"password\":\"$2y$10$LsvHsnN3u6fcOJon16.HVeZ5tXzUmBkOftkDukgRtVTs1HBXW5w5m\",\"password_confirmation\":\"$2y$10$LsvHsnN3u6fcOJon16.HVeZ5tXzUmBkOftkDukgRtVTs1HBXW5w5m\",\"roles\":[\"1\",null],\"permissions\":[null],\"_token\":\"Whag2hxoBb9sRs6K7BBcZsKmlo8q7fRQfbmUCqVn\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/laravel-cms-7.dev\\/admin\\/auth\\/users\"}', '2021-01-26 11:57:08', '2021-01-26 11:57:08'),(17, 1, 'admin/auth/users', 'GET', '192.168.10.1', '[]', '2021-01-26 11:57:09', '2021-01-26 11:57:09'),(18, 1, 'admin/auth/users/1/edit', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 11:57:12', '2021-01-26 11:57:12'),(19, 1, 'admin/auth/users', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 11:57:23', '2021-01-26 11:57:23'),(20, 1, 'admin', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 11:58:20', '2021-01-26 11:58:20'),(21, 1, 'admin/auth/permissions', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 11:58:23', '2021-01-26 11:58:23'),(22, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 11:58:25', '2021-01-26 11:58:25'),(23, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '[]', '2021-01-26 12:02:37', '2021-01-26 12:02:37'),(24, 1, 'admin/auth/permissions', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 12:18:22', '2021-01-26 12:18:22'),(25, 1, 'admin/auth/permissions', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 12:18:38', '2021-01-26 12:18:38'),(26, 1, 'admin/auth/permissions', 'GET', '192.168.10.1', '[]', '2021-01-26 12:21:36', '2021-01-26 12:21:36'),(27, 1, 'admin/auth/permissions', 'GET', '192.168.10.1', '[]', '2021-01-26 12:23:39', '2021-01-26 12:23:39'),(28, 1, 'admin/auth/permissions/1', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 12:23:47', '2021-01-26 12:23:47'),(29, 1, 'admin/auth/permissions', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 12:23:58', '2021-01-26 12:23:58'),(30, 1, 'admin/auth/permissions/1/edit', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 12:24:01', '2021-01-26 12:24:01'),(31, 1, 'admin/auth/permissions/1', 'PUT', '192.168.10.1', '{\"slug\":\"*\",\"cat_id\":\"1\",\"name\":\"All permission\",\"http_method\":[null],\"http_path\":\"*\",\"_token\":\"Whag2hxoBb9sRs6K7BBcZsKmlo8q7fRQfbmUCqVn\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/laravel-cms-7.dev\\/admin\\/auth\\/permissions\"}', '2021-01-26 12:24:11', '2021-01-26 12:24:11'),(32, 1, 'admin/auth/permissions', 'GET', '192.168.10.1', '[]', '2021-01-26 12:24:11', '2021-01-26 12:24:11'),(33, 1, 'admin/auth/permissions', 'GET', '192.168.10.1', '[]', '2021-01-26 12:41:42', '2021-01-26 12:41:42'),(34, 1, 'admin/auth/permissions-cat', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 12:42:09', '2021-01-26 12:42:09'),(35, 1, 'admin/auth/permissions-cat/1/edit', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 12:42:18', '2021-01-26 12:42:18'),(36, 1, 'admin/auth/permissions-cat/1', 'PUT', '192.168.10.1', '{\"name\":\"General\",\"_token\":\"Whag2hxoBb9sRs6K7BBcZsKmlo8q7fRQfbmUCqVn\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/laravel-cms-7.dev\\/admin\\/auth\\/permissions-cat\"}', '2021-01-26 12:42:22', '2021-01-26 12:42:22'),(37, 1, 'admin/auth/permissions-cat', 'GET', '192.168.10.1', '[]', '2021-01-26 12:42:22', '2021-01-26 12:42:22'),(38, 1, 'admin/auth/permissions-cat/1/edit', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 12:42:31', '2021-01-26 12:42:31'),(39, 1, 'admin/auth/permissions-cat/1', 'PUT', '192.168.10.1', '{\"name\":\"General1\",\"_token\":\"Whag2hxoBb9sRs6K7BBcZsKmlo8q7fRQfbmUCqVn\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/laravel-cms-7.dev\\/admin\\/auth\\/permissions-cat\"}', '2021-01-26 12:42:33', '2021-01-26 12:42:33'),(40, 1, 'admin/auth/permissions-cat', 'GET', '192.168.10.1', '[]', '2021-01-26 12:42:33', '2021-01-26 12:42:33'),(41, 1, 'admin/auth/permissions-cat/1/edit', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 12:42:35', '2021-01-26 12:42:35'),(42, 1, 'admin/auth/permissions-cat/1', 'PUT', '192.168.10.1', '{\"name\":\"General\",\"_token\":\"Whag2hxoBb9sRs6K7BBcZsKmlo8q7fRQfbmUCqVn\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/laravel-cms-7.dev\\/admin\\/auth\\/permissions-cat\"}', '2021-01-26 12:42:38', '2021-01-26 12:42:38'),(43, 1, 'admin/auth/permissions-cat', 'GET', '192.168.10.1', '[]', '2021-01-26 12:42:39', '2021-01-26 12:42:39'),(44, 1, 'admin/auth/permissions-cat', 'GET', '192.168.10.1', '[]', '2021-01-26 12:43:37', '2021-01-26 12:43:37'),(45, 1, 'admin/auth/permissions-cat', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 12:43:41', '2021-01-26 12:43:41'),(46, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 12:43:44', '2021-01-26 12:43:44'),(47, 1, 'admin/auth/permissions-cat', 'GET', '192.168.10.1', '[]', '2021-01-26 12:43:44', '2021-01-26 12:43:44'),(48, 1, 'admin/auth/permissions-cat', 'GET', '192.168.10.1', '[]', '2021-01-26 12:46:53', '2021-01-26 12:46:53'),(49, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '[]', '2021-01-26 12:48:07', '2021-01-26 12:48:07'),(50, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '[]', '2021-01-26 12:49:16', '2021-01-26 12:49:16'),(51, 1, 'admin/auth/menu', 'POST', '192.168.10.1', '{\"parent_id\":\"0\",\"title\":null,\"icon\":\"fa-bars\",\"icon_color\":\"#cb5858\",\"uri\":null,\"roles\":[null],\"permission\":null,\"_token\":\"Whag2hxoBb9sRs6K7BBcZsKmlo8q7fRQfbmUCqVn\"}', '2021-01-26 12:49:20', '2021-01-26 12:49:20'),(52, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '[]', '2021-01-26 12:49:20', '2021-01-26 12:49:20'),(53, 1, 'admin/auth/menu', 'POST', '192.168.10.1', '{\"parent_id\":\"0\",\"title\":\"test\",\"icon\":\"fa-bars\",\"icon_color\":\"#cb5858\",\"uri\":null,\"roles\":[null],\"permission\":null,\"_token\":\"Whag2hxoBb9sRs6K7BBcZsKmlo8q7fRQfbmUCqVn\"}', '2021-01-26 12:49:35', '2021-01-26 12:49:35'),(54, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '[]', '2021-01-26 12:49:35', '2021-01-26 12:49:35'),(55, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '[]', '2021-01-26 12:49:41', '2021-01-26 12:49:41'),(56, 1, 'admin/auth/menu/9', 'DELETE', '192.168.10.1', '{\"_method\":\"delete\",\"_token\":\"Whag2hxoBb9sRs6K7BBcZsKmlo8q7fRQfbmUCqVn\"}', '2021-01-26 12:49:47', '2021-01-26 12:49:47'),(57, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 12:49:47', '2021-01-26 12:49:47'),(58, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '[]', '2021-01-26 12:49:50', '2021-01-26 12:49:50'),(59, 1, 'admin/auth/menu', 'GET', '192.168.10.1', '[]', '2021-01-26 13:26:46', '2021-01-26 13:26:46'),(60, 1, 'admin/config', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 13:26:50', '2021-01-26 13:26:50'),(61, 1, 'admin/config/create', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 13:26:56', '2021-01-26 13:26:56'),(62, 1, 'admin/config', 'GET', '192.168.10.1', '[]', '2021-01-26 13:26:58', '2021-01-26 13:26:58'),(63, 1, 'admin/config', 'GET', '192.168.10.1', '[]', '2021-01-26 14:00:21', '2021-01-26 14:00:21'),(64, 1, 'admin/config', 'GET', '192.168.10.1', '[]', '2021-01-26 14:04:48', '2021-01-26 14:04:48'),(65, 1, 'admin/config', 'GET', '192.168.10.1', '[]', '2021-01-26 14:04:59', '2021-01-26 14:04:59'),(66, 1, 'admin/config', 'GET', '192.168.10.1', '[]', '2021-01-26 14:06:56', '2021-01-26 14:06:56'),(67, 1, 'admin/modules', 'GET', '192.168.10.1', '[]', '2021-01-26 14:37:02', '2021-01-26 14:37:02'),(68, 1, 'admin/modules', 'GET', '192.168.10.1', '[]', '2021-01-26 14:39:54', '2021-01-26 14:39:54'),(69, 1, 'admin/modules', 'GET', '192.168.10.1', '[]', '2021-01-26 14:42:06', '2021-01-26 14:42:06'),(70, 1, 'admin/modules', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 14:42:27', '2021-01-26 14:42:27'),(71, 1, 'admin/modules', 'GET', '192.168.10.1', '[]', '2021-01-26 14:46:50', '2021-01-26 14:46:50'),(72, 1, 'admin/modules', 'GET', '192.168.10.1', '[]', '2021-01-26 14:51:47', '2021-01-26 14:51:47'),(73, 1, 'admin/modules', 'GET', '192.168.10.1', '[]', '2021-01-26 14:51:55', '2021-01-26 14:51:55'),(74, 1, 'admin/modules', 'GET', '192.168.10.1', '[]', '2021-01-26 14:53:29', '2021-01-26 14:53:29'),(75, 1, 'admin/modules', 'GET', '192.168.10.1', '{\"name\":\"seo\",\"_pjax\":\"#pjax-container\"}', '2021-01-26 14:54:05', '2021-01-26 14:54:05'),(76, 1, 'admin/modules', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\",\"name\":null}', '2021-01-26 14:54:08', '2021-01-26 14:54:08'),(77, 1, 'admin/modules', 'GET', '192.168.10.1', '{\"name\":null}', '2021-01-26 14:59:37', '2021-01-26 14:59:37'),(78, 1, 'admin/modules', 'GET', '192.168.10.1', '{\"name\":null}', '2021-01-26 15:22:26', '2021-01-26 15:22:26'),(79, 1, 'admin/modules', 'GET', '192.168.10.1', '{\"name\":null}', '2021-01-26 15:23:19', '2021-01-26 15:23:19'),(80, 1, 'admin/modules', 'GET', '192.168.10.1', '{\"name\":null}', '2021-01-26 15:24:48', '2021-01-26 15:24:48'),(81, 1, 'admin/modules', 'GET', '192.168.10.1', '{\"name\":null}', '2021-01-26 15:25:08', '2021-01-26 15:25:08'),(82, 1, 'admin/modules', 'GET', '192.168.10.1', '{\"name\":null}', '2021-01-26 15:26:36', '2021-01-26 15:26:36'),(83, 1, 'admin/modules', 'GET', '192.168.10.1', '{\"name\":null}', '2021-01-26 15:26:51', '2021-01-26 15:26:51'),(84, 1, 'admin/modules', 'GET', '192.168.10.1', '{\"name\":null}', '2021-01-26 15:27:06', '2021-01-26 15:27:06'),(85, 1, 'admin/modules', 'GET', '192.168.10.1', '{\"name\":null}', '2021-01-26 15:30:35', '2021-01-26 15:30:35'),(86, 1, 'admin/modules', 'GET', '192.168.10.1', '{\"name\":null}', '2021-01-26 15:40:21', '2021-01-26 15:40:21'),(87, 1, 'admin/modules', 'GET', '192.168.10.1', '{\"name\":null}', '2021-01-26 15:41:56', '2021-01-26 15:41:56'),(88, 1, 'admin/config', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 15:51:56', '2021-01-26 15:51:56'),(89, 1, 'admin/config/create', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 15:52:01', '2021-01-26 15:52:01'),(90, 1, 'admin/config/create', 'GET', '192.168.10.1', '[]', '2021-01-26 15:52:01', '2021-01-26 15:52:01'),(91, 1, 'admin/config/create', 'GET', '192.168.10.1', '[]', '2021-01-26 15:57:14', '2021-01-26 15:57:14'),(92, 1, 'admin/config/create', 'GET', '192.168.10.1', '[]', '2021-01-26 16:00:07', '2021-01-26 16:00:07'),(93, 1, 'admin/config/create', 'GET', '192.168.10.1', '[]', '2021-01-26 16:00:15', '2021-01-26 16:00:15'),(94, 1, 'admin/config/create', 'GET', '192.168.10.1', '[]', '2021-01-26 16:00:34', '2021-01-26 16:00:34'),(95, 1, 'admin', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 16:01:52', '2021-01-26 16:01:52'),(96, 1, 'admin', 'GET', '192.168.10.1', '[]', '2021-01-26 16:01:55', '2021-01-26 16:01:55'),(97, 1, 'admin/config', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 16:02:00', '2021-01-26 16:02:00'),(98, 1, 'admin/config/create', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 16:02:05', '2021-01-26 16:02:05'),(99, 1, 'admin/config/create', 'GET', '192.168.10.1', '[]', '2021-01-26 16:02:08', '2021-01-26 16:02:08'),(100, 1, 'admin/config/create', 'GET', '192.168.10.1', '[]', '2021-01-26 16:03:46', '2021-01-26 16:03:46'),(101, 1, 'admin/config/create', 'GET', '192.168.10.1', '[]', '2021-01-26 16:04:49', '2021-01-26 16:04:49'),(102, 1, 'admin/config/create', 'GET', '192.168.10.1', '[]', '2021-01-26 16:04:53', '2021-01-26 16:04:53'),(103, 1, 'admin/config', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 16:06:50', '2021-01-26 16:06:50'),(104, 1, 'admin/config/create', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 16:08:51', '2021-01-26 16:08:51'),(105, 1, 'admin/config', 'POST', '192.168.10.1', '{\"category\":\"system\",\"name\":\"enable_log\",\"value\":\"0\",\"description\":\"\\u0412\\u043a\\u043b\\u044e\\u0447\\u0430\\u0435\\u0442 \\u043b\\u043e\\u0433\\u0438\\u0440\\u043e\\u0432\\u0430\\u043d\\u0438\\u0435\",\"_token\":\"Whag2hxoBb9sRs6K7BBcZsKmlo8q7fRQfbmUCqVn\",\"_previous_\":\"http:\\/\\/laravel-cms-7.dev\\/admin\\/config\"}', '2021-01-26 16:09:14', '2021-01-26 16:09:14'),(106, 1, 'admin/config', 'GET', '192.168.10.1', '[]', '2021-01-26 16:26:59', '2021-01-26 16:26:59'),(107, 1, 'admin/config/1/edit', 'GET', '192.168.10.1', '{\"_pjax\":\"#pjax-container\"}', '2021-01-26 16:27:02', '2021-01-26 16:27:02'),(108, 1, 'admin/config/1', 'PUT', '192.168.10.1', '{\"category\":\"system\",\"name\":\"enable_log\",\"value\":\"0\",\"description\":\"\\u0412\\u043a\\u043b\\u044e\\u0447\\u0430\\u0435\\u0442 \\u043b\\u043e\\u0433\\u0438\\u0440\\u043e\\u0432\\u0430\\u043d\\u0438\\u0435\",\"_token\":\"Whag2hxoBb9sRs6K7BBcZsKmlo8q7fRQfbmUCqVn\",\"_method\":\"PUT\",\"_previous_\":\"http:\\/\\/laravel-cms-7.dev\\/admin\\/config\"}', '2021-01-26 16:27:10', '2021-01-26 16:27:10');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`admin_permissions` WRITE;
DELETE FROM `laravel_cms_7`.`admin_permissions`;
INSERT INTO `laravel_cms_7`.`admin_permissions` (`id`,`name`,`slug`,`http_method`,`http_path`,`created_at`,`updated_at`,`cat_id`) VALUES (1, 'All permission', '*', '', '*', NULL, NULL, 1),(2, 'Dashboard', 'dashboard', 'GET', '/', NULL, NULL, 1),(3, 'Login', 'auth.login', '', '/auth/login\r\n/auth/logout', NULL, NULL, 1),(4, 'User setting', 'auth.setting', 'GET,PUT', '/auth/setting', NULL, NULL, 1),(5, 'Auth management', 'auth.management', '', '/auth/roles\r\n/auth/permissions\r\n/auth/menu\r\n/auth/logs', NULL, NULL, 1),(6, 'Admin Config', 'ext.config', '', '/config*', '2021-01-26 13:26:40', '2021-01-26 13:26:40', 1),(7, 'Admin helpers', 'ext.helpers', '', '/helpers/*', '2021-01-26 14:39:49', '2021-01-26 14:39:49', 1),(8, 'Модули', 'modules.index', NULL, '/modules*', '2021-01-26 17:56:14', '2021-01-26 17:56:14', 2),(9, 'Модули-Модули-create', 'modules.modules.create', NULL, '/modules*', '2021-01-26 17:56:14', '2021-01-26 17:56:14', 2),(10, 'Модули-Модули-read', 'modules.modules.read', NULL, '/modules*', '2021-01-26 17:56:14', '2021-01-26 17:56:14', 2),(11, 'Модули-Модули-update', 'modules.modules.update', NULL, '/modules*', '2021-01-26 17:56:14', '2021-01-26 17:56:14', 2),(12, 'Модули-Модули-delete', 'modules.modules.delete', NULL, '/modules*', '2021-01-26 17:56:14', '2021-01-26 17:56:14', 2),(13, 'Изображения', 'images.index', NULL, '/images*', '2021-01-26 18:40:03', '2021-01-26 18:40:03', 3),(14, 'Изображения-Изображения-create', 'images.images.create', NULL, '/images*', '2021-01-26 18:40:03', '2021-01-26 18:40:03', 3),(15, 'Изображения-Изображения-read', 'images.images.read', NULL, '/images*', '2021-01-26 18:40:03', '2021-01-26 18:40:03', 3),(16, 'Изображения-Изображения-update', 'images.images.update', NULL, '/images*', '2021-01-26 18:40:03', '2021-01-26 18:40:03', 3),(17, 'Изображения-Изображения-delete', 'images.images.delete', NULL, '/images*', '2021-01-26 18:40:03', '2021-01-26 18:40:03', 3),(18, 'Мультиязычность', 'langs.index', NULL, '/langs*', '2021-01-26 18:49:50', '2021-01-26 18:49:50', 4),(19, 'Мультиязычность-Языки-create', 'langs.langs.create', NULL, '/langs*', '2021-01-26 18:49:50', '2021-01-26 18:49:50', 4),(20, 'Мультиязычность-Языки-read', 'langs.langs.read', NULL, '/langs*', '2021-01-26 18:49:50', '2021-01-26 18:49:50', 4),(21, 'Мультиязычность-Языки-update', 'langs.langs.update', NULL, '/langs*', '2021-01-26 18:49:50', '2021-01-26 18:49:50', 4),(22, 'Мультиязычность-Языки-delete', 'langs.langs.delete', NULL, '/langs*', '2021-01-26 18:49:50', '2021-01-26 18:49:50', 4),(23, 'Мультиязычность-Метки-create', 'langs.langs_labels.create', NULL, '/langs_labels*', '2021-01-26 18:49:50', '2021-01-26 18:49:50', 4),(24, 'Мультиязычность-Метки-read', 'langs.langs_labels.read', NULL, '/langs_labels*', '2021-01-26 18:49:50', '2021-01-26 18:49:50', 4),(25, 'Мультиязычность-Метки-update', 'langs.langs_labels.update', NULL, '/langs_labels*', '2021-01-26 18:49:50', '2021-01-26 18:49:50', 4),(26, 'Мультиязычность-Метки-delete', 'langs.langs_labels.delete', NULL, '/langs_labels*', '2021-01-26 18:49:50', '2021-01-26 18:49:50', 4),(27, 'Мультиязычность-Категории меток-create', 'langs.langs_cats.create', NULL, '/langs_cats*', '2021-01-26 18:49:50', '2021-01-26 18:49:50', 4),(28, 'Мультиязычность-Категории меток-read', 'langs.langs_cats.read', NULL, '/langs_cats*', '2021-01-26 18:49:50', '2021-01-26 18:49:50', 4),(29, 'Мультиязычность-Категории меток-update', 'langs.langs_cats.update', NULL, '/langs_cats*', '2021-01-26 18:49:50', '2021-01-26 18:49:50', 4),(30, 'Мультиязычность-Категории меток-delete', 'langs.langs_cats.delete', NULL, '/langs_cats*', '2021-01-26 18:49:50', '2021-01-26 18:49:50', 4),(31, 'SEO', 'seo.index', NULL, '/seo*', '2021-01-26 21:25:29', '2021-01-26 21:25:29', 5),(32, 'SEO-SEO-create', 'seo.seo.create', NULL, '/seo*', '2021-01-26 21:25:29', '2021-01-26 21:25:29', 5),(33, 'SEO-SEO-read', 'seo.seo.read', NULL, '/seo*', '2021-01-26 21:25:29', '2021-01-26 21:25:29', 5),(34, 'SEO-SEO-update', 'seo.seo.update', NULL, '/seo*', '2021-01-26 21:25:29', '2021-01-26 21:25:29', 5),(35, 'SEO-SEO-delete', 'seo.seo.delete', NULL, '/seo*', '2021-01-26 21:25:29', '2021-01-26 21:25:29', 5),(36, 'Backup', 'ext.backup', '', '/backup*', '2021-01-26 21:49:18', '2021-01-26 21:49:18', 1),(37, 'Logs', 'ext.log-viewer', '', '/logs*', '2021-01-26 21:51:31', '2021-01-26 21:51:31', 1),(38, 'Media manager', 'ext.media-manager', '', '/media*', '2021-01-26 21:53:13', '2021-01-26 21:53:13', 1),(39, 'Scheduling', 'ext.scheduling', '', '/scheduling*', '2021-01-26 22:00:22', '2021-01-26 22:00:22', 1),(40, 'Api tester', 'ext.api-tester', '', '/api-tester*', '2021-01-26 22:06:27', '2021-01-26 22:06:27', 1),(41, 'Новости', 'news.index', NULL, '/news*', '2021-01-26 23:03:22', '2021-01-26 23:03:22', 6),(42, 'Новости-Новости-create', 'news.news.create', NULL, '/news*', '2021-01-26 23:03:22', '2021-01-26 23:03:22', 6),(43, 'Новости-Новости-read', 'news.news.read', NULL, '/news*', '2021-01-26 23:03:22', '2021-01-26 23:03:22', 6),(44, 'Новости-Новости-update', 'news.news.update', NULL, '/news*', '2021-01-26 23:03:22', '2021-01-26 23:03:22', 6),(45, 'Новости-Новости-delete', 'news.news.delete', NULL, '/news*', '2021-01-26 23:03:22', '2021-01-26 23:03:22', 6),(46, 'Exceptions reporter', 'ext.reporter', '', '/exceptions*', '2021-01-28 11:55:56', '2021-01-28 11:55:56', 1);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`admin_permissions_categories` WRITE;
DELETE FROM `laravel_cms_7`.`admin_permissions_categories`;
INSERT INTO `laravel_cms_7`.`admin_permissions_categories` (`id`,`name`) VALUES (1, 'General'),(2, 'Модули'),(3, 'Изображения'),(4, 'Мультиязычность'),(5, 'SEO'),(6, 'Новости');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`admin_role_menu` WRITE;
DELETE FROM `laravel_cms_7`.`admin_role_menu`;
INSERT INTO `laravel_cms_7`.`admin_role_menu` (`role_id`,`menu_id`,`created_at`,`updated_at`) VALUES (1, 2, NULL, NULL);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`admin_role_permissions` WRITE;
DELETE FROM `laravel_cms_7`.`admin_role_permissions`;
INSERT INTO `laravel_cms_7`.`admin_role_permissions` (`role_id`,`permission_id`,`created_at`,`updated_at`) VALUES (1, 1, NULL, NULL),(2, 2, NULL, NULL),(2, 3, NULL, NULL),(2, 31, NULL, NULL),(2, 32, NULL, NULL),(2, 33, NULL, NULL),(2, 34, NULL, NULL),(2, 35, NULL, NULL),(2, 41, NULL, NULL),(2, 42, NULL, NULL),(2, 43, NULL, NULL),(2, 44, NULL, NULL),(2, 45, NULL, NULL);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`admin_role_users` WRITE;
DELETE FROM `laravel_cms_7`.`admin_role_users`;
INSERT INTO `laravel_cms_7`.`admin_role_users` (`role_id`,`user_id`,`created_at`,`updated_at`) VALUES (1, 1, NULL, NULL),(2, 2, NULL, NULL);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`admin_roles` WRITE;
DELETE FROM `laravel_cms_7`.`admin_roles`;
INSERT INTO `laravel_cms_7`.`admin_roles` (`id`,`name`,`slug`,`created_at`,`updated_at`) VALUES (1, 'Administrator', 'administrator', '2021-01-26 11:17:12', '2021-01-26 11:17:12'),(2, 'Модератор', 'moderator', '2021-01-27 10:17:42', '2021-01-27 10:17:42');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`admin_user_permissions` WRITE;
DELETE FROM `laravel_cms_7`.`admin_user_permissions`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`admin_users` WRITE;
DELETE FROM `laravel_cms_7`.`admin_users`;
INSERT INTO `laravel_cms_7`.`admin_users` (`id`,`username`,`password`,`name`,`avatar`,`remember_token`,`created_at`,`updated_at`) VALUES (1, 'admin', '$2y$10$LsvHsnN3u6fcOJon16.HVeZ5tXzUmBkOftkDukgRtVTs1HBXW5w5m', 'Administrator', 'images/gallery_67309_428_46806.jpg', 'v0fMHp1kRAyRp4vdyQ449prefGfg6xnv4EYC14lrE9oRt27Ypc6bWFQ9W5LV', '2021-01-26 11:17:12', '2021-01-28 11:06:22'),(2, 'moderator', '$2y$10$ki3ovfw5WHDBEPSJB7qEBODSVM599pC7xK9OeXJuE1p1jx27nJQFW', 'Модератор', 'images/1372876.jpeg', NULL, '2021-01-27 10:19:07', '2021-01-27 10:19:07');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`failed_jobs` WRITE;
DELETE FROM `laravel_cms_7`.`failed_jobs`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`label_cats` WRITE;
DELETE FROM `laravel_cms_7`.`label_cats`;
INSERT INTO `laravel_cms_7`.`label_cats` (`id`,`parent_id`,`alias`,`name`,`ord`,`state`) VALUES (1, 0, 'custom', 'Общее', 1, 1),(2, 0, 'site', 'Сайт', 2, 1),(3, 1, 'labels', 'Надписи', 1, 1),(4, 0, 'news', 'Новости', 3, 1);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`label_langs` WRITE;
DELETE FROM `laravel_cms_7`.`label_langs`;
INSERT INTO `laravel_cms_7`.`label_langs` (`id`,`name`,`alias`,`ord`,`state`,`default`) VALUES (1, 'Русский', 'ru', 1, 1, 1),(2, 'English', 'en', 2, 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`labels` WRITE;
DELETE FROM `laravel_cms_7`.`labels`;
INSERT INTO `laravel_cms_7`.`labels` (`id`,`parent_id`,`label`,`value_1`,`value_2`) VALUES (1, 0, 'test', '2', NULL),(2, 2, 'defaultMetaTitle', 'Главная страница', 'Main page'),(3, 2, 'defaultMetaDescription', 'Мультиязычный сайт пример', 'Multi language site example'),(4, 4, 'read_more', 'Прочитать', 'Read more'),(5, 3, 'back_to_list', 'Назад к списку новостей', 'Back'),(6, 3, 'share_this_article', 'Поделиться', 'Share this article');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`laravel_exceptions` WRITE;
DELETE FROM `laravel_cms_7`.`laravel_exceptions`;
INSERT INTO `laravel_cms_7`.`laravel_exceptions` (`id`,`type`,`code`,`message`,`file`,`line`,`trace`,`method`,`path`,`query`,`body`,`cookies`,`headers`,`ip`,`created_at`,`updated_at`) VALUES (4, 'ParseError', '0', 'syntax error, unexpected \'new\' (T_NEW)', '/home/vagrant/code/laravel-cms-7.dev/www/app/Src/Admin/Controllers/Config/ConfigController.php', 112, '#0 /home/vagrant/code/laravel-cms-7.dev/www/vendor/composer/ClassLoader.php(322): Composer\\Autoload\\includeFile(\'/home/vagrant/c...\')\n#1 [internal function]: Composer\\Autoload\\ClassLoader->loadClass(\'App\\\\Src\\\\Admin\\\\C...\')\n#2 [internal function]: spl_autoload_call(\'App\\\\Src\\\\Admin\\\\C...\')\n#3 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Container/Container.php(809): ReflectionClass->__construct(\'App\\\\Src\\\\Admin\\\\C...\')\n#4 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Container/Container.php(691): Illuminate\\Container\\Container->build(\'App\\\\Src\\\\Admin\\\\C...\')\n#5 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(796): Illuminate\\Container\\Container->resolve(\'App\\\\Src\\\\Admin\\\\C...\', Array, true)\n#6 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Container/Container.php(637): Illuminate\\Foundation\\Application->resolve(\'App\\\\Src\\\\Admin\\\\C...\', Array)\n#7 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(781): Illuminate\\Container\\Container->make(\'App\\\\Src\\\\Admin\\\\C...\', Array)\n#8 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Route.php(253): Illuminate\\Foundation\\Application->make(\'App\\\\Src\\\\Admin\\\\C...\')\n#9 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Route.php(970): Illuminate\\Routing\\Route->getController()\n#10 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Route.php(931): Illuminate\\Routing\\Route->controllerMiddleware()\n#11 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Router.php(702): Illuminate\\Routing\\Route->gatherMiddleware()\n#12 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Router.php(678): Illuminate\\Routing\\Router->gatherRouteMiddleware(Object(Illuminate\\Routing\\Route))\n#13 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Router.php(662): Illuminate\\Routing\\Router->runRouteWithinStack(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request))\n#14 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Router.php(628): Illuminate\\Routing\\Router->runRoute(Object(Illuminate\\Http\\Request), Object(Illuminate\\Routing\\Route))\n#15 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Router.php(617): Illuminate\\Routing\\Router->dispatchToRoute(Object(Illuminate\\Http\\Request))\n#16 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(165): Illuminate\\Routing\\Router->dispatch(Object(Illuminate\\Http\\Request))\n#17 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(128): Illuminate\\Foundation\\Http\\Kernel->Illuminate\\Foundation\\Http\\{closure}(Object(Illuminate\\Http\\Request))\n#18 /home/vagrant/code/laravel-cms-7.dev/www/vendor/barryvdh/laravel-debugbar/src/Middleware/InjectDebugbar.php(60): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#19 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): Barryvdh\\Debugbar\\Middleware\\InjectDebugbar->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#20 /home/vagrant/code/laravel-cms-7.dev/www/app/Http/Middleware/LocaleMiddleware.php(31): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#21 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): App\\Http\\Middleware\\LocaleMiddleware->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#22 /home/vagrant/code/laravel-cms-7.dev/www/app/Http/Middleware/DebugModeMiddleware.php(32): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#23 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): App\\Http\\Middleware\\DebugModeMiddleware->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#24 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/TransformsRequest.php(21): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#25 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): Illuminate\\Foundation\\Http\\Middleware\\TransformsRequest->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#26 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/TransformsRequest.php(21): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#27 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): Illuminate\\Foundation\\Http\\Middleware\\TransformsRequest->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#28 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/ValidatePostSize.php(27): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#29 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): Illuminate\\Foundation\\Http\\Middleware\\ValidatePostSize->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#30 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/CheckForMaintenanceMode.php(63): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#31 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): Illuminate\\Foundation\\Http\\Middleware\\CheckForMaintenanceMode->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#32 /home/vagrant/code/laravel-cms-7.dev/www/vendor/fruitcake/laravel-cors/src/HandleCors.php(37): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#33 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): Fruitcake\\Cors\\HandleCors->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#34 /home/vagrant/code/laravel-cms-7.dev/www/vendor/fideloper/proxy/src/TrustProxies.php(57): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#35 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): Fideloper\\Proxy\\TrustProxies->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#36 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#37 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(140): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#38 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(109): Illuminate\\Foundation\\Http\\Kernel->sendRequestThroughRouter(Object(Illuminate\\Http\\Request))\n#39 /home/vagrant/code/laravel-cms-7.dev/www/public/index.php(55): Illuminate\\Foundation\\Http\\Kernel->handle(Object(Illuminate\\Http\\Request))\n#40 {main}', 'GET', 'admin/config', '[]', '', '{\"remember_admin_59ba36addc2b2f9401580f014c7f58ea4e30989d\":\"eyJpdiI6Imx6UlhtTHgvWmRxY3hNalZEamtpVXc9PSIsInZhbHVlIjoiYWZaK0lrWWQ2TnNacHhsUW5NejMrZUZKcm1Uci81aU9HL2dwZEp5VFQ5VzQvcE90THE0MnVmOVFGZW9BOUZkREpkOS93d3lsQUNocURrQTdwck8vTVFIN1pLakZtOS81a08zTnVOZHZtZDN3VzdvdmU4V2s2UGNmN2NRZHhpSVp5djBEWUIzUjFwVVhQcjlxTjNlQWVOTGZQN0FsRktNNWZnL3BYNEQ2QklnWkEwa2YweXB3Mm5vOXhOcTd6MkpWUWZpakFia3Z2WnVudVFkRDZxYkdJUXZnemNaSWtpWG5QcjgzMWJHWUpwbz0iLCJtYWMiOiI4NjlkZmJmODliMzQ4YzEzYTg4ZTU0YTYxYjNhNWY3NDg1YjYxYTM1ZmM1YjU2MTBmNDMwNGYzOThkMDhjNzg4In0=\",\"XSRF-TOKEN\":\"eyJpdiI6IkxmWnNyUWZvNHhIWTdHcWxGcW1nSXc9PSIsInZhbHVlIjoibG1rSTF1OWN3dkg5N0hEMnB3c2dSRnp3TXFRaWlNU05idmM5T1J2UitYV2o2bzZzNElqOFh2SS9wNVB6dmdseC9OMmFudVUvZUFoV0E1MWcrejBucC9YYVZESlFxT01DQ2ZvaC9UdDlTN2cwQUpDOFVxOXlmLzI3ODZseDJmNjUiLCJtYWMiOiI0NjdhMWE0YWY5YWIwZDQ4N2Y1Njc0NjRkMmFmOGFlMTNjNmMyNjhhMmE5YThlY2VlYWM3MDRiMjNmNzE4ZWE5In0=\",\"laravel_session\":\"eyJpdiI6IitkRm9WV3NxYnlQR080TlVNa2QxVWc9PSIsInZhbHVlIjoiMDlja0FvOUhUV0VDU0QrNUlSSjlWZ0liOGV1c3J0R00wYTMzQ2psV05EdmdBNTNjbHlNeVc2dUEvZ1pJU2I0Qmh2RlUyWUxGUmpnN2dHL0RYYXF2MW5BSHJpK0JhdUZoZ0NhZjkyaFlicUpFTEdheTBZKzhuR2NkbmJYeGxxKzQiLCJtYWMiOiIyYmQ1NmE2ZTFiNjM3Mjg1MTU4NDA0OWFjYWJiZDI1N2UzMWZiYzVhOTVlOWViZGQwMmY0ZWY2ODM0M2ZlMWZiIn0=\"}', '{\"cache-control\":[\"no-cache\"],\"pragma\":[\"no-cache\"],\"referer\":[\"http:\\/\\/laravel-cms-7.dev\\/admin\\/backup\"],\"connection\":[\"keep-alive\"],\"x-requested-with\":[\"XMLHttpRequest\"],\"x-pjax-container\":[\"#pjax-container\"],\"x-pjax\":[\"true\"],\"content-type\":[\"application\\/x-www-form-urlencoded; charset=UTF-8\"],\"accept-encoding\":[\"gzip, deflate\"],\"accept-language\":[\"en-US,en;q=0.5\"],\"accept\":[\"text\\/html, *\\/*; q=0.01\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko\\/20100101 Firefox\\/85.0\"],\"host\":[\"laravel-cms-7.dev\"],\"content-length\":[\"\"]}', '[\"192.168.10.1\"]', '2021-01-28 12:37:21', '2021-01-28 12:37:21'),(5, 'ParseError', '0', 'syntax error, unexpected \'new\' (T_NEW)', '/home/vagrant/code/laravel-cms-7.dev/www/app/Src/Admin/Controllers/Config/ConfigController.php', 112, '#0 /home/vagrant/code/laravel-cms-7.dev/www/vendor/composer/ClassLoader.php(322): Composer\\Autoload\\includeFile(\'/home/vagrant/c...\')\n#1 [internal function]: Composer\\Autoload\\ClassLoader->loadClass(\'App\\\\Src\\\\Admin\\\\C...\')\n#2 [internal function]: spl_autoload_call(\'App\\\\Src\\\\Admin\\\\C...\')\n#3 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Container/Container.php(809): ReflectionClass->__construct(\'App\\\\Src\\\\Admin\\\\C...\')\n#4 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Container/Container.php(691): Illuminate\\Container\\Container->build(\'App\\\\Src\\\\Admin\\\\C...\')\n#5 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(796): Illuminate\\Container\\Container->resolve(\'App\\\\Src\\\\Admin\\\\C...\', Array, true)\n#6 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Container/Container.php(637): Illuminate\\Foundation\\Application->resolve(\'App\\\\Src\\\\Admin\\\\C...\', Array)\n#7 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Application.php(781): Illuminate\\Container\\Container->make(\'App\\\\Src\\\\Admin\\\\C...\', Array)\n#8 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Route.php(253): Illuminate\\Foundation\\Application->make(\'App\\\\Src\\\\Admin\\\\C...\')\n#9 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Route.php(970): Illuminate\\Routing\\Route->getController()\n#10 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Route.php(931): Illuminate\\Routing\\Route->controllerMiddleware()\n#11 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Router.php(702): Illuminate\\Routing\\Route->gatherMiddleware()\n#12 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Router.php(678): Illuminate\\Routing\\Router->gatherRouteMiddleware(Object(Illuminate\\Routing\\Route))\n#13 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Router.php(662): Illuminate\\Routing\\Router->runRouteWithinStack(Object(Illuminate\\Routing\\Route), Object(Illuminate\\Http\\Request))\n#14 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Router.php(628): Illuminate\\Routing\\Router->runRoute(Object(Illuminate\\Http\\Request), Object(Illuminate\\Routing\\Route))\n#15 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Routing/Router.php(617): Illuminate\\Routing\\Router->dispatchToRoute(Object(Illuminate\\Http\\Request))\n#16 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(165): Illuminate\\Routing\\Router->dispatch(Object(Illuminate\\Http\\Request))\n#17 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(128): Illuminate\\Foundation\\Http\\Kernel->Illuminate\\Foundation\\Http\\{closure}(Object(Illuminate\\Http\\Request))\n#18 /home/vagrant/code/laravel-cms-7.dev/www/vendor/barryvdh/laravel-debugbar/src/Middleware/InjectDebugbar.php(60): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#19 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): Barryvdh\\Debugbar\\Middleware\\InjectDebugbar->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#20 /home/vagrant/code/laravel-cms-7.dev/www/app/Http/Middleware/LocaleMiddleware.php(31): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#21 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): App\\Http\\Middleware\\LocaleMiddleware->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#22 /home/vagrant/code/laravel-cms-7.dev/www/app/Http/Middleware/DebugModeMiddleware.php(32): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#23 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): App\\Http\\Middleware\\DebugModeMiddleware->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#24 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/TransformsRequest.php(21): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#25 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): Illuminate\\Foundation\\Http\\Middleware\\TransformsRequest->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#26 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/TransformsRequest.php(21): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#27 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): Illuminate\\Foundation\\Http\\Middleware\\TransformsRequest->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#28 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/ValidatePostSize.php(27): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#29 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): Illuminate\\Foundation\\Http\\Middleware\\ValidatePostSize->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#30 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Http/Middleware/CheckForMaintenanceMode.php(63): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#31 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): Illuminate\\Foundation\\Http\\Middleware\\CheckForMaintenanceMode->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#32 /home/vagrant/code/laravel-cms-7.dev/www/vendor/fruitcake/laravel-cors/src/HandleCors.php(37): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#33 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): Fruitcake\\Cors\\HandleCors->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#34 /home/vagrant/code/laravel-cms-7.dev/www/vendor/fideloper/proxy/src/TrustProxies.php(57): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#35 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(167): Fideloper\\Proxy\\TrustProxies->handle(Object(Illuminate\\Http\\Request), Object(Closure))\n#36 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Http\\Request))\n#37 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(140): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#38 /home/vagrant/code/laravel-cms-7.dev/www/vendor/laravel/framework/src/Illuminate/Foundation/Http/Kernel.php(109): Illuminate\\Foundation\\Http\\Kernel->sendRequestThroughRouter(Object(Illuminate\\Http\\Request))\n#39 /home/vagrant/code/laravel-cms-7.dev/www/public/index.php(55): Illuminate\\Foundation\\Http\\Kernel->handle(Object(Illuminate\\Http\\Request))\n#40 {main}', 'GET', 'admin/config', '[]', '', '{\"remember_admin_59ba36addc2b2f9401580f014c7f58ea4e30989d\":\"eyJpdiI6Imx6UlhtTHgvWmRxY3hNalZEamtpVXc9PSIsInZhbHVlIjoiYWZaK0lrWWQ2TnNacHhsUW5NejMrZUZKcm1Uci81aU9HL2dwZEp5VFQ5VzQvcE90THE0MnVmOVFGZW9BOUZkREpkOS93d3lsQUNocURrQTdwck8vTVFIN1pLakZtOS81a08zTnVOZHZtZDN3VzdvdmU4V2s2UGNmN2NRZHhpSVp5djBEWUIzUjFwVVhQcjlxTjNlQWVOTGZQN0FsRktNNWZnL3BYNEQ2QklnWkEwa2YweXB3Mm5vOXhOcTd6MkpWUWZpakFia3Z2WnVudVFkRDZxYkdJUXZnemNaSWtpWG5QcjgzMWJHWUpwbz0iLCJtYWMiOiI4NjlkZmJmODliMzQ4YzEzYTg4ZTU0YTYxYjNhNWY3NDg1YjYxYTM1ZmM1YjU2MTBmNDMwNGYzOThkMDhjNzg4In0=\",\"XSRF-TOKEN\":\"eyJpdiI6IkxmWnNyUWZvNHhIWTdHcWxGcW1nSXc9PSIsInZhbHVlIjoibG1rSTF1OWN3dkg5N0hEMnB3c2dSRnp3TXFRaWlNU05idmM5T1J2UitYV2o2bzZzNElqOFh2SS9wNVB6dmdseC9OMmFudVUvZUFoV0E1MWcrejBucC9YYVZESlFxT01DQ2ZvaC9UdDlTN2cwQUpDOFVxOXlmLzI3ODZseDJmNjUiLCJtYWMiOiI0NjdhMWE0YWY5YWIwZDQ4N2Y1Njc0NjRkMmFmOGFlMTNjNmMyNjhhMmE5YThlY2VlYWM3MDRiMjNmNzE4ZWE5In0=\",\"laravel_session\":\"eyJpdiI6IitkRm9WV3NxYnlQR080TlVNa2QxVWc9PSIsInZhbHVlIjoiMDlja0FvOUhUV0VDU0QrNUlSSjlWZ0liOGV1c3J0R00wYTMzQ2psV05EdmdBNTNjbHlNeVc2dUEvZ1pJU2I0Qmh2RlUyWUxGUmpnN2dHL0RYYXF2MW5BSHJpK0JhdUZoZ0NhZjkyaFlicUpFTEdheTBZKzhuR2NkbmJYeGxxKzQiLCJtYWMiOiIyYmQ1NmE2ZTFiNjM3Mjg1MTU4NDA0OWFjYWJiZDI1N2UzMWZiYzVhOTVlOWViZGQwMmY0ZWY2ODM0M2ZlMWZiIn0=\"}', '{\"cache-control\":[\"no-cache\"],\"pragma\":[\"no-cache\"],\"upgrade-insecure-requests\":[\"1\"],\"referer\":[\"http:\\/\\/laravel-cms-7.dev\\/admin\\/backup\"],\"connection\":[\"keep-alive\"],\"accept-encoding\":[\"gzip, deflate\"],\"accept-language\":[\"en-US,en;q=0.5\"],\"accept\":[\"text\\/html,application\\/xhtml+xml,application\\/xml;q=0.9,image\\/webp,*\\/*;q=0.8\"],\"user-agent\":[\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko\\/20100101 Firefox\\/85.0\"],\"host\":[\"laravel-cms-7.dev\"],\"content-length\":[\"\"],\"content-type\":[\"\"]}', '[\"192.168.10.1\"]', '2021-01-28 12:37:21', '2021-01-28 12:37:21');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`migrations` WRITE;
DELETE FROM `laravel_cms_7`.`migrations`;
INSERT INTO `laravel_cms_7`.`migrations` (`id`,`migration`,`batch`) VALUES (1, '2014_10_12_000000_create_users_table', 1),(2, '2014_10_12_100000_create_password_resets_table', 1),(3, '2019_08_19_000000_create_failed_jobs_table', 1),(4, '2016_01_04_173148_create_admin_tables', 2),(5, '2021_01_26_112456_create_sessions_table', 3),(6, '2021_01_26_113933_add_admin_menu_icon_color', 4),(8, '2021_01_26_114312_add_admin_permission_category', 5),(9, '2021_01_26_125816_add_modules_table', 6),(10, '2017_07_17_040159_create_config_table', 7),(11, '2017_12_04_075727_create_langs_table', 8),(12, '2017_12_14_181815_create_langs_cats_table', 8),(13, '2017_12_19_184754_create_labels_table', 8),(14, '2018_11_30_114108_add_category_field_to_admin_config', 9),(15, '2018_10_02_084659_add_images_table', 10),(16, '2018_10_01_083728_create_seo_tables', 11),(17, '2017_07_17_040159_create_exceptions_table', 12),(18, '2018_10_08_121917_create_news_table', 13);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`mod_images` WRITE;
DELETE FROM `laravel_cms_7`.`mod_images`;
INSERT INTO `laravel_cms_7`.`mod_images` (`id`,`item_id`,`module`,`main`,`path`,`filename`,`alt`,`disk`) VALUES (6, 1, 'seo', 1, '/files/seo/list/1/', '3b-1372876.jpeg', '3b-1372876.jpeg', 'public'),(7, 1, 'news', 1, '/files/news/list/1/', 'TY-WhatsApp Image 2020-12-23 at 10.01.45.jpeg', 'TY-WhatsApp Image 2020-12-23 at 10.01.45.jpeg', 'public');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`mod_news` WRITE;
DELETE FROM `laravel_cms_7`.`mod_news`;
INSERT INTO `laravel_cms_7`.`mod_news` (`id`,`log_name`,`alias`,`comments_enabled`,`state`,`lock_alias`,`created_at`,`updated_at`) VALUES (1, 'первая новость', 'pervaja-novosti', 1, 1, 1, '2021-01-26 23:22:19', '2021-01-26 23:22:19');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`mod_news_i18n` WRITE;
DELETE FROM `laravel_cms_7`.`mod_news_i18n`;
INSERT INTO `laravel_cms_7`.`mod_news_i18n` (`id`,`row_id`,`locale`,`name`,`introtext`,`text`,`seo_h1`,`seo_title`,`seo_keywords`,`seo_description`) VALUES (1, 1, 'ru', 'заголовок неовости', 'короткое описание', '<p>полное описание</p>', 'сео р1', 'мета титле', 'кейворд', 'description'),(2, 1, 'en', 'title news', 'short description', '<p>full description</p>', 'seo h1', 'meta title', 'meta keyword', 'meta description');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`mod_seo` WRITE;
DELETE FROM `laravel_cms_7`.`mod_seo`;
INSERT INTO `laravel_cms_7`.`mod_seo` (`id`,`log_name`,`alias`,`link`,`state`,`lock_alias`,`created_at`,`updated_at`) VALUES (1, 'Главная', 'glavnajajhhjhjh', 'main', 1, 1, '2021-01-26 21:44:32', '2021-01-26 22:31:34'),(2, 'Новости', 'news', '/news', 1, 1, '2021-01-27 11:34:59', '2021-01-27 11:34:59');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`mod_seo_i18n` WRITE;
DELETE FROM `laravel_cms_7`.`mod_seo_i18n`;
INSERT INTO `laravel_cms_7`.`mod_seo_i18n` (`id`,`row_id`,`locale`,`introtext`,`text`,`seo_h1`,`seo_title`,`seo_keywords`,`seo_description`) VALUES (1, 1, 'ru', 'vvc', '<p>vcvc</p>', 'cvcvvc', 'cvvvv', 'cvvcvc', 'vccv'),(2, 2, 'ru', 'seo короткое описание', '<p>seo полное описание</p>', 'seo заголовок h1', 'seo мета заголовок', 'seo мета ключи', 'seo мета описание'),(3, 2, 'en', 'seo short description', '<p>seo long description</p>', 'seo h1', 'seo meta title', 'seo meta keywords', 'seo meta description');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`password_resets` WRITE;
DELETE FROM `laravel_cms_7`.`password_resets`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`sessions` WRITE;
DELETE FROM `laravel_cms_7`.`sessions`;
INSERT INTO `laravel_cms_7`.`sessions` (`id`,`user_id`,`ip_address`,`user_agent`,`payload`,`last_activity`) VALUES ('lfvtWr5NCUiS0xTSagoYNsiW5ueUJPSzAiHG2VRY', NULL, '192.168.10.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR1pkdXdkVGZ6ZzFNb3JFVFNJcFdRdW9sMGJPN1Y3SmRxVXBYTnhsNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sYXJhdmVsLWNtcy03LmRldi9hZG1pbi9hdXRoL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1611821306),('qEOK5pOnhCr0P4vpUuH90ohpB1225O0Re0rpRmxQ', 1, '192.168.10.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101 Firefox/84.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiQ3ZMWkFBNzJVTzZoRHdZdERMbkhQdjd0VlUwT2s4eXBTMFlFUGY5dyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MTAyOiJodHRwOi8vbGFyYXZlbC1jbXMtNy5kZXYvYWRtaW4vaW1hZ2VzL25ld3MvMS8xMDAvVFktV2hhdHNBcHAlMjBJbWFnZSUyMDIwMjAtMTItMjMlMjBhdCUyMDEwLjAxLjQ1LmpwZWciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUyOiJsb2dpbl9hZG1pbl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1611752955),('QXFn9ehoCnEz4xRVckIJcnicI0ipEnw9JS2TPqGL', 1, '192.168.10.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNENSQm02VDV6TE12VTJyWjlBbm1hQ21OWEV3ME1pZ2lKTFFpOG85byI7czo1MjoibG9naW5fYWRtaW5fNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQxOiJodHRwOi8vbGFyYXZlbC1jbXMtNy5kZXYvYWRtaW4vZXhjZXB0aW9ucyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1611828723),('uwp14hKKjOZwtiMufx3Oau58vVbAdxvZvH8iCGNV', 1, '192.168.10.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101 Firefox/84.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicXIybjNwSkJxZ1NQVEViZ2NuZEhIdjdCNUR4eURyVnhvQ0NtYmIwUiI7czo1MjoibG9naW5fYWRtaW5fNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1611776037),('wzsFrXyXZyKDH8uGodtaUga92RW6jjR2QUfVPFxE', NULL, '192.168.10.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101 Firefox/85.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQlVOdWk3dlFvaFBrMkFBcFIzYURPM05IMGpEMzVlM29xNGJrUWg5WSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDg6Imh0dHA6Ly9sYXJhdmVsLWNtcy03LmRldi9hZG1pbi9hdXRoL3VzZXJzLzEvZWRpdCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1611821306);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`system_modules` WRITE;
DELETE FROM `laravel_cms_7`.`system_modules`;
INSERT INTO `laravel_cms_7`.`system_modules` (`id`,`parent_id`,`key`,`path`,`name`,`icon`,`icon_color`,`description`,`state`,`module_order`) VALUES (1, 0, 'images', 'images', 'Изображения', 'fa-cubes', '', 'Модуль картинок', 1, 0),(2, 0, 'langs', 'langs', 'Мультиязычность', 'fa-amazon', '#ffb600', 'Мультиязычность системы, языки метки.', 1, 0),(3, 0, 'modules', 'modules', 'Модули', 'fa-cubes', '', 'Модули', 1, 0),(4, 0, 'news', 'news', 'Новости', 'fa-newspaper-o', '#ffb600', 'Модуль новостей', 1, 0),(5, 0, 'seo', 'seo', 'SEO', 'fa-compass', '#ffb600', 'Модуль SEO настроек для страниц.', 1, 0);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `laravel_cms_7`.`users` WRITE;
DELETE FROM `laravel_cms_7`.`users`;
INSERT INTO `laravel_cms_7`.`users` (`id`,`name`,`email`,`email_verified_at`,`password`,`remember_token`,`created_at`,`updated_at`) VALUES (1, 'вадим', 'vadimbirsan@gmail.com', NULL, '$2y$10$fH/2VbRXtZCzb0QmLYINue2EVOJ35mH5PRrfFmK4SVMlN5ZE/iW46', NULL, '2021-01-27 14:10:07', '2021-01-27 14:10:07');
UNLOCK TABLES;
COMMIT;
