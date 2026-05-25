-- ====================================================================
-- DAY 16: Group filtering using HAVING (Chinook DB)
-- ====================================================================

-- 🔍 1. Find countries containing more than 4 registered customers
-- HAVING evaluates filters *after* group aggregations are calculated.
SELECT Country, COUNT(CustomerId) AS CustomerCount 
FROM Customer 
GROUP BY Country 
HAVING COUNT(CustomerId) > 4
ORDER BY CustomerCount DESC;

-- 🔍 2. Find albums having average track price exceeding $0.99
-- Groups tracks and aggregates the mean price, filtering group outputs.
SELECT AlbumId, AVG(UnitPrice) AS AverageTrackPrice 
FROM Track 
GROUP BY AlbumId 
HAVING AVG(UnitPrice) > 0.99;
