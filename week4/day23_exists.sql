-- ====================================================================
-- DAY 23: Row Existential Validation (EXISTS & NOT EXISTS)
-- ====================================================================

-- 🔍 1. Find users who have placed at least one high-value order
-- EXISTS is faster than IN for large datasets because it short-circuits.
SELECT u.user_id, u.first_name, u.email
FROM users u
WHERE EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.user_id = u.user_id AND o.total_amount > 500.00
);

-- 🔍 2. Find products that have NEVER been ordered
-- Matches empty items.
SELECT p.product_id, p.product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1 
    FROM order_items oi 
    WHERE oi.product_id = p.product_id
);
