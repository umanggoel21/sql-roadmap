-- ====================================================================
-- DAY 20: Self-Referencing Hierarchies (SELF JOINS) (Chinook DB)
-- ====================================================================

-- 🔍 1. Map employees to their direct reporting manager
-- Joins a table to itself using aliases to represent two distinct roles.
-- Maps the ReportsTo manager ID to the EmployeeId of the supervisor.
SELECT emp.EmployeeId,
       (emp.FirstName || ' ' || emp.LastName) AS EmployeeName,
       emp.Title AS EmployeeTitle,
       (mgr.FirstName || ' ' || mgr.LastName) AS ReportsToManager
FROM Employee emp
LEFT JOIN Employee mgr ON emp.ReportsTo = mgr.EmployeeId;
