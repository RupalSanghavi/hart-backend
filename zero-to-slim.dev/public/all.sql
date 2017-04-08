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
DROP SCHEMA IF EXISTS `mydb`;
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
  `charterCompleted` TINYINT NULL,
  `TEAM_CHARTER_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CLASS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CLASS` (
  `id` INT NOT NULL,
  `year` YEAR NULL,
  `semester` VARCHAR(45) NULL,
  `section` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
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
  `major` VARCHAR(5) NULL,
  `info` VARCHAR(45) NULL,
  `knowledge` VARCHAR(45) NULL,
  `skills_abilities` VARCHAR(45) NULL,
  `CLASS_id` INT NULL,
  `TEAM_id` INT NULL,
  `id` INT NOT NULL,
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
  `id` INT NOT NULL,
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
CREATE TABLE IF NOT EXISTS `mydb`.`STAFF` (
  `id` INT NOT NULL,
  `admin` TINYINT NULL,
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
  CONSTRAINT `fk_EVENTS_STAFF1`
    FOREIGN KEY (`STAFF_id`)
    REFERENCES `mydb`.`STAFF` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
  `id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `TEAM_id_idx` (`TEAM_id` ASC),
  CONSTRAINT `TEAM_id`
    FOREIGN KEY (`TEAM_id`)
    REFERENCES `mydb`.`TEAM` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
insert into CLASS (id, year, semester, section) values (1, 2015, 'Fall', 1);
insert into TEAM (id, name, logo, blog, charterCompleted,  TEAM_CHARTER_id ) values (1, 'Aufderhar-Friesen', 'http://dummyimage.com/238x127.jpg/ff4444/ffffff', 'In est risus, auctor sed, tristique in, tempus sit amet, sem.', false, 2);
insert into TEAM (id, name, logo, blog, charterCompleted,  TEAM_CHARTER_id ) values (2, 'Wolff LLC', 'http://dummyimage.com/224x107.bmp/5fa2dd/ffffff', 'Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue.', true, 1);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (1, 1, '1/27/2016', '2/2/2017', 'Louis Snyder', 'Bobby Lane', 'Nulla justo.', 1);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (2, 2, '3/9/2016', '6/10/2016', 'Tina Howell', 'Harry Torres', 'Integer a nibh.', 2);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (3, 3, '1/3/2017', '8/1/2016', 'Walter Hicks', 'Harold Martinez', 'Donec dapibus.', 1);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (4, 4, '7/28/2016', '10/1/2016', 'Kevin Sanchez', 'Gary Mills', 'Donec semper sapien a libero.', 2);
insert into SPRINT (id, sprint_number, start_date, end_date, scrum_master, scribe, info, TEAM_id) values (5, 5, '5/13/2016', '3/26/2017', 'Donald Moreno', 'John Carpenter', 'Nam tristique tortor eu pede.', 1);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (1, 'Vestibulum sed magna at nunc commodo placerat. Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede. Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem. Fusce consequat.', 'In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.', 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', 1, 1);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (2, 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo.', 'Praesent blandit. Nam nulla.', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 2, 2);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (3, 'Morbi a ipsum.', 'Nulla nisl. Nunc nisl. Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat. Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem. Integer tincidunt ante vel ipsum.', 3, 3);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (4, 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum.', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue.', 4, 4);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (5, 'Donec dapibus. Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', 'Duis mattis egestas metus. Aenean fermentum. Donec ut mauris eget massa tempor convallis.', 'Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla.', 5, 5);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (6, 'Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.', 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui. Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 'Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.', 1, 6);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (7, 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', 'Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo. Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor.', 'Vestibulum sed magna at nunc commodo placerat.', 2, 7);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (8, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius. Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi. Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 'Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', 'Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem. Duis aliquam convallis nunc.', 3, 8);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (9, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.', 'Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 4, 9);
insert into MBDForm (id, More, Better, Different, SPRINT_id, STUDENT_id) values (10, 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 'Nunc rhoncus dui vel sem. Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus. Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien.', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris. Morbi non lectus.', 5, 10);
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (1, 'Karen', 'Medina', 'rutrum', 'id justo sit amet sapien dignissim vestibulum', 'nulla nunc purus phasellus in felis', 'feugiat non pretium quis lectus suspendisse potenti in', 1, 1, 'kmedina0@yolasite.com', 1, 'mi', 'gYa3BSm5', 'me');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (2, 'Deborah', 'Price', 'tortor', 'lobortis vel dapibus at diam', 'erat curabitur gravida nisi at nibh in hac habitasse platea', 'ipsum integer a nibh in quis', 1, 2, 'dprice1@weibo.com', 2, 'id', 'AhpnlQ3lc', 'me');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (3, 'Raymond', 'Mills', 'posuere', 'porttitor lorem id ligula suspendisse ornare', 'eleifend donec ut dolor morbi vel lectus in quam fringilla', 'vel augue vestibulum ante ipsum primis', 1, 1, 'rmills2@pcworld.com', 3, 'quisque', 'ppW88UArvOUM', 'ce');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (4, 'George', 'Johnston', 'vulputate', 'id mauris vulputate elementum nullam varius nulla', 'turpis donec posuere metus vitae ipsum aliquam non', 'ac nulla sed vel enim sit amet nunc', 1, 1, 'gjohnston3@ask.com', 4, 'proin', '3HEWl2VvqK', 'emis');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (5, 'Melissa', 'Alexander', 'id', 'justo pellentesque viverra pede ac diam cras pellentesque volutpat dui', 'sem fusce consequat nulla nisl', 'luctus et ultrices posuere cubilia', 1, 1, 'malexander4@amazon.de', 5, 'at', 'oZZz23', 'cse');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (6, 'Linda', 'Stewart', 'non', 'eu orci mauris lacinia sapien quis', 'nisi eu orci mauris lacinia sapien quis libero', 'integer pede justo lacinia eget tincidunt eget tempus vel', 1, 1, 'lstewart5@elegantthemes.com', 6, 'eget', 'tlAHO9wKe', 'cve');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (7, 'Cynthia', 'Fowler', 'vivamus', 'aliquam quis turpis eget elit sodales', 'a ipsum integer a nibh in quis justo', 'nulla sed vel enim sit amet', 1, 1, 'cfowler6@goo.gl', 7, 'ridiculus', 'HLze7sPOQvT1', 'ce');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (8, 'Helen', 'Hill', 'molestie', 'nunc donec quis orci eget orci', 'mattis egestas metus aenean fermentum', 'pede ullamcorper augue a suscipit nulla elit ac', 1, 1, 'hhill7@spotify.com', 8, 'vel', 'HFuYkUCffk', 'env');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (9, 'Gregory', 'Burton', 'metus', 'mauris sit amet eros suspendisse accumsan tortor quis turpis', 'erat tortor sollicitudin mi sit amet lobortis', 'lectus in est risus auctor', 1, 1, 'gburton8@forbes.com', 9, 'rhoncus', 'a9yV23FJp', 'cse');
insert into STUDENT (id, first_name, last_name, image, info, knowledge, skills_abilities, CLASS_id, TEAM_id, email, MBDForm_id, salt, hash, major) values (10, 'Paul', 'Webb', 'vivamus', 'metus sapien ut nunc vestibulum ante ipsum', 'blandit nam nulla integer pede', 'diam erat fermentum justo nec condimentum neque sapien', 1, 2, 'pwebb9@ustream.tv', 10, 'bibendum', 'pfWJXzEanA', 'ee');
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('leader', 1, 1);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('finisher', 2, 2);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('thinker', 3, 3);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('leader', 4, 4);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('finisher', 5, 5);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('thinker', 6, 6);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('leader', 7, 7);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('finisher', 8, 8);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('thinker', 9, 9);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('leader', 10, 10);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('finisher', 1, 11);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('thinker', 2, 12);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('leader', 3, 13);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('finisher', 4, 14);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('thinker', 5, 15);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('leader', 6, 16);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('finisher', 7, 17);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('thinker', 8, 18);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('leader', 9, 19);
insert into HLA_FOCUS (focus_name, STUDENT_id, id) values ('finisher', 10, 20);
insert into TEAM_CHARTER (id, ideating, decision_making, disputes, conflicts, fun, team_purpose, stakeholders, mission, TEAM_id) values (1, 'Curabitur convallis. Duis consequat dui nec nisi volutpat eleifend.', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 'In eleifend quam a odio.', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', 'Nunc purus. Phasellus in felis. Donec semper sapien a libero. Nam dui.', 'Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros. Vestibulum ac est lacinia nisi venenatis tristique.', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.', 'Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 1);
insert into TEAM_CHARTER (id, ideating, decision_making, disputes, conflicts, fun, team_purpose, stakeholders, mission, TEAM_id) values (2, 'Aliquam non mauris.', 'Aliquam erat volutpat.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus.', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est. Phasellus sit amet erat.', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti. Nullam porttitor lacus at turpis.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus.', 'Vivamus vel nulla eget eros elementum pellentesque.', 'Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 2);
insert into STAFF (id, admin, last_name, first_name) values (1, 1, 'Johnston', 'Robert');
insert into STAFF (id, admin, last_name, first_name) values (2, 1, 'Palmer', 'Marilyn');
insert into STAFF (id, admin, last_name, first_name) values (3, 1, 'Shaw', 'Gloria');
insert into ANNOUNCEMENTS (title, body, create_date, priority, creator, id, STAFF_id) values ('imperdiet et', 'Quisque ut erat.', '2017-02-12', 1, 'Denise Alexander', 1, 1);
insert into ANNOUNCEMENTS (title, body, create_date, priority, creator, id, STAFF_id) values ('dolor', 'Pellentesque viverra pede ac diam.', '2016-08-07', 2, 'Howard Mason', 2, 2);
insert into ANNOUNCEMENTS (title, body, create_date, priority, creator, id, STAFF_id) values ('elementum nullam', 'Nulla mollis molestie lorem.', '2017-03-25', 3, 'Jennifer Reed', 3, 3);
insert into ANNOUNCEMENTS (title, body, create_date, priority, creator, id, STAFF_id) values ('at', 'Nam tristique tortor eu pede.', '2017-02-02', 4, 'Rose Ramirez', 4, 1);
insert into ANNOUNCEMENTS (title, body, create_date, priority, creator, id, STAFF_id) values ('curae duis faucibus', 'Maecenas ut massa quis augue luctus tincidunt.', '2016-07-31', 5, 'Beverly Ryan', 5, 2);
insert into EVENTS (id, title, start_date, end_date, creator, description, location, STAFF_id, create_date) values (1, 'nam', '2016-02-13', '2016-11-01', 'Jerry Campbell', 'primis in faucibus orci luctus', '7 Dahle Junction', 1, '2014-10-19');
insert into EVENTS (id, title, start_date, end_date, creator, description, location, STAFF_id, create_date) values (2, 'mi in', '2016-03-28', '2016-12-18', 'Karen Alexander', 'lobortis sapien sapien non mi', '81 Jana Junction', 2, '2014-11-17');
insert into EVENTS (id, title, start_date, end_date, creator, description, location, STAFF_id, create_date) values (3, 'non lectus aliquam', '2015-08-05', '2017-03-24', 'Kelly Henry', 'mi nulla ac enim in', '2154 Duke Trail', 3, '2015-03-04');
insert into EVENTS (id, title, start_date, end_date, creator, description, location, STAFF_id, create_date) values (4, 'erat vestibulum sed', '2015-05-26', '2017-04-02', 'Michael Watkins', 'nibh in hac habitasse platea', '50720 Cascade Parkway', 1, '2015-02-04');
insert into EVENTS (id, title, start_date, end_date, creator, description, location, STAFF_id, create_date) values (5, 'in tempus sit', '2015-10-21', '2016-06-07', 'Julie Adams', 'dui vel sem sed sagittis', '4742 Golf View Center', 2, '2014-08-24');
insert into EVENTS (id, title, start_date, end_date, creator, description, location, STAFF_id, create_date) values (6, 'odio cras', '2015-07-21', '2016-06-02', 'Diana Parker', 'orci luctus et ultrices posuere', '74 School Avenue', 3, '2015-03-06');
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
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (10, 8);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (3, 5);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (8, 2);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (9, 6);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (10, 4);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (2, 4);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (1, 2);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (2, 5);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (10, 1);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (6, 6);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (2, 2);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (3, 9);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (10, 3);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (4, 9);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (10, 5);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (3, 4);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (5, 5);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (8, 9);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (10, 7);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (8, 8);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (1, 8);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (6, 2);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (10, 2);
insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (6, 7);
  insert into STUDENT_ROLES (STUDENT_id, TEAM_ROLES_id) values (7, 1);
