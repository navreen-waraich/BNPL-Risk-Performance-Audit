/* PHASE 2: CLEANING & NORMALIZATION
   We are creating 3 Views to remove spaces, handle NAs, and fix data types.
*/

---------------------------------------------------------
-- VIEW 1: dim_users (Demographics)
---------------------------------------------------------
CREATE OR REPLACE VIEW `bnplportfolioperformance.german_credit_data.dim_users` AS
SELECT 
    int64_field_0 AS user_id,
    Age AS age,
    LOWER(Sex) AS gender,
    Job AS job_level,
    LOWER(Housing) AS housing_type
FROM `bnplportfolioperformance.german_credit_data.raw_data`;

---------------------------------------------------------
-- VIEW 2: dim_accounts (Financial Status)
---------------------------------------------------------
CREATE OR REPLACE VIEW `bnplportfolioperformance.german_credit_data.dim_accounts` AS
SELECT 
    int64_field_0 AS user_id,
    -- Handling the NAs: If 'NA', we label it 'no_account_info'
    CASE WHEN `Saving accounts` = 'NA' THEN 'no_account_info' ELSE `Saving accounts` END AS saving_status,
    CASE WHEN `Checking account` = 'NA' THEN 'no_account_info' ELSE `Checking account` END AS checking_status
FROM `bnplportfolioperformance.german_credit_data.raw_data`;

---------------------------------------------------------
-- VIEW 3: fact_loans (The BNPL Transactions)
---------------------------------------------------------
CREATE OR REPLACE VIEW `bnplportfolioperformance.german_credit_data.fact_loans` AS
SELECT 
    int64_field_0 AS user_id,
    `Credit amount` AS loan_amount,
    Duration AS duration_months,
    LOWER(Purpose) AS merchant_category,
    -- Standardizing Risk: 1 -> 'Good', 2 -> 'Bad'
    CASE WHEN `Credit Risk` = 1 THEN 'Good' ELSE 'Bad' END AS risk_rating
FROM `bnplportfolioperformance.german_credit_data.raw_data`;