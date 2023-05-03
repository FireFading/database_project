USE chemistry;

-- Retrieve all the chemical versions with their quantity, creation time, and expiration time:
-- Получение всех доступных версий для химического вещества по формуле с характеристиками
CREATE PROCEDURE get_chemical_versions(IN chemical_substance_formula VARCHAR(255)) BEGIN
SELECT
    quantity,
    creation_time,
    expiration_time
FROM
    ChemicalVersion
    INNER JOIN ChemicalSubstance ON ChemicalVersion.chemical_substance_id = ChemicalSubstance.id
WHERE formula = chemical_substance_formula;
END;

-- Retrieve all the chemical substances with their formula, molecular weight, specification, category, and its danger class:
-- Получение всех химических веществ со всеми характеристиками, в том числе категорией и классом опасности
CREATE PROCEDURE get_chemical_substances () BEGIN
SELECT
    formula,
    molecular_weight,
    specification,
    title,
    degree_name
FROM
    ChemicalSubstance
    INNER JOIN Category ON ChemicalSubstance.category_id = Category.id
    INNER JOIN DangerClass ON Category.danger_class_id = DangerClass.id;
END;

-- get all reactions that are under responsibility of assistant by hist last_name
-- получить все реакции, за которые отвечает ассистент, по его фамилии
CREATE PROCEDURE get_chemical_reactions_by_assistant (IN assistant_last_name VARCHAR(45)) BEGIN
SELECT
    *
FROM
    ChemicalReaction
    INNER JOIN LaboratoryAssistant ON LaboratoryAssistant.id = ChemicalReaction.laboratory_assistant_id
WHERE
    assistant_last_name = last_name;

END;

-- update characteristics of assistant
-- обновление характеристик ассистента
CREATE PROCEDURE UpdateLaboratoryAssistantCharacteristics (
    IN assistant_last_name VARCHAR(45),
    IN new_characteristics VARCHAR(45)
) BEGIN
UPDATE LaboratoryAssistant
SET
    characteristics = new_characteristics
WHERE
    last_name = assistant_last_name;
END;

-- insert a new ChemicalSubstance
-- добавление записи о новом химическом веществе
CREATE PROCEDURE InsertChemicalSubstance(
    IN p_formula VARCHAR(255),
    IN p_molecular_weight DECIMAL(10, 6),
    IN p_specification VARCHAR(255),
    IN p_category_id INT
)
BEGIN
    INSERT INTO ChemicalSubstance (formula, molecular_weight, specification, category_id)
    VALUES (p_formula, p_molecular_weight, p_specification, p_category_id);
END;