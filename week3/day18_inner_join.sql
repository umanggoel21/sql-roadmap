-- ====================================================================
-- DAY 18: Table intersections with INNER JOIN
-- ====================================================================

-- 🔍 1. Connect orders to their corresponding users
-- Links records where user_id matches across both tables.
SELECT o.order_id, o.total_amount, u.first_name, u.last_name, u.email
FROM orders o
INNER JOIN users u ON o.user_id = u.user_id;

-- 🔍 2. Chained Inner Joins: Linking 3 tables
-- Connects order items back to their order header and product descriptors.
SELECT oi.item_id, o.order_id, p.product_name, oi.quantity, oi.unit_price
FROM order_items oi
INNER JOIN orders o ON oi.order_id = o.order_id
INNER JOIN products p ON oi.product_id = p.product_id;
