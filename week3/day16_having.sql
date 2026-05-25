-- ====================================================================
-- DAY 16: Filtering Grouped Records using HAVING
-- ====================================================================

-- 🔍 1. Find countries supporting more than 3 active customers
-- HAVING filters *after* GROUP BY aggregation. WHERE cannot do this.
SELECT Country, COUNT(CustomerId) AS CustomerCount 
FROM customers 
GROUP BY Country 
HAVING CustomerCount > 3;

-- 🔍 2. Find albums that contain more than 20 tracks
-- Groups tracks by AlbumId and checks aggregate sizes.
SELECT AlbumId, COUNT(TrackId) AS TrackCount 
FROM tracks 
GROUP BY AlbumId 
HAVING TrackCount > 20;
