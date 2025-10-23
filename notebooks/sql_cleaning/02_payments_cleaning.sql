PRAGMA table_info(payments);

-- =======================================================
-- 02_payments_cleaning.sql
-- Standardizing transaction and payment data
-- =======================================================

DROP TABLE IF EXISTS payments_clean;

CREATE TABLE payments_clean AS
SELECT
    transaction_id,
    customer_id,

    -- convert date text to ISO date
    DATE(date) AS payment_date,

    -- convert text to float for numeric analysis
    CAST(amount AS FLOAT) AS amount,

    -- clean and normalize text columns
    LOWER(TRIM(method)) AS method,
    LOWER(TRIM(status)) AS status,
    TRIM(note) AS note
FROM payments;

-- quick validation
SELECT COUNT(*) AS total_cleaned FROM payments_clean;
