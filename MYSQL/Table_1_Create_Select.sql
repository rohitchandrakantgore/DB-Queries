/*
Simple MySQL guide for creating tables, inserting records, and viewing data.

Purpose of this file:
- Create a database
- Use the database
- Create tables
- Insert sample data
- Show table structure
- Show stored data

Commands used in this file and their purpose:
- CREATE DATABASE: creates a new database
- USE: selects the database to work in
- CREATE TABLE: creates a new table
- PRIMARY KEY: identifies each row uniquely
- NOT NULL: prevents empty values in a column
- UNIQUE: ensures values in a column are different
- AUTO_INCREMENT: automatically generates a unique numeric value for a column
- FOREIGN KEY: links one table to another
- INSERT INTO ... VALUES: adds new rows to a table
- SELECT: reads data from one or more tables
- WHERE: filters rows based on a condition
- DISTINCT: returns only unique values
- ORDER BY: sorts rows in ascending or descending order
- LIMIT: restricts the number of rows returned
- GROUP BY: groups rows that have the same values
- HAVING: filters grouped results
- DESCRIBE: shows the structure of a table
- SHOW TABLES: lists all tables in the current database

How to use this file:
1. Make sure your MySQL server is running.
2. Open this file in MySQL Workbench, the MySQL shell, or a VS Code SQL extension.
3. Run the queries from top to bottom.
*/

-- Create the database if it does not already exist
CREATE DATABASE IF NOT EXISTS Company;

-- Switch to the created database
USE Company;

-- Create the Employer table
CREATE TABLE IF NOT EXISTS Employer (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    EstablishedDate DATE,
    Industry VARCHAR(50)
);

-- Create the Employee table
CREATE TABLE IF NOT EXISTS Employee (
    ID INT PRIMARY KEY,
    EmployerID INT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50),
    Salary DECIMAL(10, 2) DEFAULT 0.00,
    HireDate DATE,
    CONSTRAINT fk_employee_employer
        FOREIGN KEY (EmployerID) REFERENCES Employer(ID)
);

-- Insert sample data into Employer table
INSERT INTO Employer (ID, Name, Address, PhoneNumber, Email, EstablishedDate, Industry)
VALUES
    (1, 'Tech Solutions Inc.', '123 Tech Street, Silicon Valley, CA', '123-456-7890', 'info@techsolutions.com', '2020-01-01', 'Technology'),
    (2, 'Green Energy Corp.', '456 Green Avenue, Austin, TX', '987-654-3210', 'info@greenenergy.com', '2019-06-15', 'Renewable Energy');

-- Insert sample data into Employee table
INSERT INTO Employee (ID, EmployerID, FirstName, LastName, Position, Salary, HireDate)
VALUES
    (1, 1, 'John', 'Doe', 'Software Engineer', 75000.00, '2020-01-15'),
    (2, 1, 'Jane', 'Smith', 'Project Manager', 85000.00, '2020-03-20'),
    (3, 2, 'Bob', 'Johnson', 'Energy Consultant', 65000.00, '2019-07-10'),
    (4, 2, 'Alice', 'Williams', 'Sustainability Specialist', 70000.00, '2019-09-25');

-- View all tables in the current database
SHOW TABLES;

-- Display the structure of the tables
DESCRIBE Employer;
DESCRIBE Employee;

-- Show all records from the tables
SELECT * FROM Employer;
SELECT * FROM Employee;

-- Show only selected columns
SELECT FirstName, LastName, Position FROM Employee;
SELECT Name, Email FROM Employer;

-- Create a table that uses AUTO_INCREMENT for its primary key
CREATE TABLE IF NOT EXISTS Product (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price DECIMAL(10, 2) DEFAULT 0.00,
    StockQuantity INT DEFAULT 0
);

-- Insert records without manually providing ProductID
INSERT INTO Product (ProductName, Category, Price, StockQuantity)
VALUES
    ('Laptop', 'Electronics', 999.99, 10),
    ('Mouse', 'Electronics', 25.50, 50),
    ('Keyboard', 'Electronics', 49.99, 40);

-- Add more sample records for SELECT clause examples
INSERT INTO Product (ProductName, Category, Price, StockQuantity)
VALUES
    ('Notebook', 'Stationery', 3.99, 200),
    ('Pen', 'Stationery', 1.49, 300),
    ('Desk', 'Furniture', 199.99, 15);

-- View the structure of the new table
DESCRIBE Product;

-- Show the records inserted with auto-generated IDs
SELECT * FROM Product;

-- WHERE clause
SELECT * FROM Product WHERE Category = 'Electronics';

-- DISTINCT clause
SELECT DISTINCT Category FROM Product;

-- ORDER BY clause
SELECT ProductName, Price FROM Product ORDER BY Price DESC;

-- LIMIT clause
SELECT ProductName, Price FROM Product ORDER BY Price ASC LIMIT 3;

-- GROUP BY clause
SELECT Category, COUNT(*) AS TotalProducts, SUM(StockQuantity) AS TotalStock
FROM Product
GROUP BY Category;

-- HAVING clause
SELECT Category, COUNT(*) AS TotalProducts
FROM Product
GROUP BY Category
HAVING COUNT(*) >= 2;

-- create a Department table from employer industries
CREATE TABLE IF NOT EXISTS Department AS
SELECT DISTINCT Industry AS DepartmentName
FROM Employer;

-- Show the new table structure
DESCRIBE Department;

-- Show the data inside the new table
SELECT * FROM Department;