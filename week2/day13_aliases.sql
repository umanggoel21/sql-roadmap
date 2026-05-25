-- ====================================================================
-- DAY 13: Descriptive Projections & Column Aliasing (AS)
-- ====================================================================

-- 🔍 1. Concatenate strings and assign a readable alias
-- Dialect Note: BigQuery/MySQL/PostgreSQL use CONCAT(). SQLite uses "||".
SELECT user_id, 
       (first_name || ' ' || last_name) AS full_name, 
       email AS contact_address 
FROM users;

-- 🔍 2. Dynamic mathematical output projection
-- Computes order tax projection at 8% and aliases result.
SELECT order_id, 
       total_amount, 
       (total_amount * 0.08) AS tax_estimated,
       (total_amount * 1.08) AS final_gross_amount
FROM orders;
