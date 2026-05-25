-- ====================================================================
-- DAY 14: Week 2 E-Commerce Practice Scenarios
-- ====================================================================

-- 📊 CASE 1: Retrieve high-value customer details.
-- Select all orders costing between $200 and $1000, sorted by total amount DESC, paginated to return top 5 items starting from index 3.
SELECT order_id, user_id, total_amount 
FROM orders 
WHERE total_amount BETWEEN 200.00 AND 1000.00
ORDER BY total_amount DESC 
LIMIT 5 OFFSET 3;


-- 📊 CASE 2: Generate location completeness reports.
-- Project user email along with country, replacing missing country records with 'Unknown location'.
SELECT email, COALESCE(country, 'Unknown Location') AS user_country 
FROM users;


-- 📊 CASE 3: Sales metric summaries.
-- Find total sales, average ticket, minimum order, and maximum order billed from 'Completed' statuses.
SELECT COUNT(order_id) AS orders_processed,
       SUM(total_amount) AS total_revenue,
       AVG(total_amount) AS average_ticket,
       MIN(total_amount) AS smallest_sale,
       MAX(total_amount) AS largest_sale
FROM orders
WHERE status = 'Completed';
