-- ====================================================================
-- DAY 12: Finding Extremes (MIN, MAX)
-- ====================================================================

-- 🔍 1. Identify cheapest and most expensive product values
-- Extracts absolute minimum and maximum values.
SELECT MIN(price) AS cheapest_item, MAX(price) AS flagship_item 
FROM products;

-- 🔍 2. Chronological date ranges
-- Evaluates earliest and latest transaction timestamps.
SELECT MIN(order_date) AS first_sale_timestamp, MAX(order_date) AS recent_sale_timestamp 
FROM orders;
