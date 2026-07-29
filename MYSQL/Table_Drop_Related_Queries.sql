/*
Drop table related MySQL queries.

Purpose of this file:
- Create a database
- Use the database
- Create tables
- Create a relationship between tables using a foreign key
- Drop a table safely
- Show the current tables

Commands used in this file and their purpose:
- CREATE DATABASE: creates a new database
- USE: selects the database to work in
- CREATE TABLE: creates a table in the selected database
- FOREIGN KEY: links one table to another table
- DROP TABLE: removes a table and all its data permanently
- SHOW TABLES: displays all tables in the current database
- IF EXISTS / IF NOT EXISTS: prevents errors if the object already exists or already has been removed

Important note:
- DROP TABLE removes the table structure and all data inside it.
- If a table is referenced by a foreign key, drop the child table first.
*/

-- Create the database if it does not already exist
CREATE DATABASE IF NOT EXISTS DEMO;

-- Select the database to use
USE DEMO;

-- Create the parent table
CREATE TABLE IF NOT EXISTS DemoTable (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description VARCHAR(255)
);

-- Create the child table
-- This table depends on DemoTable through a foreign key
CREATE TABLE IF NOT EXISTS DemoDetails (
    ID INT PRIMARY KEY,
    DemoID INT,
    Detail VARCHAR(255),
    FOREIGN KEY (DemoID) REFERENCES DemoTable(ID)
);

-- Show the current tables in the database
SHOW TABLES;

-- Drop the child table first
-- This is safe because DemoDetails references DemoTable
DROP TABLE IF EXISTS DemoDetails;

-- Show tables again after dropping the child table
SHOW TABLES;

-- Drop the parent table
-- This is now safe because DemoDetails has already been removed
DROP TABLE IF EXISTS DemoTable;

-- Show tables again after dropping the parent table
SHOW TABLES;

/*
Example notes:
- If you try to drop DemoTable before DemoDetails, MySQL may block it because
  DemoDetails depends on DemoTable through the foreign key.
- To remove the whole database completely, you can use:
  DROP DATABASE IF EXISTS DEMO;
*/
