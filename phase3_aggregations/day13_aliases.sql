-- ====================================================================
-- DAY 13: Descriptive Projections & Column Aliasing (AS) (Chinook DB)
-- ====================================================================

-- 🔍 1. Concatenate strings and assign a readable alias
-- Dialect Note: BigQuery/MySQL/PostgreSQL use CONCAT(). SQLite uses "||".
SELECT CustomerId, 
       (FirstName || ' ' || LastName) AS FullName, 
       Email AS ContactAddress 
FROM Customer;

-- 🔍 2. Dynamic mathematical output projection
-- Computes order tax projection at 8% and aliases result.
SELECT InvoiceId, 
       Total, 
       (Total * 0.08) AS TaxEstimated,
       (Total * 1.08) AS FinalGrossAmount
FROM Invoice;
