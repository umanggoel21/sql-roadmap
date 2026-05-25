-- ====================================================================
-- DAY 22: Subqueries Nested in WHERE Clauses
-- ====================================================================

-- 🔍 1. Extract invoices exceeding the average ticket total
-- Evaluates the internal query first, then uses it for outer filtering.
SELECT InvoiceId, CustomerId, Total 
FROM invoices 
WHERE Total > (SELECT AVG(Total) FROM invoices);

-- 🔍 2. Find tracks in albums by a specific artist ('Led Zeppelin')
-- Uses IN comparison with a subquery list.
SELECT TrackId, Name 
FROM tracks 
WHERE AlbumId IN (
    SELECT AlbumId 
    FROM albums 
    WHERE ArtistId = (
        SELECT ArtistId 
        FROM artists 
        WHERE Name = 'Led Zeppelin'
    )
);
