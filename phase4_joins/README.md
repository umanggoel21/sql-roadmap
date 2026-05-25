# 📅 Week 3: Advanced Groupings & Relational Joins

This week marks the transition from single-table lookups to relational modeling, linking discrete entity models together.

## 🎓 Core Keywords Acquired
- `GROUP BY` (records categorization)
- `HAVING` (aggregated group validation filters)
- `INNER JOIN` (intersection matching)
- `LEFT JOIN` (outer join matching & null checks)
- `SELF JOIN` (hierarchical recursive lookups)

## 💡 Key Concept Highlight: LEFT JOIN vs INNER JOIN
- `INNER JOIN` excludes rows where join keys have no match in the opposite table.
- `LEFT JOIN` retains all records from the left table and inserts NULLs for unmatched right-table records. Excellent for finding inactive records.
