/* ==============================================================
06_standardize_text_fields.sql
Purpose: Clean and normalize text fields in master_dataset
Author: Brahim Boukaskas
Date: CURRENT_DATE
============================================================== */

-- Fix city typos and normalize capitalization
UPDATE master_dataset
SET city = CASE
    WHEN LOWER(city) LIKE 'amstelvveen%' THEN 'Amstelveen'
    WHEN LOWER(city) LIKE 'haarlem%' THEN 'Haarlem'
    WHEN LOWER(city) LIKE 'amsterdam%' THEN 'Amsterdam'
    WHEN LOWER(city) LIKE 'haarlemmermeer%' THEN 'Haarlemmermeer'
    WHEN LOWER(city) LIKE 'leiden%' THEN 'Leiden'
    WHEN LOWER(city) LIKE 'the hague%' THEN 'The Hague'
    WHEN LOWER(city) LIKE 'rotterdam%' THEN 'Rotterdam'
    WHEN LOWER(city) LIKE 'alkmaar%' THEN 'Alkmaar'
    WHEN LOWER(city) LIKE 'eindhoven%' THEN 'Eindhoven'
    ELSE city
END;

-- Capitalize first letter of each city (for consistency)
UPDATE master_dataset
SET city = UPPER(SUBSTR(city, 1, 1)) || LOWER(SUBSTR(city, 2))
WHERE city IS NOT NULL AND city != '';

-- Standardize country names and remove abbreviations
UPDATE master_dataset
SET country = CASE
    WHEN LOWER(country) IN ('nl', 'ned', 'nederland', 'netherland') THEN 'Netherlands'
    ELSE country
END;

-- Trim potential extra spaces
UPDATE master_dataset
SET city = TRIM(city),
    country = TRIM(country);


SELECT DISTINCT city, country
FROM master_dataset
ORDER BY city;


/* ==============================================================
06_standardize_text_fields.sql
Purpose: Correct city and country text inconsistencies in master_dataset
Author: Brahim Boukaskas
Date: CURRENT_DATE
============================================================== */

-- Fix city names and common misspellings
UPDATE master_dataset
SET city = CASE
    WHEN LOWER(city) IN (
        'amstelveen', 'amstelvveen', 'amsteelveen', 'ammstelveen', 'amstelveenn'
    ) THEN 'Amstelveen'

    WHEN LOWER(city) IN (
        'amsterdam', 'amstedam', 'amsteerdam'
    ) THEN 'Amsterdam'

    WHEN LOWER(city) IN (
        'alkmaar', 'allkmaar'
    ) THEN 'Alkmaar'

    WHEN LOWER(city) IN (
        'haarlem', 'haarrlem', 'harlem'
    ) THEN 'Haarlem'

    WHEN LOWER(city) IN (
        'haarlemmermeer', 'harlemmermeer'
    ) THEN 'Haarlemmermeer'

    WHEN LOWER(city) IN (
        'eindhoven', 'eindhove', 'eindhven', 'einhoven', 'eiden', 'indhoven'
    ) THEN 'Eindhoven'

    WHEN LOWER(city) IN (
        'leiden', 'leien'
    ) THEN 'Leiden'

    WHEN LOWER(city) IN (
        'rotterdam', 'rotteram', 'rottterdam'
    ) THEN 'Rotterdam'

    WHEN LOWER(city) IN (
        'the hague', 'the  hague', 'the  hague�', 'the  hgue', 'thhe hague', 'he hague', 'tthe  hague'
    ) THEN 'The Hague'

    WHEN LOWER(city) IN (
        'utrecht', 'utrech', 'utreht', 'uttrcht', 'utrecht�'
    ) THEN 'Utrecht'

    ELSE city
END;

-- Normalize capitalization
UPDATE master_dataset
SET city = UPPER(SUBSTR(city, 1, 1)) || LOWER(SUBSTR(city, 2))
WHERE city IS NOT NULL AND city != '';

-- Standardize country variations
UPDATE master_dataset
SET country = CASE
    WHEN LOWER(country) IN ('nl', 'ned', 'nederland', 'netherland') THEN 'Netherlands'
    ELSE country
END;

-- Remove extra spaces and invisible characters
UPDATE master_dataset
SET city = TRIM(REPLACE(REPLACE(city, '  ', ' '), '�', '')),
    country = TRIM(REPLACE(REPLACE(country, '  ', ' '), '�', ''));


SELECT DISTINCT city, country
FROM master_dataset
ORDER BY city;
