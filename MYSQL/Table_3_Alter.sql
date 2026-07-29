/*
Alter table related MySQL queries.

Purpose of this file:
- Create a database
- Use the database
- Create tables
- Show table structure
- Alter table structure using ALTER TABLE
- Rename columns and tables
- Add, modify, or remove columns
- Set column default values

Commands used in this file and their purpose:
- CREATE DATABASE: creates a new database
- USE: selects the database to work in
- CREATE TABLE: creates a new table
- ALTER TABLE: changes the structure of an existing table
- RENAME COLUMN: renames a column
- RENAME TO: renames a table
- ADD COLUMN: adds a new column
- MODIFY COLUMN: changes the data type of a column
- DROP COLUMN: removes a column
- ALTER COLUMN ... SET DEFAULT: sets a default value for a column
- DESCRIBE: shows the structure of a table
- SHOW TABLES: lists all tables in the current database

Important notes:
- ALTER TABLE changes the schema of an existing table.
- Some changes may affect existing data, so review them carefully.
*/

-- Create the database for student-related examples
CREATE DATABASE IF NOT EXISTS STUDENT;

-- Use the selected database
USE STUDENT;

-- Create the Students table
CREATE Table IF NOT EXISTS Students (
    ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT,
    Major VARCHAR(50),
    EnrollmentDate DATE
);



-- Create the Course table
CREATE Table IF NOT EXISTS Course (
    ID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT
);

-- Show all tables in the current database
SHOW TABLES;

-- View the structure of the Students table
DESCRIBE Students;

-- Rename the column "Major" to "FieldStudy" in the Students table
ALTER TABLE Students RENAME COLUMN Major TO FieldStudy;

-- Rename the table "Students" to "StudentDetails"
ALTER TABLE Students RENAME TO StudentDetails;

-- View the updated table structure after renaming
DESCRIBE StudentDetails;

-- Add a new column "GPA" to the StudentDetails table
ALTER TABLE StudentDetails ADD COLUMN GPA DECIMAL(3, 2);

-- Modify the data type of the "GPA" column to DECIMAL(4, 2)
ALTER TABLE StudentDetails MODIFY COLUMN GPA DECIMAL(4, 2);  

-- Remove the GPA column from the table
ALTER TABLE StudentDetails DROP COLUMN GPA;

-- Set a default value for the Age column
ALTER TABLE StudentDetails ALTER COLUMN Age SET DEFAULT 18;