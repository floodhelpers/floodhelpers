/*
 Navicat MySQL Data Transfer

 Source Server         : localhost
 Source Server Version : 50542
 Source Host           : localhost
 Source Database       : floodhelpers

 Target Server Version : 50542
 File Encoding         : utf-8

 Date: 12/28/2015 13:20:26 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `craft_assetfiles`
-- ----------------------------
DROP TABLE IF EXISTS `craft_assetfiles`;
CREATE TABLE `craft_assetfiles` (
  `id` int(11) NOT NULL,
  `sourceId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kind` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` int(11) unsigned DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetfiles_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `craft_assetfiles_sourceId_fk` (`sourceId`),
  KEY `craft_assetfiles_folderId_fk` (`folderId`),
  CONSTRAINT `craft_assetfiles_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `craft_assetfolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assetfiles_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assetfiles_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_assetsources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_assetfolders`
-- ----------------------------
DROP TABLE IF EXISTS `craft_assetfolders`;
CREATE TABLE `craft_assetfolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `sourceId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetfolders_name_parentId_sourceId_unq_idx` (`name`,`parentId`,`sourceId`),
  KEY `craft_assetfolders_parentId_fk` (`parentId`),
  KEY `craft_assetfolders_sourceId_fk` (`sourceId`),
  CONSTRAINT `craft_assetfolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_assetfolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assetfolders_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_assetsources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_assetindexdata`
-- ----------------------------
DROP TABLE IF EXISTS `craft_assetindexdata`;
CREATE TABLE `craft_assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sourceId` int(10) NOT NULL,
  `offset` int(10) NOT NULL,
  `uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` int(10) DEFAULT NULL,
  `recordId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetindexdata_sessionId_sourceId_offset_unq_idx` (`sessionId`,`sourceId`,`offset`),
  KEY `craft_assetindexdata_sourceId_fk` (`sourceId`),
  CONSTRAINT `craft_assetindexdata_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_assetsources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_assetsources`
-- ----------------------------
DROP TABLE IF EXISTS `craft_assetsources`;
CREATE TABLE `craft_assetsources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `fieldLayoutId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetsources_name_unq_idx` (`name`),
  UNIQUE KEY `craft_assetsources_handle_unq_idx` (`handle`),
  KEY `craft_assetsources_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_assetsources_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_assettransformindex`
-- ----------------------------
DROP TABLE IF EXISTS `craft_assettransformindex`;
CREATE TABLE `craft_assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fileId` int(11) NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `format` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sourceId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT NULL,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assettransformindex_sourceId_fileId_location_idx` (`sourceId`,`fileId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_assettransforms`
-- ----------------------------
DROP TABLE IF EXISTS `craft_assettransforms`;
CREATE TABLE `craft_assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mode` enum('stretch','fit','crop') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'center-center',
  `height` int(10) DEFAULT NULL,
  `width` int(10) DEFAULT NULL,
  `format` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quality` int(10) DEFAULT NULL,
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `craft_assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_categories`
-- ----------------------------
DROP TABLE IF EXISTS `craft_categories`;
CREATE TABLE `craft_categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categories_groupId_fk` (`groupId`),
  CONSTRAINT `craft_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_categorygroups`
-- ----------------------------
DROP TABLE IF EXISTS `craft_categorygroups`;
CREATE TABLE `craft_categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hasUrls` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `template` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `craft_categorygroups_handle_unq_idx` (`handle`),
  KEY `craft_categorygroups_structureId_fk` (`structureId`),
  KEY `craft_categorygroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_categorygroups_i18n`
-- ----------------------------
DROP TABLE IF EXISTS `craft_categorygroups_i18n`;
CREATE TABLE `craft_categorygroups_i18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `urlFormat` text COLLATE utf8_unicode_ci,
  `nestedUrlFormat` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_categorygroups_i18n_groupId_locale_unq_idx` (`groupId`,`locale`),
  KEY `craft_categorygroups_i18n_locale_fk` (`locale`),
  CONSTRAINT `craft_categorygroups_i18n_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categorygroups_i18n_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_content`
-- ----------------------------
DROP TABLE IF EXISTS `craft_content`;
CREATE TABLE `craft_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_body` text COLLATE utf8_unicode_ci,
  `field_area` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'hebdenbridge',
  `field_skillsNeeded` text COLLATE utf8_unicode_ci,
  `field_location` text COLLATE utf8_unicode_ci,
  `field_youWillNeed` text COLLATE utf8_unicode_ci,
  `field_numberOfHelpersNeeded` int(10) unsigned DEFAULT '0',
  `field_priority` varchar(255) COLLATE utf8_unicode_ci DEFAULT '10',
  `field_equipmentNeeded` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_content_elementId_locale_unq_idx` (`elementId`,`locale`),
  KEY `craft_content_title_idx` (`title`),
  KEY `craft_content_locale_fk` (`locale`),
  CONSTRAINT `craft_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_content_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_content`
-- ----------------------------
BEGIN;
INSERT INTO `craft_content` VALUES ('1', '1', 'en_gb', null, null, 'hebdenbridge', null, null, null, '0', null, null, '2015-12-28 09:10:56', '2015-12-28 09:10:56', '050883ed-d83b-4664-982e-f67674cec009'), ('2', '2', 'en_gb', 'Welcome to Floodhelpers.dev!', '<p>It’s true, this site doesn’t have a whole lot of content yet, but don’t worry. Our web developers have just installed the CMS, and they’re setting things up for the content editors this very moment. Soon Floodhelpers.dev will be an oasis of fresh perspectives, sharp analyses, and astute opinions that will keep you coming back again and again. woot</p>', 'hebdenbridge', null, null, null, '0', null, null, '2015-12-28 09:10:59', '2015-12-28 09:36:26', 'e139460e-a0a8-46fd-908f-0b54d507a621'), ('3', '3', 'en_gb', 'We just installed Craft!', '<p>Craft is the CMS that’s powering Floodhelpers.dev. It’s beautiful, powerful, flexible, and easy-to-use, and it’s made by Pixel &amp; Tonic. We can’t wait to dive in and see what it’s capable of!</p><!--pagebreak--><p>This is even more captivating content, which you couldn’t see on the News index page because it was entered after a Page Break, and the News index template only likes to show the content on the first page.</p><p>Craft: a nice alternative to Word, if you’re making a website.</p>', 'hebdenbridge', null, null, null, '0', null, null, '2015-12-28 09:10:59', '2015-12-28 09:10:59', 'aa0f7322-57bb-423f-9ecb-e6d3a4bfbcf9'), ('4', '4', 'en_gb', 'Clean up the Cinema 1', null, 'hebdenbridge', 'Shovelling, buckets, general help, heavy lifting.', 'Market street, Hebden Bridge', 'Wellies, Gloves', '5', null, null, '2015-12-28 09:17:28', '2015-12-28 11:49:28', '95fc86b3-890d-46ae-8b83-578034f8b7cf'), ('5', '5', 'en_gb', 'Test entry', null, 'hebdenbridge', 'Electrician, Shovelling', 'HX7123', 'Wellies, Gloves, stuff', '5', null, null, '2015-12-28 10:15:31', '2015-12-28 11:15:37', '7afbd0fe-23f3-49c0-a92b-24c24b19c399'), ('6', '6', 'en_gb', 'Clean up the Cinema', null, 'hebdenbridge', 'Electrics, shovels', 'HX78AD', 'Wellies,. waders', '10', null, null, '2015-12-28 11:40:38', '2015-12-28 11:40:38', 'a05ffc26-844b-4d53-b965-9f28f9dd8a72');
COMMIT;

-- ----------------------------
--  Table structure for `craft_deprecationerrors`
-- ----------------------------
DROP TABLE IF EXISTS `craft_deprecationerrors`;
CREATE TABLE `craft_deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fingerprint` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `line` smallint(6) unsigned NOT NULL,
  `class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `method` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `template` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `templateLine` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `traces` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_elementindexsettings`
-- ----------------------------
DROP TABLE IF EXISTS `craft_elementindexsettings`;
CREATE TABLE `craft_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_elementindexsettings`
-- ----------------------------
BEGIN;
INSERT INTO `craft_elementindexsettings` VALUES ('1', 'Entry', '{\"sourceOrder\":[[\"heading\",\"Channels\"],[\"key\",\"section:3\"],[\"key\",\"section:2\"],[\"key\",\"*\"],[\"key\",\"singles\"]],\"sources\":{\"section:3\":{\"tableAttributes\":{\"1\":\"postDate\",\"2\":\"expiryDate\",\"3\":\"link\"}},\"singles\":{\"tableAttributes\":{\"1\":\"link\"}}}}', '2015-12-28 09:34:04', '2015-12-28 09:34:04', 'ce599616-ef44-45ef-b22c-a89fa12408b8');
COMMIT;

-- ----------------------------
--  Table structure for `craft_elements`
-- ----------------------------
DROP TABLE IF EXISTS `craft_elements`;
CREATE TABLE `craft_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `archived` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_elements_type_idx` (`type`),
  KEY `craft_elements_enabled_idx` (`enabled`),
  KEY `craft_elements_archived_dateCreated_idx` (`archived`,`dateCreated`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_elements`
-- ----------------------------
BEGIN;
INSERT INTO `craft_elements` VALUES ('1', 'User', '1', '0', '2015-12-28 09:10:56', '2015-12-28 09:10:56', '48582424-16de-4df9-bc98-ce5fb36826b7'), ('2', 'Entry', '1', '0', '2015-12-28 09:10:59', '2015-12-28 09:36:26', '4d8f3483-acf2-4fd4-8beb-302afde60a27'), ('3', 'Entry', '1', '0', '2015-12-28 09:10:59', '2015-12-28 09:10:59', 'bb2f0ef9-4590-4277-a506-b51d4d2a4c6f'), ('4', 'Entry', '1', '0', '2015-12-28 09:17:28', '2015-12-28 11:49:28', 'a7db87ab-52a2-4179-b375-751c170f3fe8'), ('5', 'Entry', '1', '0', '2015-12-28 10:15:31', '2015-12-28 11:15:37', 'dbbe3d44-25f4-459b-865b-121ae2544a10'), ('6', 'Entry', '1', '0', '2015-12-28 11:40:38', '2015-12-28 11:40:38', '8783da09-7c4c-4b8f-acc3-3cecd20626ac');
COMMIT;

-- ----------------------------
--  Table structure for `craft_elements_i18n`
-- ----------------------------
DROP TABLE IF EXISTS `craft_elements_i18n`;
CREATE TABLE `craft_elements_i18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elements_i18n_elementId_locale_unq_idx` (`elementId`,`locale`),
  UNIQUE KEY `craft_elements_i18n_uri_locale_unq_idx` (`uri`,`locale`),
  KEY `craft_elements_i18n_slug_locale_idx` (`slug`,`locale`),
  KEY `craft_elements_i18n_enabled_idx` (`enabled`),
  KEY `craft_elements_i18n_locale_fk` (`locale`),
  CONSTRAINT `craft_elements_i18n_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_elements_i18n_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_elements_i18n`
-- ----------------------------
BEGIN;
INSERT INTO `craft_elements_i18n` VALUES ('1', '1', 'en_gb', '', null, '1', '2015-12-28 09:10:56', '2015-12-28 09:10:56', 'ffbe0caa-d81e-4ca5-a28f-57b5ddbf763d'), ('2', '2', 'en_gb', 'homepage', '__home__', '1', '2015-12-28 09:10:59', '2015-12-28 09:36:26', '6be2e061-7f07-48c1-82f8-5f47987c0914'), ('3', '3', 'en_gb', 'we-just-installed-craft', 'news/2015/we-just-installed-craft', '1', '2015-12-28 09:10:59', '2015-12-28 09:10:59', '4d04adec-593f-4d8e-9b40-6d4085c8057e'), ('4', '4', 'en_gb', 'clean-up-the-cinema', null, '1', '2015-12-28 09:17:28', '2015-12-28 11:49:28', '3d0ad84c-8da5-4ad3-89c2-3eff313bc73d'), ('5', '5', 'en_gb', 'test-entry', null, '1', '2015-12-28 10:15:31', '2015-12-28 11:15:37', 'd32bcbf5-a93b-4b5e-b219-0a75eee17f38'), ('6', '6', 'en_gb', 'clean-up-the-cinema', null, '1', '2015-12-28 11:40:38', '2015-12-28 11:40:38', '3e702141-466d-4d26-b144-b6d63ecaa506');
COMMIT;

-- ----------------------------
--  Table structure for `craft_emailmessages`
-- ----------------------------
DROP TABLE IF EXISTS `craft_emailmessages`;
CREATE TABLE `craft_emailmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` char(150) COLLATE utf8_unicode_ci NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_emailmessages_key_locale_unq_idx` (`key`,`locale`),
  KEY `craft_emailmessages_locale_fk` (`locale`),
  CONSTRAINT `craft_emailmessages_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_entries`
-- ----------------------------
DROP TABLE IF EXISTS `craft_entries`;
CREATE TABLE `craft_entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `typeId` int(11) DEFAULT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entries_sectionId_idx` (`sectionId`),
  KEY `craft_entries_typeId_idx` (`typeId`),
  KEY `craft_entries_postDate_idx` (`postDate`),
  KEY `craft_entries_expiryDate_idx` (`expiryDate`),
  KEY `craft_entries_authorId_fk` (`authorId`),
  CONSTRAINT `craft_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_entries`
-- ----------------------------
BEGIN;
INSERT INTO `craft_entries` VALUES ('2', '1', null, null, '2015-12-28 09:10:59', null, '2015-12-28 09:10:59', '2015-12-28 09:36:26', '4337b930-e981-48b2-b426-e5ce3792d427'), ('3', '2', '2', '1', '2015-12-28 09:10:59', null, '2015-12-28 09:10:59', '2015-12-28 09:10:59', '4e37d7ce-f92d-4fd7-a913-d9b5b64df400'), ('4', '3', '3', '1', '2015-12-28 09:17:00', null, '2015-12-28 09:17:28', '2015-12-28 11:49:28', 'a3436006-b2a9-49c7-972f-cbcabf8aa37e'), ('5', '3', '3', '1', '2015-12-28 10:15:00', null, '2015-12-28 10:15:31', '2015-12-28 11:15:37', '0b324a9d-948c-4f0f-9c49-20879d1a7ca3'), ('6', '3', '3', '1', '2015-12-28 11:40:38', null, '2015-12-28 11:40:38', '2015-12-28 11:40:38', 'cf6221b9-67d6-4d94-ade1-0b6352b72ca0');
COMMIT;

-- ----------------------------
--  Table structure for `craft_entrydrafts`
-- ----------------------------
DROP TABLE IF EXISTS `craft_entrydrafts`;
CREATE TABLE `craft_entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `notes` tinytext COLLATE utf8_unicode_ci,
  `data` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entrydrafts_entryId_locale_idx` (`entryId`,`locale`),
  KEY `craft_entrydrafts_sectionId_fk` (`sectionId`),
  KEY `craft_entrydrafts_creatorId_fk` (`creatorId`),
  KEY `craft_entrydrafts_locale_fk` (`locale`),
  CONSTRAINT `craft_entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_entrytypes`
-- ----------------------------
DROP TABLE IF EXISTS `craft_entrytypes`;
CREATE TABLE `craft_entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hasTitleField` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Title',
  `titleFormat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `craft_entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `craft_entrytypes_sectionId_fk` (`sectionId`),
  KEY `craft_entrytypes_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_entrytypes`
-- ----------------------------
BEGIN;
INSERT INTO `craft_entrytypes` VALUES ('1', '1', '3', 'Homepage', 'homepage', '1', 'Title', null, null, '2015-12-28 09:10:59', '2015-12-28 09:10:59', 'e02117a5-ab58-4b2a-a007-307aedd095e8'), ('2', '2', '5', 'News', 'news', '1', 'Title', null, null, '2015-12-28 09:10:59', '2015-12-28 09:10:59', 'fd0a65a2-7984-4e04-901c-e5ee72bf167d'), ('3', '3', '10', 'Tasks', 'tasks', '1', 'Task name', null, null, '2015-12-28 09:12:05', '2015-12-28 09:31:40', '2d4003f8-6120-4eee-8879-8c58617816d6');
COMMIT;

-- ----------------------------
--  Table structure for `craft_entryversions`
-- ----------------------------
DROP TABLE IF EXISTS `craft_entryversions`;
CREATE TABLE `craft_entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` tinytext COLLATE utf8_unicode_ci,
  `data` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entryversions_entryId_locale_idx` (`entryId`,`locale`),
  KEY `craft_entryversions_sectionId_fk` (`sectionId`),
  KEY `craft_entryversions_creatorId_fk` (`creatorId`),
  KEY `craft_entryversions_locale_fk` (`locale`),
  CONSTRAINT `craft_entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_entryversions`
-- ----------------------------
BEGIN;
INSERT INTO `craft_entryversions` VALUES ('1', '2', '1', '1', 'en_gb', '1', null, '{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Homepage\",\"slug\":\"homepage\",\"postDate\":1451293859,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":[]}', '2015-12-28 09:10:59', '2015-12-28 09:10:59', '2f741817-c886-4162-b80b-bd71d51c8b92'), ('2', '2', '1', '1', 'en_gb', '2', null, '{\"typeId\":null,\"authorId\":null,\"title\":\"Welcome to Floodhelpers.dev!\",\"slug\":\"homepage\",\"postDate\":1451293859,\"expiryDate\":null,\"enabled\":\"1\",\"parentId\":null,\"fields\":{\"1\":\"<p>It\\u2019s true, this site doesn\\u2019t have a whole lot of content yet, but don\\u2019t worry. Our web developers have just installed the CMS, and they\\u2019re setting things up for the content editors this very moment. Soon Floodhelpers.dev will be an oasis of fresh perspectives, sharp analyses, and astute opinions that will keep you coming back again and again.<\\/p>\"}}', '2015-12-28 09:10:59', '2015-12-28 09:10:59', '8841b704-c2df-417c-ae83-0cd207b8cfef'), ('3', '3', '2', '1', 'en_gb', '1', null, '{\"typeId\":\"2\",\"authorId\":\"1\",\"title\":\"We just installed Craft!\",\"slug\":\"we-just-installed-craft\",\"postDate\":1451293859,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":[]}', '2015-12-28 09:10:59', '2015-12-28 09:10:59', 'aeba5a34-e78e-4abe-bdcb-69544e9b2b89'), ('4', '4', '3', '1', 'en_gb', '1', '', '{\"typeId\":null,\"authorId\":\"1\",\"title\":\"Clean up the Cinema\",\"slug\":\"clean-up-the-cinema\",\"postDate\":1451294248,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":[]}', '2015-12-28 09:17:28', '2015-12-28 09:17:28', 'd036353b-338c-405c-913b-ab99369c231d'), ('5', '2', '1', '1', 'en_gb', '3', '', '{\"typeId\":null,\"authorId\":null,\"title\":\"Welcome to Floodhelpers.dev!\",\"slug\":\"homepage\",\"postDate\":1451293859,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"1\":\"<p>It\\u2019s true, this site doesn\\u2019t have a whole lot of content yet, but don\\u2019t worry. Our web developers have just installed the CMS, and they\\u2019re setting things up for the content editors this very moment. Soon Floodhelpers.dev will be an oasis of fresh perspectives, sharp analyses, and astute opinions that will keep you coming back again and again. woot<\\/p>\"}}', '2015-12-28 09:36:26', '2015-12-28 09:36:26', 'c1bfd702-f2f1-4276-8a22-0165ba99a7f9'), ('6', '4', '3', '1', 'en_gb', '2', '', '{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Clean up the Cinema\",\"slug\":\"clean-up-the-cinema\",\"postDate\":1451294220,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"3\":\"hebdenbridge\",\"5\":\"Market street, Hebden Bridge\",\"7\":\"5\",\"4\":\"Shovelling, buckets, general help, heavy lifting.\",\"6\":\"Wellies, Gloves\"}}', '2015-12-28 10:10:16', '2015-12-28 10:10:16', '465afaf9-fd8d-43d6-b2b5-840542ae8d96'), ('7', '5', '3', '1', 'en_gb', '1', '', '{\"typeId\":null,\"authorId\":\"1\",\"title\":\"Test entry\",\"slug\":\"test-entry\",\"postDate\":1451297731,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"3\":\"hebdenbridge\",\"5\":\"Stubbing drive \",\"7\":\"5\",\"4\":\"Electrician, Shovelling\",\"6\":\"\"}}', '2015-12-28 10:15:31', '2015-12-28 10:15:31', 'f742d664-2b59-4950-916a-9ad94af5ed26'), ('8', '5', '3', '1', 'en_gb', '2', '', '{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Test entry\",\"slug\":\"test-entry\",\"postDate\":1451297700,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"3\":\"hebdenbridge\",\"5\":\"Stubbing drive \",\"7\":\"5\",\"4\":\"Electrician, Shovelling\",\"6\":\"Wellies, Gloves, stuff\"}}', '2015-12-28 10:16:07', '2015-12-28 10:16:07', '61f4b5f5-b162-458a-9809-735103ca2e1a'), ('9', '5', '3', '1', 'en_gb', '3', '', '{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Test entry\",\"slug\":\"test-entry\",\"postDate\":1451297700,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"3\":\"hebdenbridge\",\"7\":\"5\",\"5\":\"HX7123\",\"4\":\"Electrician, Shovelling\",\"6\":\"Wellies, Gloves, stuff\"}}', '2015-12-28 11:11:59', '2015-12-28 11:11:59', '4ac28c3f-b607-4c7c-a27c-233a1cef8f25'), ('10', '5', '3', '1', 'en_gb', '4', '', '{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Test entry\",\"slug\":\"test-entry\",\"postDate\":1451297700,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"3\":\"hebdenbridge\",\"7\":\"5\",\"5\":\"HX7123\",\"4\":\"Electrician, Shovelling\",\"6\":\"Wellies, Gloves, stuff\"}}', '2015-12-28 11:15:37', '2015-12-28 11:15:37', '1bcca97d-360b-4b50-916e-2e4e7542272d'), ('11', '6', '3', '1', 'en_gb', '1', '', '{\"typeId\":null,\"authorId\":\"1\",\"title\":\"Clean up the Cinema\",\"slug\":\"clean-up-the-cinema\",\"postDate\":1451302838,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"3\":\"hebdenbridge\",\"7\":\"10\",\"5\":\"HX78AD\",\"4\":\"Electrics, shovels\",\"6\":\"Wellies,. waders\"}}', '2015-12-28 11:40:38', '2015-12-28 11:40:38', '9f0a78bb-2966-45d6-80e7-28018a8559c1'), ('12', '4', '3', '1', 'en_gb', '3', '', '{\"typeId\":\"3\",\"authorId\":\"1\",\"title\":\"Clean up the Cinema 1\",\"slug\":\"clean-up-the-cinema\",\"postDate\":1451294220,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"3\":\"hebdenbridge\",\"7\":\"5\",\"5\":\"Market street, Hebden Bridge\",\"4\":\"Shovelling, buckets, general help, heavy lifting.\",\"6\":\"Wellies, Gloves\"}}', '2015-12-28 11:49:28', '2015-12-28 11:49:28', '3304d55f-0dc1-412e-879b-f6f525802339');
COMMIT;

-- ----------------------------
--  Table structure for `craft_fieldgroups`
-- ----------------------------
DROP TABLE IF EXISTS `craft_fieldgroups`;
CREATE TABLE `craft_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_fieldgroups`
-- ----------------------------
BEGIN;
INSERT INTO `craft_fieldgroups` VALUES ('1', 'Default', '2015-12-28 09:10:59', '2015-12-28 09:10:59', '5115c406-459a-46ae-b553-e5132ec3f383');
COMMIT;

-- ----------------------------
--  Table structure for `craft_fieldlayoutfields`
-- ----------------------------
DROP TABLE IF EXISTS `craft_fieldlayoutfields`;
CREATE TABLE `craft_fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sortOrder` tinyint(4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `craft_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayoutfields_tabId_fk` (`tabId`),
  KEY `craft_fieldlayoutfields_fieldId_fk` (`fieldId`),
  CONSTRAINT `craft_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `craft_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_fieldlayoutfields`
-- ----------------------------
BEGIN;
INSERT INTO `craft_fieldlayoutfields` VALUES ('1', '3', '1', '1', '1', '1', '2015-12-28 09:10:59', '2015-12-28 09:10:59', 'd083af2e-803c-4dc5-95ac-3041b0ad521a'), ('2', '5', '2', '1', '1', '1', '2015-12-28 09:10:59', '2015-12-28 09:10:59', '97d76b4e-e3e4-4580-970c-6e52eb9b2f41'), ('3', '5', '2', '2', '0', '2', '2015-12-28 09:10:59', '2015-12-28 09:10:59', '1c936dbe-5122-4d7d-8e56-0f353aef948b'), ('12', '10', '5', '3', '0', '1', '2015-12-28 09:31:40', '2015-12-28 09:31:40', '1d36b6fb-ee42-4d16-a6e7-f763f1356950'), ('13', '10', '5', '5', '0', '2', '2015-12-28 09:31:40', '2015-12-28 09:31:40', 'c8e57621-dfec-44d5-9565-229a9dc0f08e'), ('14', '10', '5', '7', '0', '3', '2015-12-28 09:31:40', '2015-12-28 09:31:40', 'ea75a633-798d-4f10-b8f5-41b3a75991eb'), ('15', '10', '5', '4', '0', '4', '2015-12-28 09:31:40', '2015-12-28 09:31:40', '139a57b0-f84b-4df2-8f52-a798c25f1e03'), ('16', '10', '5', '6', '0', '5', '2015-12-28 09:31:40', '2015-12-28 09:31:40', '4a7b199a-f9ff-495d-8b78-8d777d6aa7d1');
COMMIT;

-- ----------------------------
--  Table structure for `craft_fieldlayouts`
-- ----------------------------
DROP TABLE IF EXISTS `craft_fieldlayouts`;
CREATE TABLE `craft_fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_fieldlayouts`
-- ----------------------------
BEGIN;
INSERT INTO `craft_fieldlayouts` VALUES ('1', 'Tag', '2015-12-28 09:10:59', '2015-12-28 09:10:59', 'dd0a156c-43b0-4796-8dd2-57e4bcd9cac5'), ('3', 'Entry', '2015-12-28 09:10:59', '2015-12-28 09:10:59', '295fc1e2-9c90-4478-8199-6d0045858ef8'), ('5', 'Entry', '2015-12-28 09:10:59', '2015-12-28 09:10:59', '9f4d7acd-b09a-4c77-9d6a-66a66c2d6712'), ('10', 'Entry', '2015-12-28 09:31:40', '2015-12-28 09:31:40', 'f3a1531b-b7a0-483b-9fec-df9340554b13');
COMMIT;

-- ----------------------------
--  Table structure for `craft_fieldlayouttabs`
-- ----------------------------
DROP TABLE IF EXISTS `craft_fieldlayouttabs`;
CREATE TABLE `craft_fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayouttabs_layoutId_fk` (`layoutId`),
  CONSTRAINT `craft_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_fieldlayouttabs`
-- ----------------------------
BEGIN;
INSERT INTO `craft_fieldlayouttabs` VALUES ('1', '3', 'Content', '1', '2015-12-28 09:10:59', '2015-12-28 09:10:59', 'b74300b3-439e-4ee5-8dc5-8dd3a01caa21'), ('2', '5', 'Content', '1', '2015-12-28 09:10:59', '2015-12-28 09:10:59', '0805ba74-4d7c-4782-9292-c0e3cad8e4df'), ('5', '10', 'Tab 1', '1', '2015-12-28 09:31:40', '2015-12-28 09:31:40', '9155026e-c46c-4a35-83b8-6ea87fd7074b');
COMMIT;

-- ----------------------------
--  Table structure for `craft_fields`
-- ----------------------------
DROP TABLE IF EXISTS `craft_fields`;
CREATE TABLE `craft_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(58) COLLATE utf8_unicode_ci NOT NULL,
  `context` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'global',
  `instructions` text COLLATE utf8_unicode_ci,
  `translatable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `craft_fields_context_idx` (`context`),
  KEY `craft_fields_groupId_fk` (`groupId`),
  CONSTRAINT `craft_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_fields`
-- ----------------------------
BEGIN;
INSERT INTO `craft_fields` VALUES ('1', '1', 'Body', 'body', 'global', null, '1', 'RichText', '{\"configFile\":\"Standard.json\",\"columnType\":\"text\"}', '2015-12-28 09:10:59', '2015-12-28 09:10:59', 'bcb11092-d7b4-4efb-af6e-81016bfcce0d'), ('2', '1', 'Tags', 'tags', 'global', null, '0', 'Tags', '{\"source\":\"taggroup:1\"}', '2015-12-28 09:10:59', '2015-12-28 09:10:59', '68caeb61-2ad9-4182-8e00-11c3b7912752'), ('3', '1', 'Area', 'area', 'global', 'The geographical area that the task is located n', '0', 'RadioButtons', '{\"options\":[{\"label\":\"Hebden Bridge\",\"value\":\"hebdenbridge\",\"default\":\"1\"},{\"label\":\"Mytholmroyd\",\"value\":\"mytholmroyd\",\"default\":\"\"},{\"label\":\"Todmorden\",\"value\":\"todmorden\",\"default\":\"\"},{\"label\":\"Walsden\",\"value\":\"walsden\",\"default\":\"\"},{\"label\":\"Sowerby Bridge\",\"value\":\"sowerbybridge\",\"default\":\"\"}]}', '2015-12-28 09:23:08', '2015-12-28 09:23:08', 'b5a9dc56-2c62-434d-a0d9-94efecc5e4c2'), ('4', '1', 'Skills Needed', 'skillsNeeded', 'global', 'The specific skills needed to help with the task', '0', 'PlainText', '{\"placeholder\":\"\",\"maxLength\":\"\",\"multiline\":\"\",\"initialRows\":\"4\"}', '2015-12-28 09:24:46', '2015-12-28 09:24:46', 'dcb7a12b-0cac-44cd-960e-375f3d61bab4'), ('5', '1', 'Location', 'location', 'global', 'The specific postcode or location where the help is needed.', '0', 'PlainText', '{\"placeholder\":\"\",\"maxLength\":\"\",\"multiline\":\"\",\"initialRows\":\"4\"}', '2015-12-28 09:25:57', '2015-12-28 12:02:26', '22ebdc75-3e97-4263-b6b2-ff9ea870fc05'), ('6', '1', 'Equipment volunteers will need', 'youWillNeed', 'global', 'What the volunteers will need', '0', 'PlainText', '{\"placeholder\":\"Wellies and gloves\",\"maxLength\":\"\",\"multiline\":\"\",\"initialRows\":\"4\"}', '2015-12-28 09:26:54', '2015-12-28 12:03:01', 'ba614649-9034-459e-8052-734b7603961e'), ('7', '1', 'Number of helpers needed', 'numberOfHelpersNeeded', 'global', 'How many helpers are needed', '0', 'Number', '{\"min\":\"1\",\"max\":\"\",\"decimals\":\"0\"}', '2015-12-28 09:27:51', '2015-12-28 09:27:51', 'd4e24c25-c0e0-4b94-8b5c-f00cb6764131'), ('8', '1', 'Priority', 'priority', 'global', 'How urgent is it. \r\n1 to 10 \r\n1 is most urgent', '0', 'Dropdown', '{\"options\":[{\"label\":\"10\",\"value\":\"10\",\"default\":\"1\"},{\"label\":\"9\",\"value\":\"9\",\"default\":\"\"},{\"label\":\"8\",\"value\":\"8\",\"default\":\"\"},{\"label\":\"7\",\"value\":\"7\",\"default\":\"\"},{\"label\":\"6\",\"value\":\"6\",\"default\":\"\"},{\"label\":\"5\",\"value\":\"5\",\"default\":\"\"},{\"label\":\"4\",\"value\":\"4\",\"default\":\"\"},{\"label\":\"3\",\"value\":\"3\",\"default\":\"\"},{\"label\":\"2\",\"value\":\"2\",\"default\":\"\"},{\"label\":\"1\",\"value\":\"1\",\"default\":\"\"}]}', '2015-12-28 11:33:19', '2015-12-28 12:01:59', '4708b95a-db97-4eca-b3f2-9fde1e992633'), ('9', '1', 'Equipment needed', 'equipmentNeeded', 'global', 'The specific equipment the task needs', '0', 'PlainText', '{\"placeholder\":\"\",\"maxLength\":\"\",\"multiline\":\"\",\"initialRows\":\"4\"}', '2015-12-28 12:04:18', '2015-12-28 12:04:18', '70644643-59e8-45b2-b9a6-f472d3ab11aa');
COMMIT;

-- ----------------------------
--  Table structure for `craft_globalsets`
-- ----------------------------
DROP TABLE IF EXISTS `craft_globalsets`;
CREATE TABLE `craft_globalsets` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fieldLayoutId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `craft_globalsets_handle_unq_idx` (`handle`),
  KEY `craft_globalsets_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_info`
-- ----------------------------
DROP TABLE IF EXISTS `craft_info`;
CREATE TABLE `craft_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `build` int(11) unsigned NOT NULL,
  `schemaVersion` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `releaseDate` datetime NOT NULL,
  `edition` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `siteName` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `siteUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `timezone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `on` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `maintenance` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `track` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_info`
-- ----------------------------
BEGIN;
INSERT INTO `craft_info` VALUES ('1', '2.5', '2755', '2.5.11', '2015-12-16 22:42:32', '0', 'Flood helpers', 'http://floodhelpers.dev', 'UTC', '1', '0', 'stable', '2015-12-28 09:10:54', '2015-12-28 09:38:30', '018f1e44-83af-49f6-9cca-31ae0cdb2ddf');
COMMIT;

-- ----------------------------
--  Table structure for `craft_locales`
-- ----------------------------
DROP TABLE IF EXISTS `craft_locales`;
CREATE TABLE `craft_locales` (
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`locale`),
  KEY `craft_locales_sortOrder_idx` (`sortOrder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_locales`
-- ----------------------------
BEGIN;
INSERT INTO `craft_locales` VALUES ('en_gb', '1', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '3a54e79e-db5a-4a8c-9b9d-4b5ede8eba22');
COMMIT;

-- ----------------------------
--  Table structure for `craft_matrixblocks`
-- ----------------------------
DROP TABLE IF EXISTS `craft_matrixblocks`;
CREATE TABLE `craft_matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) DEFAULT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `ownerLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `craft_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocks_typeId_idx` (`typeId`),
  KEY `craft_matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `craft_matrixblocks_ownerLocale_fk` (`ownerLocale`),
  CONSTRAINT `craft_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerLocale_fk` FOREIGN KEY (`ownerLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_matrixblocktypes`
-- ----------------------------
DROP TABLE IF EXISTS `craft_matrixblocktypes`;
CREATE TABLE `craft_matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `craft_matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `craft_matrixblocktypes_fieldId_fk` (`fieldId`),
  KEY `craft_matrixblocktypes_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_migrations`
-- ----------------------------
DROP TABLE IF EXISTS `craft_migrations`;
CREATE TABLE `craft_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_migrations_version_unq_idx` (`version`),
  KEY `craft_migrations_pluginId_fk` (`pluginId`),
  CONSTRAINT `craft_migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `craft_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_migrations`
-- ----------------------------
BEGIN;
INSERT INTO `craft_migrations` VALUES ('1', null, 'm000000_000000_base', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', 'd1234ac8-f6e6-43bc-9dcc-4bf74d7c8439'), ('2', null, 'm140730_000001_add_filename_and_format_to_transformindex', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', 'dfc8eb6b-0ab3-43ed-a6e0-f29a2f14ecbe'), ('3', null, 'm140815_000001_add_format_to_transforms', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '5f2bc642-04be-49ff-813b-0c6eb56b5a9f'), ('4', null, 'm140822_000001_allow_more_than_128_items_per_field', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '058d4a81-a701-4492-b206-5e813a402b20'), ('5', null, 'm140829_000001_single_title_formats', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', 'b23b75fa-0276-4a40-a1ab-7f78653a0974'), ('6', null, 'm140831_000001_extended_cache_keys', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', 'a4c953a2-8ac7-4815-ab01-b8f80a9734d7'), ('7', null, 'm140922_000001_delete_orphaned_matrix_blocks', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', 'd06db438-5f88-4f4f-b30c-9962a9ccbfe2'), ('8', null, 'm141008_000001_elements_index_tune', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', 'dbaea032-b50d-4722-8ac5-270a97be297f'), ('9', null, 'm141009_000001_assets_source_handle', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', 'f01bf84f-7a4d-49e1-95a7-bb0f3c63eba7'), ('10', null, 'm141024_000001_field_layout_tabs', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '3fc47bea-2466-488e-8c58-3beb7c603c4a'), ('11', null, 'm141030_000000_plugin_schema_versions', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2a05ab92-6dcf-4d0e-b6cf-586b63713ff9'), ('12', null, 'm141030_000001_drop_structure_move_permission', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '3eb92ad9-932b-43a7-a0bb-27b458233159'), ('13', null, 'm141103_000001_tag_titles', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '3a7825b4-6398-4273-8a1d-6b835d010192'), ('14', null, 'm141109_000001_user_status_shuffle', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', 'dabb57ca-9f2a-4af2-ad95-c3ee5544909b'), ('15', null, 'm141126_000001_user_week_start_day', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2efbf55a-fbc5-476a-a11b-e32a23cee469'), ('16', null, 'm150210_000001_adjust_user_photo_size', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '12daf685-23b3-4146-9a60-fdbf4f93c761'), ('17', null, 'm150724_000001_adjust_quality_settings', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '4a04f46b-1249-4537-9c30-83655f307434'), ('18', null, 'm150827_000000_element_index_settings', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', 'c722f87f-17a8-4a87-ae6c-c28e38c30531'), ('19', null, 'm150918_000001_add_colspan_to_widgets', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', 'deebdcdd-612d-42cd-9263-8e8d99806bf6'), ('20', null, 'm151007_000000_clear_asset_caches', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '465a614b-9634-48a5-9ac0-bf4abd6f34af'), ('21', null, 'm151109_000000_text_url_formats', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '68bf5686-9945-4fa9-bb1a-99ea400ddb7d'), ('22', null, 'm151110_000000_move_logo', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '52115573-5725-49a6-a5b0-6355a5128d56'), ('23', null, 'm151117_000000_adjust_image_widthheight', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', 'cdf54b3e-78d3-4580-975c-c8d4b062ba48'), ('24', null, 'm151127_000000_clear_license_key_status', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', 'b0599c78-d5f4-4044-9a16-36bd80cef1d8'), ('25', null, 'm151127_000000_plugin_license_keys', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '6fbf7f09-8dfa-47a0-9779-b1abfd957064'), ('26', null, 'm151130_000000_update_pt_widget_feeds', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '2015-12-28 09:10:54', '7805e793-be09-41fc-8ac2-a49399e5ed14');
COMMIT;

-- ----------------------------
--  Table structure for `craft_plugins`
-- ----------------------------
DROP TABLE IF EXISTS `craft_plugins`;
CREATE TABLE `craft_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `schemaVersion` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `licenseKey` char(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','unknown') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unknown',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `settings` text COLLATE utf8_unicode_ci,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_rackspaceaccess`
-- ----------------------------
DROP TABLE IF EXISTS `craft_rackspaceaccess`;
CREATE TABLE `craft_rackspaceaccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `connectionKey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `storageUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cdnUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_rackspaceaccess_connectionKey_unq_idx` (`connectionKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_relations`
-- ----------------------------
DROP TABLE IF EXISTS `craft_relations`;
CREATE TABLE `craft_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_relations_fieldId_sourceId_sourceLocale_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceLocale`,`targetId`),
  KEY `craft_relations_sourceId_fk` (`sourceId`),
  KEY `craft_relations_sourceLocale_fk` (`sourceLocale`),
  KEY `craft_relations_targetId_fk` (`targetId`),
  CONSTRAINT `craft_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceLocale_fk` FOREIGN KEY (`sourceLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_routes`
-- ----------------------------
DROP TABLE IF EXISTS `craft_routes`;
CREATE TABLE `craft_routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `urlParts` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `urlPattern` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `template` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_routes_urlPattern_unq_idx` (`urlPattern`),
  KEY `craft_routes_locale_idx` (`locale`),
  CONSTRAINT `craft_routes_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_searchindex`
-- ----------------------------
DROP TABLE IF EXISTS `craft_searchindex`;
CREATE TABLE `craft_searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `fieldId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `keywords` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`locale`),
  FULLTEXT KEY `craft_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_searchindex`
-- ----------------------------
BEGIN;
INSERT INTO `craft_searchindex` VALUES ('1', 'username', '0', 'en_gb', ' admin '), ('1', 'firstname', '0', 'en_gb', ''), ('1', 'lastname', '0', 'en_gb', ''), ('1', 'fullname', '0', 'en_gb', ''), ('1', 'email', '0', 'en_gb', ' tim uc48 net '), ('1', 'slug', '0', 'en_gb', ''), ('2', 'slug', '0', 'en_gb', ' homepage '), ('2', 'title', '0', 'en_gb', ' welcome to floodhelpers dev '), ('2', 'field', '1', 'en_gb', ' it s true this site doesn t have a whole lot of content yet but don t worry our web developers have just installed the cms and they re setting things up for the content editors this very moment soon floodhelpers dev will be an oasis of fresh perspectives sharp analyses and astute opinions that will keep you coming back again and again woot '), ('3', 'field', '1', 'en_gb', ' craft is the cms that s powering floodhelpers dev it s beautiful powerful flexible and easy to use and it s made by pixel tonic we can t wait to dive in and see what it s capable of this is even more captivating content which you couldn t see on the news index page because it was entered after a page break and the news index template only likes to show the content on the first page craft a nice alternative to word if you re making a website '), ('3', 'field', '2', 'en_gb', ''), ('3', 'slug', '0', 'en_gb', ''), ('3', 'title', '0', 'en_gb', ' we just installed craft '), ('4', 'slug', '0', 'en_gb', ' clean up the cinema '), ('4', 'title', '0', 'en_gb', ' clean up the cinema 1 '), ('4', 'field', '3', 'en_gb', ' hebdenbridge '), ('4', 'field', '5', 'en_gb', ' market street hebden bridge '), ('4', 'field', '7', 'en_gb', ' 5 '), ('4', 'field', '4', 'en_gb', ' shovelling buckets general help heavy lifting '), ('4', 'field', '6', 'en_gb', ' wellies gloves '), ('5', 'field', '3', 'en_gb', ' hebdenbridge '), ('5', 'field', '5', 'en_gb', ' hx7123 '), ('5', 'field', '7', 'en_gb', ' 5 '), ('5', 'field', '4', 'en_gb', ' electrician shovelling '), ('5', 'field', '6', 'en_gb', ' wellies gloves stuff '), ('5', 'slug', '0', 'en_gb', ' test entry '), ('5', 'title', '0', 'en_gb', ' test entry '), ('6', 'field', '3', 'en_gb', ' hebdenbridge '), ('6', 'field', '5', 'en_gb', ' hx78ad '), ('6', 'field', '7', 'en_gb', ' 10 '), ('6', 'field', '4', 'en_gb', ' electrics shovels '), ('6', 'field', '6', 'en_gb', ' wellies waders '), ('6', 'slug', '0', 'en_gb', ' clean up the cinema '), ('6', 'title', '0', 'en_gb', ' clean up the cinema ');
COMMIT;

-- ----------------------------
--  Table structure for `craft_sections`
-- ----------------------------
DROP TABLE IF EXISTS `craft_sections`;
CREATE TABLE `craft_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('single','channel','structure') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'channel',
  `hasUrls` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `template` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enableVersioning` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sections_name_unq_idx` (`name`),
  UNIQUE KEY `craft_sections_handle_unq_idx` (`handle`),
  KEY `craft_sections_structureId_fk` (`structureId`),
  CONSTRAINT `craft_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_sections`
-- ----------------------------
BEGIN;
INSERT INTO `craft_sections` VALUES ('1', null, 'Homepage', 'homepage', 'single', '1', 'index', '1', '2015-12-28 09:10:59', '2015-12-28 09:10:59', 'b72e67d6-9aeb-4997-a7c5-bcc8cb6cb233'), ('2', null, 'News', 'news', 'channel', '1', 'news/_entry', '1', '2015-12-28 09:10:59', '2015-12-28 09:10:59', '2c992e04-76d8-423e-b874-ee48d8af81da'), ('3', null, 'Tasks', 'tasks', 'channel', '0', null, '1', '2015-12-28 09:12:05', '2015-12-28 09:12:05', 'ed110e2f-43ed-485c-be41-d135bb4f4f76');
COMMIT;

-- ----------------------------
--  Table structure for `craft_sections_i18n`
-- ----------------------------
DROP TABLE IF EXISTS `craft_sections_i18n`;
CREATE TABLE `craft_sections_i18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `enabledByDefault` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `urlFormat` text COLLATE utf8_unicode_ci,
  `nestedUrlFormat` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sections_i18n_sectionId_locale_unq_idx` (`sectionId`,`locale`),
  KEY `craft_sections_i18n_locale_fk` (`locale`),
  CONSTRAINT `craft_sections_i18n_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_sections_i18n_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_sections_i18n`
-- ----------------------------
BEGIN;
INSERT INTO `craft_sections_i18n` VALUES ('1', '1', 'en_gb', '1', '__home__', null, '2015-12-28 09:10:59', '2015-12-28 09:10:59', 'a86e1e0b-6b50-48e1-8ba1-bc073b6230b0'), ('2', '2', 'en_gb', '1', 'news/{postDate.year}/{slug}', null, '2015-12-28 09:10:59', '2015-12-28 09:10:59', 'e1a4360e-0f0e-4546-ad25-a7de40bb1331'), ('3', '3', 'en_gb', '0', null, null, '2015-12-28 09:12:05', '2015-12-28 09:12:05', 'ae3de0b9-483f-4be6-964f-3fefb1d3946b');
COMMIT;

-- ----------------------------
--  Table structure for `craft_sessions`
-- ----------------------------
DROP TABLE IF EXISTS `craft_sessions`;
CREATE TABLE `craft_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sessions_uid_idx` (`uid`),
  KEY `craft_sessions_token_idx` (`token`),
  KEY `craft_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `craft_sessions_userId_fk` (`userId`),
  CONSTRAINT `craft_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_sessions`
-- ----------------------------
BEGIN;
INSERT INTO `craft_sessions` VALUES ('1', '1', 'd85574ac1943c758d0a9ca800a24f7bc5f09b102czozMjoiVnhPSUtneUNZMENlbmZVRzFwTEZSTFpnUmxBRzgwQnIiOw==', '2015-12-28 09:10:59', '2015-12-28 09:10:59', 'c379605f-46b0-4f4e-8ac6-7c7f347ea2f8');
COMMIT;

-- ----------------------------
--  Table structure for `craft_shunnedmessages`
-- ----------------------------
DROP TABLE IF EXISTS `craft_shunnedmessages`;
CREATE TABLE `craft_shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `craft_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_structureelements`
-- ----------------------------
DROP TABLE IF EXISTS `craft_structureelements`;
CREATE TABLE `craft_structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `craft_structureelements_root_idx` (`root`),
  KEY `craft_structureelements_lft_idx` (`lft`),
  KEY `craft_structureelements_rgt_idx` (`rgt`),
  KEY `craft_structureelements_level_idx` (`level`),
  KEY `craft_structureelements_elementId_fk` (`elementId`),
  CONSTRAINT `craft_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_structures`
-- ----------------------------
DROP TABLE IF EXISTS `craft_structures`;
CREATE TABLE `craft_structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_systemsettings`
-- ----------------------------
DROP TABLE IF EXISTS `craft_systemsettings`;
CREATE TABLE `craft_systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_systemsettings`
-- ----------------------------
BEGIN;
INSERT INTO `craft_systemsettings` VALUES ('1', 'email', '{\"protocol\":\"php\",\"emailAddress\":\"tim@uc48.net\",\"senderName\":\"Floodhelpers\"}', '2015-12-28 09:10:59', '2015-12-28 09:10:59', '2e1abe62-6f48-4720-a793-8b4141478a34');
COMMIT;

-- ----------------------------
--  Table structure for `craft_taggroups`
-- ----------------------------
DROP TABLE IF EXISTS `craft_taggroups`;
CREATE TABLE `craft_taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fieldLayoutId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `craft_taggroups_handle_unq_idx` (`handle`),
  KEY `craft_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_taggroups`
-- ----------------------------
BEGIN;
INSERT INTO `craft_taggroups` VALUES ('1', 'Default', 'default', '1', '2015-12-28 09:10:59', '2015-12-28 09:10:59', '2a35be7a-610b-435f-b395-b30c19994356');
COMMIT;

-- ----------------------------
--  Table structure for `craft_tags`
-- ----------------------------
DROP TABLE IF EXISTS `craft_tags`;
CREATE TABLE `craft_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_tags_groupId_fk` (`groupId`),
  CONSTRAINT `craft_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_tasks`
-- ----------------------------
DROP TABLE IF EXISTS `craft_tasks`;
CREATE TABLE `craft_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `currentStep` int(11) unsigned DEFAULT NULL,
  `totalSteps` int(11) unsigned DEFAULT NULL,
  `status` enum('pending','error','running') COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_tasks_root_idx` (`root`),
  KEY `craft_tasks_lft_idx` (`lft`),
  KEY `craft_tasks_rgt_idx` (`rgt`),
  KEY `craft_tasks_level_idx` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_templatecachecriteria`
-- ----------------------------
DROP TABLE IF EXISTS `craft_templatecachecriteria`;
CREATE TABLE `craft_templatecachecriteria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `criteria` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecachecriteria_cacheId_fk` (`cacheId`),
  KEY `craft_templatecachecriteria_type_idx` (`type`),
  CONSTRAINT `craft_templatecachecriteria_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_templatecacheelements`
-- ----------------------------
DROP TABLE IF EXISTS `craft_templatecacheelements`;
CREATE TABLE `craft_templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `craft_templatecacheelements_cacheId_fk` (`cacheId`),
  KEY `craft_templatecacheelements_elementId_fk` (`elementId`),
  CONSTRAINT `craft_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_templatecaches`
-- ----------------------------
DROP TABLE IF EXISTS `craft_templatecaches`;
CREATE TABLE `craft_templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheKey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecaches_expiryDate_cacheKey_locale_path_idx` (`expiryDate`,`cacheKey`,`locale`,`path`),
  KEY `craft_templatecaches_locale_fk` (`locale`),
  CONSTRAINT `craft_templatecaches_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_tokens`
-- ----------------------------
DROP TABLE IF EXISTS `craft_tokens`;
CREATE TABLE `craft_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `route` text COLLATE utf8_unicode_ci,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_tokens_token_unq_idx` (`token`),
  KEY `craft_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_usergroups`
-- ----------------------------
DROP TABLE IF EXISTS `craft_usergroups`;
CREATE TABLE `craft_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_usergroups_users`
-- ----------------------------
DROP TABLE IF EXISTS `craft_usergroups_users`;
CREATE TABLE `craft_usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `craft_usergroups_users_userId_fk` (`userId`),
  CONSTRAINT `craft_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_userpermissions`
-- ----------------------------
DROP TABLE IF EXISTS `craft_userpermissions`;
CREATE TABLE `craft_userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_userpermissions_usergroups`
-- ----------------------------
DROP TABLE IF EXISTS `craft_userpermissions_usergroups`;
CREATE TABLE `craft_userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `craft_userpermissions_usergroups_groupId_fk` (`groupId`),
  CONSTRAINT `craft_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_userpermissions_users`
-- ----------------------------
DROP TABLE IF EXISTS `craft_userpermissions_users`;
CREATE TABLE `craft_userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `craft_userpermissions_users_userId_fk` (`userId`),
  CONSTRAINT `craft_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Table structure for `craft_users`
-- ----------------------------
DROP TABLE IF EXISTS `craft_users`;
CREATE TABLE `craft_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `photo` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` char(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `preferredLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `weekStartDay` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `admin` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `client` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `locked` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `suspended` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `pending` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `archived` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIPAddress` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(4) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `verificationCode` char(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `passwordResetRequired` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_users_username_unq_idx` (`username`),
  UNIQUE KEY `craft_users_email_unq_idx` (`email`),
  KEY `craft_users_verificationCode_idx` (`verificationCode`),
  KEY `craft_users_uid_idx` (`uid`),
  KEY `craft_users_preferredLocale_fk` (`preferredLocale`),
  CONSTRAINT `craft_users_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_users_preferredLocale_fk` FOREIGN KEY (`preferredLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_users`
-- ----------------------------
BEGIN;
INSERT INTO `craft_users` VALUES ('1', 'admin', null, null, null, 'tim@uc48.net', '$2y$13$IIDPcuJem6.72FI7effOYuGqHFsbvX0nmK27qWn9fsbdciWYkiL3.', null, '0', '1', '0', '0', '0', '0', '0', '2015-12-28 09:10:59', '::1', null, null, null, null, null, null, null, '0', '2015-12-28 09:10:56', '2015-12-28 09:10:56', '2015-12-28 09:10:59', 'bb6340fb-b0f5-41c5-a6e7-ad224774b3c8');
COMMIT;

-- ----------------------------
--  Table structure for `craft_widgets`
-- ----------------------------
DROP TABLE IF EXISTS `craft_widgets`;
CREATE TABLE `craft_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `colspan` tinyint(4) unsigned DEFAULT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_widgets_userId_fk` (`userId`),
  CONSTRAINT `craft_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
--  Records of `craft_widgets`
-- ----------------------------
BEGIN;
INSERT INTO `craft_widgets` VALUES ('1', '1', 'RecentEntries', '1', null, null, '1', '2015-12-28 09:11:01', '2015-12-28 09:11:01', 'c492a06a-0914-423d-b9e5-2a1acf7c6971'), ('2', '1', 'GetHelp', '2', null, null, '1', '2015-12-28 09:11:01', '2015-12-28 09:11:01', '285956bd-f967-43fb-a786-cd533a40245e'), ('3', '1', 'Updates', '3', null, null, '1', '2015-12-28 09:11:01', '2015-12-28 09:11:01', '84dba8a7-870c-47ef-ade5-c6f75b2da11d'), ('4', '1', 'Feed', '4', null, '{\"url\":\"https:\\/\\/craftcms.com\\/news.rss\",\"title\":\"Craft News\"}', '1', '2015-12-28 09:11:01', '2015-12-28 09:11:01', '5014b669-a84f-436d-bc01-6a95072a945a');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
