# 📅 Week 2: Sorting, Pagination & Aggregate math

This week progresses from single row manipulation to column calculations and ordering constraints.

## 🎓 Core Keywords Acquired
- `ORDER BY` (multi-column ASC, DESC sorting)
- `LIMIT` & `OFFSET` (paging controls)
- Native SQLite Null coercion (`IFNULL`, `COALESCE`)
- Numeric aggregations (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`)
- Output aliasing (`AS`)

## 💡 Key Concept Highlight: SQL Aliasing Best Practices
Always use readable, descriptive aliases with `AS` to present clean columns to dashboard outputs. For instance, rather than displaying `AVG(price)`, write `AS average_product_price`.
