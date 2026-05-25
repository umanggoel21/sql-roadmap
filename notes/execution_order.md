# SQL Execution Order — Complete Reference

> The #1 source of confusion for SQL beginners.  
> SQL is *written* in one order but *executed* in a completely different one.

---

## The Two Orders

```
How you WRITE SQL:         How the engine EXECUTES it:
──────────────────         ──────────────────────────
1. SELECT                  1. FROM
2. FROM                    2. JOIN / ON
3. JOIN / ON               3. WHERE
4. WHERE                   4. GROUP BY
5. GROUP BY                5. HAVING
6. HAVING                  6. SELECT  ← aliases born here
7. ORDER BY                7. DISTINCT (if present)
8. LIMIT / OFFSET          8. ORDER BY
                           9. LIMIT / OFFSET
```

**Memorize this phrase:**  
**"From Joining Where Groups Have Selected Order Limits"**  
FROM → JOIN → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT

---

## What Each Step Does

| Step | Clause | What Happens |
|------|--------|-------------|
| 1 | FROM | Load the base table into memory |
| 2 | JOIN | Combine rows from multiple tables using ON condition |
| 3 | WHERE | Filter individual rows (before grouping) |
| 4 | GROUP BY | Collapse rows into groups |
| 5 | HAVING | Filter groups (after aggregation) |
| 6 | SELECT | Pick which columns to return; aliases are assigned here |
| 7 | DISTINCT | Remove duplicate rows from SELECT result |
| 8 | ORDER BY | Sort the final result set |
| 9 | LIMIT/OFFSET | Cut the result to N rows |

---

## The Alias Problem — Most Common Mistake

Because SELECT runs **after** WHERE and HAVING, column aliases defined in SELECT **cannot be used in WHERE or HAVING**.

### ❌ BREAKS — alias in WHERE
```sql
SELECT total_amount * 0.18 AS gst
FROM orders
WHERE gst > 50;
-- ERROR: column "gst" does not exist
-- WHERE executes at step 3; "gst" alias is born at step 6
```

### ✅ FIX 1 — Repeat the expression
```sql
SELECT total_amount * 0.18 AS gst
FROM orders
WHERE total_amount * 0.18 > 50;
```

### ✅ FIX 2 — Subquery (let alias be created first, then filter it)
```sql
SELECT *
FROM (
    SELECT order_id, total_amount * 0.18 AS gst
    FROM orders
) sub
WHERE gst > 50;
```

### ✅ FIX 3 — CTE (cleaner for complex cases)
```sql
WITH order_tax AS (
    SELECT order_id, total_amount * 0.18 AS gst
    FROM orders
)
SELECT * FROM order_tax
WHERE gst > 50;
```

---

## The HAVING vs WHERE Problem

`WHERE` filters rows **before** grouping.  
`HAVING` filters **groups** after aggregation.

### ❌ WRONG — using aggregate in WHERE
```sql
SELECT user_id, COUNT(*) AS order_count
FROM orders
WHERE COUNT(*) > 2        -- ERROR: aggregates not allowed in WHERE
GROUP BY user_id;
```

### ✅ RIGHT — aggregates in HAVING
```sql
SELECT user_id, COUNT(*) AS order_count
FROM orders
GROUP BY user_id
HAVING COUNT(*) > 2;
```

### Combined WHERE + HAVING (most common real-world use)
```sql
SELECT user_id, COUNT(*) AS delivered_orders
FROM orders
WHERE status = 'delivered'          -- filter rows BEFORE grouping
GROUP BY user_id
HAVING COUNT(*) >= 2                -- filter groups AFTER aggregation
ORDER BY delivered_orders DESC;

-- Step-by-step what happens:
-- 1. FROM orders         → loads all 80 rows
-- 2. WHERE status = 'delivered'  → keeps only delivered rows (~40)
-- 3. GROUP BY user_id    → groups those 40 rows by user
-- 4. HAVING COUNT(*) >= 2 → keeps only groups with 2+ rows
-- 5. SELECT             → picks user_id, COUNT(*)
-- 6. ORDER BY           → sorts by count
```

---

## The ORDER BY Exception

Unlike WHERE and HAVING, **ORDER BY CAN use SELECT aliases** in most databases (PostgreSQL, MySQL, SQLite). This is a deliberate convenience exception.

```sql
-- ✅ This works (ORDER BY runs after SELECT)
SELECT user_id, COUNT(*) AS order_count
FROM orders
GROUP BY user_id
ORDER BY order_count DESC;   -- alias "order_count" is allowed here

-- ❌ This doesn't (HAVING runs before SELECT)
SELECT user_id, COUNT(*) AS order_count
FROM orders
GROUP BY user_id
HAVING order_count > 2;      -- ERROR in most databases
```

---

## Execution Order with JOINs

```sql
SELECT u.full_name, COUNT(o.order_id) AS num_orders
FROM users u                    -- Step 1: load users
JOIN orders o                   -- Step 2: join orders
  ON u.user_id = o.user_id
WHERE o.status = 'delivered'    -- Step 3: filter rows
GROUP BY u.user_id, u.full_name -- Step 4: group
HAVING COUNT(o.order_id) >= 2   -- Step 5: filter groups
ORDER BY num_orders DESC;       -- Step 8: sort (alias OK here)
```

**What happens step by step:**
1. `FROM users u` — loads 50 user rows
2. `JOIN orders o ON u.user_id = o.user_id` — 50 users × many orders = combined rows
3. `WHERE o.status = 'delivered'` — filters to only delivered order rows
4. `GROUP BY u.user_id, u.full_name` — groups by user
5. `HAVING COUNT(...) >= 2` — keeps users with 2+ delivered orders
6. `SELECT u.full_name, COUNT(...)` — picks columns, assigns alias
7. `ORDER BY num_orders DESC` — sorts using the alias

---

## DISTINCT Placement

`DISTINCT` is processed **after SELECT but before ORDER BY**.

```sql
SELECT DISTINCT country         -- Step 6+7: pick column, remove dupes
FROM users
ORDER BY country;               -- Step 8: sorts the distinct results
```

---

## Quick Cheat Sheet

```
Can I use alias in...
  WHERE?       ❌ No  (WHERE runs before SELECT)
  HAVING?      ❌ No  (HAVING runs before SELECT)
  GROUP BY?    ❌ No  (technically, some DBs allow it as extension)
  ORDER BY?    ✅ Yes (ORDER BY runs after SELECT)

Can I use aggregate in...
  WHERE?       ❌ No  → use HAVING
  HAVING?      ✅ Yes
  ORDER BY?    ✅ Yes (e.g., ORDER BY COUNT(*) DESC)
  SELECT?      ✅ Yes
```

---

## The "Why" in One Sentence

The database processes your query **data-first** (FROM, JOIN, WHERE) before it can compute **derived columns** (SELECT). You cannot filter on something that hasn't been calculated yet.
