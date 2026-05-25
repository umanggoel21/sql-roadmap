-- ====================================================================
-- DAY 25: Conditional logic using CASE WHEN (Chinook DB)
-- ====================================================================

-- 🔍 1. Categorize tracks into custom price tiers
-- Dynamically maps continuous data values to discrete categories.
SELECT Name AS TrackName, UnitPrice,
       CASE 
           WHEN UnitPrice < 0.99 THEN 'Budget Track'
           WHEN UnitPrice = 0.99 THEN 'Standard Track'
           ELSE 'Premium Track'
       END AS TrackPriceSegment
FROM Track;

-- 🔍 2. Pivoting aggregations (Conditional Aggregation)
-- Counts how many invoices exist in specific price categories within a single country.
SELECT BillingCountry,
       COUNT(CASE WHEN Total >= 10.00 THEN 1 END) AS HighValueInvoices,
       COUNT(CASE WHEN Total < 10.00 THEN 1 END) AS StandardValueInvoices
FROM Invoice
GROUP BY BillingCountry;
