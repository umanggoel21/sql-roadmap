# Interview Patterns — 20 Most Common DA Query Patterns

> These 20 patterns cover ~90% of SQL questions you'll face in Data Analyst interviews at product companies.
> Each pattern has the question, the approach, and the query.

---

## Pattern 1: Nth Highest Value

**Q:** Find the 3rd highest salary among employees.

```sql
-- Method 1: DENSE_RANK (handles ties correctly)
SELECT full_name, salary
FROM (
    SELECT full_name, salary,
           DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) ranked
WHERE rnk = 3;

-- Method 2: Subquery (works in all SQL dialects)
SELECT MIN(salary)
FROM employees
WHERE salary IN (
    SELECT DISTINCT salary FROM employees
    ORDER BY salary DESC
    LIMIT 3
);
```

---

## Pattern 2: Running Total (Cumulative Sum)

**Q:** Show cumulative revenue over time.

```sql
SELECT
    order_date,
    total_amount,
    SUM(total_amount) OVER (ORDER BY order_date) AS cumulative_revenue
FROM orders
WHERE status = 'delivered'
ORDER BY order_date;
```

---

## Pattern 3: Month-over-Month Growth

**Q:** Calculate % revenue growth each month vs previous month.

```sql
WITH monthly AS (
    SELECT DATE_TRUNC('month', order_date) AS month,
           SUM(total_amount) AS revenue
    FROM orders WHERE status != 'cancelled'
    GROUP BY 1
)
SELECT month, revenue,
       LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
       ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY month))
             / NULLIF(LAG(revenue) OVER (ORDER BY month), 0), 1) AS mom_pct
FROM monthly;
```

---

## Pattern 4: Top N Per Group

**Q:** Top 2 best-selling products per category.

```sql
SELECT * FROM (
    SELECT c.name AS category, p.name AS product,
           SUM(oi.quantity) AS units_sold,
           RANK() OVER (PARTITION BY c.name ORDER BY SUM(oi.quantity) DESC) AS rnk
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN categories c ON p.category_id = c.category_id
    GROUP BY c.name, p.name
) t
WHERE rnk <= 2;
```

---

## Pattern 5: Users Who Did X but NOT Y

**Q:** Users who signed up but never placed an order.

```sql
-- Method 1: LEFT JOIN + IS NULL
SELECT u.user_id, u.full_name
FROM users u
LEFT JOIN orders o ON u.user_id = o.user_id
WHERE o.order_id IS NULL;

-- Method 2: NOT IN subquery
SELECT user_id, full_name FROM users
WHERE user_id NOT IN (SELECT DISTINCT user_id FROM orders);

-- Method 3: NOT EXISTS (best performance on large tables)
SELECT user_id, full_name FROM users u
WHERE NOT EXISTS (
    SELECT 1 FROM orders o WHERE o.user_id = u.user_id
);
```

---

## Pattern 6: Repeat Buyers (Multi-Order Users)

**Q:** Find users who placed more than one order.

```sql
SELECT u.full_name, COUNT(o.order_id) AS order_count,
       SUM(o.total_amount) AS lifetime_value
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.full_name
HAVING COUNT(o.order_id) > 1
ORDER BY order_count DESC;
```

---

## Pattern 7: Cohort Analysis

**Q:** Group users by signup month and count how many placed their first order.

```sql
WITH cohorts AS (
    SELECT user_id, DATE_TRUNC('month', signup_date) AS cohort_month FROM users
),
first_orders AS (
    SELECT user_id, DATE_TRUNC('month', MIN(order_date)) AS first_order_month FROM orders GROUP BY 1
)
SELECT c.cohort_month,
       COUNT(c.user_id) AS signups,
       COUNT(fo.user_id) AS converted,
       ROUND(100.0 * COUNT(fo.user_id) / NULLIF(COUNT(c.user_id), 0), 1) AS conversion_rate
FROM cohorts c
LEFT JOIN first_orders fo ON c.user_id = fo.user_id AND fo.first_order_month = c.cohort_month
GROUP BY 1 ORDER BY 1;
```

---

## Pattern 8: Retention Rate

**Q:** What % of month-N buyers also bought in month N+1?

```sql
WITH buyers AS (
    SELECT DISTINCT user_id, DATE_TRUNC('month', order_date) AS month
    FROM orders WHERE status != 'cancelled'
)
SELECT m1.month,
       COUNT(DISTINCT m1.user_id) AS buyers,
       COUNT(DISTINCT m2.user_id) AS retained,
       ROUND(100.0 * COUNT(DISTINCT m2.user_id) / NULLIF(COUNT(DISTINCT m1.user_id), 0), 1) AS retention_pct
FROM buyers m1
LEFT JOIN buyers m2 ON m1.user_id = m2.user_id AND m2.month = m1.month + INTERVAL '1 month'
GROUP BY m1.month ORDER BY 1;
```

---

## Pattern 9: Rolling N-Day Average

**Q:** 7-day rolling average of daily order revenue.

```sql
WITH daily AS (
    SELECT order_date, SUM(total_amount) AS revenue
    FROM orders WHERE status != 'cancelled'
    GROUP BY order_date
)
SELECT order_date, revenue,
       ROUND(AVG(revenue) OVER (ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS rolling_7day
FROM daily ORDER BY order_date;
```

---

## Pattern 10: Duplicate Detection

**Q:** Find duplicate emails in the users table.

```sql
SELECT email, COUNT(*) AS cnt
FROM users
GROUP BY email
HAVING COUNT(*) > 1;
```

---

## Pattern 11: Rank Without RANK() (Classic Trick)

**Q:** For each user, rank their orders by total_amount using a subquery (no window functions).

```sql
SELECT a.user_id, a.order_id, a.total_amount,
       COUNT(b.order_id) + 1 AS rank_by_amount
FROM orders a
LEFT JOIN orders b
    ON a.user_id = b.user_id
   AND b.total_amount > a.total_amount
GROUP BY a.user_id, a.order_id, a.total_amount
ORDER BY a.user_id, rank_by_amount;
```

---

## Pattern 12: First/Last Order Per User

**Q:** Find each user's first and most recent order.

```sql
SELECT
    user_id,
    MIN(order_date) AS first_order,
    MAX(order_date) AS latest_order,
    COUNT(*)        AS total_orders,
    DATEDIFF(MAX(order_date), MIN(order_date)) AS days_as_customer  -- MySQL
    -- MAX(order_date) - MIN(order_date) AS days_as_customer        -- PostgreSQL
FROM orders
GROUP BY user_id;
```

---

## Pattern 13: Gap Detection (Missing Dates)

**Q:** Find days in a date range where no orders were placed.

```sql
-- PostgreSQL: generate a series of dates and LEFT JOIN orders
SELECT d::date AS missing_date
FROM generate_series('2024-01-01'::date, '2024-08-31'::date, '1 day') d
LEFT JOIN orders o ON o.order_date = d::date
WHERE o.order_id IS NULL
ORDER BY d;
```

---

## Pattern 14: Percentage of Total

**Q:** What % of total revenue does each category contribute?

```sql
SELECT
    c.name AS category,
    SUM(oi.quantity * oi.unit_price) AS category_revenue,
    ROUND(100.0 * SUM(oi.quantity * oi.unit_price)
        / SUM(SUM(oi.quantity * oi.unit_price)) OVER (), 1) AS pct_of_total
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.name
ORDER BY category_revenue DESC;
```

---

## Pattern 15: Self-Join for Hierarchy

**Q:** Show each employee with their manager's name.

```sql
SELECT
    e.full_name  AS employee,
    e.department,
    e.salary,
    m.full_name  AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
ORDER BY e.department, e.salary DESC;
```

---

## Pattern 16: Pivot-Style Aggregation with CASE WHEN

**Q:** Show revenue by category side by side in one row.

```sql
SELECT
    SUM(CASE WHEN c.name = 'Electronics' THEN oi.quantity * oi.unit_price ELSE 0 END) AS electronics_rev,
    SUM(CASE WHEN c.name = 'Books'       THEN oi.quantity * oi.unit_price ELSE 0 END) AS books_rev,
    SUM(CASE WHEN c.name = 'Clothing'    THEN oi.quantity * oi.unit_price ELSE 0 END) AS clothing_rev,
    SUM(oi.quantity * oi.unit_price) AS total_rev
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id;
```

---

## Pattern 17: Funnel Drop-off

**Q:** How many users reach each stage of the purchase funnel?

```sql
SELECT 'Signed Up'              AS stage, COUNT(*) AS users FROM users
UNION ALL
SELECT 'Placed Any Order',      COUNT(DISTINCT user_id)            FROM orders
UNION ALL
SELECT 'Order Delivered',       COUNT(DISTINCT user_id)            FROM orders WHERE status = 'delivered'
UNION ALL
SELECT 'Repeat Buyer (2+ orders)', COUNT(*)                        FROM (
    SELECT user_id FROM orders GROUP BY user_id HAVING COUNT(*) > 1
) t;
```

---

## Pattern 18: INTERSECT (Users Who Ordered in Both Months)

**Q:** Users who ordered in both January 2024 and February 2024.

```sql
SELECT user_id FROM orders WHERE DATE_TRUNC('month', order_date) = '2024-01-01'
INTERSECT
SELECT user_id FROM orders WHERE DATE_TRUNC('month', order_date) = '2024-02-01';
```

---

## Pattern 19: String Aggregation (List per Group)

**Q:** For each user, list all product names they bought.

```sql
-- PostgreSQL
SELECT u.full_name,
       STRING_AGG(DISTINCT p.name, ', ' ORDER BY p.name) AS products_bought
FROM users u
JOIN orders o     ON u.user_id  = o.user_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p   ON oi.product_id = p.product_id
GROUP BY u.user_id, u.full_name
ORDER BY u.full_name;

-- MySQL: use GROUP_CONCAT(DISTINCT p.name ORDER BY p.name)
```

---

## Pattern 20: Date-Based Segmentation

**Q:** Classify users as New (< 30 days), Active (30-180 days), or Lapsed (> 180 days) based on their last order.

```sql
SELECT
    u.full_name,
    MAX(o.order_date) AS last_order_date,
    CURRENT_DATE - MAX(o.order_date) AS days_since_last_order,
    CASE
        WHEN CURRENT_DATE - MAX(o.order_date) < 30  THEN 'New'
        WHEN CURRENT_DATE - MAX(o.order_date) < 180 THEN 'Active'
        ELSE 'Lapsed'
    END AS user_segment
FROM users u
JOIN orders o ON u.user_id = o.user_id
WHERE o.status != 'cancelled'
GROUP BY u.user_id, u.full_name
ORDER BY last_order_date DESC;
```

---

## Quick Reference: Which Pattern for Which Question?

| Interview Question Type | Pattern to Use |
|------------------------|----------------|
| "Nth highest value" | DENSE_RANK / subquery |
| "Top N per group" | RANK() PARTITION BY |
| "Users who did X but not Y" | LEFT JOIN + IS NULL / NOT EXISTS |
| "Growth over time" | LAG() |
| "Smoothed trend" | AVG() OVER (ROWS BETWEEN ...) |
| "Group users by sign-up period" | Cohort Analysis |
| "% of total" | SUM() OVER () in denominator |
| "First/last event per user" | MIN/MAX with GROUP BY or FIRST_VALUE() |
| "Compare two periods" | CASE WHEN + GROUP BY or INTERSECT |
| "Hierarchy/org chart" | Self JOIN or Recursive CTE |
