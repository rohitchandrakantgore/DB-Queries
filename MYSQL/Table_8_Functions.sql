USE  DEMO;

# SQL Functions
# Types of SQL functions: Aggregate, Scalar, Date/Time, String, Conversion, and System functions.

# Lets Start with Aggregate Functions

SELECT * FROM employee;

# Count: Returns the number of rows that match a specified condition.
SELECT COUNT(*) AS Total_Employees FROM employee;

# Sum: Returns the total sum of a numeric column.
SELECT SUM(emp_salary) AS Total_Salary FROM employee;

# Average: Returns the average value of a numeric column.
SELECT AVG(emp_salary) AS Average_Salary FROM employee;

# Minimum: Returns the smallest value in a column.
SELECT MIN(emp_salary) AS Minimum_Salary FROM employee;

# Maximum: Returns the largest value in a column.
SELECT MAX(emp_salary) AS Maximum_Salary FROM employee;