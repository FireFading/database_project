USE chemistry;

-- Insert data into DangerClass table
INSERT INTO
    DangerClass (id, degree_name)
VALUES
    (1, 'Highly toxic'),
    (2, 'Moderately toxic'),
    (3, 'Slightly toxic');

-- Insert data into Category table
INSERT INTO
    Category (id, title, features, danger_class_id)
VALUES
    (1, 'Acids', 'Sour taste, corrodes metals', 1),
    (2, 'Alkalis', 'Bitter taste, slippery feel', 1),
    (
        3,
        'Organic solvents',
        'Dissolves organic compounds',
        2
    );

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
    (3, 'CH3OH', 32.04, 'Methanol', 3);

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
        'Doe',
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
    );

-- Insert data into ChemicalReaction table
INSERT INTO
    ChemicalReaction (id, purpose, laboratory_assistant_id)
VALUES
    (1, 100.00, 'Neutralization', 1),
    (2, 50.00, 'Extraction', 2);

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
    (1, 100.00, NOW (), '2023-04-30 23:59:59', 1),
    (2, 50.00, NOW (), '2023-04-30 23:59:59', 2);

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
    (3, 30.00, 2, 2, NOW ());