# 📅 Week 4: Advanced Analytical SQL Logic

This week introduces advanced logical branching, recursive querying, and conditional aggregates to solve complex corporate business queries.

## 🎓 Core Keywords Acquired
- Subqueries (nested inside `WHERE`, `SELECT`, and `FROM`)
- `EXISTS` & `NOT EXISTS` (existential row-validation checks)
- `UNION` & `UNION ALL` (vertical dataset stacking)
- `CASE` expressions (conditional cohort classifications)
- SQLite date functions (`STRFTIME`, `%Y`, `%m`, `%d`)

## 💡 Key Concept Highlight: UNION vs UNION ALL
- `UNION` stacks datasets vertically and removes duplicate rows.
- `UNION ALL` stacks datasets vertically but retains duplicate rows, making it much faster because it avoids sorting and deduplication.
