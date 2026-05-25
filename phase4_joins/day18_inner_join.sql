-- ====================================================================
-- DAY 18: Table intersections with INNER JOIN (Chinook DB)
-- ====================================================================

-- 🔍 1. Connect invoices to their corresponding customers
-- Links records where CustomerId matches across both tables.
SELECT i.InvoiceId, i.Total, c.FirstName, c.LastName, c.Email
FROM Invoice i
INNER JOIN Customer c ON i.CustomerId = c.CustomerId;

-- 🔍 2. Chained Inner Joins: Linking 3 tables
-- Connects invoice lines back to their invoice header and track descriptors.
SELECT il.InvoiceLineId, i.InvoiceId, t.Name AS TrackName, il.Quantity, il.UnitPrice
FROM InvoiceLine il
INNER JOIN Invoice i ON il.InvoiceId = i.InvoiceId
INNER JOIN Track t ON il.TrackId = t.TrackId;
