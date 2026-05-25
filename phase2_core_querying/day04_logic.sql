-- ====================================================================
-- DAY 4: Compound Logical Operators (AND, OR, NOT) (Chinook DB)
-- ====================================================================

-- 🔍 1. Narrowing down records using multiple true conditions
-- Both conditions must evaluate to true.
SELECT CustomerId, FirstName, LastName, Country, Email 
FROM Customer 
WHERE Country = 'Canada' AND Email LIKE '%@gmail.com';

-- 🔍 2. Broadening selection using OR criteria
-- Only one of the conditions needs to evaluate to true.
SELECT TrackId, Name, UnitPrice 
FROM Track 
WHERE UnitPrice > 1.99 OR Name = 'Love Me Do';

-- 🔍 3. The Parentheses Trap: Precedence control
-- Goal: Find tracks in Genre 1 or 2 that cost under $1.00.
-- Correct: Grouping the OR condition ensures correct logic.
SELECT TrackId, Name, UnitPrice, GenreId
FROM Track
WHERE (GenreId = 1 OR GenreId = 2) AND UnitPrice < 1.00;
