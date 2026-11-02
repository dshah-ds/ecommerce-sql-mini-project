-- ============================================================
-- Project  : E-Commerce SQL Analysis — Mini Project
-- Author   : Devam Shah
-- Database : MySQL (miniProject)
-- ============================================================
-- Description:
--   End-to-end SQL practice project using a simulated e-commerce
--   database. Covers 42 queries across 6 progressive levels:
--   Basics → Filtering → Aggregations → JOINs → Subqueries → Set Ops.
--
-- Tables Used:
--   customers, products, orders, order_items, payments, product_reviews
--
-- How to Use:
--   1. Run schema.sql to create all tables
--   2. Run seed_data.sql to populate with sample data // You can also import the database from the link provided in README.
--   3. Open this file and run queries level by level
-- ============================================================

-- Level 1 Basics

USE miniProject;

-- 1. Retrieve customer names and emails for email marketing
-- This helps the marketing team extract basic customer contact details for campaigns.

SELECT name, email
	FROM customers;
    
-- 2. View complete product catalog with all available details
-- The product manager may want to review all product listings in one go.

SELECT * 
	FROM products;

-- 3. List all unique product categories
-- Useful for analyzing the range of departments or for creating filters on the website.

SELECT DISTINCT(category)
	FROM products;

-- 4. Show all products priced above ₹1,000
-- This helps identify high-value items for premium promotions or pricing strategy reviews.

SELECT *
	FROM products
    WHERE price > 1000;

-- 5. Display products within a mid-range price bracket (₹2,000 to ₹5,000)
-- A merchandising team might need this to create a mid-tier pricing campaign.

SELECT *
	FROM products
    WHERE price BETWEEN 2000 AND 5000;

-- 6. Fetch data for specific customer IDs (e.g., from loyalty program list)
-- This is used when customer IDs are pre-selected from another system.

SELECT *
	FROM customers
    WHERE customer_id = 24;
-- Can be any customer_id between 1 to 30 as there are 30 customers in our customers table.

-- 7. Identify customers whose names start with the letter ‘A’
-- Used for alphabetical segmentation in outreach or app display.

SELECT *
	FROM customers
    WHERE name LIKE 'A%';

-- 8. List electronics products priced under ₹3,000
-- Used by merchandising or frontend teams to showcase budget electronics.

SELECT * 
	FROM products
    WHERE category = 'Electronics'
    AND price < 3000;

-- 9. Display product names and prices in descending order of price
-- This helps teams easily view and compare top-priced items.

SELECT name, price
	FROM products
    ORDER BY price DESC;

-- 10. Display product names and prices, sorted by price and then by name
-- The merchandising or catalog team may want to list products from most expensive to cheapest. If multiple products have the same price, they should be sorted alphabetically for clarity on storefronts or printed catalogs.

SELECT name, price
	FROM products
    ORDER BY price, name;
    
-- ============================================================
-- Level 2 : Filtering and Formatting
-- ============================================================

-- 1. Retrieve orders where customer information is missing (possibly due to data migration or deletion)
-- Used to identify orphaned orders or test data where customer_id is not linked.

SELECT * 
	FROM orders 
    WHERE customer_id IS NULL;
-- Checks if customer id(customer information) is null or not and if there is, it will return that row.

SELECT * 
	FROM orders 
    WHERE order_id IS NULL 
    OR customer_id IS NULL 
    OR order_date IS NULL 
    OR status IS NULL 
    OR total_amount IS NULL;
-- Checks if any field in Orders table is NULL and if there is any NULL value, this will return that row.

-- 2. Display customer names and emails using column aliases for frontend readability
-- Useful for feeding into frontend displays or report headings that require user-friendly labels.

SELECT name AS customer_full_name, email AS customer_email -- Changed column 'name' to 'customer_full_name' and 'email' to 'customer_email' for better readability 
	FROM customers;

-- 3. Calculate total value per item ordered by multiplying quantity and item price
-- This can help generate per-line item bill details or invoice breakdowns.

SELECT order_item_id, order_id, product_id, quantity, item_price, (quantity * item_price) AS total_value
	FROM order_items;

-- 4. Combine customer name and phone number in a single column
-- Used to show brief customer summaries or contact lists.

SELECT name, phone, CONCAT(name,' ___ ',phone) AS name_number_column
	FROM customers;
-- Adding ___ between name and number to make it easy to read

-- 5. Extract only the date part from order timestamps for date-wise reporting
-- Helps group or filter orders by date without considering time.

DESCRIBE orders; -- To check the datatypes of columns
SELECT *
	FROM orders; -- To check exactly how data is in all columns
SELECT order_id, customer_id, order_date, status, total_amount, date(order_date) AS just_dates
		FROM orders; -- Extracting only dates from order_date column in separate column name just_dates

-- 6. List products that do not have any stock left
-- This helps the inventory team identify out-of-stock items.

SELECT *
	FROM products; -- This shows all data from products along with quantities of products.
SELECT *
	FROM products
    WHERE stock_quantity < 1; -- This shows all data of products whose inventory/stock_quantity will be less than 1(no stock)

-- ============================================================
-- Level 3: Aggregations
-- ============================================================

-- 1. Count the total number of orders placed
-- Used by business managers to track order volume over time.

SELECT * FROM orders; -- To check the columns of Order table.
SELECT COUNT(*) AS total_orders
	FROM orders; -- Total number of orders in orders table - indicating how many total number of orders were placed.

-- 2. Calculate the total revenue collected from all orders
-- This gives the overall sales value.

SELECT * 
	FROM orders; -- To check the columns of Order table.
SELECT SUM(total_amount) AS total_revenue
	FROM orders; -- To sum all the amounts in total_amount column of all orders to get total revenue.

-- Note: this sums every order, including the 99 cancelled ones (they still have full payments here).
-- Revenue excluding cancellations: SELECT SUM(total_amount) FROM orders WHERE status <> 'Cancelled';

-- 3. Calculate the average order value
-- Used for understanding customer spending patterns.

SELECT * 
	FROM orders; -- To check the columns of Order table.
SELECT AVG(total_amount) AS average_order_value
	FROM orders; -- Checks the average order value of the column of total_amount

-- 4. Count the number of customers who have placed at least one order
-- This identifies active customers.

SELECT * 
	FROM orders; -- To check the columns of Order table.
SELECT COUNT(DISTINCT(customer_id)) AS active_customers
	FROM orders; 
-- This first identifies the distinct/unique values of customers based on customer_id 
-- and then counts it to get the active customers from the orders table which has details of the orders placed by customers
-- and then labels the column as active_customers.

-- 5. Find the number of orders placed by each customer
-- Helpful for identifying top or repeat customers.

SELECT * 
	FROM orders; -- To check the columns of Order table.
SELECT customer_id, COUNT(customer_id) AS number_of_orders_placed -- This gives two columns, one column shows customer_id, second column will show orders placed by corresponding customer_id.
	FROM orders
    GROUP BY customer_id -- It group by's the orders based on customer_id's which makes it easier to count and read
    ORDER BY customer_id; -- Orders by in ascending order of customer_id

-- 6. Find total sales amount made by each customer

SELECT * 
	FROM orders; -- To check the columns of Order table.
SELECT customer_id, SUM(total_amount) AS sales_per_customer -- Gives two columns, one - customer_id, second - total of amount of orders
	FROM orders
	GROUP BY customer_id; -- This group by's total sales per customer_id to get total_sales amount by each customer.

-- 7. List the number of products sold per category
-- This helps category managers assess performance by department.

SELECT *
	FROM products; -- TO check the category of products and columns of the product table
SELECT *
	FROM order_items; -- To check the order_items table and to correlate products and order_items table
SELECT p.category, SUM(oi.quantity) AS total_products -- To get two columns - categories and the total number of items using SUM of quantities sold as order_items.
	FROM products AS p
    JOIN -- Inner join: only products that appear in order_items are counted
    order_items AS oi
    ON p.product_id = oi.product_id -- correlating tables using product_id column in both tables
    GROUP BY p.category; -- Grouping by categories to get the total quantity of items sold per category

-- 8. Find the average item price per category
-- Useful to compare pricing across departments.

SELECT *
	FROM products; -- To check the columns of products table
SELECT category, AVG(price) AS average_item_price 
	FROM products
    GROUP BY category;
-- This query defines to give two columns, one of the columns averages the price in price column
-- Then it defines to group by category and give average price per category.

-- 9. Show number of orders placed per day
-- Used to track daily business activity and demand trends.

SELECT * 
	FROM orders; -- To check the columns and understand data in orders table
SELECT DATE(order_date) AS order_day, COUNT(order_id) AS total_orders -- Extracts date from order_date column and counts the number of order_id 
	FROM orders
    GROUP BY order_day -- Grouping by based on dates on which the orders were placed
    ORDER BY total_orders DESC; -- Sorting descending to show which date has highest number of orders

-- 10. List total payments received per payment method
-- Helps the finance team understand preferred transaction modes.

SELECT *
	FROM payments; -- To check the columns and understand data in payments table
SELECT method AS payment_method, COUNT(payment_id) AS total_number_of_payments -- Gets the payment method and counts the number of payments made through that payment method.
	FROM payments
    GROUP BY payment_method; -- Grouping by payment_method
    
-- ============================================================
-- Level 4: Multi-Table Queries (JOINS)
-- ============================================================

-- 1. Retrieve order details along with the customer name (INNER JOIN)
-- Used for displaying which customer placed each order.

SELECT o.order_id, o.order_date, o.status, o.total_amount, c.name AS customer_name -- Getting all columns from order table and name column from customer table
	FROM orders AS o
	JOIN
    customers AS c
    ON o.customer_id = c.customer_id
    ORDER BY o.order_id;

-- 2. Get list of products that have been sold (INNER JOIN with order_items)
-- Used to find which products were actually included in orders.

SELECT DISTINCT(p.product_id), p.name, p.category, p.price, oi.item_price AS sold_price -- Getting distinct products that were sold in orders and the price at which they were sold
	FROM products AS p
	INNER JOIN 
    order_items AS oi 
    ON p.product_id = oi.product_id
	ORDER BY p.product_id;

-- 3. List all orders with their payment method (INNER JOIN)
-- Used by finance or audit teams to see how each order was paid for.

SELECT o.order_id, o.customer_id, o.order_date, o.status, o.total_amount, p.method -- Joining orders table with payments table to get payment method
	FROM orders AS o
    INNER JOIN
    payments AS p
    ON o.order_id = p.order_id;

-- 4. Get list of customers and their orders (LEFT JOIN)
-- Used to find all customers and see who has or hasn’t placed orders.

SELECT c.customer_id, c.name, c.email, c.phone, COUNT(o.order_id) AS total_orders_placed
	FROM customers AS c
    LEFT JOIN
    orders AS o
    ON c.customer_id = o.customer_id
    GROUP BY c.customer_id; 
-- This query will group by customers and join orders table to customers table to get total orders placed by each customer.

SELECT c.customer_id, c.name, c.email, c.phone, o.order_id, o.order_date
	FROM customers AS c     
    LEFT JOIN     
    orders AS o     
    ON c.customer_id = o.customer_id;
-- This query will show each customer id and when they placed the order and the order id of that order placed.
-- Both queries can be used to check if any customer who has or hasn't placed orders.

-- 5. List all products along with order item quantity (LEFT JOIN)
-- Useful for inventory teams to track what sold and what hasn’t.

SELECT p.name, p.category, SUM(oi.quantity) AS sold_quantity
	FROM products AS p
    LEFT JOIN
    order_items AS oi
    ON p.product_id = oi.product_id
    GROUP BY p.product_id;

-- 6. List all payments including those with no matching orders (RIGHT JOIN)
-- Rare but used when ensuring all payments are mapped correctly.

SELECT p.payment_date, p.amount_paid, p.method, o.order_date, o.status, o.total_amount
	FROM orders AS o
    RIGHT JOIN
    payments AS p
    ON o.order_id = p.order_id;
-- No NULL methods or rows found. All payments are mapped.

-- 7. Combine data from three tables: customer, order, and payment
-- Used for detailed transaction reports.

SELECT c.customer_id, c.name, c.email, c.phone, o.order_id, o.order_date, o.status, o.total_amount, p.payment_id, p.payment_date, p.amount_paid, p.method
	FROM customers AS c -- lowercase alias to match c. below (aliases are case-sensitive on Linux MySQL)
    JOIN 
    orders AS o
    ON c.customer_id = o.customer_id
    JOIN
    payments AS p
    ON o.order_id = p.order_id;
-- UNION
-- SELECT c.customer_id, c.name, c.email, c.phone, o.order_id, o.order_date, o.status, o.total_amount, p.payment_id, p.payment_date, p.amount_paid, p.method
-- 	FROM customers AS C
--     RIGHT JOIN 
--     orders AS o
--     ON c.customer_id = o.customer_id
--     RIGHT JOIN
--     payments AS p
--     ON o.order_id = p.order_id;


-- ============================================================
-- Level 5: Subqueries (Inner Queries)
-- ============================================================

-- 1. List all products priced above the average product price
-- Used by pricing analysts to identify premium-priced products.

SELECT *
	FROM products 
    WHERE price > 
		(
			SELECT AVG(price)
				FROM products
        );

-- 2. Find customers who have placed at least one order
-- Used to identify active customers for loyalty campaigns.

SELECT *
	FROM customers 
    WHERE customer_id IN (
		SELECT DISTINCT(customer_id)
			FROM orders
    );

-- 3. Show orders whose total amount is above the average for that customer
-- Used to detect unusually high purchases per customer.

SELECT * FROM orders ORDER BY customer_id;

SELECT *
	FROM orders AS o1
    WHERE total_amount > (
		SELECT AVG(total_amount)
			FROM orders AS o2
            WHERE o2.customer_id = o1.customer_id
    )
    ORDER BY customer_id, total_amount;

-- 4. Display customers who haven’t placed any orders
-- Used for re-engagement campaigns targeting inactive users.

SELECT *
	FROM customers
    WHERE customer_id NOT IN (
		SELECT DISTINCT(customer_id)
			FROM orders
    );

-- 5. Show products that were never ordered
-- Helps with inventory clearance decisions or product deactivation.

SELECT *
	FROM products
	WHERE product_id NOT IN (
		SELECT DISTINCT(product_id)
			FROM order_items
    );

-- 6. Show highest value order per customer
-- Used to identify the largest transaction made by each customer.

-- Simple query
SELECT customer_id, MAX(total_amount) as highest_order
	FROM orders
	GROUP BY customer_id;

-- Using subquery
SELECT customer_id, total_amount AS highest_order
	FROM orders AS o1
    WHERE total_amount = (
		SELECT MAX(total_amount)
			FROM orders AS o2
            WHERE o2.customer_id = o1.customer_id
    )
    ORDER BY customer_id;

-- 7. Highest Order Per Customer (Including Names)
-- Used to identify the largest transaction made by each customer. Outputs name as well.

SELECT c.customer_id, c.name, c.email, o.order_id, o.total_amount 
	FROM orders AS o
    JOIN 
    customers AS c
    ON o.customer_id = c.customer_id
    WHERE 
    (o.customer_id, o.total_amount) IN (
		SELECT customer_id, MAX(total_amount)
			FROM orders
            GROUP BY customer_id
    );
    
-- ============================================================
-- Level 6: Set Operations
-- ============================================================

-- 1. List all customers who have either placed an order or written a product review
-- Used to identify engaged customers from different activity areas.

SELECT *
	FROM customers
    WHERE customer_id IN (
		SELECT DISTINCT(customer_id)
			FROM orders
		UNION
        SELECT DISTINCT(customer_id)
			FROM product_reviews
    );
    -- Question mentions customers who placed an order OR written a product review
    -- Hence performing UNION between distinct customer id's in orders and product reviews.
    -- This is OR operator.

-- 2. List all customers who have placed an order as well as reviewed a product
-- [written with AND + subqueries so it runs on any MySQL version; native INTERSECT exists from MySQL 8.0.31]
-- Used to identify highly engaged customers for rewards.

SELECT *
	FROM customers
    WHERE customer_id IN (
		SELECT DISTINCT(customer_id)
			FROM orders)
		AND customer_id IN (
        SELECT DISTINCT(customer_id)
			FROM product_reviews);
-- Question mentions customer who placed an order AND wrote a product review.
-- Hence Using 2 subqueries and using AND operator 
-- This is AND operator.



