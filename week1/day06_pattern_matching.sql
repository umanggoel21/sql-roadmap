-- ====================================================================
-- DAY 6: Wildcard Character Pattern Matching (LIKE)
-- ====================================================================

-- 🔍 1. Customers using standard Gmail accounts
-- "%" matches zero or more characters preceding the phrase.
SELECT CustomerId, FirstName, LastName, Email 
FROM customers 
WHERE Email LIKE '%gmail.com';

-- 🔍 2. Tracks starting specifically with the word "Love"
-- Matches start patterns (e.g., "Love Hurts", "Love In An Elevator").
SELECT TrackId, Name, Composer 
FROM tracks 
WHERE Name LIKE 'Love%';

-- 🔍 3. Employees with a single character prefix in FirstName pattern
-- "_" matches exactly one character. Finds names like "Jane", "John".
SELECT EmployeeId, FirstName, LastName 
FROM employees 
WHERE FirstName LIKE 'J_h_';
