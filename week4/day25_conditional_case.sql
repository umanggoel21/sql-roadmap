-- ====================================================================
-- DAY 25: Conditional logic using CASE WHEN
-- ====================================================================

-- 🔍 1. Categorize products into custom price tiers
-- Dynamically maps continuous data values to discrete categories.
SELECT product_name, price,
       CASE 
           WHEN price < 20.00 THEN 'Budget'
           WHEN price BETWEEN 20.00 AND 100.00 THEN 'Mid-Tier'
           ELSE 'Premium'
       END AS product_price_segment
FROM products;

-- 🔍 2. Pivoting aggregations (Conditional Aggregation)
-- Counts how many orders exist in specific statuses within a single country.
SELECT country,
       COUNT(CASE WHEN o.status = 'Completed' THEN 1 END) AS completed_orders,
       COUNT(CASE WHEN o.status = 'Pending' THEN 1 END) AS pending_orders
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
GROUP BY country;
