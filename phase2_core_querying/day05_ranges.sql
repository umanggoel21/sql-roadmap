-- ====================================================================
-- DAY 5: Range checks and List matching (BETWEEN, IN) (Chinook DB)
-- ====================================================================

-- 🔍 1. Filtering across a numerical range
-- BETWEEN is inclusive of both boundary values.
-- Replaces: "UnitPrice >= 0.99 AND UnitPrice <= 1.99"
SELECT TrackId, Name, UnitPrice 
FROM Track 
WHERE UnitPrice BETWEEN 0.99 AND 1.99;

-- 🔍 2. Validating set memberships
-- IN searches for matching values within a specified list.
-- Replaces multiple "OR" conditions.
SELECT CustomerId, FirstName, Country 
FROM Customer 
WHERE Country IN ('Germany', 'France', 'United Kingdom', 'Italy');

-- 🔍 3. Combining ranges with list exclusions
-- Find invoices from countries other than Canada and USA, with totals between $5.00 and $15.00.
SELECT InvoiceId, Total, BillingCountry
FROM Invoice
WHERE BillingCountry NOT IN ('Canada', 'USA') AND Total BETWEEN 5.00 AND 15.00;
