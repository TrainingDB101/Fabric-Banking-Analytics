-- Fabric notebook source

-- METADATA ********************

-- META {
-- META   "kernel_info": {
-- META     "name": "synapse_pyspark"
-- META   },
-- META   "dependencies": {
-- META     "lakehouse": {
-- META       "default_lakehouse": "6cfc8354-d31c-4fde-93f9-e4579ddfae80",
-- META       "default_lakehouse_name": "fabric_banking_medallion_lakehouse",
-- META       "default_lakehouse_workspace_id": "2ac0a272-b27d-4918-b5e3-46392c5d2bf7",
-- META       "known_lakehouses": [
-- META         {
-- META           "id": "6cfc8354-d31c-4fde-93f9-e4579ddfae80"
-- META         }
-- META       ]
-- META     }
-- META   }
-- META }

-- MARKDOWN ********************

-- # Create materialized lake views 
-- 1. Use this notebook to create materialized lake views. 
-- 2. Select **Run all** to run the notebook. 
-- 3. When the notebook run is completed, return to your lakehouse and refresh your materialized lake views graph. 


-- CELL ********************

CREATE MATERIALIZED LAKE VIEW mlv_customer_summary
AS
SELECT
    gender,
    COUNT(*) AS total_customers,
    AVG(credit_score) AS average_credit_score,
    AVG(income) AS average_income,
    AVG(debt) AS average_debt,
    SUM(number_of_cards) AS total_cards
FROM dim_customer
GROUP BY gender;

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }

-- CELL ********************

CREATE MATERIALIZED LAKE VIEW mlv_card_summary
AS
SELECT
    card_brand,
    card_type,
    has_chip,
    COUNT(*) AS total_cards,
    SUM(credit_limit) AS total_credit_limit,
    AVG(credit_limit) AS average_credit_limit
FROM dim_card
GROUP BY
    card_brand,
    card_type,
    has_chip;

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }

-- CELL ********************

CREATE MATERIALIZED LAKE VIEW mlv_credit_risk_summary
AS
SELECT
CASE
    WHEN credit_score < 650 THEN 'High Risk'
    WHEN credit_score BETWEEN 650 AND 749 THEN 'Medium Risk'
    ELSE 'Low Risk'
END AS risk_category,
COUNT(*) AS total_customers,
AVG(income) AS average_income,
AVG(debt) AS average_debt
FROM dim_customer
GROUP BY
CASE
    WHEN credit_score < 650 THEN 'High Risk'
    WHEN credit_score BETWEEN 650 AND 749 THEN 'Medium Risk'
    ELSE 'Low Risk'
END;

-- METADATA ********************

-- META {
-- META   "language": "sparksql",
-- META   "language_group": "synapse_pyspark"
-- META }
