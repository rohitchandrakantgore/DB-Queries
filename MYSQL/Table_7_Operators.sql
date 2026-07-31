/*
This file demonstrates common SQL operators using the EMPLOYEE table.
It includes logical operators, comparison operators, pattern matching,
set operators, and conditional expressions.
Run the script from top to bottom so the table and sample records are created first.
*/

CREATE DATABASE IF NOT EXISTS DEMO;
USE DEMO;

-- Create the EMPLOYEE table with columns that support different operator examples.

CREATE TABLE IF NOT EXISTS EMPLOYEE (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    EMP_NAME VARCHAR(50) NOT NULL,
    EMP_CITY VARCHAR(50) NOT NULL,
    EMP_SALARY DECIMAL(10, 2) NOT NULL,
    EMP_COUNTRY VARCHAR(50),
    EMP_DEPT VARCHAR(50),
    IS_ACTIVE TINYINT(1) DEFAULT 1
);

-- Insert a mix of employees so operators can show different outcomes.
INSERT INTO EMPLOYEE (EMP_NAME, EMP_CITY, EMP_SALARY, EMP_COUNTRY, EMP_DEPT, IS_ACTIVE)
VALUES
    ('John Doe', 'New York', 60000.00, 'USA', 'IT', 1),
    ('Jane Smith', 'Los Angeles', 75000.00, 'USA', 'HR', 1),
    ('Michael Johnson', 'Chicago', 50000.00, 'USA', 'Finance', 1),
    ('Emily Davis', 'Houston', 80000.00, 'USA', 'IT', 1),
    ('William Brown', 'Phoenix', 55000.00, 'USA', 'Marketing', 0),
    ('Olivia Wilson', 'Philadelphia', 70000.00, 'USA', 'Finance', 1),
    ('James Taylor', 'San Antonio', 65000.00, 'USA', 'HR', 1),
    ('Sophia Anderson', 'San Diego', 72000.00, 'USA', 'IT', 1),
    ('Benjamin Thomas', 'Dallas', 58000.00, 'USA', 'Marketing', 0),
    ('Ava Jackson', 'San Jose', 77000.00, 'USA', 'Finance', 1),
    ('Liam White', 'Austin', 69000.00, 'USA', 'IT', 1),
    ('Mia Harris', 'Jacksonville', 62000.00, 'USA', 'HR', 1),
    ('Noah Martin', 'Fort Worth', 54000.00, 'USA', 'Finance', 0),
    ('Isabella Thompson', 'Columbus', 81000.00, 'USA', 'IT', 1),
    ('Elijah Garcia', 'Charlotte', 56000.00, 'USA', 'Marketing', 1),
    ('Charlotte Martinez', 'San Francisco', 73000.00, NULL, NULL, 1),
    ('Lucas Robinson', 'Indianapolis', 67000.00, 'USA', 'HR', 1),
    ('Amelia Clark', 'Seattle', 75000.00, 'USA', 'IT', 1),
    ('Mason Rodriguez', 'Denver', 59000.00, 'USA', NULL, 1),
    ('Harper Lewis', 'Washington D.C.', 78000.00, 'USA', 'Finance', 0),
    ('Aarav Sharma', 'Mumbai', 64000.00, 'India', 'IT', 1),
    ('Priya Nair', 'Bengaluru', 71000.00, 'India', 'HR', 1),
    ('Ravi Kumar', 'Delhi', 60000.00, 'India', 'Finance', 1);

SELECT * FROM EMPLOYEE;

-- AND: returns rows that satisfy both conditions.
SELECT * FROM EMPLOYEE
WHERE EMP_SALARY > 70000 AND EMP_DEPT = 'IT';

-- OR: returns rows that satisfy at least one of the conditions.
SELECT * FROM EMPLOYEE
WHERE EMP_CITY = 'New York' OR EMP_CITY = 'Los Angeles';

-- IN: checks whether a value exists in a given list.
SELECT * FROM EMPLOYEE
WHERE EMP_DEPT IN ('IT', 'Finance');

-- NOT IN: returns rows whose value is not in the given list.
SELECT * FROM EMPLOYEE
WHERE EMP_DEPT NOT IN ('HR', 'Marketing');

-- LIKE: used for pattern matching with wildcards.
SELECT * FROM EMPLOYEE
WHERE EMP_NAME LIKE 'J%';

-- NOT LIKE: returns rows that do not match the pattern.
SELECT * FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE 'A%';

-- BETWEEN: matches values within a range inclusive.
SELECT * FROM EMPLOYEE
WHERE EMP_SALARY BETWEEN 70000 AND 75000;

-- IS NULL: finds rows where the value is missing.
SELECT * FROM EMPLOYEE
WHERE EMP_DEPT IS NULL;

-- IS NOT NULL: finds rows where the value is present.
SELECT * FROM EMPLOYEE
WHERE EMP_COUNTRY IS NOT NULL;

-- ALL: compares a value to all values returned by a subquery.
SELECT * FROM EMPLOYEE
WHERE EMP_SALARY > ALL (SELECT EMP_SALARY FROM EMPLOYEE WHERE EMP_DEPT = 'Finance');

-- ANY: compares a value to at least one value returned by a subquery.
SELECT * FROM EMPLOYEE
WHERE EMP_SALARY > ANY (SELECT EMP_SALARY FROM EMPLOYEE WHERE EMP_DEPT = 'HR');

-- SOME: works similarly to ANY and checks against at least one value.
SELECT * FROM EMPLOYEE
WHERE EMP_SALARY > SOME (SELECT EMP_SALARY FROM EMPLOYEE WHERE EMP_DEPT = 'Marketing');

-- EXISTS: checks whether a subquery returns any rows.
SELECT * FROM EMPLOYEE e
WHERE EXISTS (
    SELECT 1
    FROM EMPLOYEE
    WHERE EMP_DEPT = 'IT' AND EMP_CITY = e.EMP_CITY
);

-- <>: checks for values that are not equal.
SELECT * FROM EMPLOYEE
WHERE EMP_DEPT <> 'Finance';

-- !=: alternative way to check for inequality.
SELECT * FROM EMPLOYEE
WHERE EMP_DEPT != 'Finance';

-- =: checks whether a flag or value matches exactly.
SELECT * FROM EMPLOYEE
WHERE IS_ACTIVE = 1;

-- UNION: combines result sets and removes duplicates.
SELECT EMP_NAME, EMP_CITY FROM EMPLOYEE WHERE EMP_DEPT = 'IT'
UNION
SELECT EMP_NAME, EMP_CITY FROM EMPLOYEE WHERE EMP_DEPT = 'Finance';

-- UNION ALL: combines result sets and keeps duplicates.
SELECT EMP_NAME, EMP_CITY FROM EMPLOYEE WHERE EMP_DEPT = 'IT'
UNION ALL
SELECT EMP_NAME, EMP_CITY FROM EMPLOYEE WHERE EMP_DEPT = 'Finance';

-- CASE: returns different values based on a condition.
SELECT EMP_NAME,
       EMP_SALARY,
       CASE
           WHEN EMP_SALARY < 60000 THEN 'Low'
           WHEN EMP_SALARY BETWEEN 60000 AND 70000 THEN 'Medium'
           ELSE 'High'
       END AS SalaryRange
FROM EMPLOYEE
ORDER BY EMP_SALARY;

-- EXCEPT: MySQL does not support EXCEPT directly, but it can be simulated using NOT IN or LEFT JOIN.

-- INTERSECT: MySQL does not support INTERSECT directly, but it can be simulated using INNER JOIN.