-- ====================================================================
-- 🎯 LEETCODE SQL PRACTICE CHALLENGES (CHINOOK SQL MASTER)
-- ====================================================================

-- 🚀 CHALLENGE 1: Duplicate Email Finder
-- Task: Find all emails that are duplicate in the database.
-- Target: customers table
SELECT Email, COUNT(Email) as EmailCount
FROM customers
GROUP BY Email
HAVING EmailCount > 1;


-- 🚀 CHALLENGE 2: Employees earning more than their managers (Mapped to Chinook reports schema)
-- Task: List all employees who support more customers than the average customer assignment of all employees.
-- Target: customers, employees
SELECT e.FirstName, e.LastName, COUNT(c.CustomerId) as CustomerCount
FROM employees e
INNER JOIN customers c ON e.EmployeeId = c.SupportRepId
GROUP BY e.EmployeeId
HAVING CustomerCount > (
    SELECT AVG(SupportCount)
    FROM (
        SELECT COUNT(CustomerId) as SupportCount
        FROM customers
        GROUP BY SupportRepId
    )
);


-- 🚀 CHALLENGE 3: Customers who never ordered
-- Task: Find all customers who have not placed a single order.
-- Target: customers, invoices
SELECT c.CustomerId, c.FirstName, c.LastName
FROM customers c
LEFT JOIN invoices i ON c.CustomerId = i.CustomerId
WHERE i.InvoiceId IS NULL;


-- 🚀 CHALLENGE 4: Top Selling Track of all time
-- Task: Find the track name, album title, and total revenue that sold the most.
-- Target: tracks, albums, invoice_items
SELECT t.Name AS TrackName, a.Title AS AlbumTitle, SUM(ii.UnitPrice * ii.Quantity) AS TotalRevenue
FROM tracks t
INNER JOIN albums a ON t.AlbumId = a.AlbumId
INNER JOIN invoice_items ii ON t.TrackId = ii.TrackId
GROUP BY t.TrackId
ORDER BY TotalRevenue DESC
LIMIT 1;
