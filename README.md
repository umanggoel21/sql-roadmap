# 📊 Enterprise SQL Roadmap: Zero-to-Hero Mastery
[![SQL Dialects](https://img.shields.io/badge/SQL-PostgreSQL%20%7C%20MySQL%20%7C%20BigQuery%20%7C%20SQL%20Server%20%7C%20SQLite-blue.svg)]()
[![Documentation](https://img.shields.io/badge/Docs-Google%20%26%20Meta%20Standard-emerald.svg)]()
[![Status](https://img.shields.io/badge/Status-Complete-green.svg)]()

Welcome to the **Enterprise SQL Roadmap**! 🎓 This repository houses an industry-grade, multi-dialect curriculum designed to take you from core declarative data retrieval to complex database design, analytics, cohort segments, and window functions.

Unlike standard tutorials that are tied to a single database schema, this roadmap is **engine-agnostic** and provides side-by-side dialect comparisons for **PostgreSQL, MySQL, SQLite, Microsoft SQL Server (T-SQL), and Google BigQuery**, mirroring the technical rigor of engineering documentation at Google and Meta.

---

## 🗺️ The 30-Day Zero-to-Hero Syllabus

| Stage | Days | Focus Area | Key Concepts | Status |
| :--- | :--- | :--- | :--- | :--- |
| **Week 1** | Days 1 - 7 | **SQL Foundations & Row Filters** | Declarative logic, three-valued NULL logic, comparison operations, operator precedence, LIKE patterns | 100% Complete |
| **Week 2** | Days 8 - 14 | **Sorting, Pagination & Aggregates** | Pagination dialects (LIMIT, OFFSET, FETCH NEXT), aggregate math, COALESCE/IFNULL functions, aliasing | 100% Complete |
| **Week 3** | Days 15 - 21 | **Groupings, Joins & Relationships** | GROUP BY, HAVING vs WHERE, INNER/LEFT/RIGHT/FULL JOIN mechanics, Self-referential hierarchies | 100% Complete |
| **Week 4** | Days 22 - 28 | **Advanced Analytical SQL** | Nested and correlated subqueries, EXISTS, UNION/INTERSECT sets, CASE logic, Date math, Window Functions | 100% Complete |
| **Final** | Days 29 - 30 | **Enterprise Case Studies** | Cohort retention, Monthly Recurring Revenue (MRR), representative yields, LeetCode Hard challenges | 100% Complete |

---

## 🏗️ Core E-Commerce Relational Schema
All examples and exercises throughout this roadmap are mapped to a universal **E-Commerce and Retail Database** schema:

```mermaid
erDiagram
    users {
        int user_id PK
        varchar email
        varchar first_name
        varchar last_name
        varchar country
        timestamp created_at
    }
    orders {
        int order_id PK
        int user_id FK
        timestamp order_date
        decimal total_amount
        varchar status
    }
    products {
        int product_id PK
        varchar product_name
        decimal price
        int category_id FK
    }
    order_items {
        int item_id PK
        int order_id FK
        int product_id FK
        int quantity
        decimal unit_price
    }
    employees {
        int employee_id PK
        varchar first_name
        varchar last_name
        int reports_to FK
        varchar title
    }
    users ||--o{ orders : places
    orders ||--|{ order_items : contains
    products ||--o{ order_items : references
    employees ||--o{ employees : reports_to
```

---

## 📂 Quick Navigation Links
* ⚠️ **[Common SQL Mistakes Guide](./notes/common_mistakes.md)**: Personalized mistakes, null pitfalls, precedence traps, and syntax ordering.
* 📝 **[Universal SQL Cheat Sheet](./notes/quick_reference.md)**: Side-by-side keywords comparison across 5 major engines.
* 🎯 **[LeetCode SQL Exercises](./leetcode/practice.sql)**: Solutions to classic industry SQL interview questions.

---
*Developed as a high-fidelity professional reference and learning template for software engineers and data analysts.*
