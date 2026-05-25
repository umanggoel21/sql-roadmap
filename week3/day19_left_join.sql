-- ====================================================================
-- DAY 19: Outer Relational Joins with LEFT JOIN
-- ====================================================================

-- 🔍 1. List all artists and their albums, including those with zero albums
-- Keeps all artists, showing NULL for those without albums.
SELECT art.ArtistId, art.Name AS ArtistName, alb.Title AS AlbumTitle
FROM artists art
LEFT JOIN albums alb ON art.ArtistId = alb.ArtistId;

-- 🔍 2. Find inactive customers who have never placed an order
-- Returns rows from customers where join match is NULL.
SELECT c.CustomerId, c.FirstName, c.LastName
FROM customers c
LEFT JOIN invoices i ON c.CustomerId = i.CustomerId
WHERE i.InvoiceId IS NULL;
