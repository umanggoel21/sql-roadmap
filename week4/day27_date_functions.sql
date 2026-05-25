-- ====================================================================
-- DAY 27: SQLite Chronological Date Formatting & Manipulation
-- ====================================================================

-- 🔍 1. Extract invoice counts grouped by billing year
-- Uses native STRFTIME('%Y') function.
SELECT STRFTIME('%Y', InvoiceDate) AS SalesYear, 
       SUM(Total) AS YearlyRevenue,
       COUNT(InvoiceId) AS OrderCount
FROM invoices
GROUP BY SalesYear;

-- 🔍 2. Extract monthly sales patterns during a year
-- Uses native STRFTIME('%m') function.
SELECT STRFTIME('%m', InvoiceDate) AS SalesMonth, 
       SUM(Total) AS MonthlyRevenue
FROM invoices
GROUP BY SalesMonth
ORDER BY SalesMonth ASC;
