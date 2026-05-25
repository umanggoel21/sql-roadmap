-- ====================================================================
-- DAY 3: Row-Level Filtering using Basic Comparison Operators
-- ====================================================================

-- 🔍 1. Invoices exceeding a specific monetary value
-- Filters decimal records with greater-than operator.
SELECT InvoiceId, CustomerId, InvoiceDate, Total 
FROM invoices 
WHERE Total > 10.00;

-- 🔍 2. Customers situated outside the United States
-- Uses inequality operator "<>" to exclude USA records.
SELECT CustomerId, FirstName, LastName, Country 
FROM customers 
WHERE Country <> 'USA';

-- 🔍 3. Long tracks exceeding 5 minutes
-- Filters tracks table with milliseconds comparison (5 min = 300,000 ms).
SELECT TrackId, Name, Milliseconds 
FROM tracks 
WHERE Milliseconds > 300000;
