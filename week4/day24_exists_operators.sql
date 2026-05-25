-- ====================================================================
-- DAY 24: Row Existential Validation checks (EXISTS & NOT EXISTS)
-- ====================================================================

-- 🔍 1. Identify customers who have at least one transaction
-- EXISTS returns TRUE/FALSE, evaluating faster than standard IN clauses.
SELECT c.CustomerId, c.FirstName, c.LastName
FROM customers c
WHERE EXISTS (
    SELECT 1 
    FROM invoices i 
    WHERE i.CustomerId = c.CustomerId
);

-- 🔍 2. List tracks that have NEVER been sold
-- Uses NOT EXISTS to check for missing relationships.
SELECT t.TrackId, t.Name
FROM tracks t
WHERE NOT EXISTS (
    SELECT 1 
    FROM invoice_items ii 
    WHERE ii.TrackId = t.TrackId
);
