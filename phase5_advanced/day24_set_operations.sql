-- ====================================================================
-- DAY 24: Stacking Datasets Vertically (UNION, UNION ALL) (Chinook DB)
-- ====================================================================

-- 🔍 1. Stack customer and employee contact information
-- UNION filters out duplicate records and sorts results.
SELECT 'Employee' AS Role, FirstName, LastName, Email FROM Employee
UNION
SELECT 'Customer' AS Role, FirstName, LastName, Email FROM Customer;

-- 🔍 2. Stack high-tier and mid-tier invoice categories
-- UNION ALL stacks records directly without sorting or deduplication.
SELECT InvoiceId, Total, 'High Total Spend' AS SpendTier FROM Invoice WHERE Total >= 15.00
UNION ALL
SELECT InvoiceId, Total, 'Standard Spend' AS SpendTier FROM Invoice WHERE Total < 15.00;
