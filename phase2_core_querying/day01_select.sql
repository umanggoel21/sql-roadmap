-- ====================================================================
-- DAY 1: Core SELECT & Basic Data Retrieval (Chinook DB)
-- ====================================================================

-- 🔍 1. Select all columns from the Customer table
-- Best Practice: Avoid using "*" in production to minimize network payload.
SELECT * FROM Customer;

-- 🔍 2. Select specific columns from the Track table
-- Explicitly naming columns increases query stability and speed.
SELECT TrackId, Name, UnitPrice FROM Track;

-- 🔍 3. Get total row volume inside the Customer table
-- Counts non-null identifiers.
SELECT COUNT(CustomerId) AS TotalCustomers FROM Customer;

-- 🔍 4. Limit the returned rows to a specific count
-- Dialect Note: SQLite, MySQL, PostgreSQL use "LIMIT 10".
-- SQL Server uses: "SELECT TOP 10 TrackId FROM Track;"
SELECT TrackId, Name FROM Track LIMIT 10;
