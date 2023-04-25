-- -----------------------------------------------------
-- Schema chemistry
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `chemistry` DEFAULT CHARACTER
SET
  utf8;

USE `chemistry`;

-- -----------------------------------------------------
-- Table `chemistry`.`Класс опасности`
-- -----------------------------------------------------
CREATE TABLE
  IF NOT EXISTS `chemistry`.`Класс опасности` (
    `id` INT NOT NULL,
    `степень` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`)
  );

-- -----------------------------------------------------
-- Table `chemistry`.`Категория`
-- -----------------------------------------------------
CREATE TABLE
  IF NOT EXISTS `chemistry`.`Категория` (
    `id` INT NOT NULL,
    `название` VARCHAR(45) NOT NULL,
    `свойства` VARCHAR(45) NOT NULL,
    `класс опасности` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_Категория_Класс опасности1_idx` (`класс опасности` ASC) VISIBLE,
    CONSTRAINT `fk_Категория_Класс опасности1` FOREIGN KEY (`класс опасности`) REFERENCES `chemistry`.`Класс опасности` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
  );

-- -----------------------------------------------------
-- Table `chemistry`.`Химическое вещество`
-- -----------------------------------------------------
CREATE TABLE
  IF NOT EXISTS `chemistry`.`Химическое вещество` (
    `id` INT NOT NULL,
    `категория` INT NOT NULL,
    `формула` VARCHAR(255) NOT NULL,
    `молекулярный вес` DECIMAL(10, 6) NOT NULL,
    `описание` VARCHAR(255) NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_Химические вещества_Категория_idx` (`категория` ASC) VISIBLE,
    CONSTRAINT `fk_Химические вещества_Категория1` FOREIGN KEY (`категория`) REFERENCES `chemistry`.`Категория` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
  );

-- -----------------------------------------------------
-- Table `chemistry`.`Лаборант`
-- -----------------------------------------------------
CREATE TABLE
  IF NOT EXISTS `chemistry`.`Лаборант` (
    `id` INT NOT NULL,
    `имя` VARCHAR(45) NOT NULL,
    `фамилия` VARCHAR(45) NOT NULL,
    `отчество` VARCHAR(45) NOT NULL,
    `телефон` VARCHAR(11) NOT NULL,
    `год рождения` YEAR NOT NULL,
    `характеристика` VARCHAR(45) NULL,
    `электронная почта` VARCHAR(45) NULL,
    PRIMARY KEY (`id`)
  );

-- -----------------------------------------------------
-- Table `chemistry`.`Проведенная химическая реакция`
-- -----------------------------------------------------
CREATE TABLE
  IF NOT EXISTS `chemistry`.`Проведенная химическая реакция` (
    `id` INT NOT NULL,
    `лаборант` INT NOT NULL,
    `количество` DECIMAL(10, 6) NOT NULL,
    `назначение` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_Использование_Лаборанты1_idx` (`лаборант` ASC) VISIBLE,
    CONSTRAINT `fk_Использование_Лаборанты1` FOREIGN KEY (`лаборант`) REFERENCES `chemistry`.`Лаборант` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
  );

-- -----------------------------------------------------
-- Table `chemistry`.`Версия`
-- -----------------------------------------------------
CREATE TABLE
  IF NOT EXISTS `chemistry`.`Версия` (
    `id` INT NOT NULL,
    `количество` DECIMAL(10, 6) NOT NULL,
    `время создания` TIMESTAMP NOT NULL,
    `срок годности` DATETIME NOT NULL,
    `химическое вещество` INT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_Версия_Химическое вещество1_idx` (`химическое вещество` ASC) VISIBLE,
    CONSTRAINT `fk_Версия_Химическое вещество1` FOREIGN KEY (`химическое вещество`) REFERENCES `chemistry`.`Химическое вещество` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
  );

-- -----------------------------------------------------
-- Table `chemistry`.`Использованное вещество`
-- -----------------------------------------------------
CREATE TABLE
  IF NOT EXISTS `chemistry`.`Использованное вещество` (
    `id` INT NOT NULL,
    `проведенная химическая реакция` INT NOT NULL,
    `количество` DECIMAL(10, 6) NOT NULL,
    `версия химического вещества` INT NOT NULL,
    `время` TIMESTAMP NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_Использованное вещество_Испол_idx` (`проведенная химическая реакция` ASC) VISIBLE,
    INDEX `fk_Использованное вещество_Верси_idx` (`версия химического вещества` ASC) VISIBLE,
    CONSTRAINT `fk_Использованное вещество_Исполь1` FOREIGN KEY (`проведенная химическая реакция`) REFERENCES `chemistry`.`Проведенная химическая реакция` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT `fk_Использованное вещество_Версия1` FOREIGN KEY (`версия химического вещества`) REFERENCES `chemistry`.`Версия` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
  );