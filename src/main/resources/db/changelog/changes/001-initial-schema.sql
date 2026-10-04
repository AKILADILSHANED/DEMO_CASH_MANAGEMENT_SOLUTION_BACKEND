--liquibase formatted sql

--changeset akila:1
CREATE TABLE `user` (
   `user_id` varchar(6) NOT NULL,
   `department` varchar(20) NOT NULL,
   `is_first_login` int NOT NULL,
   `login_attempts` int NOT NULL,
   `section` varchar(20) NOT NULL,
   `user_active_status` int NOT NULL,
   `user_created_date` datetime(6) NOT NULL,
   `user_email` varchar(50) NOT NULL,
   `user_epf` varchar(10) NOT NULL,
   `user_first_name` varchar(20) NOT NULL,
   `user_last_name` varchar(20) NOT NULL,
   `is_admin` int NOT NULL,
   `user_password` varchar(100) NOT NULL,
   `user_position` varchar(50) NOT NULL,
   `user_signature` longblob,
   `user_title` varchar(5) NOT NULL,
   `user_created_by` varchar(6) DEFAULT NULL,
   `user_deleted_by` varchar(6) DEFAULT NULL,
   PRIMARY KEY (`user_id`),
   KEY `FKhyljy5x33enl32g55cwpqddib` (`user_created_by`),
   KEY `FK2rr328tchvu168y7uv1qdfjhj` (`user_deleted_by`),
   CONSTRAINT `FK2rr328tchvu168y7uv1qdfjhj` FOREIGN KEY (`user_deleted_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKhyljy5x33enl32g55cwpqddib` FOREIGN KEY (`user_created_by`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:2
CREATE TABLE `bank` (
   `bank_id` varchar(7) NOT NULL,
   `bank_name` varchar(100) NOT NULL,
   PRIMARY KEY (`bank_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:3
CREATE TABLE `user_module` (
   `module_id` varchar(10) NOT NULL,
   `module_name` varchar(30) NOT NULL,
   PRIMARY KEY (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:4
CREATE TABLE `bank_account` (
   `account_id` varchar(7) NOT NULL,
   `account_number` varchar(30) NOT NULL,
   `account_type` int NOT NULL,
   `bank_branch` varchar(50) NOT NULL,
   `currency` varchar(10) NOT NULL,
   `delete_status` int NOT NULL,
   `gl_code` int NOT NULL,
   `registered_date` datetime(6) NOT NULL,
   `bank` varchar(7) NOT NULL,
   `deleted_by` varchar(6) DEFAULT NULL,
   `registered_by` varchar(6) NOT NULL,
   PRIMARY KEY (`account_id`),
   KEY `FK7bukh68om5p8kftys2ucmjsw9` (`bank`),
   KEY `FKir2108uu318daacbkrdrwpp6a` (`deleted_by`),
   KEY `FKhs8b8adtmusq03rb4qx20n00h` (`registered_by`),
   CONSTRAINT `FK7bukh68om5p8kftys2ucmjsw9` FOREIGN KEY (`bank`) REFERENCES `bank` (`bank_id`),
   CONSTRAINT `FKhs8b8adtmusq03rb4qx20n00h` FOREIGN KEY (`registered_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKir2108uu318daacbkrdrwpp6a` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:5
CREATE TABLE `payment` (
   `payment_id` varchar(12) NOT NULL,
   `is_deleted` int NOT NULL,
   `payment_type` varchar(50) NOT NULL,
   `registered_date` datetime(6) NOT NULL,
   `deleted_by` varchar(6) DEFAULT NULL,
   `registered_by` varchar(6) NOT NULL,
   PRIMARY KEY (`payment_id`),
   KEY `FK63n2ybij01giubim17y5ay9w9` (`deleted_by`),
   KEY `FKi8mytbj03598fcu88bhy444o` (`registered_by`),
   CONSTRAINT `FK63n2ybij01giubim17y5ay9w9` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKi8mytbj03598fcu88bhy444o` FOREIGN KEY (`registered_by`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:6
CREATE TABLE `cross_adjustment` (
   `cross_adjustment_id` varchar(18) NOT NULL,
   `adjusted_date` datetime(6) NOT NULL,
   `is_reversed` int NOT NULL,
   `reversed_by` varchar(6) DEFAULT NULL,
   PRIMARY KEY (`cross_adjustment_id`),
   KEY `FKbemwev1e9qhd1a2m7lnrlk87m` (`reversed_by`),
   CONSTRAINT `FKbemwev1e9qhd1a2m7lnrlk87m` FOREIGN KEY (`reversed_by`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:7
CREATE TABLE `sub_function` (
   `function_id` varchar(8) NOT NULL,
   `function_name` varchar(30) NOT NULL,
   `module` varchar(10) NOT NULL,
   PRIMARY KEY (`function_id`),
   KEY `FKhwccxq8yb5akrtxq6f015lci6` (`module`),
   CONSTRAINT `FKhwccxq8yb5akrtxq6f015lci6` FOREIGN KEY (`module`) REFERENCES `user_module` (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:8
CREATE TABLE `transfer_channel` (
   `channel_id` varchar(7) NOT NULL,
   `created_date` datetime(6) DEFAULT NULL,
   `channel_type` varchar(50) NOT NULL,
   `deleted_status` int NOT NULL,
   `priority_level` int NOT NULL,
   `short_key` varchar(20) NOT NULL,
   `defined_by` varchar(6) NOT NULL,
   `delete_by` varchar(6) DEFAULT NULL,
   PRIMARY KEY (`channel_id`),
   KEY `FK3y77rxsrgxnd9lo510w7f1evd` (`defined_by`),
   KEY `FKgualabp5ths71wy4pk3vp5186` (`delete_by`),
   CONSTRAINT `FK3y77rxsrgxnd9lo510w7f1evd` FOREIGN KEY (`defined_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKgualabp5ths71wy4pk3vp5186` FOREIGN KEY (`delete_by`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:9
CREATE TABLE `repos` (
   `repo_id` varchar(15) NOT NULL,
   `calculation_method` varchar(1) DEFAULT NULL,
   `transfer_eligibility` int NOT NULL,
   `interest_rate` varchar(5) DEFAULT NULL,
   `invest_date` date DEFAULT NULL,
   `is_deleted` int NOT NULL,
   `is_invested` int NOT NULL,
   `maturity_date` date DEFAULT NULL,
   `maturity_value` decimal(13,2) NOT NULL,
   `created_date` datetime(6) NOT NULL,
   `repo_type` int NOT NULL,
   `repo_value` decimal(13,2) NOT NULL,
   `bank_account` varchar(7) NOT NULL,
   `created_by` varchar(6) NOT NULL,
   `deleted_by` varchar(6) DEFAULT NULL,
   PRIMARY KEY (`repo_id`),
   KEY `FKc3f02jv5vjgs5lm1mau7tcd46` (`bank_account`),
   KEY `FK5lh1el4qhomvgb6nlwlsmpe59` (`created_by`),
   KEY `FKfwghqouj29lxs6nmltqa06al8` (`deleted_by`),
   CONSTRAINT `FK5lh1el4qhomvgb6nlwlsmpe59` FOREIGN KEY (`created_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKc3f02jv5vjgs5lm1mau7tcd46` FOREIGN KEY (`bank_account`) REFERENCES `bank_account` (`account_id`),
   CONSTRAINT `FKfwghqouj29lxs6nmltqa06al8` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:10
CREATE TABLE `transfers` (
   `transfer_id` varchar(15) NOT NULL,
   `approved_date` datetime(6) DEFAULT NULL,
   `checked_date` datetime(6) DEFAULT NULL,
   `is_approved` int NOT NULL,
   `is_checked` int NOT NULL,
   `is_reversed` int NOT NULL,
   `transfer_amount` decimal(13,2) NOT NULL,
   `transfer_date` datetime(6) NOT NULL,
   `approved_by` varchar(6) DEFAULT NULL,
   `chanel` varchar(7) NOT NULL,
   `checked_by` varchar(6) DEFAULT NULL,
   `cross_adjustment` varchar(18) NOT NULL,
   `from_account` varchar(7) NOT NULL,
   `from_repo` varchar(15) DEFAULT NULL,
   `initiated_by` varchar(6) NOT NULL,
   `reversed_by` varchar(6) DEFAULT NULL,
   `to_account` varchar(7) NOT NULL,
   `to_repo` varchar(15) DEFAULT NULL,
   PRIMARY KEY (`transfer_id`),
   UNIQUE KEY `UKtl34luc0yneyhx79d0gdnlvpm` (`cross_adjustment`),
   KEY `FKh99k4bjsy36osyusguy460nqj` (`approved_by`),
   KEY `FKctxtqkn0ubgolcakwfktgjwxu` (`chanel`),
   KEY `FK3do28ebnivwvdx1dn7x23tlri` (`checked_by`),
   KEY `FK4a2d85j6vyjiag8uvmwq9e5tf` (`from_account`),
   KEY `FKgi03kl5t810tmwgvh3e10plpl` (`from_repo`),
   KEY `FKr7k7yh626utuofns0463bjsqd` (`initiated_by`),
   KEY `FK8sxu0j25o3nik2njil638ninl` (`reversed_by`),
   KEY `FKr3m48mh3e3xhsxcwjmqjtx4wl` (`to_account`),
   KEY `FKt6etivijlmtgyiyj4fkuq4n2u` (`to_repo`),
   CONSTRAINT `FK3do28ebnivwvdx1dn7x23tlri` FOREIGN KEY (`checked_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FK4a2d85j6vyjiag8uvmwq9e5tf` FOREIGN KEY (`from_account`) REFERENCES `bank_account` (`account_id`),
   CONSTRAINT `FK8sxu0j25o3nik2njil638ninl` FOREIGN KEY (`reversed_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKctxtqkn0ubgolcakwfktgjwxu` FOREIGN KEY (`chanel`) REFERENCES `transfer_channel` (`channel_id`),
   CONSTRAINT `FKgi03kl5t810tmwgvh3e10plpl` FOREIGN KEY (`from_repo`) REFERENCES `repos` (`repo_id`),
   CONSTRAINT `FKh99k4bjsy36osyusguy460nqj` FOREIGN KEY (`approved_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKp841icg961saj5811eme6jvag` FOREIGN KEY (`cross_adjustment`) REFERENCES `cross_adjustment` (`cross_adjustment_id`),
   CONSTRAINT `FKr3m48mh3e3xhsxcwjmqjtx4wl` FOREIGN KEY (`to_account`) REFERENCES `bank_account` (`account_id`),
   CONSTRAINT `FKr7k7yh626utuofns0463bjsqd` FOREIGN KEY (`initiated_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKt6etivijlmtgyiyj4fkuq4n2u` FOREIGN KEY (`to_repo`) REFERENCES `repos` (`repo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:11
CREATE TABLE `account_balance` (
   `balance_id` varchar(15) NOT NULL,
   `balance_amount` float NOT NULL,
   `balance_date` date NOT NULL,
   `delete_status` int NOT NULL,
   `account_id` varchar(7) NOT NULL,
   `deleted_by` varchar(6) DEFAULT NULL,
   `entered_by` varchar(6) NOT NULL,
   PRIMARY KEY (`balance_id`),
   KEY `FKiwacgp88uxnlnyla0c43ecjdg` (`account_id`),
   KEY `FK5bl8rgmdk4dy54kjpvyneo0gi` (`deleted_by`),
   KEY `FK9letf4yhgsxl2m2717l8na36r` (`entered_by`),
   CONSTRAINT `FK5bl8rgmdk4dy54kjpvyneo0gi` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FK9letf4yhgsxl2m2717l8na36r` FOREIGN KEY (`entered_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKiwacgp88uxnlnyla0c43ecjdg` FOREIGN KEY (`account_id`) REFERENCES `bank_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:12
CREATE TABLE `account_balance_adjustments` (
   `adjustment_id` varchar(15) NOT NULL,
   `adjustment_amount` decimal(13,2) NOT NULL,
   `adjustment_date` datetime(6) NOT NULL,
   `adjustment_remark` varchar(100) NOT NULL,
   `adjustment_balance` varchar(15) NOT NULL,
   `cross_adjustment_id` varchar(18) DEFAULT NULL,
   `transfer_id` varchar(15) DEFAULT NULL,
   PRIMARY KEY (`adjustment_id`),
   KEY `FKdpr5c2d9vbgdohs4yd8lldgxc` (`adjustment_balance`),
   KEY `FKcjp6qme2nwu0gk1ysp8i3qmpf` (`cross_adjustment_id`),
   KEY `FKegkr22vek5higmbwydukt4lgr` (`transfer_id`),
   CONSTRAINT `FKcjp6qme2nwu0gk1ysp8i3qmpf` FOREIGN KEY (`cross_adjustment_id`) REFERENCES `cross_adjustment` (`cross_adjustment_id`),
   CONSTRAINT `FKdpr5c2d9vbgdohs4yd8lldgxc` FOREIGN KEY (`adjustment_balance`) REFERENCES `account_balance` (`balance_id`),
   CONSTRAINT `FKegkr22vek5higmbwydukt4lgr` FOREIGN KEY (`transfer_id`) REFERENCES `transfers` (`transfer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:13
CREATE TABLE `repo_adjustment` (
   `adjustment_id` varchar(18) NOT NULL,
   `adjustment_amount` decimal(13,2) NOT NULL,
   `adjustment_date` datetime(6) NOT NULL,
   `adjustment_remark` varchar(100) NOT NULL,
   `adjusted_repo` varchar(15) NOT NULL,
   `cross_adjustment_id` varchar(18) DEFAULT NULL,
   `transfer_id` varchar(15) DEFAULT NULL,
   PRIMARY KEY (`adjustment_id`),
   KEY `FK7rewdujemomu112skuvcqsgjd` (`adjusted_repo`),
   KEY `FKq1vuv0u92ni59ysiuvd518ppr` (`cross_adjustment_id`),
   KEY `FKqgtq9lm0r3ciadqv4mgb1odjw` (`transfer_id`),
   CONSTRAINT `FK7rewdujemomu112skuvcqsgjd` FOREIGN KEY (`adjusted_repo`) REFERENCES `repos` (`repo_id`),
   CONSTRAINT `FKq1vuv0u92ni59ysiuvd518ppr` FOREIGN KEY (`cross_adjustment_id`) REFERENCES `cross_adjustment` (`cross_adjustment_id`),
   CONSTRAINT `FKqgtq9lm0r3ciadqv4mgb1odjw` FOREIGN KEY (`transfer_id`) REFERENCES `transfers` (`transfer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:14
CREATE TABLE `repo_transfers` (
   `transfer_id` varchar(15) NOT NULL,
   `is_approved` int NOT NULL,
   `is_reversed` int NOT NULL,
   `transfer_amount` float NOT NULL,
   `transfer_date` datetime(6) NOT NULL,
   `approved_by` varchar(6) DEFAULT NULL,
   `from_repo` varchar(15) NOT NULL,
   `initiated_by` varchar(6) NOT NULL,
   `reversed_by` varchar(6) DEFAULT NULL,
   `to_repo` varchar(15) NOT NULL,
   PRIMARY KEY (`transfer_id`),
   KEY `FKso3sab6w68ogfw3rgwxdvmj8c` (`approved_by`),
   KEY `FKg6gou898w1mr8oor8nbat0d3h` (`from_repo`),
   KEY `FKf4plmqc8i48r2dh2lq0migtpv` (`initiated_by`),
   KEY `FK50p7yl3f1rmd1lgtc5lolfuka` (`reversed_by`),
   KEY `FKcj1mv6975lg52jtyi0p0jei49` (`to_repo`),
   CONSTRAINT `FK50p7yl3f1rmd1lgtc5lolfuka` FOREIGN KEY (`reversed_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKcj1mv6975lg52jtyi0p0jei49` FOREIGN KEY (`to_repo`) REFERENCES `repos` (`repo_id`),
   CONSTRAINT `FKf4plmqc8i48r2dh2lq0migtpv` FOREIGN KEY (`initiated_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKg6gou898w1mr8oor8nbat0d3h` FOREIGN KEY (`from_repo`) REFERENCES `repos` (`repo_id`),
   CONSTRAINT `FKso3sab6w68ogfw3rgwxdvmj8c` FOREIGN KEY (`approved_by`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:15
CREATE TABLE `transfer_option` (
   `option_id` varchar(9) NOT NULL,
   `defined_date` datetime(6) NOT NULL,
   `is_active` int NOT NULL,
   `is_deleted` int NOT NULL,
   `defined_by` varchar(6) NOT NULL,
   `deleted_by` varchar(6) DEFAULT NULL,
   `from_account` varchar(7) NOT NULL,
   `to_account` varchar(7) NOT NULL,
   `transfer_channel` varchar(7) NOT NULL,
   PRIMARY KEY (`option_id`),
   KEY `FKrt0s6443ld5cto1l4jmohbo62` (`defined_by`),
   KEY `FKbr07ggkfi93heoohqw95nceld` (`deleted_by`),
   KEY `FKf0m41xxtacr7cnamdsftcjbrw` (`from_account`),
   KEY `FK8u8d3pgrrn0vl5qqfy4ka0kv6` (`to_account`),
   KEY `FK4swt54bf6dkxjtghjyqpvys01` (`transfer_channel`),
   CONSTRAINT `FK4swt54bf6dkxjtghjyqpvys01` FOREIGN KEY (`transfer_channel`) REFERENCES `transfer_channel` (`channel_id`),
   CONSTRAINT `FK8u8d3pgrrn0vl5qqfy4ka0kv6` FOREIGN KEY (`to_account`) REFERENCES `bank_account` (`account_id`),
   CONSTRAINT `FKbr07ggkfi93heoohqw95nceld` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKf0m41xxtacr7cnamdsftcjbrw` FOREIGN KEY (`from_account`) REFERENCES `bank_account` (`account_id`),
   CONSTRAINT `FKrt0s6443ld5cto1l4jmohbo62` FOREIGN KEY (`defined_by`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:16
CREATE TABLE `forecast_request` (
   `request_id` varchar(13) NOT NULL,
   `delete_status` int NOT NULL,
   `request_amount` decimal(38,2) NOT NULL,
   `request_date` datetime(6) NOT NULL,
   `required_date` date NOT NULL,
   `bank_account` varchar(7) DEFAULT NULL,
   `deleted_by` varchar(6) DEFAULT NULL,
   `payment` varchar(12) NOT NULL,
   `request_by` varchar(6) NOT NULL,
   PRIMARY KEY (`request_id`),
   KEY `FKqp65nn12xfcuv572smh5x45ja` (`bank_account`),
   KEY `FKht279dcs20o4yjw755nbbo0e4` (`deleted_by`),
   KEY `FKejoh91k0lkgp997broxmrrgci` (`payment`),
   KEY `FK6rrqlcrrhg4lt503gm4v81lfj` (`request_by`),
   CONSTRAINT `FK6rrqlcrrhg4lt503gm4v81lfj` FOREIGN KEY (`request_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKejoh91k0lkgp997broxmrrgci` FOREIGN KEY (`payment`) REFERENCES `payment` (`payment_id`),
   CONSTRAINT `FKht279dcs20o4yjw755nbbo0e4` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKqp65nn12xfcuv572smh5x45ja` FOREIGN KEY (`bank_account`) REFERENCES `bank_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:17
CREATE TABLE `fund_request` (
   `request_id` varchar(14) NOT NULL,
   `approve_status` int NOT NULL,
   `delete_status` int NOT NULL,
   `request_amount` decimal(38,2) NOT NULL,
   `request_date` datetime(6) NOT NULL,
   `required_date` date NOT NULL,
   `approved_by` varchar(6) DEFAULT NULL,
   `bank_account` varchar(7) DEFAULT NULL,
   `deleted_by` varchar(6) DEFAULT NULL,
   `payment` varchar(12) NOT NULL,
   `request_by` varchar(6) NOT NULL,
   PRIMARY KEY (`request_id`),
   KEY `FK7snslsvjuyx7mjd9t3owv0ml4` (`approved_by`),
   KEY `FKqvmw29puralcunw31ttneme4` (`bank_account`),
   KEY `FKfdsti7j7jtyvvqumhfqo5xghp` (`deleted_by`),
   KEY `FKgwlonh3tdxbi83okevwnjmx4n` (`payment`),
   KEY `FK6lojlc4rd8dha2wmgvqel15cv` (`request_by`),
   CONSTRAINT `FK6lojlc4rd8dha2wmgvqel15cv` FOREIGN KEY (`request_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FK7snslsvjuyx7mjd9t3owv0ml4` FOREIGN KEY (`approved_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKfdsti7j7jtyvvqumhfqo5xghp` FOREIGN KEY (`deleted_by`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKgwlonh3tdxbi83okevwnjmx4n` FOREIGN KEY (`payment`) REFERENCES `payment` (`payment_id`),
   CONSTRAINT `FKqvmw29puralcunw31ttneme4` FOREIGN KEY (`bank_account`) REFERENCES `bank_account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:18
CREATE TABLE `session` (
   `session_id` int NOT NULL AUTO_INCREMENT,
   `created_at` datetime(6) NOT NULL,
   `expires_at` datetime(6) DEFAULT NULL,
   `ip_address` varchar(45) NOT NULL,
   `last_activity_at` datetime(6) NOT NULL,
   `session_status` varchar(255) NOT NULL,
   `session_token` varchar(36) NOT NULL,
   `session_user` varchar(6) NOT NULL,
   PRIMARY KEY (`session_id`),
   UNIQUE KEY `UKd16yqd2ghhaxopy9mvwqsnu08` (`session_token`),
   KEY `FKf6nhj27ic6xwpl8b5m67fm74s` (`session_user`),
   CONSTRAINT `FKf6nhj27ic6xwpl8b5m67fm74s` FOREIGN KEY (`session_user`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--changeset akila:19
CREATE TABLE `user_function` (
   `user_id` varchar(6) NOT NULL,
   `function_id` varchar(8) NOT NULL,
   KEY `FKq3n6agb4oy88s3mtkkkhuepxc` (`function_id`),
   KEY `FKhgl3dbaq4ubmj3td3abco3kfn` (`user_id`),
   CONSTRAINT `FKhgl3dbaq4ubmj3td3abco3kfn` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
   CONSTRAINT `FKq3n6agb4oy88s3mtkkkhuepxc` FOREIGN KEY (`function_id`) REFERENCES `sub_function` (`function_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;