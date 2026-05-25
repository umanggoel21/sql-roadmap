-- ====================================================================
-- DAY 8: Sorting Records with ORDER BY
-- ====================================================================

-- 🔍 1. Sort customers alphabetically by country, then by city
-- ASC is default. Dynamic multi-column sorting rules.
SELECT Country, City, FirstName, LastName 
FROM customers 
ORDER BY Country ASC, City ASC;

-- 🔍 2. List tracks sorted by duration, longest first
-- DESC specifies descending order.
SELECT TrackId, Name, Milliseconds 
FROM tracks 
ORDER BY Milliseconds DESC;

-- 🔍 3. Sort albums with NULL handling preference (SQLite standard)
-- Null values are sorted first by default in ASC order.
SELECT Title, ArtistId FROM albums ORDER BY ArtistId ASC;
