/*
Simple MySQL guide for creating tables, inserting records, and viewing data.

Focus:
- Create a database
- Create tables
- Insert sample data
- Show table structure
- Show stored data

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
    ID INT PRIMARY KEY,
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

-- create a Department table from employer industries
CREATE TABLE IF NOT EXISTS Department AS
SELECT DISTINCT Industry AS DepartmentName
FROM Employer;

-- Show the new table structure
DESCRIBE Department;

-- Show the data inside the new table
SELECT * FROM Department;