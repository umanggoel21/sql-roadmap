-- ====================================================================
-- DAY 2: Unique Values & NULL Logic (Chinook DB)
-- ====================================================================

-- 🔍 1. Retrieve unique countries where customers reside
-- DISTINCT eliminates duplicate rows across selected columns.
SELECT DISTINCT Country FROM Customer;

-- 🔍 2. Retrieve records containing missing information (NULL checks)
-- Anti-Pattern Alert: Never write "WHERE Company = NULL". Always use "IS NULL".
SELECT CustomerId, FirstName, LastName, Company 
FROM Customer 
WHERE Company IS NULL;

-- 🔍 3. Retrieve records containing confirmed values
-- Checks for the presence of valid entries.
SELECT CustomerId, FirstName, LastName, Company 
FROM Customer 
WHERE Company IS NOT NULL;
