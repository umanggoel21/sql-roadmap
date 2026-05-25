-- ====================================================================
-- 🎓 DAY 29 & 30: FINAL SHOWCASE ANALYTICAL REPORT
-- ====================================================================

-- 📊 CASE STUDY 1: Lifetime Cohort Revenue Yield
-- Task: Group users by their signup country, calculating registration volume, 
-- active order volume, total lifetime spend, and average customer lifetime value (CLV).
SELECT u.country,
       COUNT(DISTINCT u.user_id) AS registration_volume,
       COUNT(o.order_id) AS active_orders,
       SUM(o.total_amount) AS cumulative_revenue,
       (SUM(o.total_amount) / COUNT(DISTINCT u.user_id)) AS customer_lifetime_value
FROM users u
INNER JOIN orders o ON u.user_id = o.user_id
GROUP BY u.country
ORDER BY cumulative_revenue DESC;


-- 📊 CASE STUDY 2: Monthly E-Commerce Revenue Growth Velocity
-- Task: Extract month-by-month transaction volumes, total revenue, average order size, 
-- and utilize window functions to display previous month's revenue and calculated growth pacing.
WITH MonthlySales AS (
    SELECT STRFTIME('%Y-%m', order_date) AS sales_period,
           COUNT(order_id) AS order_volume,
           SUM(total_amount) AS absolute_revenue,
           AVG(total_amount) AS average_ticket
    FROM orders
    GROUP BY sales_period
)
SELECT sales_period,
       order_volume,
       absolute_revenue,
       average_ticket,
       LAG(absolute_revenue, 1) OVER (ORDER BY sales_period ASC) AS previous_period_revenue,
       (absolute_revenue - LAG(absolute_revenue, 1) OVER (ORDER BY sales_period ASC)) AS net_growth
FROM MonthlySales
ORDER BY sales_period ASC;


-- 📊 CASE STUDY 3: Product Category Margin & Inventory Audit
-- Task: Audit product performance by calculating total items sold, total revenue, 
-- and utilizing conditional logic to flag low-performing vs high-performing items.
SELECT p.product_id, p.product_name, p.price,
       SUM(oi.quantity) AS units_sold,
       SUM(oi.quantity * oi.unit_price) AS category_revenue,
       CASE 
           WHEN SUM(oi.quantity) >= 100 THEN 'Flagship Seller'
           WHEN SUM(oi.quantity) BETWEEN 20 AND 99 THEN 'Steady Contributor'
           ELSE 'Slow Moving Asset'
       END AS performance_tier
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.price
ORDER BY category_revenue DESC;
