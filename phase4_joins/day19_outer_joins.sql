-- ====================================================================
-- DAY 19: LEFT JOIN, RIGHT JOIN & FULL JOIN Mechanics (Chinook DB)
-- ====================================================================

-- 🔍 1. List all tracks and their purchase volumes, including unsold items
-- LEFT JOIN retains all records from the left table (Track).
SELECT t.TrackId, t.Name AS TrackName, SUM(COALESCE(il.Quantity, 0)) AS UnitsSold
FROM Track t
LEFT JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY t.TrackId, t.Name
ORDER BY UnitsSold DESC;

-- 🔍 2. Find customers who have never placed a single invoice
-- Finds customers where the left joined invoice ID is NULL.
SELECT c.CustomerId, c.FirstName, c.LastName, c.Email
FROM Customer c
LEFT JOIN Invoice i ON c.CustomerId = i.CustomerId
WHERE i.InvoiceId IS NULL;
