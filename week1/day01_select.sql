-- ====================================================================
-- DAY 1: Database Basics & Declarative SELECT Queries
-- ====================================================================

-- 🔍 1. Select all details for all customers
-- Hits customers table (plural) and returns all columns.
SELECT * FROM customers;

-- 🔍 2. Select specific contact details of customers
-- Returns only name and email details, reducing memory bandwidth.
SELECT FirstName, LastName, Email FROM customers;

-- 🔍 3. Count total number of rows in the customer database
-- Essential for checking record volumes.
SELECT COUNT(*) FROM customers;

-- 🔍 4. Select billing emails and limit results
-- Returns 10 rows from invoices. Terminated properly with a semicolon.
SELECT Email, Phone FROM customers LIMIT 10;
