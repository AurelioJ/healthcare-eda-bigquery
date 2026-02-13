-- =============================================
-- Financial Analysis
-- Cost patterns and revenue drivers.
-- =============================================

-- Average Billing per Condition
SELECT
  `Medical Condition`,
  ROUND(AVG(`Billing Amount`),2) AS avg_billing,
  COUNT(*) AS cases,
  ROUND(COUNT(*) / SUM(COUNT(*)) OVER() * 100, 2) AS percent
FROM `data-audit-project.Project1.healthcare`
WHERE `Billing Amount` >= 0
GROUP BY `Medical Condition`
ORDER BY avg_billing DESC;

-- Total revenue for each Insurance Provider
SELECT
  `Insurance Provider`,
  ROUND(SUM(`Billing Amount`),2) AS total_revenue
FROM `data-audit-project.Project1.healthcare`
WHERE `Billing Amount` >= 0
GROUP BY `Insurance Provider`
ORDER BY total_revenue DESC;
