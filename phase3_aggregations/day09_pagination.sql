-- ====================================================================
-- DAY 9: Result Pagination using LIMIT and OFFSET (Chinook DB)
-- ====================================================================

-- 🔍 1. Retrieve the top 5 most expensive tracks
-- Sorts descending then isolates first 5 rows.
SELECT Name, UnitPrice 
FROM Track 
ORDER BY UnitPrice DESC 
LIMIT 5;

-- 🔍 2. Paginate: Retrieve rows 6 through 10 of tracks
-- OFFSET bypasses the specified number of rows.
SELECT Name, UnitPrice 
FROM Track 
ORDER BY TrackId ASC 
LIMIT 5 OFFSET 5;

-- 🔍 3. Standard ANSI/T-SQL Pagination Comparison
-- In Microsoft SQL Server (T-SQL), standard pagination is written as:
-- SELECT Name, UnitPrice 
-- FROM Track 
-- ORDER BY TrackId ASC 
-- OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;
