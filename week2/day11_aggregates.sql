-- ====================================================================
-- DAY 11: Quantitative Aggregations (COUNT, SUM, AVG)
-- ====================================================================

-- 🔍 1. Count non-null country listings
-- COUNT(column) ignores NULLs. COUNT(*) counts all rows.
SELECT COUNT(country) AS active_country_records FROM users;

-- 🔍 2. Calculate cumulative totals
-- Sum of all order transactions.
SELECT SUM(total_amount) AS lifetime_total_sales FROM orders;

-- 🔍 3. Calculate average transaction pricing
-- Arithmetic mean of order tickets.
SELECT AVG(total_amount) AS average_order_value FROM orders;
