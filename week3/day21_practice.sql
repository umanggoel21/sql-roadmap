-- ====================================================================
-- DAY 21: Week 3 Relational Practice Scenarios
-- ====================================================================

-- 📊 CASE 1: Top Revenue-Generating Product Categories.
-- Find category names (or IDs) with cumulative sales revenue exceeding $5000.
SELECT p.category_id, 
       SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category_id
HAVING total_revenue > 5000.00
ORDER BY total_revenue DESC;


-- 📊 CASE 2: Inactive catalog items.
-- Find all products that have never been purchased (never listed in order_items).
SELECT p.product_id, p.product_name, p.price
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.item_id IS NULL;


-- 📊 CASE 3: Active buyer cohorts.
-- Group users by country, counting only users who have completed at least one order.
SELECT u.country, COUNT(DISTINCT u.user_id) AS active_buyer_count
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
WHERE o.status = 'Completed'
GROUP BY u.country
ORDER BY active_buyer_count DESC;
