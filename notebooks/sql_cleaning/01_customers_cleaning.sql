-- Droping old version if it exists
DROP TABLE IF EXISTS customers_clean;

-- Creating cleaned version
CREATE TABLE customers_clean AS
SELECT
    customer_id,
    TRIM(first_name) AS first_name,
    TRIM(last_name) AS last_name,
    LOWER(email) AS email,
    REPLACE(country, 'Ned.', 'Netherlands') AS country,
    CASE
        WHEN lease_end IS NULL THEN 'active'
        ELSE lease_end
    END AS lease_end,
    monthly_fee
FROM customers;

SELECT COUNT(*) FROM customers_clean;

PRAGMA table_info(customers);

-- =======================================================
-- 01_customers_cleaning.sql
-- Cleaning and standardizing customer information
-- =======================================================

DROP TABLE IF EXISTS customers_clean;

CREATE TABLE customers_clean AS
SELECT
    customer_id,
    TRIM(first_name) AS first_name,
    TRIM(last_name) AS last_name,
    LOWER(TRIM(email)) AS email,

    -- normalizing phone numbers
    REPLACE(REPLACE(REPLACE(phone, ' ', ''), '-', ''), 'ext', '') AS phone,

    TRIM(street_address) AS street_address,
    TRIM(city) AS city,
    TRIM(postal_code) AS postal_code,

    CASE
        WHEN country IN ('Nederland', 'Ned.', 'NL') THEN 'Netherlands'
        ELSE country
    END AS country,

    DATE(sign_up_date) AS sign_up_date,
    DATE(lease_start) AS lease_start,
    CASE
        WHEN lease_end IS NULL OR lease_end = '' THEN 'active'
        ELSE lease_end
    END AS lease_end,

    LOWER(REPLACE(unit_id, '#', '')) AS unit_id,

    -- removing sqm/m2 text and cast to number
    CAST(
        REPLACE(
            REPLACE(
                REPLACE(unit_size, 'sqm', ''),
                'm2', ''
            ),
            ' ', ''
        ) AS FLOAT
    ) AS unit_size,

    -- fixing: correcting column name here
    CAST(monthly_fee AS FLOAT) AS monthly_fee,

    LOWER(payment_status) AS payment_status,
    DATE(last_payment_date) AS last_payment_date,
    TRIM(notes) AS notes
FROM customers;

-- quick check
SELECT COUNT(*) AS total_cleaned FROM customers_clean;
