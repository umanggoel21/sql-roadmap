# ⚠️ SQLite Common Mistakes & Pitfalls

During this 30-day journey, I tracked common syntax mistakes and SQLite-specific behaviors. Below is a summary table to prevent errors in production.

## 🚫 Avoid These Common Pitfalls

| Mistake Category | ❌ Incorrect Query Pattern |   Correct Query Pattern | Why It Fails |
| :--- | :--- | :--- | :--- |
| **Table Plurality** | `SELECT * FROM customer;` | `SELECT * FROM customers;` | In Chinook, tables are plural (`customers`, `invoices`, `tracks`). |
| **Null Comparisons** | `WHERE State = NULL;` | `WHERE State IS NULL;` | `NULL` represents missing data; standard comparison operators (`=`, `<>`) always evaluate to `NULL`. |
| **String Literals** | `WHERE Country = "USA";` | `WHERE Country = 'USA';` | Double quotes are reserved for column identifiers in ANSI SQL. Always use single quotes for values. |
| **Logical Order** | `SELECT Name FROM tracks WHERE GenreId = 1 OR GenreId = 2 AND Composer = 'Slash';` | `SELECT Name FROM tracks WHERE (GeneId = 1 OR GenreId = 2) AND Composer = 'Slash';` | `AND` takes precedence over `OR`. Parentheses are mandatory to group OR conditions properly. |
| **Aggregate Filters** | `SELECT GenreId, COUNT(*) FROM tracks WHERE COUNT(*) > 10 GROUP BY GenreId;` | `SELECT GenreId, COUNT(*) FROM tracks GROUP BY GenreId HAVING COUNT(*) > 10;` | `WHERE` filters individual rows *before* aggregation. Use `HAVING` to filter grouped records. |
| **Date Extraction** | `WHERE InvoiceDate LIKE '2010%';` | `WHERE STRFTIME('%Y', InvoiceDate) = '2010';` | Text pattern matching on ISO dates is fragile. Always use SQLite's native `STRFTIME` functions. |

---

## 🛠️ Debugging Strategy Checklist
1. **Check Table Names**: Run `SELECT name FROM sqlite_master WHERE type='table';` to confirm spelling.
2. **Order of Clauses**: Always write clauses in this exact syntax order:
   `SELECT` ➔ `FROM` ➔ `JOIN` ➔ `WHERE` ➔ `GROUP BY` ➔ `HAVING` ➔ `ORDER BY` ➔ `LIMIT` ➔ `OFFSET`.
3. **Data Type Awareness**: Remember that string matches in `LIKE` are case-insensitive by default in SQLite, but this is not guaranteed in other SQL dialects.
