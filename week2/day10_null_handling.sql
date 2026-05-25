-- ====================================================================
-- DAY 10: Null handling functions (IFNULL & COALESCE)
-- ====================================================================

-- 🔍 1. Substitute missing company text values with fallback labels
-- Uses SQLite native IFNULL function.
SELECT CustomerId, FirstName, LastName, IFNULL(Company, 'Private Citizen') AS CustomerCompany
FROM customers;

-- 🔍 2. Coalesce multiple possible null paths
-- COALESCE evaluates elements sequentially and returns the first non-null argument.
SELECT CustomerId, FirstName, LastName, 
       COALESCE(Company, State, 'No Metadata') AS PrimaryContactLocation
FROM customers;
