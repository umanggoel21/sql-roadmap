-- ====================================================================
-- DAY 4: Compound Logical Operators (AND, OR, NOT)
-- ====================================================================

-- 🔍 1. Narrowing down records using multiple true conditions
-- Both conditions must evaluate to true.
SELECT user_id, email, country 
FROM users 
WHERE country = 'Canada' AND email LIKE '%@gmail.com';

-- 🔍 2. Broadening selection using OR criteria
-- Only one of the conditions needs to evaluate to true.
SELECT product_id, product_name, price 
FROM products 
WHERE price > 500.00 OR product_name = 'Special Edition Keyboard';

-- 🔍 3. The Parentheses Trap: Precedence control
-- Goal: Find products in Category 1 or 2 that cost under $50.
-- Correct: Grouping the OR condition ensures correct logic.
SELECT product_id, product_name, price, category_id
FROM products
WHERE (category_id = 1 OR category_id = 2) AND price < 50.00;
