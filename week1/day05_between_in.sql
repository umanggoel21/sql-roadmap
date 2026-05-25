-- ====================================================================
-- DAY 5: Filter Simplification using BETWEEN and IN
-- ====================================================================

-- 🔍 1. Invoices generated in a specific billing tier range
-- BETWEEN is inclusive of both values. Replaces "Total >= 5 AND Total <= 15".
SELECT InvoiceId, CustomerId, Total 
FROM invoices 
WHERE Total BETWEEN 5.00 AND 15.00;

-- 🔍 2. Customers residing in targeted European markets
-- IN checks membership in a listed set. Highly readable compared to multiple ORs.
SELECT CustomerId, FirstName, LastName, Country 
FROM customers 
WHERE Country IN ('United Kingdom', 'Germany', 'France', 'Belgium');

-- 🔍 3. Combining Set validation with ranges
-- Finds tracks of specific genres that are between 3 and 4 minutes.
SELECT TrackId, Name, GenreId, Milliseconds 
FROM tracks 
WHERE GenreId IN (1, 2, 3) AND Milliseconds BETWEEN 180000 AND 240000;
