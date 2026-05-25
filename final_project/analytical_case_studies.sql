-- ====================================================================
-- 🎓 FINAL SHOWCASE ANALYTICAL REPORT (Chinook DB)
-- ====================================================================

-- 📊 CASE STUDY 1: Lifetime Cohort Revenue Yield
-- Task: Group customers by their country, calculating customer volume, 
-- active invoices volume, total cumulative spend, and average customer lifetime value (CLV).
SELECT c.Country,
       COUNT(DISTINCT c.CustomerId) AS CustomerVolume,
       COUNT(i.InvoiceId) AS ActiveInvoices,
       SUM(i.Total) AS CumulativeRevenue,
       (SUM(i.Total) / COUNT(DISTINCT c.CustomerId)) AS CustomerLifetimeValue
FROM Customer c
INNER JOIN Invoice i ON c.CustomerId = i.CustomerId
GROUP BY c.Country
ORDER BY CumulativeRevenue DESC;


-- 📊 CASE STUDY 2: Monthly Revenue Growth Velocity
-- Task: Extract month-by-month transaction volumes, total revenue, average invoice size, 
-- and utilize window functions to display previous month's revenue and calculated growth pacing.
WITH MonthlySales AS (
    SELECT STRFTIME('%Y-%m', InvoiceDate) AS SalesPeriod,
           COUNT(InvoiceId) AS InvoiceVolume,
           SUM(Total) AS AbsoluteRevenue,
           AVG(Total) AS AverageTicket
    FROM Invoice
    GROUP BY SalesPeriod
)
SELECT SalesPeriod,
       InvoiceVolume,
       AbsoluteRevenue,
       AverageTicket,
       LAG(AbsoluteRevenue, 1) OVER (ORDER BY SalesPeriod ASC) AS PreviousPeriodRevenue,
       (AbsoluteRevenue - LAG(AbsoluteRevenue, 1) OVER (ORDER BY SalesPeriod ASC)) AS NetGrowth
FROM MonthlySales
ORDER BY SalesPeriod ASC;


-- 📊 CASE STUDY 3: Track Category Margin & Purchase Audit
-- Task: Audit track performance by calculating total items sold, total revenue, 
-- and utilizing conditional logic to flag low-performing vs high-performing items.
SELECT t.TrackId, t.Name AS TrackName, t.UnitPrice,
       SUM(il.Quantity) AS UnitsSold,
       SUM(il.Quantity * il.UnitPrice) AS TrackRevenue,
       CASE 
           WHEN SUM(il.Quantity) >= 10 THEN 'Flagship Seller'
           WHEN SUM(il.Quantity) BETWEEN 3 AND 9 THEN 'Steady Contributor'
           ELSE 'Slow Moving Asset'
       END AS PerformanceTier
FROM Track t
LEFT JOIN InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY t.TrackId, t.Name, t.UnitPrice
ORDER BY TrackRevenue DESC;
