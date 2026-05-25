-- ====================================================================
-- DAY 20: Self-Referencing Table Relationships (SELF JOINS)
-- ====================================================================

-- 🔍 1. Map employees to their direct managers
-- Self join connects employees table to itself.
SELECT emp.EmployeeId,
       (emp.FirstName || ' ' || emp.LastName) AS EmployeeName,
       emp.Title AS EmployeeTitle,
       (mgr.FirstName || ' ' || mgr.LastName) AS ReportsToManager
FROM employees emp
LEFT JOIN employees mgr ON emp.ReportsTo = mgr.EmployeeId;
