-- ====================================================================
-- DAY 25: Stacking Datasets vertically with UNION and UNION ALL
-- ====================================================================

-- 🔍 1. Stack employee and customer contact lists
-- Combines matching columns. Removes duplicates.
SELECT 'Employee' AS Source, FirstName, LastName, Email FROM employees
UNION
SELECT 'Customer' AS Source, FirstName, LastName, Email FROM customers;

-- 🔍 2. Stack invoices with total spent cohorts
-- Demonstrates UNION ALL logic retaining all records.
SELECT InvoiceId, Total, 'High Value' AS Class FROM invoices WHERE Total >= 10.00
UNION ALL
SELECT InvoiceId, Total, 'Standard Value' AS Class FROM invoices WHERE Total < 10.00;
