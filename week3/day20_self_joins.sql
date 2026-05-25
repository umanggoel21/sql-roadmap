-- ====================================================================
-- DAY 20: Self-Referencing Hierarchies (SELF JOINS)
-- ====================================================================

-- 🔍 1. Map employees to their direct reporting manager
-- Joins a table to itself using aliases to represent two distinct roles.
SELECT emp.employee_id,
       (emp.first_name || ' ' || emp.last_name) AS employee_name,
       emp.title AS employee_title,
       (mgr.first_name || ' ' || mgr.last_name) AS reports_to_manager
FROM employees emp
LEFT JOIN employees mgr ON emp.reports_to = mgr.employee_id;
