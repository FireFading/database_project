USE chemistry;

-- update quantity of chemical substance when add new used substance record
-- обновление количества версии химического вещества после добавления записи в таблицу использованных веществ
CREATE TRIGGER update_chemical_version_amount AFTER INSERT ON UsedSubstance FOR EACH ROW BEGIN DECLARE new_amount DECIMAL(10, 6);

SET
    new_amount = (
        SELECT
            quantity
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

-- check the danger class of the ChemicalSubstance before inserting a new UsedSubstance record
-- предотвращение выдачи вещества с очень высокой степенью токсичности
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
    MESSAGE_TEXT = CONCAT (
        'Cannot add UsedSubstance instance. The ChemicalSubstance has a DangerClass of "Highly toxic". ChemicalVersion ID: ',
        NEW.chemical_version_id
    );

END IF;

END;

-- -- check expiration date before create UsedSubstance record
-- -- проверка срока годности вещества перед выдачей в использование
CREATE TRIGGER check_chemical_version_expiration BEFORE INSERT ON chemistry.UsedSubstance FOR EACH ROW BEGIN DECLARE version_expiration DATETIME;

SELECT
    expiration_time INTO version_expiration
FROM
    chemistry.ChemicalVersion
WHERE
    id = NEW.chemical_version_id;

IF version_expiration < NOW () THEN SIGNAL SQLSTATE '45000'
SET
    MESSAGE_TEXT = 'Cannot add UsedSubstance instance. The ChemicalVersion has expired.';

END IF;

END;