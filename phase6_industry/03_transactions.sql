-- =============================================================
--  Phase 6 — Industry Skills
--  File  : 03_transactions.sql
--  Topic : BEGIN, COMMIT, ROLLBACK — ACID properties
-- =============================================================

-- ---------------------------------------------------------------
-- WHAT IS A TRANSACTION?
-- A transaction is a sequence of SQL statements treated as ONE unit.
-- Either ALL succeed, or NONE apply (atomicity).
-- This prevents partial updates from corrupting your data.
-- ---------------------------------------------------------------

-- ---------------------------------------------------------------
-- ACID Properties (what makes transactions safe)
-- ---------------------------------------------------------------
-- A — Atomicity    : all or nothing
-- C — Consistency  : database moves from one valid state to another
-- I — Isolation    : concurrent transactions don't interfere
-- D — Durability   : committed changes survive crashes

-- ---------------------------------------------------------------
-- 1. Basic Transaction Syntax
-- ---------------------------------------------------------------

-- Scenario: A user cancels an order.
-- We need to update the order status AND restore stock quantities.
-- These two updates must happen together.

BEGIN;  -- Start transaction (also written as: START TRANSACTION;)

    -- Step 1: Mark the order as cancelled
    UPDATE orders
    SET status = 'cancelled'
    WHERE order_id = 43;

    -- Step 2: Restore stock for all items in that order
    UPDATE products p
    SET stock_qty = p.stock_qty + oi.quantity
    FROM order_items oi
    WHERE oi.order_id = 43
      AND oi.product_id = p.product_id;

COMMIT;  -- Makes both changes permanent

-- ---------------------------------------------------------------
-- 2. ROLLBACK — Undo on Error
-- ---------------------------------------------------------------

BEGIN;

    -- Simulate a mistake:
    UPDATE orders SET total_amount = 0 WHERE order_id = 1;

    -- Oh no — that was wrong! Undo everything:
ROLLBACK;

-- Verify: order 1's total_amount is still intact
SELECT order_id, total_amount FROM orders WHERE order_id = 1;

-- ---------------------------------------------------------------
-- 3. SAVEPOINT — Partial Rollback
-- ---------------------------------------------------------------

BEGIN;

    UPDATE orders SET status = 'shipped' WHERE order_id = 40;

    SAVEPOINT after_status_update;  -- Checkpoint

    UPDATE orders SET total_amount = 9999 WHERE order_id = 40;  -- Mistake!

    ROLLBACK TO SAVEPOINT after_status_update;  -- Undo only the bad step

    -- status update is still pending; amount update was rolled back
    -- Verify inside the transaction:
    SELECT order_id, status, total_amount FROM orders WHERE order_id = 40;

COMMIT;  -- Only the status update gets committed

-- ---------------------------------------------------------------
-- 4. When Transactions Are Implicitly Used
-- ---------------------------------------------------------------
-- Most databases auto-commit each statement by default.
-- To disable auto-commit: SET AUTOCOMMIT = 0; (MySQL)
-- In PostgreSQL, each statement is implicitly in its own transaction
-- unless you explicitly BEGIN.

-- ---------------------------------------------------------------
-- 5. Isolation Levels (awareness, not deep dive)
-- ---------------------------------------------------------------
-- READ UNCOMMITTED  — can read "dirty" (uncommitted) data
-- READ COMMITTED    — default in PostgreSQL; only reads committed data
-- REPEATABLE READ   — same query returns same rows within transaction
-- SERIALIZABLE      — strictest; transactions behave as if sequential

-- Set isolation level for a transaction:
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
    SELECT COUNT(*) FROM orders;  -- locked snapshot
COMMIT;

-- ---------------------------------------------------------------
-- 6. Real-World Pattern: Safe Money Transfer
-- ---------------------------------------------------------------
-- Imagine user 1 sends $50 credit to user 2.
-- (This assumes a hypothetical wallet table for illustration)

-- CREATE TABLE IF NOT EXISTS wallets (
--     user_id INT PRIMARY KEY REFERENCES users(user_id),
--     balance NUMERIC(10,2) NOT NULL DEFAULT 0 CHECK (balance >= 0)
-- );

BEGIN;
    -- Deduct from sender
    -- UPDATE wallets SET balance = balance - 50 WHERE user_id = 1;
    -- Add to receiver
    -- UPDATE wallets SET balance = balance + 50 WHERE user_id = 2;
    -- If either fails, ROLLBACK prevents partial state
COMMIT;

-- ---------------------------------------------------------------
-- KEY RULE: Always use transactions for multi-step data changes.
-- Without them, a crash between two UPDATE statements leaves
-- your database in an inconsistent state.
-- ---------------------------------------------------------------
