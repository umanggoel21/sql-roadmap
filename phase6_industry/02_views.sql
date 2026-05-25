-- =============================================================
--  Phase 6 — Industry Skills
--  File  : 02_views.sql
--  Topic : CREATE VIEW vs CTE — what they are and when to use each
-- =============================================================

-- ---------------------------------------------------------------
-- WHAT IS A VIEW?
-- A view is a saved SELECT query stored in the database.
-- It behaves like a virtual table — you can SELECT from it,
-- JOIN it, and in some cases INSERT/UPDATE through it.
-- ---------------------------------------------------------------

-- ---------------------------------------------------------------
-- 1. Creating Views
-- ---------------------------------------------------------------

-- Simple view: delivered orders with user info
CREATE OR REPLACE VIEW v_delivered_orders AS
SELECT
    o.order_id,
    u.full_name,
    u.email,
    u.country,
    o.order_date,
    o.total_amount
FROM orders o
JOIN users u ON o.user_id = u.user_id
WHERE o.status = 'delivered';

-- Now query it like a regular table:
SELECT * FROM v_delivered_orders
WHERE country = 'India'
ORDER BY total_amount DESC;

-- ---------------------------------------------------------------
-- 2. A more useful view: product sales summary
-- ---------------------------------------------------------------
CREATE OR REPLACE VIEW v_product_sales AS
SELECT
    p.product_id,
    p.name            AS product_name,
    c.name            AS category,
    SUM(oi.quantity)  AS total_units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    COUNT(DISTINCT oi.order_id)      AS num_orders
FROM products p
JOIN categories c    ON p.category_id = c.category_id
JOIN order_items oi  ON p.product_id  = oi.product_id
GROUP BY p.product_id, p.name, c.name;

-- Usage:
SELECT * FROM v_product_sales
ORDER BY total_revenue DESC
LIMIT 10;

-- JOIN a view with another table:
SELECT vs.product_name, vs.total_revenue, p.stock_qty
FROM v_product_sales vs
JOIN products p ON vs.product_id = p.product_id
WHERE vs.total_units_sold > 5;

-- ---------------------------------------------------------------
-- 3. DROP a view
-- ---------------------------------------------------------------
-- DROP VIEW IF EXISTS v_delivered_orders;

-- ---------------------------------------------------------------
-- 4. VIEW vs CTE — The Key Difference
-- ---------------------------------------------------------------

-- CTE: exists only for the duration of a single query
WITH recent_orders AS (
    SELECT * FROM orders
    WHERE order_date >= '2024-01-01'
)
SELECT u.full_name, COUNT(*) AS orders_in_2024
FROM recent_orders r
JOIN users u ON r.user_id = u.user_id
GROUP BY u.full_name
ORDER BY orders_in_2024 DESC;

-- View: persists in the database, reusable across sessions and users

-- ---------------------------------------------------------------
-- DECISION GUIDE:
--
-- Use a VIEW when:
--   ✅ You need to reuse the same query logic across many queries
--   ✅ You want to hide complexity from other team members
--   ✅ You need access control (grant SELECT on view, not raw table)
--   ✅ The query is used by BI tools / dashboards
--
-- Use a CTE when:
--   ✅ The logic is only needed once, in one query
--   ✅ You're breaking a complex query into readable steps
--   ✅ You need recursion (recursive CTEs)
--   ✅ You don't want to pollute the database with permanent objects
-- ---------------------------------------------------------------

-- ---------------------------------------------------------------
-- 5. Materialized Views (PostgreSQL only)
-- ---------------------------------------------------------------
-- A materialized view stores the query RESULT on disk.
-- Much faster to read, but needs manual refresh when data changes.

CREATE MATERIALIZED VIEW mv_product_sales AS
SELECT
    p.name AS product_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name;

-- Refresh when underlying data changes:
REFRESH MATERIALIZED VIEW mv_product_sales;

-- Query is now instant (reads from disk cache):
SELECT * FROM mv_product_sales ORDER BY total_revenue DESC;

-- Drop materialized view:
DROP MATERIALIZED VIEW IF EXISTS mv_product_sales;

-- Drop regular views (cleanup):
DROP VIEW IF EXISTS v_delivered_orders;
DROP VIEW IF EXISTS v_product_sales;
