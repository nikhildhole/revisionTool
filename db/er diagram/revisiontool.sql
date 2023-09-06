-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema revision_tool
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema revision_tool
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `revision_tool` DEFAULT CHARACTER SET utf8 ;
USE `revision_tool` ;

-- -----------------------------------------------------
-- Table `revision_tool`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `revision_tool`.`users` ;

CREATE TABLE IF NOT EXISTS `revision_tool`.`users` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `mobile_number` VARCHAR(20) NULL DEFAULT NULL,
  `email` VARCHAR(50) NOT NULL,
  `is_active` TINYINT(4) NOT NULL DEFAULT 1,
  `password` VARCHAR(1000) NOT NULL,
  `wrong_attempts` INT(11) NOT NULL DEFAULT 0,
  `last_wrong_attempt` DATETIME NULL DEFAULT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `profile_pic` VARCHAR(255) NULL DEFAULT NULL,
  `birth_date` DATE NULL DEFAULT NULL,
  `notification` ENUM('none', 'email', 'whatsapp', 'both') NOT NULL DEFAULT 'none',
  `role` ENUM('student', 'teacher', 'admin') NOT NULL DEFAULT 'student',
  `is_email_verify` TINYINT(4) NOT NULL DEFAULT 0,
  `is_mobile_number_veirfy` TINYINT(4) NULL DEFAULT 0,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `contact_number_UNIQUE` (`mobile_number` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 75
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `revision_tool`.`modules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `revision_tool`.`modules` ;

CREATE TABLE IF NOT EXISTS `revision_tool`.`modules` (
  `module_id` INT(11) NOT NULL AUTO_INCREMENT,
  `module_name` VARCHAR(50) NOT NULL,
  `created_by` INT(11) NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`module_id`),
  UNIQUE INDEX `module_id_UNIQUE` (`module_id` ASC),
  INDEX `module_users_user_id_idx` (`created_by` ASC),
  CONSTRAINT `modules_users_user_id`
    FOREIGN KEY (`created_by`)
    REFERENCES `revision_tool`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 26
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `revision_tool`.`topics`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `revision_tool`.`topics` ;

CREATE TABLE IF NOT EXISTS `revision_tool`.`topics` (
  `topic_id` INT(11) NOT NULL AUTO_INCREMENT,
  `module_id` INT(11) NOT NULL,
  `topic_name` VARCHAR(255) NOT NULL,
  `create_ by` INT(11) NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`topic_id`),
  UNIQUE INDEX `category_id_UNIQUE` (`topic_id` ASC),
  INDEX `topic_modules_module_id_idx` (`module_id` ASC),
  INDEX `topics_users_user_id_idx` (`create_ by` ASC),
  CONSTRAINT `topics_modules_module_id`
    FOREIGN KEY (`module_id`)
    REFERENCES `revision_tool`.`modules` (`module_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `topics_users_user_id`
    FOREIGN KEY (`create_ by`)
    REFERENCES `revision_tool`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 30
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `revision_tool`.`points`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `revision_tool`.`points` ;

CREATE TABLE IF NOT EXISTS `revision_tool`.`points` (
  `point_id` INT(11) NOT NULL AUTO_INCREMENT,
  `topic_id` INT(11) NOT NULL,
  `point` VARCHAR(255) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `create_by` INT(11) NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`point_id`),
  UNIQUE INDEX `point_id_UNIQUE` (`point_id` ASC),
  INDEX `points_modules_module_id_idx` (`topic_id` ASC),
  INDEX `points_users_user_id_idx` (`create_by` ASC),
  CONSTRAINT `points_topics_topic_id`
    FOREIGN KEY (`topic_id`)
    REFERENCES `revision_tool`.`topics` (`topic_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `points_users_user_id`
    FOREIGN KEY (`create_by`)
    REFERENCES `revision_tool`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `revision_tool`.`points_history`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `revision_tool`.`points_history` ;

CREATE TABLE IF NOT EXISTS `revision_tool`.`points_history` (
  `points_history_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `point_id` INT(11) NOT NULL,
  `time_taken_to_answer` TIME NOT NULL,
  `asked_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `next_time` DATETIME NOT NULL,
  PRIMARY KEY (`points_history_id`),
  INDEX `points_history_users_user_id_idx` (`user_id` ASC),
  INDEX `points_history_points_point_id_idx` (`point_id` ASC),
  CONSTRAINT `points_history_points_point_id`
    FOREIGN KEY (`point_id`)
    REFERENCES `revision_tool`.`points` (`point_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `points_history_users_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `revision_tool`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 64
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `revision_tool`.`points_in_revision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `revision_tool`.`points_in_revision` ;

CREATE TABLE IF NOT EXISTS `revision_tool`.`points_in_revision` (
  `points_in_revision_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `point_id` INT(11) NOT NULL,
  `is_active` TINYINT(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`points_in_revision_id`),
  INDEX `points_in_revision_users_user_id_idx` (`user_id` ASC),
  INDEX `points_In_revision_points_point_id_idx` (`point_id` ASC),
  CONSTRAINT `points_In_revision_points_point_id`
    FOREIGN KEY (`point_id`)
    REFERENCES `revision_tool`.`points` (`point_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `points_in_revision_users_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `revision_tool`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 41
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `revision_tool`.`token`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `revision_tool`.`token` ;

CREATE TABLE IF NOT EXISTS `revision_tool`.`token` (
  `token_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `refresh_token` VARCHAR(64) NOT NULL,
  `expire_time` DATETIME NOT NULL,
  `remember_me` TINYINT(4) NOT NULL,
  PRIMARY KEY (`token_id`),
  UNIQUE INDEX `active_id_UNIQUE` (`token_id` ASC),
  UNIQUE INDEX `session_key_UNIQUE` (`refresh_token` ASC),
  INDEX `active_logins_users_user_id_idx` (`user_id` ASC),
  CONSTRAINT `active_logins_users_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `revision_tool`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `revision_tool`.`verificationcode`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `revision_tool`.`verificationcode` ;

CREATE TABLE IF NOT EXISTS `revision_tool`.`verificationcode` (
  `Id` INT(11) NOT NULL AUTO_INCREMENT,
  `UserId` INT(11) NULL DEFAULT NULL,
  `Code` VARCHAR(10) NOT NULL,
  `ExpirationTime` DATETIME NULL DEFAULT NULL,
  `CreatedAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`Id`),
  INDEX `verificationcode_user_user_id_idx` (`UserId` ASC),
  CONSTRAINT `verificationcode_user_user_id`
    FOREIGN KEY (`UserId`)
    REFERENCES `revision_tool`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8;

USE `revision_tool` ;

-- -----------------------------------------------------
-- procedure Next_Point
-- -----------------------------------------------------

USE `revision_tool`;
DROP procedure IF EXISTS `revision_tool`.`Next_Point`;

DELIMITER $$
USE `revision_tool`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Next_Point`(IN p_USER_ID INT)
BEGIN
    DECLARE p_POINT_ID INT DEFAULT 0;
    
    SELECT POINT_ID INTO p_POINT_ID FROM POINTS_HISTORY 
    WHERE USER_ID = p_USER_ID 
    AND NEXT_TIME <= CURRENT_TIMESTAMP() 
    AND POINT_ID IN (SELECT POINT_ID FROM POINTS_IN_REVISION WHERE USER_ID = p_USER_ID AND IS_ACTIVE = TRUE)
    ORDER BY NEXT_TIME 
    LIMIT 1;
    
    SELECT p_POINT_ID;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure Next_Point_IN_MODULE
-- -----------------------------------------------------

USE `revision_tool`;
DROP procedure IF EXISTS `revision_tool`.`Next_Point_IN_MODULE`;

DELIMITER $$
USE `revision_tool`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Next_Point_IN_MODULE`(IN p_USER_ID INT, in MODULE_ID INT)
BEGIN
    DECLARE p_POINT_ID INT DEFAULT 0;
    
    SELECT POINT_ID INTO p_POINT_ID FROM POINTS_IN_REVISION 
    WHERE USER_ID = p_USER_ID 
    AND POINT_ID IN (SELECT POINT_ID FROM POINTS_HISTORY WHERE USER_ID = USER_ID)
    AND POINT_ID IN (SELECT POINT_ID FROM POINTS WHERE TOPIC_ID IN (SELECT TOPIC_ID FROM TOPICS WHERE MODULE_ID = MODULE_ID))
    LIMIT 1;
    
    SELECT POINT_ID INTO p_POINT_ID FROM POINTS_HISTORY 
    WHERE USER_ID = p_USER_ID 
    AND NEXT_TIME <= CURRENT_TIMESTAMP() 
    AND POINT_ID IN (SELECT POINT_ID FROM POINTS_IN_REVISION WHERE USER_ID = p_USER_ID AND IS_ACTIVE = TRUE)
    AND POINT_ID IN (SELECT POINT_ID FROM POINTS WHERE TOPIC_ID IN (SELECT TOPIC_ID FROM TOPICS WHERE MODULE_ID = MODULE_ID))
    ORDER BY NEXT_TIME 
    LIMIT 1;
    
    SELECT p_POINT_ID;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


