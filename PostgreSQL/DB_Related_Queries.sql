/*
PostgreSQL database-related queries.

Purpose of this file:
- Create a database
- List available databases
- Connect to a database
- Show the current database
- Drop a database safely

Commands used in this file and their purpose:
- createdb: creates a PostgreSQL database from the terminal
- CREATE DATABASE: creates a database from the psql shell
- \c: connects to a database
- SELECT ... FROM pg_database: lists databases in PostgreSQL
- SELECT current_database(): shows the currently connected database
- DROP DATABASE: removes a database permanently

Important notes:
- In PostgreSQL, a database is usually created before you connect to it.
- You cannot drop the database you are currently connected to.
- PostgreSQL uses different commands than MySQL for listing databases.
*/

-- Method 1: Create a database from the terminal
-- Example:
-- createdb company

-- Method 2: Create a database from psql
-- First connect to the default database, usually postgres
-- \c postgres
-- CREATE DATABASE company;

-- After creating the database, connect to it
-- \c company

-- Show all databases in PostgreSQL
SELECT datname
FROM pg_database
WHERE datistemplate = false
ORDER BY datname;

-- Show the currently connected database
SELECT current_database();

-- Example: drop a database if it exists
-- Important: do not run this while connected to that database
-- DROP DATABASE IF EXISTS company;