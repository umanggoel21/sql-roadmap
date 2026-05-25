-- ====================================================================
-- DAY 9: Pagination Controls using LIMIT and OFFSET
-- ====================================================================

-- 🔍 1. Identify the top 5 most expensive tracks in the store
-- Orders DESC then takes the top 5 records.
SELECT Name, UnitPrice 
FROM tracks 
ORDER BY UnitPrice DESC 
LIMIT 5;

-- 🔍 2. Paginate results: Get rows 6 through 10 of longest tracks
-- OFFSET shifts the starting point of evaluation.
SELECT Name, Milliseconds 
FROM tracks 
ORDER BY Milliseconds DESC 
LIMIT 5 OFFSET 5;
