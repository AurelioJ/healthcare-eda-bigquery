-- =============================================
-- Demographics
-- Objective:
-- Determine WHO are the patients
-- =============================================

-- Gender as percentage
SELECT
  Gender,
  COUNT(*) AS total_patients,
  ROUND(COUNT(*) / SUM(COUNT(*)) OVER() * 100, 2) AS percent
FROM `data-audit-project.Project1.healthcare`
GROUP BY Gender;

-- Age buckets as percentage
SELECT
  CASE
    WHEN Age < 18 THEN '0-17'
    WHEN Age BETWEEN 18 AND 35 THEN '18-35'
    WHEN Age BETWEEN 36 AND 60 THEN '36-60'
    ELSE '60+'
  END AS age_group,
  COUNT(*) AS total_patients,
  ROUND(COUNT(*) / SUM(COUNT(*)) OVER() * 100, 2) AS percent
FROM `data-audit-project.Project1.healthcare`
GROUP BY age_group;

-- Medical Conditons as percentage
SELECT
  `Medical Condition`,
  COUNT(*) AS case_count,
  ROUND(COUNT(*) / SUM(COUNT(*)) OVER() * 100, 2) AS percent
FROM `data-audit-project.Project1.healthcare`
GROUP BY `Medical Condition`
ORDER BY case_count DESC;
