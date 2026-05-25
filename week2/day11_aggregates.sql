-- ====================================================================
-- DAY 11: Statistical Math aggregates (COUNT, SUM, AVG)
-- ====================================================================

-- 🔍 1. Count non-null phone numbers in customer database
-- COUNT(ColumnName) excludes NULLs.
SELECT COUNT(Phone) AS TotalActivePhones FROM customers;

-- 🔍 2. Total lifetime revenue collected from invoices
-- Calculates absolute sum of continuous values.
SELECT SUM(Total) AS LifetimeStoreRevenue FROM invoices;

-- 🔍 3. Average total ticket purchase amount
-- Calculates overall arithmetic mean of tickets.
SELECT AVG(Total) AS AverageTicketPurchase FROM invoices;
