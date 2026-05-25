-- ====================================================================
-- DAY 17: Multi-Column Groupings (Chinook DB)
-- ====================================================================

-- 🔍 1. Group customers by Country and State
-- Calculates aggregations across multiple groupings.
SELECT Country, State, COUNT(CustomerId) AS CustomerCount
FROM Customer 
WHERE State IS NOT NULL
GROUP BY Country, State
ORDER BY Country ASC, State ASC;

-- 🔍 2. Group invoices by billing country and year (Invoice volumes)
-- Evaluates status volumes per country per year.
-- STRFTIME is used to extract the year in SQLite.
SELECT BillingCountry, STRFTIME('%Y', InvoiceDate) AS BillingYear, COUNT(InvoiceId) AS InvoiceVolume
FROM Invoice
GROUP BY BillingCountry, BillingYear
ORDER BY InvoiceVolume DESC;
