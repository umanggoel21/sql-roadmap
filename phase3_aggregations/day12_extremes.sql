-- ====================================================================
-- DAY 12: Finding Extremes (MIN, MAX) (Chinook DB)
-- ====================================================================

-- 🔍 1. Identify cheapest and most expensive track values
-- Extracts absolute minimum and maximum values.
SELECT MIN(UnitPrice) AS CheapestItem, MAX(UnitPrice) AS FlagshipItem 
FROM Track;

-- 🔍 2. Chronological date ranges
-- Evaluates earliest and latest invoice timestamps.
SELECT MIN(InvoiceDate) AS FirstSaleTimestamp, MAX(InvoiceDate) AS RecentSaleTimestamp 
FROM Invoice;
