CREATE TABLE `m_spots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) DEFAULT NULL,
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `kana_name` varchar(512) DEFAULT NULL COMMENT 'スポット名称（カナ）',
  `zip_code` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` text,
  `tel_num` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `fax_num` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `m_user_id` int(11) NOT NULL,
  `valid_from` datetime DEFAULT NULL,
  `valid_to` datetime DEFAULT NULL,
  `url` varchar(512) DEFAULT NULL COMMENT 'Webサイト',
  `comment` text COMMENT 'コメント',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `m_group_id` (`m_group_id`),
  KEY `m_user_id` (`m_user_id`),
  KEY `idx_m_spots_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `m_spot_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `m_group_id` int(11) NOT NULL,
  `name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `display_order` int(11) NOT NULL COMMENT '優先表示順',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `m_group_id` (`m_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci                
;

CREATE TABLE `t_spot_group_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `m_spot_id` int(11) NOT NULL,
  `m_group_id` int(11) NOT NULL,
  `m_spot_tag_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `m_group_id` (`m_group_id`),
  KEY `m_spot_idm_group_id_m_spot_tag_id` (`m_spot_id`,`m_group_id`,`m_spot_tag_id`),
  KEY `m_spot_tag_id` (`m_spot_tag_id`),
  CONSTRAINT `t_spot_groups_ibfk_1` FOREIGN KEY (`m_group_id`) REFERENCES `m_groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
;

CREATE TABLE `t_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `m_user_id` int(11) NOT NULL,
  `m_spot_id` int(11) DEFAULT NULL,
  `t_history_id` int(11) NOT NULL,
  `m_group_id` int(11) NOT NULL,
  `m_report_id` int(11) DEFAULT NULL,
  `m_activity_id` int(11) DEFAULT NULL,
  `t_report_original_id` int(11) DEFAULT NULL,
  `json_data` mediumtext COLLATE utf8_unicode_ci,
  `timezone_name` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `m_user_id` (`m_user_id`),
  KEY `t_history_id` (`t_history_id`),
  KEY `m_report_id` (`m_report_id`),
  KEY `m_group_id` (`m_group_id`),
  KEY `m_activity_id` (`m_activity_id`),
  KEY `m_spot_id` (`m_spot_id`),
  KEY `t_reports_ibfk_6` (`t_report_original_id`),
  KEY `t_reports_user_history` (`m_user_id`,`t_history_id`),
  CONSTRAINT `t_reports_ibfk_1` FOREIGN KEY (`m_user_id`) REFERENCES `m_users` (`id`),
  CONSTRAINT `t_reports_ibfk_2` FOREIGN KEY (`t_history_id`) REFERENCES `t_histories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
;

CREATE TABLE `m_activities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `m_group_id` int(11) NOT NULL,
  `name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `display_order` int(11) NOT NULL COMMENT '優先表示順',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `m_group_id` (`m_group_id`),
  CONSTRAINT `m_activities_ibfk_1` FOREIGN KEY (`m_group_id`) REFERENCES `m_groups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
;

CREATE TABLE `m_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_login_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_pass` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mail_address` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ユーザのメールアドレス',
  `logout_at` datetime DEFAULT NULL COMMENT '端末でアカウントのログアウトをした日時',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `m_users_user_login_id` (`user_login_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
;

 CREATE TABLE `t_belongings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `m_group_id` int(11) NOT NULL,
  `m_user_id` int(11) NOT NULL,
  `authority_level` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `t_belongings_m_group_id` (`m_group_id`),
  KEY `t_belongings_m_user_id_and_m_group_id` (`m_user_id`,`m_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
;

CREATE TABLE `m_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `group_code` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL,
  `parent_group_id` int(11) DEFAULT NULL,
  `view_all_users_flag` tinyint(4) NOT NULL DEFAULT '0',
  `user_make_spot` tinyint(4) NOT NULL DEFAULT '0',
  `user_see_spot` tinyint(4) NOT NULL DEFAULT '1',
  `user_make_plan` tinyint(4) NOT NULL DEFAULT '1',
  `user_see_plan` tinyint(4) NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `m_groups_group_id` (`group_id`),
  KEY `company_id` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
;


