# 🛒 E-Commerce SQL Analysis — Mini Project

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql)
![SQL](https://img.shields.io/badge/SQL-DQL%20%7C%20JOINs%20%7C%20Subqueries-orange)
![Queries](https://img.shields.io/badge/Queries-42-brightgreen)
![Status](https://img.shields.io/badge/Status-Complete-success)

> A structured, progressive SQL practice project on a simulated e-commerce database — covering 42 queries across 6 difficulty levels, from basic `SELECT` statements to correlated subqueries and set operations.

---

## 📌 Project Overview

This project simulates a real-world e-commerce backend database and uses it to answer 42 business-driven SQL questions. Each query is written to solve a realistic scenario — marketing analysis, inventory checks, revenue reporting, customer segmentation, and more.

The project is designed to demonstrate practical SQL skills that apply directly to data analyst and backend developer roles.

---

## 🗄️ Database Schema

Six related tables that represent a typical e-commerce system:

```
customers ──< orders ──< order_items >── products
                │
             payments

products ──< product_reviews >── customers
```

| Table | Description |
|---|---|
| `customers` | 30 customers |
| `products` | 50 products |
| `orders` | 400 orders |
| `order_items` | 1201 Line items linking orders to products |
| `payments` | 400 Payment records with method (Credit Card, Debit Card, Net Banking, UPI) |
| `product_reviews` | 50 Customer ratings and reviews per product |

---

Additionally instead of running queries to create tables and adding seed data,
You can import the database by downloading from the following link:
https://drive.google.com/file/d/1CBd4Vb5JNsA0ZUvIi1LZlqm-OEVZMbmD/view?usp=sharing

---

## 📊 Query Levels

| Level | Topic | Queries |
|---|---|---|
| **1** | Basics — SELECT, WHERE, ORDER BY | 10 |
| **2** | Filtering & Formatting — NULL, Aliases, CONCAT, DATE() | 6 |
| **3** | Aggregations — COUNT, SUM, AVG, GROUP BY | 10 |
| **4** | Multi-Table Queries — INNER, LEFT, RIGHT JOIN | 7 |
| **5** | Subqueries — Nested & Correlated | 7 |
| **6** | Set Operations — UNION, simulated INTERSECT | 2 |

---

## 📁 Repository Structure

```
ecommerce-sql-project/
│
├── miniProject_exercise.sql   # All 42 queries with comments & explanations
├── schema.sql                 # CREATE TABLE statements for all 6 tables
├── seed_data.sql              # INSERT statements — sample data to populate tables
├── questions.md               # The full question bank (42 questions, organized by level)
└── README.md                  # Project documentation (this file)
```

---

## 🚀 Getting Started

### Prerequisites
- MySQL 8.0+ (or compatible — MariaDB works too)
- Any SQL client: MySQL Workbench, DBeaver, TablePlus, or the CLI

### Setup

```sql
-- 1. Run the schema to create the database and all tables
source /path/to/schema.sql

-- 2. Populate with sample data
source /path/to/seed_data.sql

-- 3. Open and run the queries
source /path/to/miniProject_exercise.sql
```

Or open each file in MySQL Workbench / your preferred SQL client and run them in order.

---

## 💡 Sample Queries & Highlights

**Customers who never placed an order** *(re-engagement campaigns)*
```sql
SELECT * FROM customers
WHERE customer_id NOT IN (
    SELECT DISTINCT(customer_id) FROM orders
);
```

**Highest order per customer with customer details** *(correlated subquery + JOIN)*
```sql
SELECT c.customer_id, c.name, c.email, o.order_id, o.total_amount
FROM orders AS o
JOIN customers AS c ON o.customer_id = c.customer_id
WHERE (o.customer_id, o.total_amount) IN (
    SELECT customer_id, MAX(total_amount)
    FROM orders GROUP BY customer_id
);
```

**Orders above that customer's own average spend** *(correlated subquery)*
```sql
SELECT * FROM orders AS o1
WHERE total_amount > (
    SELECT AVG(total_amount) FROM orders AS o2
    WHERE o2.customer_id = o1.customer_id
)
ORDER BY customer_id, total_amount;
```

---

## 🔍 Key SQL Concepts Demonstrated

- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`, `DISTINCT`
- `IS NULL`, `BETWEEN`, `LIKE`, `IN`, `NOT IN`
- `CONCAT()`, `DATE()`, column aliases (`AS`)
- `COUNT()`, `SUM()`, `AVG()`, `MAX()`, `GROUP BY`
- `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, multi-table JOINs
- Nested subqueries and correlated subqueries
- `UNION` and simulated `INTERSECT` in MySQL

---

## 📝 Notes

- All queries are written for **MySQL 8.0**. Level 6 writes `INTERSECT` as two `IN` subqueries joined by `AND`, which works on every MySQL version. (MySQL added native `INTERSECT` and `EXCEPT` in 8.0.31.)
- Level 3 Q2 ("total revenue") sums **all** orders, as the question asks — including 99 cancelled orders, which still have full payment records because refunds aren't modelled in this dataset. Excluding them (`WHERE status <> 'Cancelled'`) gives 5,309,237.04 instead of 6,960,973.66.
- Every query includes a **business context comment** explaining the real-world use case.
- Queries reference the `miniProject` database — the schema file handles `CREATE DATABASE` and `USE miniProject` automatically.

---

## Author

**Devam Shah** · Data Scientist & Analytics Engineer

- Website: [devam-shah.com](https://devam-shah.com)
- LinkedIn: [linkedin.com/in/devam-a-shah](https://www.linkedin.com/in/devam-a-shah)
- GitHub: [github.com/dshah-ds](https://github.com/dshah-ds)
- Medium: [@devamshah26](https://medium.com/@devamshah26)
- Blog: [One Notebook at a Time](https://onenotebookatatime.blogspot.com)

