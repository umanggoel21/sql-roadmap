-- ====================================================================
-- DAY 17: Relational Integrations with INNER JOIN
-- ====================================================================

-- 🔍 1. Join tracks with their corresponding albums
-- Matches unique keys in both tables to display cohesive results.
SELECT t.TrackId, t.Name AS TrackName, a.Title AS AlbumTitle
FROM tracks t
INNER JOIN albums a ON t.AlbumId = a.AlbumId;

-- 🔍 2. Map customer records to their support employee details
-- Integrates customers table with employees table using foreign key support mapping.
SELECT c.CustomerId, 
       (c.FirstName || ' ' || c.LastName) AS CustomerName,
       (e.FirstName || ' ' || e.LastName) AS RepresentativeAssigned
FROM customers c
INNER JOIN employees e ON c.SupportRepId = e.EmployeeId;
