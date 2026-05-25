-- ====================================================================
-- DAY 6: String Pattern Matching (LIKE Wildcards)
-- ====================================================================

-- 🔍 1. Match suffix domains using the "%" wildcard
-- "%" matches any sequence of zero or more characters.
SELECT user_id, email 
FROM users 
WHERE email LIKE '%@yahoo.com';

-- 🔍 2. Match prefix values using standard LIKE
-- Finds products starting specifically with the word "Super".
SELECT product_id, product_name 
FROM products 
WHERE product_name LIKE 'Super%';

-- 🔍 3. Match specific character lengths using "_" wildcard
-- "_" matches exactly one character. Matches 'user1', 'userA', etc.
SELECT user_id, first_name 
FROM users 
WHERE first_name LIKE 'user_';
