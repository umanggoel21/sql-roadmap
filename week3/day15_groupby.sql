-- ====================================================================
-- DAY 15: Segment Categorization using GROUP BY
-- ====================================================================

-- 🔍 1. Count customers registered in each country
-- Groups by Country and evaluates aggregate count for each group.
SELECT Country, COUNT(CustomerId) AS CustomerCount 
FROM customers 
GROUP BY Country 
ORDER BY CustomerCount DESC;

-- 🔍 2. Calculate average duration of tracks per GenreId
-- Grouping by GenreId, calculating averages.
SELECT GenreId, AVG(Milliseconds) AS AverageLength 
FROM tracks 
GROUP BY GenreId;
