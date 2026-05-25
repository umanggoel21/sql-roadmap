-- ====================================================================
-- DAY 17: Multi-Column Groupings
-- ====================================================================

-- 🔍 1. Group users by country and location status
-- Calculates aggregations across multiple groupings.
SELECT country, 
       COUNT(user_id) AS registered_users
FROM users 
GROUP BY country
ORDER BY country ASC;

-- 🔍 2. Group orders by status and date groupings (Daily order counts)
-- Evaluates status volumes per day.
SELECT order_date, status, COUNT(order_id) AS volume_processed
FROM orders
GROUP BY order_date, status;
