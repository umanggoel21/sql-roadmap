-- ====================================================================
-- DAY 26: Date Extraction & Time Calculations (Chinook DB)
-- ====================================================================

-- 🔍 1. Extract year/month from timestamps using STRFTIME
-- In SQLite, STRFTIME parses the datetime column.
-- Dialect Note: Standard SQL uses EXTRACT(YEAR FROM InvoiceDate).
SELECT InvoiceId, 
       STRFTIME('%Y', InvoiceDate) AS InvoiceYear,
       STRFTIME('%m', InvoiceDate) AS InvoiceMonth
FROM Invoice;

-- 🔍 2. Calculate dates difference (Days since invoice date)
-- SQLite native date diff uses JULIANDAY.
SELECT InvoiceId, InvoiceDate,
       (JULIANDAY('now') - JULIANDAY(InvoiceDate)) AS DaysSinceInvoice
FROM Invoice;
