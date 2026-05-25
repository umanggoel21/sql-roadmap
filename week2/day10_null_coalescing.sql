-- ====================================================================
-- DAY 10: Null handling functions (COALESCE & Dialects)
-- ====================================================================

-- 🔍 1. Universal COALESCE: Returns first non-null argument
-- Dialect Note: COALESCE is ANSI-standard and works across all five engines.
SELECT user_id, first_name, COALESCE(country, 'Not Provided') AS shipping_country
FROM users;

-- 🔍 2. Multi-column fallback chains
-- Evaluates list sequentially: returns State if present; otherwise Country; otherwise 'Worldwide'.
SELECT user_id, COALESCE(country, 'No Address') AS primary_location
FROM users;

-- 🔍 3. Dialect-Specific Replacements
-- T-SQL: "ISNULL(country, 'Worldwide')"
-- MySQL/SQLite: "IFNULL(country, 'Worldwide')"
-- Oracle: "NVL(country, 'Worldwide')"
