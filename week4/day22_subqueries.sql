-- ====================================================================
-- DAY 22: Nested and Correlated Subqueries
-- ====================================================================

-- 🔍 1. Subquery in WHERE: Identify orders exceeding the average total amount
-- Evaluates the inner select once, returning a single value to the outer query.
SELECT order_id, user_id, total_amount 
FROM orders 
WHERE total_amount > (SELECT AVG(total_amount) FROM orders);

-- 🔍 2. Correlated Subquery: Project users along with their recent order dates
-- Inner query references outer table 'u.user_id'. Evaluated per row.
SELECT u.user_id, u.email,
       (SELECT MAX(o.order_date) FROM orders o WHERE o.user_id = u.user_id) AS last_order_date
FROM users u;

-- 🔍 3. Derived Subquery: Average aggregate sales from daily order sums
-- Evaluates average from a derived source table.
SELECT AVG(daily_revenue) AS average_daily_yield
FROM (
    SELECT order_date, SUM(total_amount) AS daily_revenue
    FROM orders
    GROUP BY order_date
) AS daily_sales_table;
