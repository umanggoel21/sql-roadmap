-- ====================================================================
-- DAY 3: Row-Level Filtering using Comparison Operators (Chinook DB)
-- ====================================================================

-- 🔍 1. Filter numeric columns using comparison boundaries
-- Finds premium tracks costing more than $0.99.
SELECT TrackId, Name, UnitPrice 
FROM Track 
WHERE UnitPrice > 0.99;

-- 🔍 2. Filter string columns using exact equality
-- Always use single quotes for string values.
SELECT CustomerId, FirstName, LastName, Country 
FROM Customer 
WHERE Country = 'USA';

-- 🔍 3. Exclude specific records using inequality operators
-- Matches all invoice billing countries EXCEPT the USA.
-- Uses standard "<>" (equivalent to "!=" in most dialects).
SELECT InvoiceId, Total, BillingCountry 
FROM Invoice 
WHERE BillingCountry <> 'USA';
