-- ====================================================================
-- DAY 19: LEFT JOIN, RIGHT JOIN & FULL JOIN Mechanics
-- ====================================================================

-- 🔍 1. List all products and their order volumes, including unsold items
-- LEFT JOIN retains all records from the left table (products).
SELECT p.product_id, p.product_name, SUM(oi.quantity) AS units_sold
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name;

-- 🔍 2. Find customers who have never placed a single order
-- Finds users where the left joined order ID is NULL.
SELECT u.user_id, u.first_name, u.last_name, u.email
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
WHERE o.order_id IS NULL;
