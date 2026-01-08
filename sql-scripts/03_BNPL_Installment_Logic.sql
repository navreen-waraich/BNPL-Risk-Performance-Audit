CREATE OR REPLACE VIEW `bnplportfolioperformance.german_credit_data.fact_installments` AS
SELECT 
    user_id,
    merchant_category,
    risk_rating,
    -- Calculate the equal payment amount
    loan_amount / 4 AS installment_amount,
    -- Assign a number to each payment (1, 2, 3, or 4)
    payment_number
FROM `bnplportfolioperformance.german_credit_data.fact_loans`
CROSS JOIN UNNEST(GENERATE_ARRAY(1, 4)) AS payment_number;