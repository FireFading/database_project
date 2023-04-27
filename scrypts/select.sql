USE chemistry;

-- Retrieve all the categories with their features and danger class:
SELECT
    title,
    features,
    degree_name
FROM
    Category
    INNER JOIN DangerClass ON Category.danger_class_id = DangerClass.id;

-- Retrieve all the chemical substances with their formula, molecular weight, specification, category, and its danger class:
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
SELECT
    quantity,
    purpose,
    first_name,
    last_name
FROM
    ChemicalReaction
    INNER JOIN LaboratoryAssistant ON ChemicalReaction.laboratory_assistant_id = LaboratoryAssistant.id;

-- Retrieve all the chemical versions with their quantity, creation time, expiration time, chemical substance, and its category:
SELECT
    quantity,
    creation_time,
    expiration_time,
    formula,
    title as category
FROM
    ChemicalVersion
    INNER JOIN ChemicalSubstance ON ChemicalVersion.chemical_substance_id = ChemicalSubstance.id
    INNER JOIN Category ON ChemicalSubstance.category_id = Category.id;

-- Retrieve all the used substances with their amount, chemical reaction, chemical version, and the time it was used:
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

-- Retrieve the count of different danger classes:
-- Retrieve the average molecular weight of all chemical substances:
SELECT
    AVG(molecular_weight) as avg_molecular_weight
FROM
    ChemicalSubstance;

-- Retrieve the earliest and latest birthday of all laboratory assistants:
SELECT
    MIN(birthday) as earliest_birthday,
    MAX(birthday) as latest_birthday
FROM
    LaboratoryAssistant;

-- Retrieve the highest and lowest chemical substance molecular weight, along with their formula:
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

-- Retrieve the unique and not null degree names of all danger classes:
SELECT DISTINCT
    degree_name AS unique_degree_names
FROM
    DangerClass
WHERE
    degree_name IS NOT NULL;

-- Retrieve the not null and unique titles of all categories along with their danger class degree name:
SELECT DISTINCT
    c.title AS unique_category_titles,
    d.degree_name AS danger_class_degree_name
FROM
    Category c
    INNER JOIN DangerClass d ON c.danger_class_id = d.id
WHERE
    c.title IS NOT NULL;

-- Retrieve the not null and unique phone numbers of all laboratory assistants along with their email addresses:
SELECT DISTINCT
    phone AS unique_phone_numbers,
    email AS email_address
FROM
    LaboratoryAssistant
WHERE
    phone IS NOT NULL;

-- Retrieve all chemical substances with a molecular weight greater than 1000:
SELECT
    formula,
    molecular_weight
FROM
    ChemicalSubstance
WHERE
    molecular_weight > 1000;

-- Retrieve all chemical reactions with a quantity greater than or equal to 5 and the purpose "research":
SELECT
    id,
    quantity,
    purpose
FROM
    ChemicalReaction
WHERE
    quantity >= 5
    AND purpose = 'research';

-- Retrieve all chemical substances that have an expiration time before 2024-01-01:
SELECT
    formula,
    expiration_time
FROM
    ChemicalVersion
    INNER JOIN ChemicalSubstance ON ChemicalVersion.chemical_substance_id = ChemicalSubstance.id
WHERE
    expiration_time < '2024-01-01';

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