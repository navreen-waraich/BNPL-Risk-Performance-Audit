#STEP 1: QUALITY AUDIT

SELECT 
    -- 1. TOTAL VOLUME (How much data are we dealing with?)
    COUNT(*) AS total_records,
    
    -- 2. COMPLETENESS (Where are the NAs/Nulls?)
    COUNTIF(`Saving accounts` = 'NA' OR `Saving accounts` IS NULL) AS missing_savings,
    COUNTIF(`Checking account` = 'NA' OR `Checking account` IS NULL) AS missing_checking,
    COUNTIF(Purpose IS NULL) AS missing_purpose,
    
    -- 3. UNIQUENESS (Are there duplicate entries?)
    -- We compare total rows to unique rows. If these match, no duplicates!
    COUNT(DISTINCT int64_field_0) AS unique_ids, 
    
    -- 4. TARGET BALANCE (Good vs Bad risk)
    -- Your column is 'Credit Risk'. Let's see the 1 vs 0 split.
    COUNTIF(`Credit Risk` = 1) AS count_good_risk,
    COUNTIF(`Credit Risk` = 2) AS count_bad_risk,
    
    -- 5. RANGE CHECKS (Validity)
    MIN(Age) AS min_age,
    MAX(Age) AS max_age,
    MIN(`Credit amount`) AS min_loan,
    MAX(`Credit amount`) AS max_loan,
    AVG(Duration) AS avg_duration_months

FROM `bnplportfolioperformance.german_credit_data.raw_data`