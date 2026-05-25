-- =============================================================
--  Phase 6 — Industry Skills
--  File  : 05_data_quality.sql
--  Topic : Find duplicates, orphans, NULLs — real-world DA work
-- =============================================================

-- ---------------------------------------------------------------
-- 80% of a Data Analyst's first week at any company:
-- Understanding the data quality of their tables.
-- These are the exact queries you'll write on day 1.
-- ---------------------------------------------------------------

-- ---------------------------------------------------------------
-- 1. Find DUPLICATE ROWS
-- ---------------------------------------------------------------

-- Duplicate emails in users table
SELECT email, COUNT(*) AS occurrences
FROM users
GROUP BY email
HAVING COUNT(*) > 1;

-- Find all columns of duplicate records (not just the count)
SELECT *
FROM users
WHERE email IN (
    SELECT email
    FROM users
    GROUP BY email
    HAVING COUNT(*) > 1
)
ORDER BY email;

-- More general pattern: duplicates on a business key
-- (e.g., same user placed same order on same date — suspicious)
SELECT user_id, order_date, total_amount, COUNT(*) AS cnt
FROM orders
GROUP BY user_id, order_date, total_amount
HAVING COUNT(*) > 1;

-- ---------------------------------------------------------------
-- 2. Find ORPHANED RECORDS (referential integrity check)
-- ---------------------------------------------------------------

-- Orders that reference a user_id that doesn't exist
-- (Should be 0 with FK constraints, but useful when importing raw data)
SELECT o.order_id, o.user_id
FROM orders o
LEFT JOIN users u ON o.user_id = u.user_id
WHERE u.user_id IS NULL;

-- Order items referencing a non-existent product
SELECT oi.item_id, oi.product_id
FROM order_items oi
LEFT JOIN products p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Products with a category_id that doesn't exist
SELECT p.product_id, p.name, p.category_id
FROM products p
LEFT JOIN categories c ON p.category_id = c.category_id
WHERE c.category_id IS NULL;

-- ---------------------------------------------------------------
-- 3. NULL AUDIT — Find columns with unexpected NULLs
-- ---------------------------------------------------------------

-- Count NULLs in every key column of orders
SELECT
    COUNT(*)                                    AS total_rows,
    COUNT(*) - COUNT(order_id)                  AS null_order_id,
    COUNT(*) - COUNT(user_id)                   AS null_user_id,
    COUNT(*) - COUNT(order_date)                AS null_order_date,
    COUNT(*) - COUNT(status)                    AS null_status,
    COUNT(*) - COUNT(total_amount)              AS null_total_amount
FROM orders;

-- Find users with NULL country (shouldn't happen with our schema, but useful pattern)
SELECT user_id, full_name, email
FROM users
WHERE country IS NULL OR TRIM(country) = '';

-- Find products where price is 0 or NULL (suspicious)
SELECT product_id, name, price
FROM products
WHERE price IS NULL OR price = 0;

-- ---------------------------------------------------------------
-- 4. RANGE / CONSTRAINT VALIDATION
-- ---------------------------------------------------------------

-- Orders where total_amount doesn't match the sum of order_items
-- (Detects data sync bugs between tables)
SELECT
    o.order_id,
    o.total_amount             AS recorded_total,
    SUM(oi.quantity * oi.unit_price) AS calculated_total,
    o.total_amount - SUM(oi.quantity * oi.unit_price) AS discrepancy
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.total_amount
HAVING ABS(o.total_amount - SUM(oi.quantity * oi.unit_price)) > 1.00
ORDER BY ABS(discrepancy) DESC;

-- Future dates — orders placed "in the future" (data entry error)
SELECT order_id, order_date, status
FROM orders
WHERE order_date > CURRENT_DATE;

-- Negative or zero quantities (should never happen)
SELECT * FROM order_items WHERE quantity <= 0;

-- ---------------------------------------------------------------
-- 5. COMPLETENESS CHECK — % of NULLs per column
-- ---------------------------------------------------------------

SELECT
    'full_name'   AS col, ROUND(100.0 * COUNT(*) FILTER (WHERE full_name IS NULL)  / COUNT(*), 1) AS pct_null FROM users
UNION ALL
SELECT 'email',          ROUND(100.0 * COUNT(*) FILTER (WHERE email IS NULL)       / COUNT(*), 1) FROM users
UNION ALL
SELECT 'country',        ROUND(100.0 * COUNT(*) FILTER (WHERE country IS NULL)     / COUNT(*), 1) FROM users
UNION ALL
SELECT 'signup_date',    ROUND(100.0 * COUNT(*) FILTER (WHERE signup_date IS NULL) / COUNT(*), 1) FROM users;

-- ---------------------------------------------------------------
-- 6. DEDUPLICATION — Keep one row, delete duplicates
-- ---------------------------------------------------------------

-- Pattern: keep the row with the lowest order_id, delete the rest
-- (Demo only — safe to run because our data has no actual duplicates)

-- Step 1: Identify which rows to delete
SELECT order_id
FROM (
    SELECT
        order_id,
        ROW_NUMBER() OVER (
            PARTITION BY user_id, order_date, total_amount
            ORDER BY order_id
        ) AS rn
    FROM orders
) ranked
WHERE rn > 1;

-- Step 2: Delete them (run after verifying Step 1 looks correct)
-- DELETE FROM orders
-- WHERE order_id IN (
--     SELECT order_id
--     FROM (
--         SELECT order_id,
--                ROW_NUMBER() OVER (
--                    PARTITION BY user_id, order_date, total_amount
--                    ORDER BY order_id
--                ) AS rn
--         FROM orders
--     ) ranked
--     WHERE rn > 1
-- );

-- ---------------------------------------------------------------
-- PRO TIP: Always run these checks when you get a new dataset.
-- Create a "Data Quality Report" query that runs all checks at once
-- and returns a summary table — this impresses interviewers.
-- ---------------------------------------------------------------
