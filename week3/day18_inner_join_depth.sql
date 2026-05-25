-- ====================================================================
-- DAY 18: Multi-Table INNER JOIN Chaining
-- ====================================================================

-- 🔍 1. Chain 4 tables: Tracks, Albums, Artists, Genres
-- Connects complex relational branches using matching keys.
SELECT t.TrackId, 
       t.Name AS TrackName, 
       a.Title AS AlbumTitle, 
       art.Name AS ArtistName, 
       g.Name AS GenreName
FROM tracks t
INNER JOIN albums a ON t.AlbumId = a.AlbumId
INNER JOIN artists art ON a.ArtistId = art.ArtistId
INNER JOIN genres g ON t.GenreId = g.GenreId;
