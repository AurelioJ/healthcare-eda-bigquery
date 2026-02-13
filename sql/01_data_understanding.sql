-- =============================================
-- Null Check
-- Objective:
-- Assess completeness of dataset before cleaning
-- =============================================
SELECT 
  COUNT(*) AS total_rows,

  COUNTIF(Name IS NULL) AS name_nulls,
  COUNTIF(Age IS NULL) AS age_nulls,
  COUNTIF(Gender IS NULL) AS gender_nulls,
  COUNTIF(`Blood Type` IS NULL) AS blood_type_nulls,
  COUNTIF(`Medical Condition` IS NULL) AS medical_condition_nulls,
  COUNTIF(`Date of Admission` IS NULL) AS date_of_admission_nulls,
  COUNTIF(Doctor IS NULL) AS doctor_nulls,
  COUNTIF(Hospital IS NULL) AS hospital_nulls,
  COUNTIF(`Insurance Provider` IS NULL) AS insurance_provider_nulls,
  COUNTIF(`Billing Amount` IS NULL) AS billing_amount_nulls,
  COUNTIF(`Room Number` IS NULL) AS room_number_nulls,
  COUNTIF(`Admission Type` IS NULL) AS admission_type_nulls,
  COUNTIF(`Discharge Date` IS NULL) AS discharge_date_nulls,
  COUNTIF(Medication IS NULL) AS medication_nulls,
  COUNTIF(`Test Results` IS NULL) AS test_results_nulls

FROM `data-audit-project.Project1.healthcare`;

-- =============================================
-- Row Count
-- Objective:
-- Assess total number of records to understand dataset size and scale of analysis.
-- =============================================
SELECT 
  COUNT(*) AS total_rows
FROM `data-audit-project.Project1.healthcare`;

-- =============================================
-- Real Duplicates
-- Objective:
-- Identify rows that are exactly repeated or could skew analysis.
-- =============================================
SELECT 
  Name,
  `Date of Admission`,
  Hospital,
  Doctor,
  COUNT(*) AS duplicate_count
FROM `data-audit-project.Project1.healthcare`
GROUP BY Name, `Date of Admission`, Hospital, Doctor
HAVING duplicate_count > 1
ORDER BY duplicate_count DESC;

-- =============================================
-- Categorical Value Distribution
-- Objective:
-- Identify rows that are exactly repeated or could skew analysis.
-- =============================================

-- Gender
SELECT
  Gender,
  COUNT(*) AS count,
  ROUND((COUNT(*) / SUM(COUNT(*)) OVER() * 100), 5) AS percent
FROM `data-audit-project.Project1.healthcare`
GROUP BY Gender
ORDER BY count DESC;

-- Blood Type
SELECT
  `Blood Type`,
  COUNT(*) AS count,
  ROUND((COUNT(*) / SUM(COUNT(*)) OVER() * 100), 5) AS percent
FROM `data-audit-project.Project1.healthcare`
GROUP BY `Blood Type`
ORDER BY count DESC;

--Admission Type 
SELECT
  `Admission Type`,
  COUNT(*) AS count,
  ROUND((COUNT(*) / SUM(COUNT(*)) OVER() * 100), 5) AS percent
FROM `data-audit-project.Project1.healthcare`
GROUP BY `Admission Type`
ORDER BY count DESC;

--Insurance Provider
SELECT
  `Insurance Provider`,
  COUNT(*) AS count,
  ROUND((COUNT(*) / SUM(COUNT(*)) OVER() * 100), 5) AS percent
FROM `data-audit-project.Project1.healthcare`
GROUP BY `Insurance Provider`
ORDER BY count DESC;

--Medical Condition
SELECT
  `Medical Condition`,
  COUNT(*) AS count,
  ROUND((COUNT(*) / SUM(COUNT(*)) OVER() * 100), 5) AS percent
FROM `data-audit-project.Project1.healthcare`
GROUP BY `Medical Condition`
ORDER BY count DESC;

--Hospital
SELECT
  Hospital,
  COUNT(*) AS count,
  ROUND((COUNT(*) / SUM(COUNT(*)) OVER() * 100), 5) AS percent
FROM `data-audit-project.Project1.healthcare`
GROUP BY Hospital
ORDER BY count DESC;

SELECT
  Hospital,
  --COUNT(*) AS count,
  --ROUND((COUNT(*) / SUM(COUNT(*)) OVER() * 100), 5) AS percent
FROM `data-audit-project.Project1.healthcare`
WHERE Hospital LIKE '%,%'
--GROUP BY Hospital
--ORDER BY count DESC;

--Doctor
SELECT
  Doctor,
  COUNT(*) AS count,
  ROUND((COUNT(*) / SUM(COUNT(*)) OVER() * 100), 5) AS percent
FROM `data-audit-project.Project1.healthcare`
GROUP BY Doctor
ORDER BY count DESC;

-- =============================================
-- Numerical Summaries
-- Objective:
-- Check for unrealistic or extreme values.
-- =============================================

-- Age
SELECT 
  MIN(Age) AS min_age, 
  MAX(Age) AS max_age, 
  ROUND(AVG(Age), 1) AS avg_age
FROM `data-audit-project.Project1.healthcare`;

-- Billing Amount
SELECT 
  MIN(`Billing Amount`) AS min_bill, 
  MAX(`Billing Amount`) AS max_bill, 
  ROUND(AVG(`Billing Amount`), 5) AS avg_bill
FROM `data-audit-project.Project1.healthcare`;

-- =============================================
-- Date Columns
-- Objective:
-- Ensure date logic is valid and derive metrics.
-- =============================================

-- Check if discharge is before admission
SELECT *
FROM `data-audit-project.Project1.healthcare`
WHERE `Discharge Date` < `Date of Admission`;

-- Average Length of Stay
SELECT AVG(DATE_DIFF(`Discharge Date`, `Date of Admission`, DAY)) AS avg_length_of_stay
FROM `data-audit-project.Project1.healthcare`;

-- =============================================
-- Text Columns
-- Objective:
-- Objective: Catch whitespace, capitalization, and too many unique values.
-- =============================================

-- Medication distribution
SELECT Medication, COUNT(*) AS freq
FROM `data-audit-project.Project1.healthcare`
GROUP BY Medication
ORDER BY freq DESC;

-- Distinct names vs total rows
SELECT COUNT(DISTINCT Name) AS distinct_names,
       COUNT(*) AS total_rows
FROM `data-audit-project.Project1.healthcare`;








