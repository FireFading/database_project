CREATE SCHEMA IF NOT EXISTS chemistry DEFAULT CHARACTER
SET
    utf8;

USE chemistry;

-- DangerClass - класс опасности
CREATE TABLE
    IF NOT EXISTS DangerClass (
        id INT NOT NULL,
        degree_name VARCHAR(45) UNIQUE NOT NULL,
        PRIMARY KEY (id)
    );

-- Category - категория химического вещества
CREATE TABLE
    IF NOT EXISTS Category (
        id INT NOT NULL,
        title VARCHAR(45) UNIQUE NOT NULL,
        features VARCHAR(45) NOT NULL,
        danger_class_id INT NOT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY (danger_class_id) REFERENCES DangerClass (id)
    );

-- ChemicalSubstance - химическое вещество
CREATE TABLE
    IF NOT EXISTS ChemicalSubstance (
        id INT NOT NULL,
        formula VARCHAR(255) NOT NULL,
        molecular_weight DECIMAL(10, 6) NOT NULL,
        specification VARCHAR(255) NULL,
        category_id INT NOT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY (category_id) REFERENCES Category (id)
    );

-- LaboratoryAssistance - Лаборант
CREATE TABLE
    IF NOT EXISTS LaboratoryAssistant (
        id INT NOT NULL,
        first_name VARCHAR(45) NOT NULL,
        last_name VARCHAR(45) NOT NULL,
        patronymic VARCHAR(45) NOT NULL,
        phone VARCHAR(11) UNIQUE NOT NULL,
        birthday DATE NOT NULL,
        characteristics VARCHAR(45) NULL,
        email VARCHAR(45) NULL,
        PRIMARY KEY (id)
    );

-- ChemicalReaction - проведенная химическая реакция
CREATE TABLE
    IF NOT EXISTS ChemicalReaction (
        id INT NOT NULL,
        purpose VARCHAR(45) NOT NULL,
        laboratory_assistant_id INT NOT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY (laboratory_assistant_id) REFERENCES LaboratoryAssistant (id)
    );

-- ChemicalVersion - версия химического вещества
CREATE TABLE
    IF NOT EXISTS ChemicalVersion (
        id INT NOT NULL,
        quantity DECIMAL(10, 6) NOT NULL,
        creation_time TIMESTAMP NOT NULL,
        expiration_time DATETIME NOT NULL,
        chemical_substance_id INT NOT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY (chemical_substance_id) REFERENCES ChemicalSubstance (id)
    );

-- UsedSubstance - использованное химическое вещество
CREATE TABLE
    IF NOT EXISTS UsedSubstance (
        id INT NOT NULL,
        amount DECIMAL(10, 6) NOT NULL,
        chemical_reaction_id INT NOT NULL,
        chemical_version_id INT NOT NULL,
        time TIMESTAMP NOT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY (chemical_reaction_id) REFERENCES ChemicalReaction (id),
        FOREIGN KEY (chemical_version_id) REFERENCES ChemicalVersion (id)
    );