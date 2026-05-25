-- ====================================================================
-- DAY 28: Week 4 Case Analytics Projects
-- ====================================================================

-- 📊 CASE 1: Customer lifetime classifications.
-- Classify users into tiers: Platinum (spend > $1000), Gold ($500-$1000), Silver (<$500).
SELECT u.user_id, u.email,
       SUM(o.total_amount) AS cumulative_spend,
       CASE 
           WHEN SUM(o.total_amount) >= 1000.00 THEN 'Platinum'
           WHEN SUM(o.total_amount) BETWEEN 500.00 AND 1000.00 THEN 'Gold'
           ELSE 'Silver'
       END AS user_cohort_tier
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.email
ORDER BY cumulative_spend DESC;


-- 📊 CASE 2: Identify the second most expensive product in each category.
-- Uses Window Functions and CTEs.
WITH CategoryRankings AS (
    SELECT category_id, product_name, price,
           ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY price DESC) AS position_index
    FROM products
)
SELECT category_id, product_name, price
FROM CategoryRankings
WHERE position_index = 2;
