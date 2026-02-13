-- =============================================
-- Data Cleaning
-- =============================================

-- Case Normalization and Sub-string removal
-- Categorize the billing amounts because of negatives
-- Display length of stay
-- Bucket age Groups

SELECT
  INITCAP(Name) AS Name,
  TRIM(UPPER(Gender)) AS cleaned_gender,
  REPLACE(Doctor, 'Dr.', '') AS Doctor, 
  CASE 
    WHEN `Billing Amount` < 0 THEN 'Refund/Adjustment'
    WHEN `Billing Amount` = 0 THEN 'No Charge'
    ELSE 'Standard Charge'
  END AS billing_category, 
  DATE_DIFF(`Discharge Date`, `Date of Admission`, DAY) AS length_of_stay,
  CASE
    WHEN Age < 18 THEN '0-17'
    WHEN Age BETWEEN 18 AND 35 THEN '18-35'
    WHEN Age BETWEEN 36 AND 60 THEN '36-60'
    ELSE '60+'
  END AS age_group
  
FROM `data-audit-project.Project1.healthcare`;

