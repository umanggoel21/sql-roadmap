-- ====================================================================
-- DAY 21: Week 3 Relational & Aggregation Capstone Projects
-- ====================================================================

-- 📊 Question 1: Total Customer Spent & Invoices counts per country.
SELECT c.Country,
       COUNT(DISTINCT c.CustomerId) AS UniqueCustomers,
       COUNT(i.InvoiceId) AS InvoiceCount,
       SUM(i.Total) AS TotalRevenue
FROM customers c
INNER JOIN invoices i ON c.CustomerId = i.CustomerId
GROUP BY c.Country
ORDER BY TotalRevenue DESC;

-- 📊 Question 2: Popular Genres list.
-- Extract Genre names having more than 100 sales.
SELECT g.Name AS GenreName, COUNT(ii.InvoiceLineId) AS TrackSalesCount
FROM genres g
INNER JOIN tracks t ON g.GenreId = t.GenreId
INNER JOIN invoice_items ii ON t.TrackId = ii.TrackId
GROUP BY g.GenreId
HAVING TrackSalesCount > 100
ORDER BY TrackSalesCount DESC;

-- 📊 Question 3: Complete Tracks purchase catalog.
-- List all track details including artist and album.
SELECT t.Name AS TrackName, 
       a.Title AS AlbumTitle, 
       art.Name AS ArtistName,
       SUM(ii.Quantity) AS UnitsSold
FROM tracks t
INNER JOIN albums a ON t.AlbumId = a.AlbumId
INNER JOIN artists art ON a.ArtistId = art.ArtistId
LEFT JOIN invoice_items ii ON t.TrackId = ii.TrackId
GROUP BY t.TrackId
ORDER BY UnitsSold DESC
LIMIT 10;
