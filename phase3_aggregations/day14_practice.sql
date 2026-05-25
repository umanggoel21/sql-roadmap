-- ====================================================================
-- DAY 14: Phase 3 Aggregation Practice Scenarios (Chinook DB)
-- ====================================================================

-- 📊 CASE 1: Retrieve invoice detail segments.
-- Select all invoices costing between $5.00 and $20.00, sorted by total amount DESC, paginated to return top 5 items starting from index 3.
SELECT InvoiceId, CustomerId, Total 
FROM Invoice 
WHERE Total BETWEEN 5.00 AND 20.00
ORDER BY Total DESC 
LIMIT 5 OFFSET 3;


-- 📊 CASE 2: Generate location completeness reports.
-- Project customer email along with billing details, replacing missing company records with 'Direct Buyer'.
SELECT Email, COALESCE(Company, 'Direct Buyer') AS CustomerSegment 
FROM Customer;


-- 📊 CASE 3: Sales metric summaries.
-- Find total sales, average ticket, minimum order, and maximum order billed.
SELECT COUNT(InvoiceId) AS InvoicesProcessed,
       SUM(Total) AS TotalRevenue,
       AVG(Total) AS AverageTicket,
       MIN(Total) AS SmallestSale,
       MAX(Total) AS LargestSale
FROM Invoice;
