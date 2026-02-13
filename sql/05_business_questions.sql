-- =============================================
-- Business Questions
-- =============================================

--Are patients billed the same amount for the same condition on the same admission date?
SELECT
  Name,
  `Date of Admission`,
  `Medical Condition`,
  `Billing Amount`,
  COUNT(*) AS duplicate_count
FROM `data-audit-project.Project1.healthcare`
GROUP BY Name, `Date of Admission`, `Medical Condition`, `Billing Amount`
HAVING duplicate_count > 1;

--High-cost 5%

--Do emergency admissions cost more than elective admissions?
SELECT
  `Admission Type`,
  ROUND(AVG(`Billing Amount`),2) AS avg_billing,
  ROUND(AVG(DATE_DIFF(`Discharge Date`, `Date of Admission`, DAY)),2) AS avg_LOS,
  COUNT(*) AS total_cases
FROM `data-audit-project.Project1.healthcare`
WHERE `Billing Amount` >= 0
GROUP BY `Admission Type`
ORDER BY avg_billing DESC;

--LOS vs billing
SELECT 
  DATE_DIFF(`Discharge Date`, `Date of Admission`, DAY) AS length_of_stay,
  AVG(`Billing Amount`) AS billing_avg
FROM `data-audit-project.Project1.healthcare`
GROUP BY length_of_stay

--Insurance comparison
SELECT 
  `Insurance Provider`,
  AVG(`Billing Amount`) AS billing_avg
FROM `data-audit-project.Project1.healthcare`
GROUP BY `Insurance Provider`

