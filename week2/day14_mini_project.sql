-- ====================================================================
-- DAY 14: Week 2 E-Commerce Analytical Business Projects
-- ====================================================================

-- 📊 Question 1: Customer Contact Completeness report
-- Generate customer names, replacing missing Fax numbers with 'No Fax Provided'.
SELECT CustomerId, 
       (FirstName || ' ' || LastName) AS CustomerName,
       IFNULL(Fax, 'No Fax Provided') AS FaxDetails
FROM customers
ORDER BY CustomerName ASC;

-- 📊 Question 2: Calculate financial statistics on total sales billed to USA.
SELECT COUNT(InvoiceId) AS USATransactionCount,
       SUM(Total) AS USALifetimeRevenue,
       AVG(Total) AS USAAverageSpend,
       MIN(Total) AS USAMinimumTicket,
       MAX(Total) AS USAMaximumTicket
FROM invoices
WHERE BillingCountry = 'USA';

-- 📊 Question 3: Find pagination rankings for tracks.
-- Get the 10 longest tracks, ignoring the top 3 longest tracks.
SELECT Name, Milliseconds 
FROM tracks 
ORDER BY Milliseconds DESC 
LIMIT 10 OFFSET 3;
