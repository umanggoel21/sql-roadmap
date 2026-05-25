-- ====================================================================
-- DAY 28: Week 4 Case Classification & Date Capstone Projects
-- ====================================================================

-- 📊 Question 1: Customer Value Cohorts classification.
-- Classify customers by lifetime spending: VIP (>$45), Good ($30-$45), Regular (<$30).
SELECT c.CustomerId,
       (c.FirstName || ' ' || c.LastName) AS CustomerName,
       SUM(i.Total) AS LifetimeSpend,
       CASE 
           WHEN SUM(i.Total) >= 45.00 THEN 'VIP'
           WHEN SUM(i.Total) BETWEEN 30.00 AND 45.00 THEN 'Good'
           ELSE 'Regular'
       END AS CustomerTier
FROM customers c
INNER JOIN invoices i ON c.CustomerId = i.CustomerId
GROUP BY c.CustomerId
ORDER BY LifetimeSpend DESC;

-- 📊 Question 2: Average Days between customer invoices.
-- Calculates difference using SQLite JulianDay date conversions.
SELECT i1.CustomerId,
       MIN(JULIANDAY(i2.InvoiceDate) - JULIANDAY(i1.InvoiceDate)) AS ShortestDaysBetweenOrders
FROM invoices i1
INNER JOIN invoices i2 ON i1.CustomerId = i2.CustomerId AND i1.InvoiceId <> i2.InvoiceId
WHERE JULIANDAY(i2.InvoiceDate) > JULIANDAY(i1.InvoiceDate)
GROUP BY i1.CustomerId;
