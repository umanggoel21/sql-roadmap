-- ====================================================================
-- DAY 27: Introduction to Window Functions (ROW_NUMBER, RANK) (Chinook DB)
-- ====================================================================

-- 🔍 1. Assign sequential indices to tracks within their genres
-- Window functions perform calculations across a set of table rows.
SELECT TrackId, Name AS TrackName, GenreId, UnitPrice,
       ROW_NUMBER() OVER (PARTITION BY GenreId ORDER BY UnitPrice DESC) AS GenrePriceSequence
FROM Track;

-- 🔍 2. Rank invoices based on their cumulative totals
-- Uses OVER (ORDER BY) to generate rankings.
SELECT InvoiceId, Total,
       RANK() OVER (ORDER BY Total DESC) AS SpendRank,
       DENSE_RANK() OVER (ORDER BY Total DESC) AS SpendDenseRank
FROM Invoice;
