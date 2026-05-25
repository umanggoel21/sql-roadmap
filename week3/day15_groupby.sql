-- ====================================================================
-- DAY 15: Segment Aggregations using GROUP BY
-- ====================================================================

-- 🔍 1. Find user populations grouped by country
-- Evaluates row counts for distinct countries.
SELECT country, COUNT(user_id) AS active_users 
FROM users 
GROUP BY country 
ORDER BY active_users DESC;

-- 🔍 2. Find product volume counts per category
-- Organizes products by category_id.
SELECT category_id, COUNT(product_id) AS product_catalog_count 
FROM products 
GROUP BY category_id;
