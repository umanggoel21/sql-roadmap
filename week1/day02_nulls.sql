-- ====================================================================
-- DAY 2: Unique Values & The Three-Valued Logic (NULLs)
-- ====================================================================

-- 🔍 1. Retrieve unique shipping countries where users reside
-- DISTINCT eliminates duplicate rows across selected columns.
SELECT DISTINCT country FROM users;

-- 🔍 2. Retrieve records containing missing information (NULL checks)
-- Anti-Pattern Alert: Never write "WHERE country = NULL". Always use "IS NULL".
SELECT user_id, email, country 
FROM users 
WHERE country IS NULL;

-- 🔍 3. Retrieve records containing confirmed values
-- Checks for the presence of valid entries.
SELECT user_id, email, country 
FROM users 
WHERE country IS NOT NULL;
