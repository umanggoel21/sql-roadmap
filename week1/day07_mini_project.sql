-- ====================================================================
-- DAY 7: Week 1 Revision Quiz & Business Practice
-- ====================================================================

-- 🎓 SECTION A: Theoretical Verification (Answers commented)
-- Q1: What happens if you run "WHERE State = NULL"?
-- A1: It returns 0 rows. NULL comparisons must use the "IS" operator.
-- Q2: Explain the execution difference between AND and OR.
-- A2: AND executes first by default (higher precedence). Group multiple OR clauses in parenthesised blocks.

-- 💻 SECTION B: Practical E-Commerce Business Questions

-- 📊 Question 1: Extract all invoices billed to 'Germany', 'France', or 'Brazil' exceeding $8.00.
SELECT InvoiceId, BillingCountry, Total 
FROM invoices 
WHERE BillingCountry IN ('Germany', 'France', 'Brazil') AND Total > 8.00;

-- 📊 Question 2: Find all customers who do not list a company and live in Canada.
SELECT CustomerId, FirstName, LastName, Company, Country
FROM customers
WHERE Company IS NULL AND Country = 'Canada';

-- 📊 Question 3: Extract tracks containing the word 'Blues' anywhere in the title.
SELECT TrackId, Name, Composer 
FROM tracks 
WHERE Name LIKE '%Blues%';

-- 📊 Question 4: Find all invoices where the total is strictly between $1.98 and $5.94.
SELECT InvoiceId, CustomerId, Total 
FROM invoices 
WHERE Total BETWEEN 1.98 AND 5.94;
