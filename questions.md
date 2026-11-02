# 📝 SQL Question Bank — E-Commerce Mini Project

All 42 questions answered in `miniProject_exercise.sql`, organized by level of difficulty.

---

## Level 1 — Basics (SELECT, WHERE, ORDER BY)

1. Retrieve customer names and emails for an email marketing campaign.
2. View the complete product catalog with all available details.
3. List all unique product categories available in the store.
4. Show all products priced above ₹1,000.
5. Display products within a mid-range price bracket (₹2,000 to ₹5,000).
6. Fetch complete details for a specific customer ID (e.g., customer 24).
7. Identify customers whose names start with the letter 'A'.
8. List Electronics products priced under ₹3,000.
9. Display product names and prices in descending order of price.
10. Display product names and prices sorted by price, then alphabetically by name.

---

## Level 2 — Filtering & Formatting (NULL checks, Aliases, String functions, Date functions)

1. Retrieve orders where customer information is missing (NULL customer_id).
2. Display customer names and emails using descriptive column aliases.
3. Calculate the total value per line item (quantity × item price).
4. Combine customer name and phone number into a single readable column.
5. Extract only the date part from order timestamps for date-based reporting.
6. List all products that are currently out of stock.

---

## Level 3 — Aggregations (GROUP BY, COUNT, SUM, AVG, MAX)

1. Count the total number of orders placed.
2. Calculate total revenue collected from all orders.
3. Calculate the average order value.
4. Count the number of customers who have placed at least one order.
5. Find the number of orders placed by each customer.
6. Find the total sales amount made by each customer.
7. List the total number of products sold per category.
8. Find the average item price per product category.
9. Show the number of orders placed per day, sorted by busiest day.
10. List total payments received per payment method.

---

## Level 4 — Multi-Table Queries (JOINs)

1. Retrieve order details along with the customer name. *(INNER JOIN)*
2. Get the list of products that have actually been sold. *(INNER JOIN)*
3. List all orders along with their payment method. *(INNER JOIN)*
4. Get a list of all customers and their order history, including customers with no orders. *(LEFT JOIN)*
5. List all products along with quantities sold, including unsold products. *(LEFT JOIN)*
6. List all payments, including any not matched to an order. *(RIGHT JOIN)*
7. Combine customer, order, and payment data into one detailed transaction report. *(Multi-JOIN)*

---

## Level 5 — Subqueries (Nested / Correlated)

1. List all products priced above the average product price.
2. Find customers who have placed at least one order. *(using IN subquery)*
3. Show orders whose total amount is above the average for that specific customer. *(correlated subquery)*
4. Display customers who have never placed any order. *(NOT IN subquery)*
5. Show products that were never ordered. *(NOT IN subquery)*
6. Show the highest-value order per customer — two approaches: simple `MAX` vs subquery.
7. Show the highest-value order per customer, including their name and email.

---

## Level 6 — Set Operations (UNION, simulated INTERSECT)

1. List all customers who have either placed an order **or** written a product review. *(UNION)*
2. List all customers who have placed an order **and** also reviewed a product. *(simulated INTERSECT using AND + subqueries)*

---

## 📌 Notes

- All queries use the `miniProject` database.
- Level 6 Q2 writes `INTERSECT` as `AND` with two subqueries, which works on every MySQL version (native `INTERSECT` arrived in MySQL 8.0.31).
- The `DISTINCT` keyword is used throughout to avoid double-counting.
- Correlated subqueries (Level 5 Q3, Q6) reference the outer query's table using an alias.
