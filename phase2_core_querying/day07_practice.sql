-- ====================================================================
-- DAY 7: Phase 2 Case Exercises & Solutions (Chinook DB)
-- ====================================================================

-- 📊 CASE 1: Find active premium customers outside the USA.
-- Target customers from Canada or UK, registered with yahoo or gmail emails, who are not in 'USA'.
SELECT CustomerId, FirstName, LastName, Country, Email 
FROM Customer 
WHERE Country IN ('Canada', 'United Kingdom') AND Country <> 'USA' AND (Email LIKE '%@gmail.com' OR Email LIKE '%@yahoo.com');


-- 📊 CASE 2: Identify budget-friendly high-priority items.
-- Target tracks in Genre 3 or 5 costing between $0.99 and $1.99.
SELECT TrackId, Name, UnitPrice, GenreId
FROM Track
WHERE (GenreId = 3 OR GenreId = 5) AND UnitPrice BETWEEN 0.99 AND 1.99;


-- 📊 CASE 3: Identify specific customer segments.
-- Select all customers whose first name starts with 'J' and has a phone number.
SELECT CustomerId, FirstName, LastName, Phone
FROM Customer
WHERE FirstName LIKE 'J%' AND Phone IS NOT NULL;
