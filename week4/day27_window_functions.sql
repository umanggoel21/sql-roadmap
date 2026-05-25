-- ====================================================================
-- DAY 27: Introduction to Window Functions (ROW_NUMBER, RANK)
-- ====================================================================

-- 🔍 1. Assign sequential indices to products within their categories
-- Window functions perform calculations across a set of table rows.
SELECT product_id, product_name, category_id, price,
       ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY price DESC) AS category_price_sequence
FROM products;

-- 🔍 2. Rank users based on their cumulative spent totals
-- Uses OVER (ORDER BY) to generate continuous rankings.
SELECT user_id, total_amount,
       RANK() OVER (ORDER BY total_amount DESC) AS spend_rank,
       DENSE_RANK() OVER (ORDER BY total_amount DESC) AS spend_dense_rank
FROM orders;
