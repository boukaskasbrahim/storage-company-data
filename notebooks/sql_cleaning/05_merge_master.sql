-- =======================================================
-- 05_merge_master.sql
-- Combining all cleaned tables into one unified dataset
-- =======================================================

DROP TABLE IF EXISTS master_dataset;

CREATE TABLE master_dataset AS
WITH latest_payment AS (
    SELECT
        customer_id,
        MAX(payment_date) AS last_payment_date,
        SUM(amount) AS total_paid
    FROM payments_clean
    GROUP BY customer_id
),
latest_visit AS (
    SELECT
        customer_id,
        MAX(visited_at) AS last_visit_date
    FROM visits_clean
    GROUP BY customer_id
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.phone,
    c.city,
    c.country,
    c.sign_up_date,
    c.lease_start,
    c.lease_end,
    c.unit_id,
    u.canonical_unit_id,
    u.size_sqm,
    u.monthly_fee AS unit_monthly_fee,
    c.payment_status,
    lp.last_payment_date,
    lp.total_paid,
    lv.last_visit_date,
    c.notes
FROM customers_clean c
LEFT JOIN units_clean u ON c.unit_id = u.unit_id
LEFT JOIN latest_payment lp ON c.customer_id = lp.customer_id
LEFT JOIN latest_visit lv ON c.customer_id = lv.customer_id;

UPDATE master_dataset
SET phone = CASE
    WHEN phone LIKE 'PHONE%' THEN NULL
    ELSE REPLACE(REPLACE(REPLACE(REPLACE(phone, ' ', ''), '-', ''), '+31', '0'), '0031', '0')
END;

UPDATE master_dataset
SET unit_id = LOWER(
    TRIM(REPLACE(REPLACE(unit_id, 'unit', ''), ' ', ''))
);

UPDATE master_dataset
SET lease_end = REPLACE(REPLACE(REPLACE(lease_end, '.', '-'), '/', '-'), '–', '-')
WHERE lease_end NOT IN ('active', 'indefinite');

UPDATE master_dataset
SET sign_up_date = REPLACE(REPLACE(REPLACE(sign_up_date, '.', '-'), '/', '-'), '–', '-');

SELECT lease_end FROM master_dataset WHERE lease_end GLOB '*[a-zA-Z]*';

UPDATE master_dataset
SET lease_end = 
    CASE
        WHEN lease_end IN ('active', 'indefinite', '') THEN lease_end
        ELSE REPLACE(REPLACE(REPLACE(lease_end, '.', '-'), '/', '-'), '–', '-')
    END;



UPDATE master_dataset
SET lease_end = 
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
        lease_end,
        '-Jan-', '-01-'),
        '-Feb-', '-02-'),
        '-Mar-', '-03-'),
        '-Apr-', '-04-'),
        '-May-', '-05-'),
        '-Jun-', '-06-'),
        '-Jul-', '-07-'),
        '-Aug-', '-08-'),
        '-Sep-', '-09-'),
        '-Oct-', '-10-'),
        '-Nov-', '-11-'),
        '-Dec-', '-12-')
WHERE lease_end NOT IN ('active', 'indefinite');



UPDATE master_dataset
SET lease_end = 
    CASE
        WHEN lease_end GLOB '??-??-????' THEN 
            SUBSTR(lease_end, 7, 4) || '-' || SUBSTR(lease_end, 4, 2) || '-' || SUBSTR(lease_end, 1, 2)
        ELSE lease_end
    END
WHERE lease_end NOT IN ('active', 'indefinite');


SELECT lease_end
FROM master_dataset
ORDER BY lease_end
LIMIT 50;


SELECT lease_end
FROM master_dataset
WHERE lease_end NOT LIKE '____-__-__'
  AND lease_end NOT IN ('active', 'indefinite');


UPDATE master_dataset
SET lease_end = 
    SUBSTR(lease_end, 1, 4) || '-' || 
    SUBSTR(lease_end, 5, 2) || '-' || 
    SUBSTR(lease_end, 7, 2)
WHERE LENGTH(lease_end) = 8
  AND lease_end NOT LIKE '____-__-__'
  AND lease_end NOT IN ('active', 'indefinite');


SELECT DISTINCT lease_end
FROM master_dataset
WHERE lease_end NOT IN ('active', 'indefinite')
ORDER BY lease_end;
