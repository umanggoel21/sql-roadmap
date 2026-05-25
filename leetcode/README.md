# LeetCode SQL Practice

> **How to use this folder:**  
> Attempt the problem yourself first. Then open the solution file to compare approaches.  
> Each problem is tagged with the Phase that teaches the required concept.

---

## Problem Index

| # | Problem | Difficulty | Phase Tag | Key Concept |
|---|---------|-----------|-----------|-------------|
| 175 | [Combine Two Tables](https://leetcode.com/problems/combine-two-tables/) | Easy | Phase 4 — Joins | LEFT JOIN |
| 176 | [Second Highest Salary](https://leetcode.com/problems/second-highest-salary/) | Medium | Phase 5 — Advanced | Subquery / DENSE_RANK |
| 177 | [Nth Highest Salary](https://leetcode.com/problems/nth-highest-salary/) | Medium | Phase 5 — Advanced | DENSE_RANK / LIMIT OFFSET |
| 178 | [Rank Scores](https://leetcode.com/problems/rank-scores/) | Medium | Phase 5 — Advanced | DENSE_RANK |
| 180 | [Consecutive Numbers](https://leetcode.com/problems/consecutive-numbers/) | Medium | Phase 5 — Advanced | Self JOIN / LAG |
| 181 | [Employees Earning More Than Managers](https://leetcode.com/problems/employees-earning-more-than-their-managers/) | Easy | Phase 4 — Joins | Self JOIN |
| 182 | [Duplicate Emails](https://leetcode.com/problems/duplicate-emails/) | Easy | Phase 3 — Aggregations | GROUP BY + HAVING |
| 183 | [Customers Who Never Order](https://leetcode.com/problems/customers-who-never-order/) | Easy | Phase 4 — Joins | LEFT JOIN + IS NULL |
| 184 | [Department Highest Salary](https://leetcode.com/problems/department-highest-salary/) | Medium | Phase 5 — Advanced | RANK() PARTITION BY |
| 185 | [Department Top Three Salaries](https://leetcode.com/problems/department-top-three-salaries/) | Hard | Phase 5 — Advanced | DENSE_RANK() PARTITION BY |
| 196 | [Delete Duplicate Emails](https://leetcode.com/problems/delete-duplicate-emails/) | Easy | Phase 6 — Industry | DELETE + subquery |
| 197 | [Rising Temperature](https://leetcode.com/problems/rising-temperature/) | Easy | Phase 5 — Advanced | LAG / Self JOIN on dates |
| 262 | [Trips and Users](https://leetcode.com/problems/trips-and-users/) | Hard | Phase 6 — Industry | Complex JOINs + CASE WHEN |
| 511 | [Game Play Analysis I](https://leetcode.com/problems/game-play-analysis-i/) | Easy | Phase 3 — Aggregations | MIN() with GROUP BY |
| 512 | [Game Play Analysis II](https://leetcode.com/problems/game-play-analysis-ii/) | Easy | Phase 5 — Advanced | Correlated subquery |
| 534 | [Game Play Analysis III](https://leetcode.com/problems/game-play-analysis-iii/) | Medium | Phase 5 — Advanced | Running sum with window |
| 550 | [Game Play Analysis IV](https://leetcode.com/problems/game-play-analysis-iv/) | Medium | Phase 6 — Industry | Retention query pattern |
| 570 | [Managers with at Least 5 Direct Reports](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/) | Medium | Phase 4 — Joins | JOIN + GROUP BY + HAVING |
| 577 | [Employee Bonus](https://leetcode.com/problems/employee-bonus/) | Easy | Phase 4 — Joins | LEFT JOIN + NULL handling |
| 584 | [Find Customer Referee](https://leetcode.com/problems/find-customer-referee/) | Easy | Phase 2 — Core | NULL logic + IS NULL |

---

## Solutions

Solutions with explanations are in `practice.sql`.

> **Before peeking at a solution**, try to:
> 1. Identify which phase concept it tests
> 2. Write the query yourself
> 3. Run it against our E-Commerce schema (if similar data applies)
> 4. Then compare

---

## How to Use LeetCode with This Roadmap

| After finishing... | Practice these LeetCode problems |
|--------------------|----------------------------------|
| Phase 2 — Core Querying | #183, #584 |
| Phase 3 — Aggregations | #182, #511 |
| Phase 4 — Joins | #175, #181, #183, #570, #577 |
| Phase 5 — Advanced | #176, #177, #178, #180, #184, #185, #197, #512, #534 |
| Phase 6 — Industry | #196, #262, #550 |

---

## Tips for LeetCode SQL

1. **Always check the schema first** — read the table definitions before writing anything
2. **Edge cases matter** — NULL values, empty tables, ties in rankings
3. **DENSE_RANK vs RANK vs ROW_NUMBER** — know when each one changes the answer
4. **For Hard problems** — break them into CTEs, solve each part separately
5. **Multiple valid solutions exist** — the goal is correctness, then readability
