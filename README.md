# Task 6: Subqueries and Nested Queries (MySQL Workbench CE 8.0)

## 🎯 Objective
Use scalar, correlated, and nested subqueries in SELECT, WHERE, and FROM clauses.

---

## 🛠️ Tools
- MySQL Workbench CE 8.0
- Sample schema with tables: `client_master`, `product_master`, `sales_order`, `sales_order_details`

---

## 📚 Key Concepts Covered
- Scalar subquery
- Correlated subquery
- Subqueries using IN, EXISTS
- Subqueries in SELECT, WHERE, FROM

---

## 🧪 Sample Schema Overview

- `client_master(client_no, cname, state)`
- `product_master(product_no, description, product_rate)`
- `sales_order(order_no, client_no, order_date, delivery_date)`
- `sales_order_details(order_no, product_no, qty_ordered)`

---

## 📜 Queries Implemented

### 🔹 Scalar Subqueries

1. Find client who placed the latest order

### 🔹 Correlated Subqueries

2. Show product details that appear in more than 1 order

### 🔹 Subqueries with IN, EXISTS

3. Products that were ordered (`IN`)
4. Clients who placed at least one order (`EXISTS`)

### 🔹 Subquery in FROM clause

5. Average order amount per client

---

## ✅ Deliverables

- `task6.sql`: SQL file with all queries and example data
- `README.md`: This file

---
