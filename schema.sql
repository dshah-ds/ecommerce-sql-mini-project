-- ============================================================
-- Project  : E-Commerce SQL Analysis — Mini Project
-- File     : schema.sql
-- Purpose  : Create all tables for the miniProject database
-- Run this FIRST before seed_data.sql or miniProject_exercise.sql
-- ============================================================

-- CREATING DATABASE AND SELECTING OPTIONS

-- DROPPING DATABASE if exists previously
DROP DATABASE IF EXISTS miniProject;

-- CHARACTER SET utf8mb4 envelopes all characters including smileys | ai/ci defines to ignore same character e and é like charatcers also case sensitive characters.
CREATE DATABASE miniProject CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci; 

-- USE DATABASE miniProject
USE miniProject;

-- CREATING TABLES customers, products, orders, order_items, payments and product_reviews
-- Using Engine InnoDB to create tables as it is ACID compliant and makes creating and working with tables easier


-- -----------------------------------------------
-- Table: customers
-- -----------------------------------------------

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) Engine = InnoDB;

-- -----------------------------------------------
-- Table: products
-- -----------------------------------------------

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    added_on DATETIME DEFAULT CURRENT_TIMESTAMP
)Engine = InnoDB;

-- -----------------------------------------------
-- Table: orders
-- -----------------------------------------------

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Pending',
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
)Engine = InnoDB;

-- -----------------------------------------------
-- Table: order_items
-- -----------------------------------------------

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    item_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
)Engine = InnoDB;

-- -----------------------------------------------
-- Table: payments
-- -----------------------------------------------

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount_paid DECIMAL(10,2) NOT NULL CHECK (amount_paid > 0),
    method VARCHAR(20) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
)Engine = InnoDB;

-- -----------------------------------------------
-- Table: product_reviews
-- -----------------------------------------------

CREATE TABLE product_reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    customer_id INT,
    rating INT NOT NULL,
    review_text TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
)Engine = InnoDB;