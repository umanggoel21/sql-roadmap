-- ====================================================================
-- DAY 11: Quantitative Aggregations (COUNT, SUM, AVG) (Chinook DB)
-- ====================================================================

-- 🔍 1. Count non-null country listings
-- COUNT(column) ignores NULLs. COUNT(*) counts all rows.
SELECT COUNT(Country) AS ActiveCountryRecords FROM Customer;

-- 🔍 2. Calculate cumulative totals
-- Sum of all invoice transaction totals.
SELECT SUM(Total) AS LifetimeTotalSales FROM Invoice;

-- 🔍 3. Calculate average transaction pricing
-- Arithmetic mean of invoice totals.
SELECT AVG(Total) AS AverageInvoiceValue FROM Invoice;
