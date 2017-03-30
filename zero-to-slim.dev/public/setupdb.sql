-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`TEAM`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TEAM` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `logo` VARCHAR(45) NULL,
  `blog` VARCHAR(45) NULL,
  `charterCompleted` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CLASS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CLASS` (
  `id` INT NOT NULL,
  `year` VARCHAR(45) NULL,
  `semester` VARCHAR(45) NULL,
  `section` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TEAM_CHARTER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TEAM_CHARTER` (
  `ideating` VARCHAR(2000) NULL,
  `decision_making` VARCHAR(2000) NULL,
  `disputes` VARCHAR(2000) NULL,
  `conflicts` VARCHAR(2000) NULL,
  `fun` VARCHAR(2000) NULL,
  `team_purpose` VARCHAR(2000) NULL,
  `stakeholders` VARCHAR(2000) NULL,
  `mission` VARCHAR(2000) NULL,
  `TEAM_id` INT NOT NULL,
  PRIMARY KEY (`TEAM_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SPRINT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`SPRINT` (
  `id` INT NOT NULL,
  `sprint_number` INT NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `scrum_master` VARCHAR(45) NULL,
  `scribe` VARCHAR(45) NULL,
  `info` VARCHAR(45) NULL,
  `TEAM_id` INT NOT NULL,
  `TEAM_CHARTER_TEAM_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_SPRINT_TEAM_idx` (`TEAM_id` ASC),
  UNIQUE INDEX `TEAM_id_UNIQUE` (`TEAM_id` ASC),
  INDEX `fk_SPRINT_TEAM_CHARTER1_idx` (`TEAM_CHARTER_TEAM_id` ASC),
  CONSTRAINT `fk_SPRINT_TEAM`
    FOREIGN KEY (`TEAM_id`)
    REFERENCES `mydb`.`TEAM` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SPRINT_TEAM_CHARTER1`
    FOREIGN KEY (`TEAM_CHARTER_TEAM_id`)
    REFERENCES `mydb`.`TEAM_CHARTER` (`TEAM_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MBDForm`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MBDForm` (
  `id` INT NOT NULL,
  `More` VARCHAR(2000) NULL,
  `Better` VARCHAR(2000) NULL,
  `Different` VARCHAR(2000) NULL,
  `SPRINT_id` INT NULL,
  `STUDENT_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_MBDForm_SPRINT1_idx` (`SPRINT_id` ASC),
  CONSTRAINT `fk_MBDForm_SPRINT1`
    FOREIGN KEY (`SPRINT_id`)
    REFERENCES `mydb`.`SPRINT` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`STUDENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`STUDENT` (
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `image` VARCHAR(45) NULL,
  `major` VARCHAR(45) NULL,
  `info` VARCHAR(45) NULL,
  `HLA_focus` VARCHAR(45) NULL,
  `knowledge` VARCHAR(45) NULL,
  `skills_abilities` VARCHAR(45) NULL,
  `CLASS_id` INT NULL,
  `TEAM_id` INT NULL,
  `id` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  `MBDForm_id` INT NULL,
  `salt` VARCHAR(250) NULL,
  `hash` VARCHAR(300) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_STUDENT_CLASS1_idx` (`CLASS_id` ASC),
  INDEX `fk_STUDENT_TEAM1_idx` (`TEAM_id` ASC),
  UNIQUE INDEX `TEAM_id_UNIQUE` (`TEAM_id` ASC),
  UNIQUE INDEX `CLASS_id_UNIQUE` (`CLASS_id` ASC),
  INDEX `fk_STUDENT_MBDForm1_idx` (`MBDForm_id` ASC),
  CONSTRAINT `fk_STUDENT_CLASS1`
    FOREIGN KEY (`CLASS_id`)
    REFERENCES `mydb`.`CLASS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_STUDENT_TEAM1`
    FOREIGN KEY (`TEAM_id`)
    REFERENCES `mydb`.`TEAM` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_STUDENT_MBDForm1`
    FOREIGN KEY (`MBDForm_id`)
    REFERENCES `mydb`.`MBDForm` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TEAM_ROLES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TEAM_ROLES` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`STUDENT_ROLES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`STUDENT_ROLES` (
  `STUDENT_id` INT NOT NULL,
  `TEAM_ROLES_id` INT NOT NULL,
  PRIMARY KEY (`STUDENT_id`, `TEAM_ROLES_id`),
  INDEX `fk_STUDENT_ROLES_STUDENT1_idx` (`STUDENT_id` ASC),
  INDEX `fk_STUDENT_ROLES_TEAM_ROLES1_idx` (`TEAM_ROLES_id` ASC),
  CONSTRAINT `fk_STUDENT_ROLES_STUDENT1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`STUDENT` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_STUDENT_ROLES_TEAM_ROLES1`
    FOREIGN KEY (`TEAM_ROLES_id`)
    REFERENCES `mydb`.`TEAM_ROLES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RESOURCES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RESOURCES` (
  `id` INT NOT NULL,
  `link` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `category` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`HLA_FOCUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`HLA_FOCUS` (
  `focus_name` VARCHAR(45) NULL,
  `STUDENT_id` INT NOT NULL,
  PRIMARY KEY (`STUDENT_id`),
  CONSTRAINT `fk_HLA_FOCUS_STUDENT1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`STUDENT` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`STAFF`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`STAFF` (
  `id` INT NOT NULL,
  `admin` TINYINT(1) NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ANNOUNCEMENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ANNOUNCEMENTS` (
  `title` VARCHAR(45) NULL,
  `body` VARCHAR(45) NULL,
  `create_date` DATE NULL,
  `priority` INT NULL,
  `creator` VARCHAR(45) NULL,
  `STAFF_id` INT NOT NULL,
  `id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ANNOUNCEMENTS_STAFF1_idx` (`STAFF_id` ASC),
  UNIQUE INDEX `STAFF_id_UNIQUE` (`STAFF_id` ASC),
  CONSTRAINT `fk_ANNOUNCEMENTS_STAFF1`
    FOREIGN KEY (`STAFF_id`)
    REFERENCES `mydb`.`STAFF` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EVENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EVENTS` (
  `id` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `create_date` DATE NULL,
  `creator` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `location` VARCHAR(45) NULL,
  `STAFF_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_EVENTS_STAFF1_idx` (`STAFF_id` ASC),
  UNIQUE INDEX `STAFF_id_UNIQUE` (`STAFF_id` ASC),
  CONSTRAINT `fk_EVENTS_STAFF1`
    FOREIGN KEY (`STAFF_id`)
    REFERENCES `mydb`.`STAFF` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
