USE chemistry;

-- get all reactions that are under responsibility of assistant by hist last_name
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