# 📝 Multi-Dialect SQL Cheat Sheet & Engine Reference

A side-by-side keywords comparison sheet across the 5 major relational database engines: **PostgreSQL, MySQL, SQLite, T-SQL (SQL Server), and Google BigQuery**.

## 📊 Cross-Dialect Reference Table

| Feature / Keyword | 🐘 PostgreSQL | 🐬 MySQL | 🪶 SQLite | 🖥️ T-SQL (SQL Server) | ☁️ Google BigQuery |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Pagination** | `LIMIT 10 OFFSET 5` | `LIMIT 5, 10` or `LIMIT 10 OFFSET 5` | `LIMIT 10 OFFSET 5` | `OFFSET 5 ROWS FETCH NEXT 10 ROWS ONLY` | `LIMIT 10 OFFSET 5` |
| **Null Coalescence**| `COALESCE(col, 'NA')` | `COALESCE(col, 'NA')` or `IFNULL` | `COALESCE(col, 'NA')` or `IFNULL` | `COALESCE(col, 'NA')` or `ISNULL(col, 'NA')` | `COALESCE(col, 'NA')` or `IFNULL` |
| **Concatenation** | `col1 \|\| ' ' \|\| col2` | `CONCAT(col1, ' ', col2)` | `col1 \|\| ' ' \|\| col2` | `col1 + ' ' + col2` or `CONCAT` | `CONCAT(col1, ' ', col2)` |
| **Date Extraction** | `EXTRACT(YEAR FROM date)` | `YEAR(date)` | `STRFTIME('%Y', date)` | `DATEPART(year, date)` or `YEAR(date)` | `EXTRACT(YEAR FROM date)` |
| **String Cast** | `CAST(col AS VARCHAR)` | `CAST(col AS CHAR)` | `CAST(col AS TEXT)` | `CAST(col AS VARCHAR)` | `CAST(col AS STRING)` |
| **Regular Expr** | `col ~ 'pattern'` | `col REGEXP 'pattern'` | `col REGEXP 'pattern'` | `col LIKE 'pattern'` | `REGEXP_CONTAINS(col, 'pattern')` |

---

## 🏗️ Universal E-Commerce Schema Field Directory
Use these structural column listings as a reference when writing queries:

* **`users` Table**:
  - `user_id` (Primary Key, integer)
  - `email` (varchar)
  - `first_name` (varchar)
  - `last_name` (varchar)
  - `country` (varchar)
  - `created_at` (timestamp)
* **`orders` Table**:
  - `order_id` (Primary Key, integer)
  - `user_id` (Foreign Key, integer)
  - `order_date` (timestamp)
  - `total_amount` (decimal)
  - `status` (varchar)
* **`products` Table**:
  - `product_id` (Primary Key, integer)
  - `product_name` (varchar)
  - `price` (decimal)
  - `category_id` (Foreign Key, integer)
* **`order_items` Table**:
  - `item_id` (Primary Key, integer)
  - `order_id` (Foreign Key, integer)
  - `product_id` (Foreign Key, integer)
  - `quantity` (integer)
  - `unit_price` (decimal)
* **`employees` Table**:
  - `employee_id` (Primary Key, integer)
  - `first_name` (varchar)
  - `last_name` (varchar)
  - `reports_to` (Foreign Key, referencing `employee_id`)
  - `title` (varchar)
