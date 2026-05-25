-- ====================================================================
-- DAY 7: Week 1 Case Exercises & Solutions
-- ====================================================================

-- 📊 CASE 1: Find active premium users outside the USA.
-- Target users from Canada or UK, registered with confirmed emails, who are not in 'USA'.
SELECT user_id, email, country 
FROM users 
WHERE country IN ('Canada', 'United Kingdom') AND country <> 'USA' AND email IS NOT NULL;


-- 📊 CASE 2: Identify budget-friendly high-priority items.
-- Target products in Category 3 or 5 costing between $15.00 and $45.00.
SELECT product_id, product_name, price, category_id
FROM products
WHERE (category_id = 3 OR category_id = 5) AND price BETWEEN 15.00 AND 45.00;


-- 📊 CASE 3: Identify institutional emails.
-- Select all users whose email starts with 'admin' or ends with '.edu'.
SELECT user_id, email
FROM users
WHERE email LIKE 'admin%' OR email LIKE '%.edu';
