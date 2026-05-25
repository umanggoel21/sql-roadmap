-- ====================================================================
-- DAY 24: Stacking Datasets Vertically (UNION, UNION ALL)
-- ====================================================================

-- 🔍 1. Stack user and employee contact information
-- UNION filters out duplicate records and sorts results.
SELECT 'Employee' AS role, first_name, last_name, email FROM employees
UNION
SELECT 'Customer' AS role, first_name, last_name, email FROM users;

-- 🔍 2. Stack high-tier and mid-tier order categories
-- UNION ALL stacks records directly without sorting or deduplication.
SELECT order_id, total_amount, 'Enterprise Spend' AS tier FROM orders WHERE total_amount >= 1000.00
UNION ALL
SELECT order_id, total_amount, 'Standard Spend' AS tier FROM orders WHERE total_amount < 1000.00;
