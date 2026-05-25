-- ====================================================================
-- DAY 21: Phase 4 Relational Practice Scenarios (Chinook DB)
-- ====================================================================

-- 📊 CASE 1: Top Revenue-Generating Genres.
-- Find genre names with cumulative sales revenue exceeding $100.
SELECT g.Name AS GenreName, 
       SUM(il.Quantity * il.UnitPrice) AS TotalRevenue
FROM InvoiceLine il
INNER JOIN Track t ON il.TrackId = t.TrackId
INNER JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name
HAVING TotalRevenue > 100.00
ORDER BY TotalRevenue DESC;


-- 📊 CASE 2: Inactive catalog items.
-- Find all tracks that have never been purchased (never listed in InvoiceLine).
SELECT t.TrackId, t.Name AS TrackName, t.UnitPrice
FROM Track t
LEFT JOIN InvoiceLine il ON t.TrackId = il.TrackId
WHERE il.InvoiceLineId IS NULL;


-- 📊 CASE 3: Active customer billing cohorts.
-- Group customers by country, counting only customers who have placed at least one invoice.
SELECT c.Country, COUNT(DISTINCT c.CustomerId) AS ActiveCustomerCount
FROM Customer c
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.Country
ORDER BY ActiveCustomerCount DESC;
