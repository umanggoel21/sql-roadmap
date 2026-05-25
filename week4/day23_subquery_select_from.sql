-- ====================================================================
-- DAY 23: Subqueries in SELECT and FROM Columns
-- ====================================================================

-- 🔍 1. Correlated Subquery: Display customers along with their lifetime order counts
-- Subquery is evaluated once for every outer customer row.
SELECT c.CustomerId, 
       c.FirstName, 
       c.LastName,
       (SELECT COUNT(*) FROM invoices i WHERE i.CustomerId = c.CustomerId) AS OrderCount
FROM customers c;

-- 🔍 2. Derived Subquery: Calculate the average of average album length totals
-- Uses a subquery in the FROM clause to create a temporary derived table.
SELECT AVG(AlbumAverageDuration) AS OverallAverageAlbumLength
FROM (
    SELECT AlbumId, AVG(Milliseconds) AS AlbumAverageDuration
    FROM tracks
    GROUP BY AlbumId
) AS DerivedAlbumAverages;
