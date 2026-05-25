# ⚠️ The SQL Mistake Registry: Common Pitfalls & Anti-Patterns

This guide captures common logical, syntactic, and structural errors encountered when writing database queries, along with their correct patterns.

## 🚫 Avoid These Common Anti-Patterns

### 1. The Three-Valued Logic Trap (Comparing NULL with `=` or `<>`)
* **Anti-Pattern**:
  ```sql
  -- Returns ZERO rows because NULL represents an unknown value, not a blank text
  SELECT * FROM users WHERE country = NULL;
  ```
* **Correct Pattern**:
  ```sql
  SELECT * FROM users WHERE country IS NULL;
  ```
* **Key Concept**: In ANSI SQL, any comparison with `NULL` (such as `= NULL` or `<> NULL`) evaluates to `UNKNOWN` (three-valued logic). Always use `IS NULL` or `IS NOT NULL`.

---

### 2. Operator Precedence Hierarchy (AND executing before OR)
* **Anti-Pattern**:
  ```sql
  -- Evaluates as: Category 1 products AND price < 50, OR ANY Category 2 product regardless of price
  SELECT * FROM products WHERE category_id = 1 OR category_id = 2 AND price < 50.00;
  ```
* **Correct Pattern**:
  ```sql
  SELECT * FROM products WHERE (category_id = 1 OR category_id = 2) AND price < 50.00;
  ```
* **Key Concept**: `AND` has higher operator precedence than `OR`. Use parentheses to explicitly control evaluation boundaries.

---

### 3. Syntax Execution Order vs Logical Query Flow
* **Syntax Order (How you write it)**:
  `SELECT` ➔ `FROM` ➔ `JOIN` ➔ `WHERE` ➔ `GROUP BY` ➔ `HAVING` ➔ `ORDER BY` ➔ `LIMIT`
* **Logical Execution Order (How the database processes it)**:
  1. `FROM` & `JOIN` (Gather target raw tables)
  2. `WHERE` (Filter specific rows)
  3. `GROUP BY` (Aggregate rows into groups)
  4. `HAVING` (Filter aggregated groups)
  5. `SELECT` (Select final columns)
  6. `DISTINCT` (Filter out duplicates)
  7. `ORDER BY` (Sort output rows)
  8. `LIMIT` / `OFFSET` (Paginate final rows)
* **Common Mistake**: Trying to use a column alias defined in the `SELECT` clause within a `WHERE` clause. This fails because `WHERE` executes *before* `SELECT`.

---

### 4. WHERE vs HAVING Aggregate Math Filters
* **Anti-Pattern**:
  ```sql
  -- Fails because aggregate functions cannot appear in the WHERE clause
  SELECT user_id, COUNT(*) FROM orders WHERE COUNT(*) > 5 GROUP BY user_id;
  ```
* **Correct Pattern**:
  ```sql
  SELECT user_id, COUNT(*) FROM orders GROUP BY user_id HAVING COUNT(*) > 5;
  ```
* **Key Concept**: Use `WHERE` to filter raw rows *before* they are grouped. Use `HAVING` to filter aggregated metrics *after* grouping has completed.

---

### 5. Single Quotes vs Double Quotes
* **Anti-Pattern**:
  ```sql
  SELECT * FROM users WHERE country = "USA";
  ```
* **Correct Pattern**:
  ```sql
  SELECT * FROM users WHERE country = 'USA';
  ```
* **Key Concept**: In standard SQL, single quotes (`'`) denote **string literals (values)**. Double quotes (`"`) denote **delimited identifiers (table or column names)**.
