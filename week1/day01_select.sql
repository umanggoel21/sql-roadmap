-- ====================================================================
-- DAY 1: Core SELECT & Basic Data Retrieval
-- ====================================================================

-- 🔍 1. Select all columns from the users database
-- Best Practice: Avoid using "*" in production systems to minimize network payload.
SELECT * FROM users;

-- 🔍 2. Select specific columns from the products database
-- Explicitly naming columns increases query stability.
SELECT product_id, product_name, price FROM products;

-- 🔍 3. Get total row volume inside the users table
-- Counts non-null identifiers.
SELECT COUNT(user_id) AS total_users FROM users;

-- 🔍 4. Limit the returned rows to a specific count
-- Dialect Note: BigQuery, MySQL, PostgreSQL, SQLite use "LIMIT 10".
-- SQL Server uses: "SELECT TOP 10 product_id FROM products;"
SELECT product_id, product_name FROM products LIMIT 10;
