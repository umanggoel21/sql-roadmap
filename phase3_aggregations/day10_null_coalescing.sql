-- ====================================================================
-- DAY 10: Null handling functions (COALESCE & Dialects) (Chinook DB)
-- ====================================================================

-- 🔍 1. Universal COALESCE: Returns first non-null argument
-- Dialect Note: COALESCE is ANSI-standard and works across all five engines.
SELECT CustomerId, FirstName, LastName, COALESCE(Company, 'Individual') AS CustomerType
FROM Customer;

-- 🔍 2. Multi-column fallback chains
-- Evaluates list sequentially: returns Company if present; otherwise State; otherwise 'No Location Info'.
SELECT CustomerId, COALESCE(Company, State, 'No Location Info') AS PrimaryIdentifier
FROM Customer;

-- 🔍 3. Dialect-Specific Replacements
-- T-SQL: "ISNULL(Company, 'Individual')"
-- MySQL/SQLite: "IFNULL(Company, 'Individual')"
-- Oracle: "NVL(Company, 'Individual')"
