USE chemistry;

-- Retrieve all the categories with their features and danger class:
-- Получение всех категорий с соответствующим им классам опасности
SELECT
    title,
    features,
    degree_name
FROM
    Category
    INNER JOIN DangerClass ON Category.danger_class_id = DangerClass.id;

-- Retrieve all the chemical substances with their formula, molecular weight, specification, category, and its danger class:
-- Получение всех химических веществ со всеми характеристиками, в том числе категорией и классом опасности
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

-- Retrieve all the laboratory assistants with their first name, last name, patronymic, phone number, birthday, and email:
-- Получение всех лаборантов
SELECT
    first_name,
    last_name,
    patronymic,
    phone,
    birthday,
    email
FROM
    LaboratoryAssistant;

-- Retrieve all the chemical reactions with their quantity, purpose, and the laboratory assistant responsible for it:
-- Получение всех проведенных химических реакций с лаборантами, ответственными за проведение
SELECT
    purpose,
    first_name,
    last_name
FROM
    ChemicalReaction
    INNER JOIN LaboratoryAssistant ON ChemicalReaction.laboratory_assistant_id = LaboratoryAssistant.id;

-- Retrieve all the chemical versions with their quantity, creation time, expiration time, chemical substance, and its category:
-- Получение всех доступных версий химических веществ с характеристиками, в том числе категорией и классом опасности
SELECT
    quantity,
    creation_time,
    expiration_time,
    formula,
    title as category,
    degree_name
FROM
    ChemicalVersion
    INNER JOIN ChemicalSubstance ON ChemicalVersion.chemical_substance_id = ChemicalSubstance.id
    INNER JOIN Category ON ChemicalSubstance.category_id = Category.id
    INNER JOIN DangerClass ON Category.danger_class_id = DangerClass.id;

-- Retrieve all the used substances with their amount, chemical reaction, chemical version, and the time it was used:
-- Получение всех использованных веществ с количеством и целью использования
SELECT
    amount,
    purpose,
    formula,
    time
FROM
    UsedSubstance
    INNER JOIN ChemicalReaction ON UsedSubstance.chemical_reaction_id = ChemicalReaction.id
    INNER JOIN ChemicalVersion ON UsedSubstance.chemical_version_id = ChemicalVersion.id
    INNER JOIN ChemicalSubstance ON ChemicalVersion.chemical_substance_id = ChemicalSubstance.id;

-- Retrieve max and min ages of all laboratory assistants:
-- Получение максимального и минимального возрастов лаборантов
SELECT
    TIMESTAMPDIFF(YEAR, MIN(birthday), CURDATE()) AS min_age,
    TIMESTAMPDIFF(YEAR, MAX(birthday), CURDATE()) AS max_age
FROM
    LaboratoryAssistant;

-- Retrieve the highest and lowest chemical substance molecular weight, along with their formula:
-- Получение максимального и минимального молекулярного веса химических веществ
SELECT
    MAX(molecular_weight) as highest_molecular_weight,
    MIN(molecular_weight) as lowest_molecular_weight
FROM
    ChemicalSubstance;

-- Retrieve the total amount of used substances, grouped by chemical substance and reaction purpose:
SELECT
    formula,
    purpose,
    SUM(amount) as total_amount
FROM
    UsedSubstance
    INNER JOIN ChemicalVersion ON UsedSubstance.chemical_version_id = ChemicalVersion.id
    INNER JOIN ChemicalSubstance ON ChemicalVersion.chemical_substance_id = ChemicalSubstance.id
    INNER JOIN ChemicalReaction ON UsedSubstance.chemical_reaction_id = ChemicalReaction.id
GROUP BY
    formula,
    purpose;

-- Retrieve the not null and unique titles of all categories along with their danger class degree name:
-- Получение всех категорий с соответствующими классами опасности
SELECT DISTINCT
    c.title AS unique_category_titles,
    d.degree_name AS danger_class_degree_name
FROM
    Category c
    INNER JOIN DangerClass d ON c.danger_class_id = d.id
WHERE
    c.title IS NOT NULL;

-- Retrieve all chemical substances that have an expiration time before name
-- Получение всех химических веществ с истекшим сроком годности
SELECT
    formula,
    expiration_time
FROM
    ChemicalVersion
    INNER JOIN ChemicalSubstance ON ChemicalVersion.chemical_substance_id = ChemicalSubstance.id
WHERE
    expiration_time < CURDATE();

-- Retrieve all used substances with an amount greater than 10, grouped by chemical substance and laboratory assistant first name:
SELECT
    ChemicalSubstance.formula,
    LaboratoryAssistant.first_name,
    SUM(amount) AS total_amount
FROM
    UsedSubstance
    INNER JOIN ChemicalVersion ON UsedSubstance.chemical_version_id = ChemicalVersion.id
    INNER JOIN ChemicalSubstance ON ChemicalVersion.chemical_substance_id = ChemicalSubstance.id
    INNER JOIN ChemicalReaction ON UsedSubstance.chemical_reaction_id = ChemicalReaction.id
    INNER JOIN LaboratoryAssistant ON ChemicalReaction.laboratory_assistant_id = LaboratoryAssistant.id
WHERE
    amount > 10
GROUP BY
    ChemicalSubstance.formula,
    LaboratoryAssistant.first_name;