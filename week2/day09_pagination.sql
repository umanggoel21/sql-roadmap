-- ====================================================================
-- DAY 9: Result Pagination using LIMIT and OFFSET
-- ====================================================================

-- 🔍 1. Retrieve the top 5 most expensive products
-- Sorts descending then isolates first 5 rows.
SELECT product_name, price 
FROM products 
ORDER BY price DESC 
LIMIT 5;

-- 🔍 2. Paginate: Retrieve rows 6 through 10 of premium products
-- OFFSET bypasses the specified number of rows.
SELECT product_name, price 
FROM products 
ORDER BY price DESC 
LIMIT 5 OFFSET 5;

-- 🔍 3. Standard ANSI/T-SQL Pagination Comparison
-- In Microsoft SQL Server (T-SQL), standard pagination is written as:
-- SELECT product_name, price 
-- FROM products 
-- ORDER BY price DESC 
-- OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;
