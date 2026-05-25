-- =============================================================
--  Phase 6 — Industry Skills
--  File  : 04_schema_design.sql
--  Topic : Normalization (1NF/2NF/3NF) + Star Schema
-- =============================================================

-- ---------------------------------------------------------------
-- WHY NORMALIZATION?
-- Raw data often arrives denormalized (flat, redundant).
-- Normalization organizes it to:
--   1. Eliminate data redundancy
--   2. Prevent update/insert/delete anomalies
--   3. Make the schema easier to maintain
-- ---------------------------------------------------------------

-- ---------------------------------------------------------------
-- EXAMPLE: A badly designed flat table (unnormalized)
-- ---------------------------------------------------------------
/*
order_id | customer_name | customer_email  | product_name | category  | qty | price
---------|---------------|-----------------|--------------|-----------|-----|------
1        | Aarav Kumar   | aarav@email.com | Laptop       | Electr.   |  1  | 999
2        | Aarav Kumar   | aarav@email.com | Earbuds      | Electr.   |  2  |  79
3        | Sofia         | sofia@email.com | Laptop       | Electr.   |  1  | 999

Problems:
- Aarav's email stored 2x (redundancy)
- Change Aarav's email → must update every row he ordered in
- "Electronics" repeated in every electronics product row
- Product price repeated every time it's ordered
*/

-- ---------------------------------------------------------------
-- 1NF — First Normal Form
-- ---------------------------------------------------------------
-- Rules:
--   ✅ Each column holds atomic (indivisible) values
--   ✅ No repeating groups or arrays
--   ✅ Each row is unique

-- VIOLATION:
/*
order_id | products
---------|----------------------
1        | Laptop, Earbuds    ← multiple values in one cell = NOT 1NF
*/

-- FIX: One row per product per order (this is order_items table)
/*
order_id | product_id | qty
---------|------------|----
1        | 2          | 1
1        | 1          | 2
*/

-- ---------------------------------------------------------------
-- 2NF — Second Normal Form
-- ---------------------------------------------------------------
-- Rules:
--   ✅ Must be in 1NF
--   ✅ Every non-key column depends on the WHOLE primary key
--   (Relevant when the PK is composite)

-- VIOLATION (composite PK: order_id + product_id):
/*
order_id | product_id | qty | product_name   ← depends only on product_id, not full PK
*/

-- FIX: Split product_name into a separate products table
-- This is exactly what we've done in our schema:
-- order_items(order_id, product_id, qty, unit_price)  ← fully dependent on composite PK
-- products(product_id, name, price, ...)               ← product info lives here

-- ---------------------------------------------------------------
-- 3NF — Third Normal Form
-- ---------------------------------------------------------------
-- Rules:
--   ✅ Must be in 2NF
--   ✅ No transitive dependencies (non-key column depending on another non-key column)

-- VIOLATION:
/*
products(product_id, name, category_id, category_name)
                                         ↑ depends on category_id, not product_id
*/

-- FIX: Move category_name to a categories table
-- categories(category_id, name)   ← 3NF: category_name depends only on category_id PK
-- products(product_id, name, category_id, ...)

-- This is exactly our schema! Our E-Commerce schema is in 3NF.

-- ---------------------------------------------------------------
-- Verify our schema satisfies 3NF:
-- ---------------------------------------------------------------
SELECT
    p.product_id,
    p.name    AS product,
    p.price,
    c.name    AS category   -- category_name lives in its own table ✅
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- ---------------------------------------------------------------
-- STAR SCHEMA — Data Warehouse Design
-- (Directly relevant to DWDM subject)
-- ---------------------------------------------------------------
-- In analytics/BI, we deliberately DENORMALIZE for query speed.
-- The star schema has:
--   - 1 central FACT table (metrics, events)
--   - Multiple DIMENSION tables (descriptors)

-- FACT table = order_items (what happened: qty, revenue, time)
-- DIMENSION tables:
--   dim_users    → who (demographics)
--   dim_products → what (product attributes)
--   dim_dates    → when (date breakdowns)
--   dim_location → where (country, city)

-- Conceptual star schema DDL:
/*
CREATE TABLE dim_date (
    date_id     INT PRIMARY KEY,
    full_date   DATE,
    year        INT,
    quarter     INT,
    month       INT,
    month_name  VARCHAR(10),
    week        INT,
    day_of_week VARCHAR(10)
);

CREATE TABLE fact_sales (
    sale_id     SERIAL PRIMARY KEY,
    date_id     INT REFERENCES dim_date(date_id),
    user_id     INT REFERENCES users(user_id),
    product_id  INT REFERENCES products(product_id),
    quantity    INT,
    revenue     NUMERIC(10,2),
    cost        NUMERIC(10,2),
    profit      NUMERIC(10,2)
);
*/

-- Star schema query pattern (fast aggregations):
SELECT
    EXTRACT(YEAR  FROM o.order_date) AS year,
    EXTRACT(MONTH FROM o.order_date) AS month,
    c.name                            AS category,
    SUM(oi.quantity * oi.unit_price)  AS monthly_revenue
FROM order_items oi
JOIN orders    o ON oi.order_id   = o.order_id
JOIN products  p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY year, month, c.name
ORDER BY year, month, monthly_revenue DESC;

-- ---------------------------------------------------------------
-- OLTP vs OLAP — Key Distinction
-- ---------------------------------------------------------------
/*
OLTP (Online Transaction Processing)        OLAP (Online Analytical Processing)
─────────────────────────────────────       ──────────────────────────────────
Normalized (3NF)                            Denormalized (star/snowflake)
INSERT/UPDATE/DELETE heavy                  SELECT heavy
Many small, fast transactions               Few large, complex queries
Row-oriented storage                        Column-oriented storage
Examples: PostgreSQL, MySQL                 Examples: BigQuery, Redshift, Snowflake

Our repo schema = OLTP
Star schema above = OLAP
*/
