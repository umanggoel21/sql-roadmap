-- ====================================================================
-- DAY 26: Dialect-Agnostic Date Extraction & Formatting
-- ====================================================================

-- 🔍 1. Extract year/month from timestamps using standard EXTRACT
-- Supported by PostgreSQL, BigQuery, and T-SQL.
-- PostgreSQL / BigQuery: "EXTRACT(YEAR FROM order_date)"
-- T-SQL: "YEAR(order_date)"
-- SQLite: "STRFTIME('%Y', order_date)"
SELECT order_id, 
       STRFTIME('%Y', order_date) AS order_year,
       STRFTIME('%m', order_date) AS order_month
FROM orders;

-- 🔍 2. Calculate dates difference (Days between orders)
-- SQLite native date diff uses JULIANDAY.
SELECT order_id, order_date,
       (JULIANDAY('now') - JULIANDAY(order_date)) AS days_since_order
FROM orders;
