-- ====================================================================
-- DAY 5: Range checks and List matching (BETWEEN, IN)
-- ====================================================================

-- 🔍 1. Filtering across a numerical range
-- BETWEEN is inclusive of both boundary values.
-- Replaces: "price >= 10.00 AND price <= 50.00"
SELECT product_id, product_name, price 
FROM products 
WHERE price BETWEEN 10.00 AND 50.00;

-- 🔍 2. Validating set memberships
-- IN searches for matching values within a specified list.
-- Replaces multiple "OR" conditions.
SELECT user_id, first_name, country 
FROM users 
WHERE country IN ('Germany', 'France', 'United Kingdom', 'Italy');

-- 🔍 3. Combining ranges with list exclusions
-- Find active orders not pending, costing between $100 and $500.
SELECT order_id, total_amount, status
FROM orders
WHERE status NOT IN ('Cancelled', 'Pending') AND total_amount BETWEEN 100.00 AND 500.00;
