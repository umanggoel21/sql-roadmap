# Phase 6 — Industry Skills

> **This phase makes you hireable.**  
> Everything before this taught you to write SQL. This phase teaches you to think like a Data Analyst.

---

## What's In This Phase

| File | Topic | Why It Matters |
|------|-------|----------------|
| `01_indexes_and_explain.sql` | Indexes + EXPLAIN plans | Asked in every senior DA interview |
| `02_views.sql` | CREATE VIEW vs CTE | Used daily in BI/analytics work |
| `03_transactions.sql` | BEGIN / COMMIT / ROLLBACK | Prevents data corruption |
| `04_schema_design.sql` | 1NF/2NF/3NF + Star Schema | DWDM subject + system design rounds |
| `05_data_quality.sql` | Duplicates, NULLs, orphans | Day 1 at any analytics job |
| `06_interview_patterns.sql` | Cohort, retention, funnel, MoM | The 6 patterns that appear everywhere |

---

## Interview Readiness Check

After completing this phase, you should be able to:

- [ ] Explain when to add an index and what `Seq Scan` vs `Index Scan` means
- [ ] Write a VIEW that hides JOIN complexity from a BI tool
- [ ] Explain why you'd use a CTE instead of a VIEW (and vice versa)
- [ ] Write a transaction that safely cancels an order and restores stock
- [ ] Draw the ERD of a normalized 3NF schema from a flat table
- [ ] Explain the difference between a star schema and an OLTP schema
- [ ] Write a query to find duplicate records and safely delete them
- [ ] Write a Month-over-Month growth query using LAG()
- [ ] Write a cohort analysis from scratch
- [ ] Answer: *"Which category drives the most repeat purchases from Q1 users?"*

---

## Recommended Practice After This Phase

- See `notes/interview_patterns.md` for 20 more common patterns
- Re-do the `final_project/` Level 2 (messy data) and Level 3 (business analysis)
- Try LeetCode Hard problems tagged `database`

---

## What Comes After Phase 6?

At this point you have everything needed for a **Data Analyst** role. Optional next steps:

- **dbt** — SQL transformations for data pipelines
- **BigQuery / Snowflake** — cloud data warehouses
- **Python + pandas** — programmatic data analysis
- **Power BI / Tableau** — visualization layer on top of your SQL

---

*← [Phase 5 — Advanced SQL](../phase5_advanced/README.md)*
