-- ====================================================================
-- DAY 26: Conditional Logic using CASE WHEN
-- ====================================================================

-- 🔍 1. Categorize tracks based on duration length cohorts
-- Dynamic row-level categorization.
SELECT Name, Milliseconds,
       CASE 
           WHEN Milliseconds < 180000 THEN 'Short Track'
           WHEN Milliseconds BETWEEN 180000 AND 300000 THEN 'Medium Track'
           ELSE 'Epic Track'
       END AS TrackCohort
FROM tracks;

-- 🔍 2. Pivot aggregate spent columns (Conditional Aggregation)
-- Counts how many invoices fall into specific cost thresholds.
SELECT COUNT(CASE WHEN Total >= 10.00 THEN 1 END) AS HighValueOrders,
       COUNT(CASE WHEN Total < 10.00 THEN 1 END) AS StandardValueOrders
FROM invoices;
