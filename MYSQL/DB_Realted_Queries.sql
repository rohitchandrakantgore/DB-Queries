/*
Database-related MySQL queries.

This file demonstrates:
- Creating databases
- Listing available databases
- Switching to a database
- Dropping a database (example)

Notes:
- Use IF NOT EXISTS to avoid errors when rerunning the script.
- Database names should not be enclosed in single quotes.
- Dropping a database is destructive and should be used carefully.
*/

-- Create databases only if they do not already exist
CREATE DATABASE IF NOT EXISTS COMPANY;

CREATE DATABASE IF NOT EXISTS DEMO;

CREATE DATABASE IF NOT EXISTS DATA;

-- Show all databases available on the MySQL server
SHOW DATABASES;

-- Example: drop a database if it exists
DROP DATABASE IF EXISTS DEMO;

-- Switch to the COMPANY database
USE COMPANY;


