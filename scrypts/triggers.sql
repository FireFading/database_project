USE chemistry;

-- update amount of chemical substance when add new used substance record
CREATE TRIGGER update_chemical_version_amount AFTER INSERT ON UsedSubstance FOR EACH ROW BEGIN DECLARE new_amount DECIMAL(10, 6);

SET
    new_amount = (
        SELECT
            amount
        FROM
            ChemicalVersion
        WHERE
            id = NEW.chemical_version_id
    ) - NEW.amount;

UPDATE ChemicalVersion
SET
    quantity = new_amount
WHERE
    id = NEW.chemical_version_id;

END;

-- prevent adding UsedSubstance instance if laborant is under 21 years old
CREATE TRIGGER prevent_underage_laboratory_assistant BEFORE INSERT ON UsedSubstance FOR EACH ROW BEGIN DECLARE laborant_age INT;

SELECT
    YEAR (CURDATE ()) - YEAR (birthday) INTO laborant_age
FROM
    LaboratoryAssistant
WHERE
    id = NEW.laboratory_assistant_id;

IF laborant_age < 21 THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Cannot add UsedSubstance instance. The LaboratoryAssistant is under 21 years old.';

END IF;

END;

-- check the danger class of the ChemicalSubstance before inserting a new UsedSubstance record
CREATE TRIGGER prevent_highly_toxic_chemical_substance BEFORE INSERT ON UsedSubstance FOR EACH ROW BEGIN DECLARE danger_class_name VARCHAR(45);

SELECT
    DangerClass.degree_name INTO danger_class_name
FROM
    DangerClass
    INNER JOIN Category ON Category.danger_class_id = DangerClass.id
    INNER JOIN ChemicalSubstance ON ChemicalSubstance.category_id = Category.id
WHERE
    ChemicalSubstance.id = NEW.chemical_version_id;

IF danger_class_name = 'Highly toxic' THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Cannot add UsedSubstance instance. The ChemicalSubstance has a DangerClass of "Highly toxic".';

END IF;

END;

-- check expiration date before create UsedSubstance record
CREATE TRIGGER check_chemical_version_expiration
BEFORE INSERT ON chemistry.UsedSubstance
FOR EACH ROW
BEGIN
    DECLARE version_expiration DATETIME;

    SELECT expiration_time INTO version_expiration
    FROM chemistry.ChemicalVersion
    WHERE id = NEW.chemical_version_id;

    IF version_expiration < NOW() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot add UsedSubstance instance. The ChemicalVersion has expired.';
    END IF;
END;