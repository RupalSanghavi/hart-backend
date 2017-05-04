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
-- Table `mydb`.`CLASS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`CLASS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`CLASS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `year` YEAR NULL,
  `semester` VARCHAR(45) NULL,
  `section` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TEAM`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TEAM` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TEAM` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `logo` VARCHAR(45) NULL,
  `blog` VARCHAR(45) NULL,
  `charterCompleted` TINYINT NULL,
  `TEAM_CHARTER_id` INT NULL,
  `CLASS_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_TEAM_CLASS1_idx` (`CLASS_id` ASC),
  CONSTRAINT `fk_TEAM_CLASS1`
    FOREIGN KEY (`CLASS_id`)
    REFERENCES `mydb`.`CLASS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SPRINT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SPRINT` ;

CREATE TABLE IF NOT EXISTS `mydb`.`SPRINT` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sprint_number` INT NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `scrum_master` VARCHAR(45) NULL,
  `scribe` VARCHAR(45) NULL,
  `info` VARCHAR(45) NULL,
  `TEAM_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_SPRINT_TEAM_idx` (`TEAM_id` ASC),
  CONSTRAINT `fk_SPRINT_TEAM`
    FOREIGN KEY (`TEAM_id`)
    REFERENCES `mydb`.`TEAM` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`MBDForm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`MBDForm` ;

CREATE TABLE IF NOT EXISTS `mydb`.`MBDForm` (
  `id` INT NOT NULL AUTO_INCREMENT,
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
DROP TABLE IF EXISTS `mydb`.`STUDENT` ;

CREATE TABLE IF NOT EXISTS `mydb`.`STUDENT` (
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `image` VARCHAR(45) NULL,
  `major` VARCHAR(45) NULL,
  `info` VARCHAR(45) NULL,
  `knowledge` VARCHAR(45) NULL,
  `skills_abilities` VARCHAR(45) NULL,
  `CLASS_id` INT NULL,
  `TEAM_id` INT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NULL,
  `MBDForm_id` INT NULL,
  `salt` VARCHAR(250) NULL,
  `hash` VARCHAR(300) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_STUDENT_CLASS1_idx` (`CLASS_id` ASC),
  INDEX `fk_STUDENT_TEAM1_idx` (`TEAM_id` ASC),
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
DROP TABLE IF EXISTS `mydb`.`TEAM_ROLES` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TEAM_ROLES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`STUDENT_ROLES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`STUDENT_ROLES` ;

CREATE TABLE IF NOT EXISTS `mydb`.`STUDENT_ROLES` (
  `STUDENT_id` INT NOT NULL,
  `TEAM_ROLES_id` INT NOT NULL,
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
DROP TABLE IF EXISTS `mydb`.`RESOURCES` ;

CREATE TABLE IF NOT EXISTS `mydb`.`RESOURCES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `link` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `category` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`HLA_FOCUS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`HLA_FOCUS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`HLA_FOCUS` (
  `focus_name` VARCHAR(45) NULL,
  `STUDENT_id` INT NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_HLA_FOCUS_STUDENT1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`STUDENT` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`STAFF`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`STAFF` ;

CREATE TABLE IF NOT EXISTS `mydb`.`STAFF` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `admin` TINYINT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `hash` VARCHAR(300) NULL,
  `salt` VARCHAR(250) NULL,
  `email` VARCHAR(200) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ANNOUNCEMENTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ANNOUNCEMENTS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ANNOUNCEMENTS` (
  `title` VARCHAR(45) NULL,
  `body` VARCHAR(45) NULL,
  `create_datetime` DATETIME NULL,
  `priority` INT NULL,
  `creator` VARCHAR(45) NULL,
  `STAFF_id` INT NOT NULL,
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  INDEX `fk_ANNOUNCEMENTS_STAFF1_idx` (`STAFF_id` ASC),
  CONSTRAINT `fk_ANNOUNCEMENTS_STAFF1`
    FOREIGN KEY (`STAFF_id`)
    REFERENCES `mydb`.`STAFF` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EVENTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EVENTS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`EVENTS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `create_date` DATE NULL,
  `creator` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `location` VARCHAR(45) NULL,
  `STAFF_id` INT NULL,
  `TEAM_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_EVENTS_STAFF1_idx` (`STAFF_id` ASC),
  INDEX `fk_EVENTS_TEAM1_idx` (`TEAM_id` ASC),
  CONSTRAINT `fk_EVENTS_STAFF1`
    FOREIGN KEY (`STAFF_id`)
    REFERENCES `mydb`.`STAFF` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EVENTS_TEAM1`
    FOREIGN KEY (`TEAM_id`)
    REFERENCES `mydb`.`TEAM` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TEAM_CHARTER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TEAM_CHARTER` ;

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
  `id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  INDEX `TEAM_id_idx` (`TEAM_id` ASC),
  CONSTRAINT `TEAM_id`
    FOREIGN KEY (`TEAM_id`)
    REFERENCES `mydb`.`TEAM` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TOOLS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TOOLS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TOOLS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comm_tool` VARCHAR(45) NULL,
  `STUDENT_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_TOOLS_STUDENT1_idx` (`STUDENT_id` ASC),
  CONSTRAINT `fk_TOOLS_STUDENT1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`STUDENT` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SESSIONS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SESSIONS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`SESSIONS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `authenticated` TINYINT NULL,
  `username` VARCHAR(200) NULL,
  `team_id` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


insert into CLASS (id, year, semester, section) values (1, 2015, 'Fall', 1);
insert into CLASS (id, year, semester, section) values (2, 2017, 'Spring', 1);
insert into TEAM (id, name, logo, blog, charterCompleted,  TEAM_CHARTER_id, CLASS_id ) values (1, 'Aufderhar-Friesen', 'http://dummyimage.com/238x127.jpg/ff4444/ffffff', 'In est risus, auctor sed, tristique in, tempus sit amet, sem.', false, 2, 1);
insert into TEAM (id, name, logo, blog, charterCompleted,  TEAM_CHARTER_id, CLASS_id ) values (2, 'Wolff LLC', 'http://dummyimage.com/224x107.bmp/5fa2dd/ffffff', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', true, 1, 1);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (1, 1, '2016-04-19 22:02:37', '2017-09-23 16:04:27', 'Corette Boschmann', 'Pepita Sambrok', 'Vivamus vel nulla eget eros elementum pellentesque.', 1);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (2, 2, '2016-02-01 08:06:04', '2016-06-15 12:33:21', 'Gayelord Lowre', 'Ondrea Lilburne', 'Morbi porttitor lorem id ligula.', 2);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (3, 3, '2016-04-15 06:29:54', '2016-07-03 22:39:58', 'Antonella Phibb', 'Lombard Langelaan', 'Nam tristique tortor eu pede.', 1);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (4, 4, '2016-01-24 11:57:04', '2017-04-05 14:00:01', 'Marice Rosenthal', 'Suzette Godin', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 2);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (5, 5, '2016-10-31 00:33:39', '2017-02-15 06:27:24', 'Hastings Hand', 'Elvira Choules', 'Nunc purus.', 1);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (6, 6, '2016-12-19 03:35:12', '2016-09-17 10:03:26', 'Jasper Allmann', 'Johny Fivey', 'Donec vitae nisi.', 2);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (7, 7, '2016-08-07 18:26:11', '2016-04-15 19:15:15', 'Barnebas Vedyasov', 'Georgine Carmen', 'Integer a nibh.', 1);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (8, 8, '2016-05-11 06:55:18', '2016-07-09 14:47:50', 'Guthry Goutcher', 'Benito Parriss', 'Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', 2);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (9, 9, '2016-05-19 17:46:08', '2017-02-19 01:57:52', 'Jard Pengilley', 'Abelard MacDowal', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 1);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (10, 10, '2016-06-05 17:41:37', '2016-07-31 09:21:58', 'Bunny Grayer', 'Thorny Sandeson', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 2);insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (1, 'Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.', 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', 1, 1);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (2, 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.', 'Praesent blandit. Nam nulla.', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 2, 2);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (3, 'Morbi a ipsum.', 'Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.', 3, 3);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (4, 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.', 4, 4);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (5, 'Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.', 'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', 5, 5);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (6, 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 'Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.', 1, 6);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (7, 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', 'Vestibulum sed magna at nunc commodo placerat.', 2, 7);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (8, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc.', 3, 8);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (9, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', 'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 4, 9);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (10, 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 'Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus.', 5, 10);
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (1, 'Billye', 'Thyng', 'in', 'imperdiet et commodo vulputate justo in', 'interdum eu tincidunt in leo maecenas', 'pede lobortis ligula sit amet', 1, 2, 'bthyng0@discovery.com', 1, 'tristique', 'aRDjM8zcVej', 'Electrical Engineering');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (2, 'Evy', 'Ostrich', 'nec', 'augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent', 'a nibh in quis justo maecenas', 'ut massa quis augue luctus', 1, 1, 'eostrich1@senate.gov', 2, 'quam', 'qbuwlw6yaq', 'Environmental');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (3, 'Silvano', 'Price', 'consequat', 'at velit eu est congue elementum in hac habitasse', 'est donec odio justo sollicitudin ut suscipit a feugiat', 'porta volutpat erat quisque erat eros viverra', 1, 2, 'sprice2@dell.com', 3, 'cras', '0GvukLN4aKQ', 'Computer Engineering');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (4, 'Mahmud', 'Townes', 'augue', 'et ultrices posuere cubilia curae mauris viverra diam vitae', 'integer non velit donec diam neque', 'lobortis vel dapibus at diam', 1, 1, 'mtownes3@oakley.com', 4, 'et', 'VParvZYrjI', 'Electrical Engineering');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (5, 'Auguste', 'Estoile', 'blandit', 'in hac habitasse platea dictumst', 'hendrerit at vulputate vitae nisl aenean lectus pellentesque', 'posuere cubilia curae nulla dapibus dolor vel est donec odio', 1, 1, 'aestoile4@prnewswire.com', 5, 'sit', 'LB9Qp3E6', 'Civil Engineering');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (6, 'Holt', 'Tarbin', 'felis', 'risus dapibus augue vel accumsan tellus nisi eu orci', 'duis ac nibh fusce lacus purus', 'elit proin interdum mauris non ligula pellentesque ultrices phasellus', 1, 1, 'htarbin5@barnesandnoble.com', 6, 'volutpat', 'dDiuIC6', 'Electrical Engineering');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (7, 'Lionello', 'Wrightam', 'scelerisque', 'bibendum imperdiet nullam orci pede', 'semper sapien a libero nam', 'quis orci eget orci vehicula', 1, 2, 'lwrightam6@eventbrite.com', 7, 'augue', 'b6p9yEOryO', 'Mechanical Engineering');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (8, 'Dewey', 'Endrizzi', 'vestibulum', 'duis consequat dui nec nisi volutpat eleifend donec', 'aliquam non mauris morbi non', 'ut odio cras mi pede', 1, 1, 'dendrizzi7@facebook.com', 8, 'justo', 'HSlPz69duJ5G', 'EMIS');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (9, 'Christian', 'MacMenamin', 'pellentesque', 'justo lacinia eget tincidunt eget tempus vel pede morbi', 'lorem vitae mattis nibh ligula', 'in porttitor pede justo eu massa', 1, 1, 'cmacmenamin8@alexa.com', 9, 'in', 'lkTGIihVfjZV', 'Computer Engineering');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (10, 'Walden', 'Hendrikse', 'sit', 'erat fermentum justo nec condimentum neque', 'augue vestibulum rutrum rutrum neque aenean auctor', 'phasellus id sapien in sapien iaculis congue', 1, 2, 'whendrikse9@si.edu', 10, 'hac', 'EgrR8Qqonn', 'Computer Engineering');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values
                    (11,"Rupal","Sanghavi","image","I love to code.","Coding","Coding",1,2,"test@gmail.com",10,"$2a$10$7Dst8pZHelwgemSuGWn04A==","$2a$10$7Dst8pZHelwgemSuGWn04.cmyHa/D1PiOTdhq5/6eHDvsvA970O.i","cse");
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Communication', 1, 1);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Problem Solving', 2, 2);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Strategic Perspective', 3, 3);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Ethics and Integrity', 4, 4);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Innovative Spirit', 5, 5);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Intentional Learner', 6, 6);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Relationship Development', 7, 7);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Directive Leadership', 8, 8);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Champions Effective Processes', 9, 9);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Self Awareness', 10, 10);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Diversity and Difference', 1, 11);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Engaging Leadership', 2, 12);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Communication', 3, 13);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Problem Solving', 4, 14);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Strategic Perspective', 5, 15);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Ethics and Integrity', 6, 16);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Innovative Spirit', 7, 17);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Intentional Learner', 8, 18);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Relationship Development', 9, 19);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('Directive Leadership', 10, 20);
insert into TEAM_CHARTER (id, ideating, decision_making, disputes, conflicts, fun, team_purpose, stakeholders, mission, TEAM_id) values (1, 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 'In eleifend quam a odio.', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 'Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui.', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.', 'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 1);
insert into TEAM_CHARTER (id, ideating, decision_making, disputes, conflicts, fun, team_purpose, stakeholders, mission, TEAM_id) values (2, 'Aliquam non mauris.', 'Aliquam erat volutpat.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus.', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus.', 'Vivamus vel nulla eget eros elementum pellentesque.', 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 2);
insert into STAFF (id, admin, last_name, first_name, hash, salt, email) values (1, 1, 'Furmedge', 'Wang', '7ae7fe8c91483423441ce20769806494448b6fa7', 'porttitor', 'wcrop0@weibo.com');
insert into STAFF (id, admin, last_name, first_name, hash, salt, email) values (2, 1, 'Spitell', 'Vikky', 'ac070f6574ae04bd942b6b47806d462770d37096', 'dictumst', 'vmcgroarty1@apple.com');
insert into STAFF (id, admin, last_name, first_name, hash, salt, email) values (3, 1, 'Cookson', 'Biddy', '72cce212cfce41b21329933c28a98e835a3fa22c', 'vitae', 'bpaszak2@fda.gov');
INSERT into STAFF (email,salt,hash) VALUES ('khubbard@lyle.smu.edu','$2a$10$ZeSI0uSQv9OUdqlgF.GL3Q==','$2a$10$ZeSI0uSQv9OUdqlgF.GL3OmnnqscVTXeRmU/nqJNdZKZkEiwDU5/a');
insert into ANNOUNCEMENTS (title, body, create_datetime, priority, creator, id, STAFF_id) values ('cum sociis', 'Integer ac leo.', '2016-09-08 09:29:30', 1, 'David Howell', 1, 1);
insert into ANNOUNCEMENTS (title, body, create_datetime, priority, creator, id, STAFF_id) values ('lorem', 'Ut tellus.', '2017-01-05 10:05:39', 2, 'Larry Sims', 2, 2);
insert into ANNOUNCEMENTS (title, body, create_datetime, priority, creator, id, STAFF_id) values ('natoque penatibus', 'Duis bibendum.', '2016-11-12 23:55:19', 3, 'Kathleen Hansen', 3, 3);
insert into ANNOUNCEMENTS (title, body, create_datetime, priority, creator, id, STAFF_id) values ('at', 'Pellentesque ultrices mattis odio.', '2017-02-09 17:22:24', 4, 'Diana Morris', 4, 1);
insert into ANNOUNCEMENTS (title, body, create_datetime, priority, creator, id, STAFF_id) values ('ridiculus mus etiam', 'Vestibulum rutrum rutrum neque.', '2016-07-18 20:39:28', 5, 'Kathleen Mcdonald', 5, 2);
insert into EVENTS (id, title, start_date, end_date, creator, description, location, STAFF_id, create_date, TEAM_id) values (1, 'justo sit', '2015-08-26', '2016-11-02', 'Jimmy Black', 'orci luctus et ultrices posuere', '8 Talisman Hill', 1, '2015-03-21', 1);
insert into EVENTS (id, title, start_date, end_date, creator, description, location, STAFF_id, create_date, TEAM_id) values (2, 'nullam porttitor', '2016-02-14', '2016-12-26', 'Carol Fields', 'vel nulla eget eros elementum', '2 Dawn Drive', 2, '2015-01-08', 2);
insert into EVENTS (id, title, start_date, end_date, creator, description, location, STAFF_id, create_date, TEAM_id) values (3, 'parturient', '2015-10-03', '2016-12-31', 'Martin Rogers', 'semper est quam pharetra magna', '45 Hoffman Parkway', 3, '2015-01-13', 1);
insert into EVENTS (id, title, start_date, end_date, creator, description, location, STAFF_id, create_date, TEAM_id) values (4, 'at feugiat', '2015-12-04', '2016-08-01', 'Annie Richards', 'luctus et ultrices posuere cubilia', '31517 Banding Plaza', 1, '2014-07-12', 2);
insert into EVENTS (id, title, start_date, end_date, creator, description, location, STAFF_id, create_date, TEAM_id) values (5, 'sed accumsan', '2016-02-21', '2017-01-14', 'Ann Robertson', 'in faucibus orci luctus et', '6233 Fordem Drive', 2, '2014-08-12', 1);
insert into EVENTS (id, title, start_date, end_date, creator, description, location, STAFF_id, create_date, TEAM_id) values (6, 'erat', '2015-11-28', '2016-05-25', 'Douglas Rice', 'fringilla rhoncus mauris enim leo', '0206 Magdeline Point', 3, '2014-05-12', 2);
insert into RESOURCES (id, link, name, category) values (1, 'www.github.com', 'Github', 'Source Control');
insert into RESOURCES (id, link, name, category) values (2, 'www.asana.com', 'Asana', 'Project Management');
insert into RESOURCES (id, link, name, category) values (3, 'www.jira.com', 'Jira', 'Project Management');
insert into TEAM_ROLES (id, name) values (1, 'Executive');
insert into TEAM_ROLES (id, name) values (2, 'Explorer');
insert into TEAM_ROLES (id, name) values (3, 'Innovator');
insert into TEAM_ROLES (id, name) values (4, 'Analyst');
insert into TEAM_ROLES (id, name) values (5, 'Driver');
insert into TEAM_ROLES (id, name) values (6, 'Chairman');
insert into TEAM_ROLES (id, name) values (7, 'Completer');
insert into TEAM_ROLES (id, name) values (8, 'Team player');
insert into TEAM_ROLES (id, name) values (9, 'Expert');
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (1, 4);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (2, 8);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (3, 5);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (4, 6);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (5, 8);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (6, 2);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (7, 5);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (8, 8);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (9, 3);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (10, 6);

insert into TOOLS (id, comm_tool, STUDENT_id) values (1, 'Github', 1);
insert into TOOLS (id, comm_tool, STUDENT_id) values (2, 'Asana', 2);
insert into TOOLS (id, comm_tool, STUDENT_id) values (3, 'Jira', 3);
insert into TOOLS (id, comm_tool, STUDENT_id) values (4, 'Slack', 4);
insert into TOOLS (id, comm_tool, STUDENT_id) values (5, 'Groupme', 5);
insert into TOOLS (id, comm_tool, STUDENT_id) values (6, 'Github', 6);
insert into TOOLS (id, comm_tool, STUDENT_id) values (7, 'Asana', 7);
insert into TOOLS (id, comm_tool, STUDENT_id) values (8, 'Jira', 8);
insert into TOOLS (id, comm_tool, STUDENT_id) values (9, 'Slack', 10);
insert into TOOLS (id, comm_tool, STUDENT_id) values (10, 'Groupme', 1);
insert into TOOLS (id, comm_tool, STUDENT_id) values (11, 'Github', 2);
insert into TOOLS (id, comm_tool, STUDENT_id) values (12, 'Asana', 3);
insert into TOOLS (id, comm_tool, STUDENT_id) values (13, 'Jira', 4);
insert into TOOLS (id, comm_tool, STUDENT_id) values (14, 'Slack', 5);
insert into TOOLS (id, comm_tool, STUDENT_id) values (15, 'Groupme', 6);
insert into TOOLS (id, comm_tool, STUDENT_id) values (16, 'Github', 7);
insert into TOOLS (id, comm_tool, STUDENT_id) values (17, 'Asana', 8);
insert into TOOLS (id, comm_tool, STUDENT_id) values (18, 'Jira', 10);
insert into TOOLS (id, comm_tool, STUDENT_id) values (19, 'Slack', 1);
insert into TOOLS (id, comm_tool, STUDENT_id) values (20, 'Groupme', 2);
insert into TOOLS (id, comm_tool, STUDENT_id) values (21, 'Github', 3);
insert into TOOLS (id, comm_tool, STUDENT_id) values (22, 'Asana', 4);
