-- ====================================================================
-- 🎯 LEETCODE SQL PRACTICE CHALLENGES (UNIVERSAL E-COMMERCE SCHEMA)
-- ====================================================================

-- 🚀 CHALLENGE 1: Duplicate Email Finder (LeetCode 182 Easy)
-- Task: Identify users who have registered with duplicate emails.
-- Dialect: ANSI SQL (Runs on all engines)
SELECT email, COUNT(email) AS occurrence_count
FROM users
GROUP BY email
HAVING COUNT(email) > 1;


-- 🚀 CHALLENGE 2: Customers Who Never Order (LeetCode 183 Easy)
-- Task: Find all users who have not placed a single order.
-- Dialect: ANSI SQL (LEFT JOIN approach)
SELECT u.user_id, u.first_name, u.last_name, u.email
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
WHERE o.order_id IS NULL;


-- 🚀 CHALLENGE 3: Employees Earning More Than Their Managers (LeetCode 181 Easy)
-- Task: Find all employees who report to a manager but hold a title mapping 
-- to higher hierarchical depth (adapted as self-join).
-- Dialect: ANSI SQL
SELECT e.employee_id, e.first_name AS employee_name, e.title AS employee_title,
       m.first_name AS manager_name, m.title AS manager_title
FROM employees e
INNER JOIN employees m ON e.reports_to = m.employee_id
WHERE e.employee_id <> m.employee_id;


-- 🚀 CHALLENGE 4: Top Billed User per Country (LeetCode 185 Hard adapted)
-- Task: Find the customer in each country who has spent the highest cumulative total amount.
-- Dialect: Standard SQL (Using Window Functions - PostgreSQL, BigQuery, T-SQL, MySQL 8+)
WITH UserSpending AS (
    SELECT u.country, u.user_id, u.first_name, u.last_name,
           SUM(o.total_amount) AS total_spent,
           RANK() OVER (PARTITION BY u.country ORDER BY SUM(o.total_amount) DESC) as ranking
    FROM users u
    INNER JOIN orders o ON u.user_id = o.user_id
    GROUP BY u.country, u.user_id, u.first_name, u.last_name
)
SELECT country, user_id, first_name, last_name, total_spent
FROM UserSpending
WHERE ranking = 1;
