-- =============================================================
--  Phase 6 — Industry Skills
--  File  : 01_indexes_and_explain.sql
--  Topic : Indexes — what, why, when + reading EXPLAIN plans
-- =============================================================

-- ---------------------------------------------------------------
-- WHAT IS AN INDEX?
-- An index is a data structure (usually a B-tree) that speeds up
-- lookups on a column at the cost of extra storage and slower writes.
-- Think of it like a book's index vs reading every page.
-- ---------------------------------------------------------------

-- ---------------------------------------------------------------
-- 1. Creating Indexes
-- ---------------------------------------------------------------

-- Single-column index (most common)
CREATE INDEX idx_orders_user_id    ON orders(user_id);
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_products_category ON products(category_id);

-- Composite index — useful when you filter/sort on two columns together
-- Order matters! Put the most selective column first.
CREATE INDEX idx_orders_user_date  ON orders(user_id, order_date);

-- Partial index — only indexes rows matching a condition
-- Great for queries that almost always filter by status = 'delivered'
CREATE INDEX idx_orders_delivered  ON orders(order_date)
    WHERE status = 'delivered';

-- Unique index (also enforces uniqueness)
CREATE UNIQUE INDEX idx_users_email ON users(email);

-- ---------------------------------------------------------------
-- 2. Dropping Indexes
-- ---------------------------------------------------------------
-- DROP INDEX idx_orders_user_id;  -- uncomment to test

-- ---------------------------------------------------------------
-- 3. When to Add an Index
-- ---------------------------------------------------------------
-- ✅ Add an index when the column appears in:
--    - WHERE clauses frequently
--    - JOIN ON conditions
--    - ORDER BY / GROUP BY on large tables
--    - High-cardinality columns (many distinct values)
--
-- ❌ Don't add indexes on:
--    - Small tables (full scan is faster)
--    - Columns rarely used in filters
--    - Tables with heavy INSERT/UPDATE load (indexes slow writes)
--    - Low-cardinality columns like boolean flags (barely helps)

-- ---------------------------------------------------------------
-- 4. Reading EXPLAIN / EXPLAIN ANALYZE  (PostgreSQL)
-- ---------------------------------------------------------------

-- Basic EXPLAIN — shows the query plan without executing
EXPLAIN
SELECT *
FROM orders
WHERE user_id = 10;

-- EXPLAIN ANALYZE — actually runs the query + shows real timing
EXPLAIN ANALYZE
SELECT o.order_id, u.full_name, o.total_amount
FROM orders o
JOIN users u ON o.user_id = u.user_id
WHERE o.status = 'delivered'
ORDER BY o.total_amount DESC;

-- ---------------------------------------------------------------
-- HOW TO READ THE OUTPUT:
--
-- Seq Scan        → Full table scan (no index used) — watch for this on large tables
-- Index Scan      → Using an index — good
-- Index Only Scan → Even better — answer found entirely in the index
-- Hash Join       → Common for large JOIN operations
-- Nested Loop     → Common for small result sets
-- Sort            → Explicit sort step (can be removed with an index)
--
-- Key numbers to look at:
-- "rows=X"         → estimated rows
-- "actual rows=X"  → real rows (from ANALYZE)
-- "cost=X..Y"      → startup cost .. total cost (arbitrary units)
-- "actual time=X"  → milliseconds
-- ---------------------------------------------------------------

-- Before/After comparison — add index and see the plan change:
DROP INDEX IF EXISTS idx_orders_status;

EXPLAIN ANALYZE
SELECT * FROM orders WHERE status = 'delivered';
-- Likely: Seq Scan (no index)

CREATE INDEX idx_orders_status ON orders(status);

EXPLAIN ANALYZE
SELECT * FROM orders WHERE status = 'delivered';
-- May now show: Bitmap Index Scan or Index Scan

-- ---------------------------------------------------------------
-- 5. MySQL equivalent (for reference)
-- ---------------------------------------------------------------
-- EXPLAIN SELECT * FROM orders WHERE user_id = 10;
-- Look at "type" column:
--   ALL    → full scan (bad on large tables)
--   ref    → index used
--   eq_ref → unique index match (best)
--   const  → single row match (best)
