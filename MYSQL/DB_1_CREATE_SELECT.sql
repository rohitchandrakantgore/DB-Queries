/*
Database-related MySQL queries.

Purpose of this file:
- Create databases
- Show available databases
- Select a database
- Show the current database
- Drop a database safely
- Understand common database commands

Commands used in this file and their purpose:
- CREATE DATABASE: creates a new database
- SHOW DATABASES: lists all databases on the MySQL server
- USE: selects the database to work in
- SELECT DATABASE(): shows the currently selected database
- DROP DATABASE: removes a database and all its tables permanently
- IF EXISTS / IF NOT EXISTS: prevents errors when running queries again

Important notes:
- Database names should not be enclosed in single quotes.
- DROP DATABASE is destructive and removes all data inside that database.
- Modern MySQL does not support a standard RENAME DATABASE command.
*/

-- Create databases only if they do not already exist
CREATE DATABASE IF NOT EXISTS COMPANY;

CREATE DATABASE IF NOT EXISTS DEMO;

CREATE DATABASE IF NOT EXISTS DATA;

-- Show all databases available on the server
SHOW DATABASES;

-- Select a database to work with
USE COMPANY;

-- Show the currently selected database
SELECT DATABASE();

-- Example: drop a database if it exists
-- DROP DATABASE IF EXISTS DEMO;

-- Example: rename a database
-- Modern MySQL does not support a standard RENAME DATABASE command.
-- A safe alternative is to export/import the database.


