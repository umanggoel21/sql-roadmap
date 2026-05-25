-- ====================================================================
-- DAY 13: Descriptive Naming Conventions with Column Aliasing
-- ====================================================================

-- 🔍 1. Format full customer name into a single column
-- Uses SQLite concatenation operator "||".
SELECT CustomerId, 
       (FirstName || ' ' || LastName) AS FullName, 
       Email AS ContactEmail 
FROM customers;

-- 🔍 2. Format database calculations for dashboard displays
-- Applies arithmetic inside the statement and aliases the output.
SELECT SUM(Total) AS TotalSales, 
       COUNT(InvoiceId) AS OrderCount, 
       (SUM(Total) / COUNT(InvoiceId)) AS CalculatedAverageTicket 
FROM invoices;
