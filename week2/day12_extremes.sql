-- ====================================================================
-- DAY 12: Finding Extremes (MIN, MAX)
-- ====================================================================

-- 🔍 1. Identify cheapest and most expensive track pricing
-- Computes min and max values.
SELECT MIN(UnitPrice) AS CheapestTrackPrice, MAX(UnitPrice) AS MostExpensiveTrackPrice 
FROM tracks;

-- 🔍 2. Find range of invoice transaction dates
-- Evaluates chronological minimums and maximums.
SELECT MIN(InvoiceDate) AS EarliestInvoice, MAX(InvoiceDate) AS LatestInvoice 
FROM invoices;
