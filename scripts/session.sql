USE chemistry;

-- check trigger update_chemical_version_amount
-- SELECT * FROM ChemicalVersion;

-- INSERT INTO UsedSubstance (
--         id,
--         amount,
--         chemical_reaction_id,
--         chemical_version_id,
--         time
--     ) VALUES (4, 10.00, 1, 1, NOW ());

-- SELECT * FROM ChemicalVersion;


-- check trigger prevent_highly_toxic_chemical_substance
-- SELECT
--     formula,
--     molecular_weight,
--     specification,
--     title,
--     degree_name
-- FROM
--     ChemicalSubstance
--     INNER JOIN Category ON ChemicalSubstance.category_id = Category.id
--     INNER JOIN DangerClass ON Category.danger_class_id = DangerClass.id;

-- INSERT INTO UsedSubstance (
--         id,
--         amount,
--         chemical_reaction_id,
--         chemical_version_id,
--         time
--     ) VALUES (4, 10.00, 1, 1, NOW ());


-- check trigger check_chemical_version_expiration
-- SELECT * FROM ChemicalVersion;
