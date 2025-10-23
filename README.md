# Storage Company Data Cleaning Project  

**Author:** Brahim Boukaskas  
**Level:** Junior Data Analyst  
**Tools Used:** Python (pandas), SQLite, SQL, VS Code  

---

## Project Overview  

This project is based on fictitious data I generated for a storage company.  
The goal was to simulate a realistic scenario where a data analyst receives messy and inconsistent files from different departments — customers, payments, visits, and units — and needs to transform them into a clean and structured database ready for analysis.  

The raw data contained common real-world issues such as:
- Typographical errors and duplicated rows  
- Missing or inconsistent dates  
- Mixed phone number formats  
- Non-standard text capitalization  
- Irregular city and country names  

The objective was to clean, standardize, and merge all datasets into one structured database.

---

## Approach and Workflow  

I began using Python (pandas) for the initial exploration phase:
- Identified missing values and duplicates  
- Checked data types and inconsistent formats  
- Cleaned some columns such as dates and numeric values  
- Exported the first cleaned version of each dataset to CSV  

After testing cleaning steps in Python, I moved the process to SQL (SQLite) for better control, scalability, and transparency.  
In VS Code, I created several SQL scripts to handle transformations, normalization, and data integration into a master table.

---

## Project Structure  



Data/
├── raw/ # Original raw CSVs
├── cleaned/ # Cleaned data exported from Python
└── storage_company.db # Final SQLite database

notebooks/
├── 01_exploration.ipynb # Initial data exploration
├── 02_cleaning_pipeline.ipynb # Python cleaning steps
├── 03_database_build.ipynb # Database creation
├── 04_modeling.ipynb # Analysis preparation
└── sql_cleaning/ # SQL-based cleaning scripts
├── 01_customers_cleaning.sql
├── 02_payments_cleaning.sql
├── 03_units_cleaning.sql
├── 04_visits_cleaning.sql
├── 05_merge_master.sql
├── 06_standardize_text_fields.sql
├── 07_standardize_phone_numbers.sql
└── 08_fix_date_formats.sql


---

## Cleaning Highlights  

- Removed duplicates and incomplete records  
- Fixed inconsistent date formats (DD/MM/YYYY, YYYY-MM-DD, etc.)  
- Standardized city and country names (for example, “Amstedam” → “Amsterdam”)  
- Cleaned and unified phone numbers  
- Normalized capitalization and text formatting  
- Combined all datasets into one unified master dataset  
- Saved everything in a clean SQLite database (`storage_company.db`)

---

## Tools and Technologies  

| Tool | Purpose |
|------|----------|
| Python (pandas) | Data exploration and initial cleaning |
| SQLite (SQL) | Final cleaning, merging, and transformations |
| VS Code | Development environment and SQL integration |
| GitHub | Version control and portfolio presentation |

---

## Final Results  

The final database contains the following tables:  

| Table | Rows | Description |
|--------|------|-------------|
| customers | 2,200 | Cleaned customer information |
| payments | 10,000 | Transaction details |
| visits | 5,000 | Visit logs |
| units | 500 | Storage unit data |
| master_dataset | 2,200 | Final merged and standardized dataset |

All data is now consistent, queryable, and ready for reporting or dashboard visualization.

---

## Key Learnings  

- Learned how to transform raw, inconsistent CSV files into a structured SQL database  
- Understood how Python and SQL can complement each other in data preparation  
- Practiced data standardization, validation, and integration  
- Strengthened project organization and database management skills  

---

## About Me  

My name is **Brahim Boukaskas**, and I am a junior data analyst passionate about transforming data into useful insights.  
Through this project, I practiced a complete end-to-end cleaning workflow, from Python exploration to SQL-based structuring, following the same process used in professional data environments.  
