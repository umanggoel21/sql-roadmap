-- =============================================================
--  sql-roadmap | E-Commerce Schema
--  File  : schema/create_tables.sql
--  Run this FIRST before seed_data.sql
--  Compatible with: PostgreSQL 13+ | MySQL 8+ | SQLite 3.35+
-- =============================================================

-- Drop tables in reverse-dependency order (safe re-run)
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS users;

-- ---------------------------------------------------------------
-- 1. USERS
-- ---------------------------------------------------------------
CREATE TABLE users (
    user_id       SERIAL PRIMARY KEY,          -- PostgreSQL; use AUTO_INCREMENT for MySQL
    full_name     VARCHAR(100) NOT NULL,
    email         VARCHAR(150) NOT NULL UNIQUE,
    country       VARCHAR(60)  NOT NULL,
    signup_date   DATE         NOT NULL,
    is_active     BOOLEAN      NOT NULL DEFAULT TRUE
);

-- ---------------------------------------------------------------
-- 2. CATEGORIES
-- ---------------------------------------------------------------
CREATE TABLE categories (
    category_id   SERIAL PRIMARY KEY,
    name          VARCHAR(80)  NOT NULL UNIQUE,
    description   TEXT
);

-- ---------------------------------------------------------------
-- 3. PRODUCTS
-- ---------------------------------------------------------------
CREATE TABLE products (
    product_id    SERIAL PRIMARY KEY,
    name          VARCHAR(120) NOT NULL,
    category_id   INT          REFERENCES categories(category_id),
    price         NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    stock_qty     INT          NOT NULL DEFAULT 0 CHECK (stock_qty >= 0),
    is_available  BOOLEAN      NOT NULL DEFAULT TRUE
);

-- ---------------------------------------------------------------
-- 4. EMPLOYEES  (managers reference other employees — self join)
-- ---------------------------------------------------------------
CREATE TABLE employees (
    employee_id   SERIAL PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    department    VARCHAR(60)  NOT NULL,
    manager_id    INT          REFERENCES employees(employee_id),  -- NULL = top-level
    salary        NUMERIC(10,2) NOT NULL CHECK (salary > 0),
    hire_date     DATE         NOT NULL
);

-- ---------------------------------------------------------------
-- 5. ORDERS
-- ---------------------------------------------------------------
CREATE TABLE orders (
    order_id      SERIAL PRIMARY KEY,
    user_id       INT          NOT NULL REFERENCES users(user_id),
    order_date    DATE         NOT NULL,
    status        VARCHAR(20)  NOT NULL DEFAULT 'pending'
                                CHECK (status IN ('pending','processing','shipped','delivered','cancelled')),
    total_amount  NUMERIC(10,2) NOT NULL CHECK (total_amount >= 0)
);

-- ---------------------------------------------------------------
-- 6. ORDER_ITEMS  (bridge table — orders ↔ products)
-- ---------------------------------------------------------------
CREATE TABLE order_items (
    item_id       SERIAL PRIMARY KEY,
    order_id      INT          NOT NULL REFERENCES orders(order_id),
    product_id    INT          NOT NULL REFERENCES products(product_id),
    quantity      INT          NOT NULL CHECK (quantity > 0),
    unit_price    NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0)
);

-- Quick sanity check (comment out if your client doesn't support DO blocks)
-- DO $$ BEGIN
--   RAISE NOTICE 'Schema created successfully. Run seed_data.sql next.';
-- END $$;
