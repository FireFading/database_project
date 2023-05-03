USE chemistry;

-- get all reactions that are under responsibility of assistant by hist last_name
-- получить все реакции, за которые отвечает ассистент, по его фамилии
CREATE PROCEDURE get_chemical_reactions_by_assistant (IN assistant_last_name INT) BEGIN
SELECT
    *
FROM
    ChemicalReaction
    INNER JOIN LaboratoryAssistant ON LaboratoryAssistant.id = ChemicalReaction.laboratory_assistant_id
WHERE
    assistant_last_name = last_name;

END

-- update characteristics of assistant
-- обновление характеристик ассистента
CREATE PROCEDURE UpdateLaboratoryAssistantCharacteristics (
    IN assistant_last_name INT,
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