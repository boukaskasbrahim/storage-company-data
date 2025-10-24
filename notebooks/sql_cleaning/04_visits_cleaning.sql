PRAGMA table_info(visits);

-- =======================================================
-- 04_visits_cleaning.sql
-- Cleaning and standardizing visit logs
-- =======================================================

DROP TABLE IF EXISTS visits_clean;

CREATE TABLE visits_clean AS
SELECT
    visit_id,
    customer_id,
    LOWER(TRIM(unit_id)) AS unit_id,

    -- normalizing visit date format
    DATE(visited_at) AS visited_at,

    -- cleaning purpose text
    LOWER(TRIM(purpose)) AS purpose
FROM visits;

-- quick validation
SELECT COUNT(*) AS total_cleaned FROM visits_clean;
