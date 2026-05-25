-- =============================================================
--  Phase 6 — Industry Skills
--  File  : 06_interview_patterns.sql
--  Topic : Real DA interview query patterns — cohort, retention,
--          funnel, MoM growth, rolling averages
-- =============================================================

-- ---------------------------------------------------------------
-- These are the 6 query patterns that appear in EVERY
-- Data Analyst interview at product companies.
-- Master these and you're ready for Flipkart, Swiggy,
-- Meesho, PhonePe, etc.
-- ---------------------------------------------------------------

-- ═══════════════════════════════════════════════════════════════
-- PATTERN 1: COHORT ANALYSIS
-- "Group users by their signup month and track their behaviour"
-- ═══════════════════════════════════════════════════════════════

-- Step 1: Tag each user with their cohort (signup month)
WITH user_cohorts AS (
    SELECT
        user_id,
        DATE_TRUNC('month', signup_date) AS cohort_month
    FROM users
),

-- Step 2: Find the first order month for each user
first_orders AS (
    SELECT
        user_id,
        DATE_TRUNC('month', MIN(order_date)) AS first_order_month
    FROM orders
    GROUP BY user_id
)

-- Step 3: Join and see which cohort converted to buyers
SELECT
    uc.cohort_month,
    COUNT(uc.user_id)                              AS total_signups,
    COUNT(fo.user_id)                              AS converted_to_buyer,
    ROUND(100.0 * COUNT(fo.user_id)
               / NULLIF(COUNT(uc.user_id), 0), 1) AS conversion_rate_pct
FROM user_cohorts uc
LEFT JOIN first_orders fo
    ON uc.user_id = fo.user_id
   AND fo.first_order_month = uc.cohort_month  -- converted in the same month they signed up
GROUP BY uc.cohort_month
ORDER BY uc.cohort_month;

-- ═══════════════════════════════════════════════════════════════
-- PATTERN 2: RETENTION QUERY
-- "What % of users who ordered in month N also ordered in month N+1?"
-- ═══════════════════════════════════════════════════════════════

WITH monthly_buyers AS (
    SELECT DISTINCT
        user_id,
        DATE_TRUNC('month', order_date) AS order_month
    FROM orders
    WHERE status != 'cancelled'
)

SELECT
    m1.order_month                              AS month,
    COUNT(DISTINCT m1.user_id)                  AS buyers_this_month,
    COUNT(DISTINCT m2.user_id)                  AS retained_next_month,
    ROUND(100.0 * COUNT(DISTINCT m2.user_id)
               / NULLIF(COUNT(DISTINCT m1.user_id), 0), 1) AS retention_rate_pct
FROM monthly_buyers m1
LEFT JOIN monthly_buyers m2
    ON m1.user_id = m2.user_id
   AND m2.order_month = m1.order_month + INTERVAL '1 month'
GROUP BY m1.order_month
ORDER BY month;

-- ═══════════════════════════════════════════════════════════════
-- PATTERN 3: FUNNEL ANALYSIS
-- "How many users move through each stage of the purchase funnel?"
-- ═══════════════════════════════════════════════════════════════

-- Our funnel: Signed up → Placed any order → Completed (delivered)
SELECT
    'Signed Up'   AS stage,
    COUNT(*)      AS users,
    100.0         AS pct_of_top
FROM users

UNION ALL

SELECT
    'Placed Order',
    COUNT(DISTINCT user_id),
    ROUND(100.0 * COUNT(DISTINCT user_id) / (SELECT COUNT(*) FROM users), 1)
FROM orders

UNION ALL

SELECT
    'Completed Order (Delivered)',
    COUNT(DISTINCT user_id),
    ROUND(100.0 * COUNT(DISTINCT user_id) / (SELECT COUNT(*) FROM users), 1)
FROM orders
WHERE status = 'delivered';

-- ═══════════════════════════════════════════════════════════════
-- PATTERN 4: MONTH-OVER-MONTH (MoM) GROWTH
-- "How did revenue grow each month compared to the previous month?"
-- ═══════════════════════════════════════════════════════════════

WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(total_amount)               AS revenue
    FROM orders
    WHERE status != 'cancelled'
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month)    AS prev_month_revenue,
    ROUND(
        100.0 * (revenue - LAG(revenue) OVER (ORDER BY month))
              / NULLIF(LAG(revenue) OVER (ORDER BY month), 0),
        1
    )                                      AS mom_growth_pct
FROM monthly_revenue
ORDER BY month;

-- ═══════════════════════════════════════════════════════════════
-- PATTERN 5: ROLLING 7-DAY AVERAGE
-- "What's the 7-day rolling average of daily order revenue?"
-- ═══════════════════════════════════════════════════════════════

WITH daily_revenue AS (
    SELECT
        order_date,
        SUM(total_amount) AS daily_revenue
    FROM orders
    WHERE status != 'cancelled'
    GROUP BY order_date
)

SELECT
    order_date,
    daily_revenue,
    ROUND(
        AVG(daily_revenue) OVER (
            ORDER BY order_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS rolling_7day_avg
FROM daily_revenue
ORDER BY order_date;

-- ═══════════════════════════════════════════════════════════════
-- PATTERN 6: THE HARD INTERVIEW QUESTION
-- "Which product category drives the most repeat purchases
--  from users who signed up in Q1 2023?"
-- ═══════════════════════════════════════════════════════════════

WITH q1_users AS (
    -- Users who signed up in Q1 2023
    SELECT user_id
    FROM users
    WHERE signup_date BETWEEN '2023-01-01' AND '2023-03-31'
),

q1_orders AS (
    -- Their orders
    SELECT o.order_id, o.user_id
    FROM orders o
    JOIN q1_users u ON o.user_id = u.user_id
    WHERE o.status != 'cancelled'
),

repeat_buyers AS (
    -- Q1 users who ordered MORE than once (repeat buyers)
    SELECT user_id
    FROM q1_orders
    GROUP BY user_id
    HAVING COUNT(order_id) > 1
),

category_sales AS (
    -- What categories did repeat buyers buy?
    SELECT
        c.name          AS category,
        COUNT(oi.item_id) AS total_items_purchased
    FROM order_items oi
    JOIN q1_orders qo   ON oi.order_id   = qo.order_id
    JOIN repeat_buyers rb ON qo.user_id  = rb.user_id
    JOIN products p     ON oi.product_id = p.product_id
    JOIN categories c   ON p.category_id = c.category_id
    GROUP BY c.name
)

SELECT
    category,
    total_items_purchased,
    RANK() OVER (ORDER BY total_items_purchased DESC) AS category_rank
FROM category_sales
ORDER BY category_rank;

-- ---------------------------------------------------------------
-- BONUS: Top N per category (a classic interview question)
-- "Show the top 2 best-selling products per category"
-- ---------------------------------------------------------------
SELECT *
FROM (
    SELECT
        c.name                                   AS category,
        p.name                                   AS product,
        SUM(oi.quantity)                         AS units_sold,
        RANK() OVER (
            PARTITION BY c.name
            ORDER BY SUM(oi.quantity) DESC
        )                                        AS rnk
    FROM order_items oi
    JOIN products  p ON oi.product_id = p.product_id
    JOIN categories c ON p.category_id = c.category_id
    GROUP BY c.name, p.name
) ranked
WHERE rnk <= 2
ORDER BY category, rnk;
