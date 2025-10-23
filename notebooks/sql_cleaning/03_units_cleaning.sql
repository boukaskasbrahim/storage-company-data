PRAGMA table_info(units);


-- =======================================================
-- 03_units_cleaning.sql
-- Cleaning and standardizing storage unit information
-- =======================================================

DROP TABLE IF EXISTS units_clean;

CREATE TABLE units_clean AS
SELECT
    LOWER(TRIM(unit_id)) AS unit_id,
    LOWER(TRIM(canonical_unit_id)) AS canonical_unit_id,

    -- make sure numeric columns are usable in analysis
    CAST(size_sqm AS FLOAT) AS size_sqm,
    CAST(monthly_fee AS FLOAT) AS monthly_fee
FROM units;

-- quick validation
SELECT COUNT(*) AS total_cleaned FROM units_clean;
