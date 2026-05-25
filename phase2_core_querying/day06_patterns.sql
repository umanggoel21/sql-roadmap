-- ====================================================================
-- DAY 6: String Pattern Matching (LIKE Wildcards) (Chinook DB)
-- ====================================================================

-- 🔍 1. Match suffix domains using the "%" wildcard
-- "%" matches any sequence of zero or more characters.
SELECT CustomerId, Email 
FROM Customer 
WHERE Email LIKE '%@yahoo.com';

-- 🔍 2. Match prefix values using standard LIKE
-- Finds tracks starting specifically with the word "Love".
SELECT TrackId, Name 
FROM Track 
WHERE Name LIKE 'Love%';

-- 🔍 3. Match specific character lengths using "_" wildcard
-- "_" matches exactly one character. Matches 'Mark', 'Marc', etc.
SELECT CustomerId, FirstName 
FROM Customer 
WHERE FirstName LIKE 'Mar_';
