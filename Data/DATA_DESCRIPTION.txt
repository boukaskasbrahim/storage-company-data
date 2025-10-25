
Synthetic "dirty" dataset for a storage company (generated for practice).
Files included:
 - customers_dirty.csv : 2200 customer rows with intentional dirty data (missing values, corrupted text, inconsistent date formats, bad emails, duplicates)
 - payments_dirty.csv  : 10,000 payment transactions with messy amount formats, non-existing customer refs, and inconsistent statuses
 - visits_log_dirty.csv: 5,000 visit logs with mixed timestamp formats and corrupted entries
 - units.csv           : 500 units with inconsistent naming and some negative rental prices (to practice validation)
 
Common dirty patterns included:
 - Missing emails and phones
 - Emails like "name at domain.com" or trailing spaces / missing dots
 - Phone formats: +31, 06-, 0031-6-, raw digits, text like "PHONE123"
 - Date formats mixed: YYYY-MM-DD, DD/MM/YYYY, MM-DD-YYYY, DD-Mon-YYYY, YYYYMMDD, etc.
 - Lease end dates earlier than start dates, or text values like "indefinite"
 - Negative or zero monthly fees, non-numeric sizes, weird unit labels
 - Duplicate rows and near-duplicates
 - Random non-ASCII characters and null bytes in text fields
 - Transactions referencing non-existent customers
 - Amounts formatted with commas as decimal separators ("EUR 123,45")
 - Corrupted timestamps in visits

Usage suggestions:
 - Use these files to practice data profiling, cleaning, deduplication, type conversions, validation rules, and ETL pipelines.
 - Try detecting invalid emails, normalizing phone numbers, converting dates to ISO, fixing negative fees, resolving duplicates, and joining payments to customers.
