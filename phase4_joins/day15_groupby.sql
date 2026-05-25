-- ====================================================================
-- DAY 15: Segment Aggregations using GROUP BY (Chinook DB)
-- ====================================================================

-- 🔍 1. Find customer populations grouped by country
-- Evaluates row counts for distinct countries.
SELECT Country, COUNT(CustomerId) AS CustomerCount 
FROM Customer 
GROUP BY Country 
ORDER BY CustomerCount DESC;

-- 🔍 2. Find track volume counts per genre
-- Organizes tracks by GenreId.
SELECT GenreId, COUNT(TrackId) AS TrackCount 
FROM Track 
GROUP BY GenreId
ORDER BY TrackCount DESC;
