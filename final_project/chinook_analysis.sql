-- ====================================================================
-- 🎓 DAY 29 & 30: FINAL SHOWCASE ANALYTICAL REPORT
-- ====================================================================

-- 📊 CASE STUDY 1: Sales Representative Performance Audit
-- Task: Evaluate support representative metrics, calculating total customers assigned, total invoices, and lifetime revenue supported.
SELECT e.EmployeeId,
       (e.FirstName || ' ' || e.LastName) AS SupportRepName,
       e.Title AS Title,
       COUNT(DISTINCT c.CustomerId) AS CustomersAssigned,
       COUNT(i.InvoiceId) AS TotalOrdersSupported,
       SUM(i.Total) AS TotalRevenueGenerated
FROM employees e
INNER JOIN customers c ON e.EmployeeId = c.SupportRepId
INNER JOIN invoices i ON c.CustomerId = i.CustomerId
GROUP BY e.EmployeeId
ORDER BY TotalRevenueGenerated DESC;


-- 📊 CASE STUDY 2: E-Commerce Catalog Genre Yield Report
-- Task: Audit which music genre drives the most profit vs total tracks available in store.
SELECT g.Name AS GenreName,
       COUNT(DISTINCT t.TrackId) AS TotalCatalogTracks,
       SUM(ii.Quantity) AS TotalTracksSold,
       SUM(ii.UnitPrice * ii.Quantity) AS AbsoluteRevenue,
       (SUM(ii.UnitPrice * ii.Quantity) / COUNT(DISTINCT t.TrackId)) AS YieldPerTrack
FROM genres g
INNER JOIN tracks t ON g.GenreId = t.GenreId
LEFT JOIN invoice_items ii ON t.TrackId = ii.TrackId
GROUP BY g.GenreId
ORDER BY AbsoluteRevenue DESC;


-- 📊 CASE STUDY 3: Monthly Revenue Velocity Analysis
-- Task: Extract month-by-month transaction counts and absolute sales values to track retail seasonalities.
SELECT STRFTIME('%Y-%m', InvoiceDate) AS SalesPeriod,
       COUNT(InvoiceId) AS TotalTransactionVolume,
       SUM(Total) AS PeriodRevenue,
       AVG(Total) AS AverageTicketSize
FROM invoices
GROUP BY SalesPeriod
ORDER BY SalesPeriod ASC;
