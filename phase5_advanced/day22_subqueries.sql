-- ====================================================================
-- DAY 22: Nested and Correlated Subqueries (Chinook DB)
-- ====================================================================

-- 🔍 1. Subquery in WHERE: Identify invoices exceeding the average total amount
-- Evaluates the inner select once, returning a single value to the outer query.
SELECT InvoiceId, CustomerId, Total 
FROM Invoice 
WHERE Total > (SELECT AVG(Total) FROM Invoice);

-- 🔍 2. Correlated Subquery: Project customers along with their recent invoice dates
-- Inner query references outer table 'c.CustomerId'. Evaluated per row.
SELECT c.CustomerId, c.Email,
       (SELECT MAX(i.InvoiceDate) FROM Invoice i WHERE i.CustomerId = c.CustomerId) AS LastInvoiceDate
FROM Customer c;

-- 🔍 3. Derived Subquery: Average aggregate sales from daily invoice sums
-- Evaluates average from a derived source table.
SELECT AVG(DailyRevenue) AS AverageDailyYield
FROM (
    SELECT InvoiceDate, SUM(Total) AS DailyRevenue
    FROM Invoice
    GROUP BY InvoiceDate
) AS DailySalesTable;
