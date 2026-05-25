-- ====================================================================
-- DAY 2: Distinct Values & NULL Check Operations
-- ====================================================================

-- 🔍 1. Extract unique countries where customers make orders
-- Eliminates duplicates using DISTINCT.
SELECT DISTINCT BillingCountry FROM invoices;

-- 🔍 2. Identify customers missing state/province records
-- Compares value with NULL. Never use "= NULL" because NULL represents undefined values.
SELECT CustomerId, FirstName, LastName, Country 
FROM customers 
WHERE State IS NULL;

-- 🔍 3. Identify customers who DO have active state entries
-- Utilizes IS NOT NULL.
SELECT CustomerId, FirstName, LastName, State, Country
FROM customers
WHERE State IS NOT NULL;
