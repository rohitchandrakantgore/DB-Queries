CREATE DATABASE IF NOT EXISTS `SampleDB`;

USE `SampleDB`;

-- Constraints are rules added to table columns to keep data accurate, valid, and consistent.
-- They help prevent invalid data, maintain relationships between tables, and improve data quality.
-- This script demonstrates common SQL constraints such as
-- PRIMARY KEY, AUTO_INCREMENT, NOT NULL, UNIQUE, DEFAULT, FOREIGN KEY, and CHECK.
-- PRIMARY KEY identifies each row uniquely.
-- AUTO_INCREMENT generates the next value automatically.
-- NOT NULL prevents empty values.
-- UNIQUE prevents duplicate values.
-- DEFAULT provides a fallback value.
-- CHECK limits values to valid ones.
-- FOREIGN KEY links rows to another table.
-- Run the script from top to bottom so the tables and sample data are created properly.

CREATE TABLE IF NOT EXISTS `Customer` (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY, -- PRIMARY KEY uniquely identifies each row; AUTO_INCREMENT fills it automatically.
    FirstName VARCHAR(50) NOT NULL, -- NOT NULL prevents empty values in this column.
    LastName VARCHAR(50) NOT NULL, -- NOT NULL prevents empty values in this column.
    Email VARCHAR(100) UNIQUE, -- UNIQUE ensures no duplicate email values.
    PhoneNumber VARCHAR(15),
    Address VARCHAR(255),
    Nationality VARCHAR(50) DEFAULT 'INDIA' -- DEFAULT gives a fallback value if none is provided.
);

CREATE TABLE IF NOT EXISTS `Product` (
    ProductID INT AUTO_INCREMENT PRIMARY KEY, -- PRIMARY KEY uniquely identifies each product; AUTO_INCREMENT fills it automatically.
    ProductName VARCHAR(100) NOT NULL, -- NOT NULL prevents empty product names.
    Price DECIMAL(10, 2) NOT NULL CHECK (Price > 0), -- CHECK ensures price must be greater than zero.
    StockQuantity INT DEFAULT 0 CHECK (StockQuantity >= 0), -- CHECK ensures stock cannot be negative.
    Category VARCHAR(50) DEFAULT 'General' -- DEFAULT fills in a category if one is not supplied.
);

CREATE TABLE IF NOT EXISTS `Orders` (
    OrderID INT AUTO_INCREMENT PRIMARY KEY, -- PRIMARY KEY uniquely identifies each order; AUTO_INCREMENT fills it automatically.
    CustomerID INT NOT NULL, -- NOT NULL ensures an order always has a customer reference.
    OrderDate DATE NOT NULL, -- NOT NULL ensures every order has a date.
    TotalAmount DECIMAL(10, 2) NOT NULL CHECK (TotalAmount >= 0), -- CHECK ensures total amount is not negative.
    IsPaid TINYINT(1) DEFAULT 0 CHECK (IsPaid IN (0, 1)), -- CHECK ensures the paid status is stored as 0 or 1.
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) -- FOREIGN KEY links orders to valid customers.
);

-- Insert sample data into Customer
INSERT INTO `Customer` (FirstName, LastName, Email, PhoneNumber, Address, Nationality)
VALUES
    ('Ananya', 'Sharma', 'ananya@example.com', '9876543210', 'Delhi', 'INDIA'),
    ('Rahul', 'Verma', 'rahul@example.com', '9123456780', 'Mumbai', 'INDIA'),
    ('Meera', 'Patel', 'meera@example.com', '9988776655', 'Ahmedabad', 'USA');

-- Insert sample data into Product
INSERT INTO `Product` (ProductName, Price, StockQuantity, Category)
VALUES
    ('Laptop', 59999.99, 10, 'Electronics'),
    ('Mouse', 799.50, 50, 'Electronics'),
    ('Notebook', 45.00, 200, 'Stationery');

-- Insert sample data into Orders
INSERT INTO `Orders` (CustomerID, OrderDate, TotalAmount, IsPaid)
VALUES
    (1, '2024-01-15', 1250.50, 1),
    (1, '2024-02-20', 349.99, 0),
    (2, '2024-03-01', 8990.00, 1),
    (3, '2024-03-10', 150.25, 0);

-- View the inserted records
SHOW TABLES;
SELECT * FROM `Customer`;
SELECT * FROM `Product`;
SELECT * FROM `Orders`;

-- Show table structure
DESCRIBE `Customer`;
DESCRIBE `Product`;
DESCRIBE `Orders`;

-- Example invalid inserts that will fail due to constraints
-- INSERT INTO `Customer` (FirstName, LastName, Email)
-- VALUES (NULL, 'Roy', 'asha@example.com');

-- INSERT INTO `Customer` (FirstName, LastName, Email)
-- VALUES ('Asha', 'Singh', 'ananya@example.com');

-- INSERT INTO `Product` (ProductName, Price, StockQuantity)
-- VALUES ('Tablet', -100.00, 5);

-- INSERT INTO `Orders` (CustomerID, OrderDate, TotalAmount, IsPaid)
-- VALUES (999, '2024-04-01', 100.00, 1);

