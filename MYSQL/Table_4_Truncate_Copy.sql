/*
Table copy, truncate, and SELECT clause examples in MySQL.

Purpose of this file:
- Create a database
- Use the database
- Create tables
- Insert sample data
- Create copies of tables using LIKE and AS SELECT
- Truncate a table
- Demonstrate common SELECT clauses

Commands used in this file and their purpose:
- CREATE DATABASE: creates a new database
- USE: selects the database to work in
- CREATE TABLE: creates a new table
- INSERT INTO: adds rows to a table
- CREATE TABLE ... AS SELECT: creates a table from the results of a query
- CREATE TABLE ... LIKE: creates a table with the same structure as another table
- TRUNCATE: removes all rows from a table while keeping its structure
- SELECT: reads data from one or more tables
- WHERE: filters rows based on a condition
- DISTINCT: returns only unique values
- ORDER BY: sorts rows in ascending or descending order
- LIMIT: restricts the number of rows returned
- GROUP BY: groups rows with the same values
- HAVING: filters grouped results
- SHOW TABLES: lists all tables in the current database
*/

-- Create the database for car-related examples
CREATE DATABASE IF NOT EXISTS CAR;

-- Use the selected database
USE CAR;

-- Create the CarDetails table
CREATE TABLE IF NOT EXISTS CarDetails (
    ID INT PRIMARY KEY,
    Make VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Year INT,
    Price DECIMAL(10, 2)
);
-- Create the OwnerDetails table with a foreign key reference
CREATE TABLE IF NOT EXISTS OwnerDetails (
    ID INT PRIMARY KEY,
    CarID INT,
    OwnerName VARCHAR(100) NOT NULL,
    PurchaseDate DATE,
    CONSTRAINT fk_ownerdetails_cardetails
        FOREIGN KEY (CarID) REFERENCES CarDetails(ID)
);
-- Show all tables in the current database
SHOW TABLES;

-- Insert sample car records
INSERT INTO CarDetails (ID, Make, Model, Year, Price) VALUES
(1, 'Toyota', 'Camry', 2020, 24000.00),
(2, 'Honda', 'Civic', 2019, 22000.00),
(3, 'Ford', 'Mustang', 2021, 35000.00);

-- Insert sample owner records
INSERT INTO OwnerDetails (ID, CarID, OwnerName, PurchaseDate) VALUES
(1, 1, 'John Doe', '2020-05-15'),
(2, 2, 'Jane Smith', '2019-08-22'),
(3, 3, 'Alice Johnson', '2021-03-10');


-- Create a copy of OwnerDetails using AS SELECT
CREATE TABLE IF NOT EXISTS OwnerDetailsCopy AS SELECT * FROM OwnerDetails;

-- Create a shallow copy using LIKE
CREATE TABLE IF NOT EXISTS OwnerDetailsShallowCopy LIKE OwnerDetails;

-- Insert additional rows into the shallow copy
INSERT INTO OwnerDetailsShallowCopy (ID, CarID, OwnerName, PurchaseDate) VALUES
(1, 1, 'John Doe1', '2020-05-15'),
(2, 2, 'Jane Smith2', '2019-08-22'),
(3, 3, 'Alice Johnson3', '2021-03-10');

-- Remove all rows from the original table while keeping its structure
TRUNCATE TABLE OwnerDetails;

-- View the data after truncation
SELECT * FROM OwnerDetails;
SELECT * FROM OwnerDetailsCopy;

SELECT * FROM OwnerDetailsShallowCopy;


-- Create a deep copy of OwnerDetailsCopy
CREATE TABLE IF NOT EXISTS OwnerDetailsDeepCopy LIKE OwnerDetailsCopy;
INSERT INTO OwnerDetailsDeepCopy SELECT * FROM OwnerDetailsCopy;
SELECT * FROM OwnerDetailsDeepCopy;