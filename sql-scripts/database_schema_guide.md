# Project Data Architecture (Google BigQuery)

**Project Origin:** The foundation of this project is the UCI German Credit Dataset. While the source data focused on single-payment loans, I engineered a custom BNPL (Buy-Now-Pay-Later) Simulation to transform the static records into a dynamic, 4-part installment payment cycle. \
This project follows a Star Schema design to transform raw, unstructured transaction logs into clean, audit-ready analytical tables.

**1. Raw Layer**\
raw_data: The landing table containing initial transaction logs, demographics, and account statuses.

**2. Dimensional Tables (Attributes)**\
dim_users: Cleaned demographic data including Age Groups, Gender, Job levels and Housing. \
dim_accounts: Financial status indicators (Checking, Savings).

**3. Fact Tables (Metrics)**\
fact_loans: High-level loan details (Total Amount, Merchant, Duration, Risk Rating).\
fact_installments: The core analytical table. It tracks the status of each of the 4 installments for every user.

**4. Stored Procedures / Scripts**\
**01_Audit_Investigation:** Cleans the raw German Credit data by handling null values, removing duplicates, and standardizing formatting for consistency.\
**02_Cleaning_and_Normalization:** Deconstructs the flattened dataset into a relational Star Schema consisting of four distinct Dimension and Fact tables.\
**03_BNPL_Installment_Logic:** Engineers the 4-part payment cycle logic and simulates missing installments to model real-world credit default patterns.
