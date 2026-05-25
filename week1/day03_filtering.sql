-- ====================================================================
-- DAY 3: Row-Level Filtering using Comparison Operators
-- ====================================================================

-- 🔍 1. Filter numeric columns using comparison boundaries
-- Finds premium products costing more than $100.
SELECT product_id, product_name, price 
FROM products 
WHERE price > 100.00;

-- 🔍 2. Filter string columns using exact equality
-- Always use single quotes for string values.
SELECT user_id, email, country 
FROM users 
WHERE country = 'USA';

-- 🔍 3. Exclude specific records using inequality operators
-- Matches all rows EXCEPT orders that are completed.
-- Uses standard "<>" (equivalent to "!=" in most dialects).
SELECT order_id, total_amount, status 
FROM orders 
WHERE status <> 'Completed';
