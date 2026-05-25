-- ====================================================================
-- DAY 8: Sorting Results using ORDER BY (Chinook DB)
-- ====================================================================

-- 🔍 1. Multi-column sorting: Country ASC, LastName DESC
-- Default sorting direction is ASC. Columns are evaluated left-to-right.
SELECT Country, LastName, FirstName, Email 
FROM Customer 
ORDER BY Country ASC, LastName DESC;

-- 🔍 2. Sort numeric pricing, descending
-- Orders tracks from most expensive to cheapest.
SELECT TrackId, Name, UnitPrice 
FROM Track 
ORDER BY UnitPrice DESC;

-- 🔍 3. Sort ordering with NULL handling
-- Dialect Note: PostgreSQL supports "NULLS LAST / NULLS FIRST" parameters:
-- "SELECT Email FROM Customer ORDER BY Company ASC NULLS LAST;"
-- In SQLite/MySQL, NULLs naturally sort to the top (first) on ASC.
SELECT Email, Company FROM Customer ORDER BY Company ASC;
