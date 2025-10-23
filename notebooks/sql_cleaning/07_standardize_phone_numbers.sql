/* ==============================================================
07_standardize_phone_numbers.sql
Purpose: Clean and standardize phone number formats in master_dataset
Author: Brahim Boukaskas
Date: CURRENT_DATE
============================================================== */

-- 1. Remove invalid placeholders and obvious fake values
UPDATE master_dataset
SET phone = NULL
WHERE phone LIKE 'PHONE%'
   OR phone LIKE '%ext%'
   OR phone LIKE '%xxxx%'
   OR phone LIKE '%???%'
   OR phone IS NULL
   OR TRIM(phone) = '';

-- 2. Remove spaces, hyphens, and parentheses for normalization
UPDATE master_dataset
SET phone = REPLACE(REPLACE(REPLACE(REPLACE(phone, ' ', ''), '-', ''), '(', ''), ')', '')
WHERE phone IS NOT NULL;

-- 3. Normalize international Dutch numbers:
-- +31 or 0031 → 0
UPDATE master_dataset
SET phone = CASE
    WHEN phone LIKE '+31%' THEN '0' || SUBSTR(phone, 4)
    WHEN phone LIKE '0031%' THEN '0' || SUBSTR(phone, 5)
    ELSE phone
END
WHERE phone IS NOT NULL;

-- 4. Keep only valid-looking Dutch numbers (10 digits starting with 0)
UPDATE master_dataset
SET phone = NULL
WHERE LENGTH(phone) < 10
   OR LENGTH(phone) > 11
   OR phone NOT GLOB '0*';

-- 5. Optional: format consistently as 06-xxxx-xxxx (Dutch mobile style)
UPDATE master_dataset
SET phone = SUBSTR(phone, 1, 2) || '-' ||
            SUBSTR(phone, 3, 4) || '-' ||
            SUBSTR(phone, 7)
WHERE LENGTH(phone) = 10;


SELECT DISTINCT phone
FROM master_dataset
WHERE phone IS NOT NULL
ORDER BY phone
LIMIT 30;
