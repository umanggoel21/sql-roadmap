-- ====================================================================
-- DAY 8: Sorting Results using ORDER BY
-- ====================================================================

-- 🔍 1. Multi-column sorting: country ASC, registration date DESC
-- Default sorting direction is ASC. Columns are evaluated left-to-right.
SELECT country, created_at, email 
FROM users 
ORDER BY country ASC, created_at DESC;

-- 🔍 2. Sort numeric pricing, descending
-- Orders products from most expensive to cheapest.
SELECT product_id, product_name, price 
FROM products 
ORDER BY price DESC;

-- 🔍 3. Sort ordering with NULL handling
-- Dialect Note: PostgreSQL supports "NULLS LAST / NULLS FIRST" parameters:
-- "SELECT email FROM users ORDER BY country ASC NULLS LAST;"
SELECT email, country FROM users ORDER BY country ASC;
