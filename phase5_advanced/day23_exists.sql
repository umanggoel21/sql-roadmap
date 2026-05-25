-- ====================================================================
-- DAY 23: Row Existential Validation (EXISTS & NOT EXISTS) (Chinook DB)
-- ====================================================================

-- 🔍 1. Find customers who have placed at least one high-value invoice
-- EXISTS is faster than IN for large datasets because it short-circuits.
SELECT c.CustomerId, c.FirstName, c.Email
FROM Customer c
WHERE EXISTS (
    SELECT 1 
    FROM Invoice i 
    WHERE i.CustomerId = c.CustomerId AND i.Total > 15.00
);

-- 🔍 2. Find tracks that have NEVER been purchased (never listed in InvoiceLine)
-- Matches empty items.
SELECT t.TrackId, t.Name AS TrackName
FROM Track t
WHERE NOT EXISTS (
    SELECT 1 
    FROM InvoiceLine il 
    WHERE il.TrackId = t.TrackId
);
