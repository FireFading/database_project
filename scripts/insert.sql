USE chemistry;

-- Insert data into DangerClass table
INSERT INTO
    DangerClass (id, degree_name)
VALUES
    (1, 'Highly toxic'),
    (2, 'Moderately toxic'),
    (3, 'Slightly toxic'),
    (4, 'Non-toxic'),
    (5, 'Undefined');

-- Insert data into Category table
INSERT INTO
    Category (id, title, features, danger_class_id)
VALUES
    (1, 'Acids', 'Sour taste, corrodes metals', 1),
    (2, 'Alkalis', 'Bitter taste, slippery feel', 2),
    (
        3,
        'Organic solvents',
        'Dissolves organic compounds',
        2
    ),
    (4, "Salt", 'Sour taste, corrodes metals', 4),
    (5, 'Oxide', 'Connection with oxygen', 3);

-- Insert data into ChemicalSubstance table
INSERT INTO
    ChemicalSubstance (
        id,
        formula,
        molecular_weight,
        specification,
        category_id
    )
VALUES
    (
        1,
        'H2SO4',
        98.079,
        'Concentrated sulfuric acid',
        1
    ),
    (2, 'NaOH', 40.00, 'Sodium hydroxide pellets', 2),
    (3, 'CH3OH', 32.04, 'Methanol', 3),
    (4, 'H2O', 18.01528, 'Water', 5),
    (5, 'C6H12O6', 180.156, 'Glucose', 3),
    (6, 'NaCl', 58.443, 'Trusted salt', 4),
    (7, 'CO2', 44.01, 'Carbon Dioxide', 5);

-- Insert data into LaboratoryAssistant table
INSERT INTO
    LaboratoryAssistant (
        id,
        first_name,
        last_name,
        patronymic,
        phone,
        birthday,
        characteristics,
        email
    )
VALUES
    (
        1,
        'John',
        'Doether',
        'Smith',
        '1234567890',
        '1990-01-01',
        'Experienced',
        'johndoe@example.com'
    ),
    (
        2,
        'Jane',
        'Doe',
        'Smith',
        '0987654321',
        '1995-01-01',
        'Detail-oriented',
        'janedoe@example.com'
    ),
    (
        3,
        'Michael',
        'Johnson',
        'Brown',
        '5555555555',
        '1985-12-31',
        'Characteristics 3',
        'michael.johnson@example.com'
    ),
    (
        4,
        'Emily',
        'Taylor',
        'Davis',
        '1111111111',
        '1998-06-15',
        'Characteristics 4',
        'emily.taylor@example.com'
    );

-- Insert data into ChemicalReaction table
INSERT INTO
    ChemicalReaction (id, purpose, laboratory_assistant_id)
VALUES
    (1, 'Neutralization', 1),
    (2, 'Extraction', 2),
    (3, 'Extraction', 3),
    (4, 'Extraction', 4);

-- Insert data into ChemicalVersion table
INSERT INTO
    ChemicalVersion (
        id,
        quantity,
        creation_time,
        expiration_time,
        chemical_substance_id
    )
VALUES
    (
        1,
        100.00,
        '2023-04-30 23:59:59',
        '2023-12-31 23:59:59',
        2
    ),
    (
        2,
        150.00,
        '2023-04-30 23:59:59',
        '2023-12-31 23:59:59',
        2
    ),
    (
        3,
        750.00,
        '2022-02-23 23:59:59',
        '2023-11-28 23:59:59',
        3
    ),
    (
        4,
        250.00,
        '2022-01-30 23:59:59',
        '2023-10-10 23:59:59',
        4
    ),
    (
        5,
        50.00,
        '2020-01-30 23:59:59',
        '2025-02-10 23:59:59',
        5
    ),
    (
        6,
        25.00,
        '2019-01-30 23:59:59',
        '2024-02-10 23:59:59',
        6
    ),
    (
        7,
        50.00,
        '2023-01-30 23:59:59',
        '2024-02-10 23:59:59',
        7
    );

-- Insert data into UsedSubstance table
INSERT INTO
    UsedSubstance (
        id,
        amount,
        chemical_reaction_id,
        chemical_version_id,
        time
    )
VALUES
    (1, 10.00, 1, 1, NOW ()),
    (2, 20.00, 1, 2, NOW ()),
    (3, 30.00, 2, 2, NOW ()),
    (4, 30.00, 3, 3, NOW ()),
    (5, 30.00, 3, 3, NOW ()),
    (6, 30.00, 4, 7, NOW ());