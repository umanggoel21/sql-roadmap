-- ====================================================================
-- DAY 4: Compound Logic & Order of Operations (AND, OR, NOT)
-- ====================================================================

-- 🔍 1. Customers located specifically in California, USA
-- Both criteria must evaluate to true. Single quotes are mandatory.
SELECT CustomerId, FirstName, LastName, State, Country 
FROM customers 
WHERE Country = 'USA' AND State = 'CA';

-- 🔍 2. High-value orders OR orders billed to Canada
-- Either condition must be true. Demonstrates loose criteria filtering.
SELECT InvoiceId, Total, BillingCountry 
FROM invoices 
WHERE Total > 15.00 OR BillingCountry = 'Canada';

-- 🔍 3. Combining AND with OR (Mandatory Parentheses)
-- Goal: Find Slash tracks in Metal (Genre 3) or Rock (Genre 1).
-- Without parentheses, AND would match Rock first, ignoring Composer.
SELECT TrackId, Name, GenreId, Composer 
FROM tracks 
WHERE (GenreId = 1 OR GenreId = 3) AND Composer = 'Slash';
