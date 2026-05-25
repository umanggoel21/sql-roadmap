# 📝 SQLite Quick Reference Cheat Sheet

A comprehensive syntactical cheat sheet mapping core SQL keywords to SQLite/Chinook implementations.

## 🔑 Core Syntax Cheat Sheet

```sql
-- 1. Selection & Aliasing
SELECT ColumnName AS FriendlyName FROM TableName;

-- 2. Unique Values & Counting
SELECT DISTINCT Country, COUNT(CustomerId) FROM customers GROUP BY Country;

-- 3. String Filtering
SELECT * FROM customers WHERE Email LIKE '%@gmail.com';

-- 4. Multi-Condition compound checks
SELECT * FROM invoices 
WHERE BillingCountry IN ('USA', 'Canada', 'United Kingdom')
  AND Total BETWEEN 5.00 AND 15.00;

-- 5. Paginated Rank sorting
SELECT Name, Milliseconds FROM tracks 
ORDER BY Milliseconds DESC 
LIMIT 10 OFFSET 5;

-- 6. Clean Multi-Table Joins
SELECT t.Name, a.Title, g.Name AS Genre
FROM tracks t
INNER JOIN albums a ON t.AlbumId = a.AlbumId
INNER JOIN genres g ON t.GenreId = g.GenreId;

-- 7. Conditional Bucketing (CASE)
SELECT Name,
       CASE 
           WHEN Milliseconds < 180000 THEN 'Short (<3min)'
           WHEN Milliseconds BETWEEN 180000 AND 300000 THEN 'Medium (3-5min)'
           ELSE 'Long (>5min)'
       END AS DurationCategory
FROM tracks;

-- 8. Date Parsing (SQLite)
SELECT InvoiceId, STRFTIME('%Y-%m', InvoiceDate) AS YearMonth
FROM invoices;
```

---

## 📊 Chinook Database Core Tables Reference
- **customers**: Stores customer demographics (`CustomerId`, `FirstName`, `LastName`, `Country`, `SupportRepId`).
- **invoices**: Order header details (`InvoiceId`, `CustomerId`, `InvoiceDate`, `Total`, `BillingCountry`).
- **invoice_items**: Order line-items (`InvoiceLineId`, `InvoiceId`, `TrackId`, `UnitPrice`, `Quantity`).
- **tracks**: Songs metadata (`TrackId`, `Name`, `AlbumId`, `MediaTypeId`, `GenreId`, `Composer`, `Milliseconds`, `Bytes`, `UnitPrice`).
- **albums**: Grouping of tracks (`AlbumId`, `Title`, `ArtistId`).
- **artists**: Musician list (`ArtistId`, `Name`).
- **employees**: Internal store representatives (`EmployeeId`, `LastName`, `FirstName`, `ReportsTo`).
