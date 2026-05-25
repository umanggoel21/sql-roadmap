-- ====================================================================
-- DAY 16: Group filtering using HAVING
-- ====================================================================

-- 🔍 1. Find countries containing more than 50 registered users
-- HAVING evaluates filters *after* group aggregations are calculated.
SELECT country, COUNT(user_id) AS user_count 
FROM users 
GROUP BY country 
HAVING COUNT(user_id) > 50;

-- 🔍 2. Find product categories having average price exceeding $150
-- Groups products and aggregates the mean price, filtering group outputs.
SELECT category_id, AVG(price) AS average_category_price 
FROM products 
GROUP BY category_id 
HAVING AVG(price) > 150.00;
