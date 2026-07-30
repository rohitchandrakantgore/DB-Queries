/*
Joins in SQL are used to combine rows from two or more tables.

Types of joins:
- INNER JOIN: returns only matching rows from both tables.
- LEFT JOIN: returns all rows from the left table and matching rows from the right.
- RIGHT JOIN: returns all rows from the right table and matching rows from the left.
- FULL OUTER JOIN: returns all rows from both tables, including unmatched ones.
- SELF JOIN: joins a table to itself.
- CROSS JOIN: returns all possible row combinations between two tables.
- ANTI JOIN: returns rows from one table that do not have a match in another table.
*/

-- using database
USE Company;

-- INNER JOIN
SELECT Employee.ID, Employee.FirstName, Employee.LastName, Employer.Name, Employer.Industry
FROM Employee
INNER JOIN Employer ON Employee.EmployerID = Employer.ID;

-- LEFT JOIN
SELECT Employee.ID, Employee.FirstName, Employee.LastName, Employee.Position,
       Employer.Name, Employer.Industry, Employer.Address
FROM Employee
LEFT JOIN Employer ON Employee.EmployerID = Employer.ID;

-- RIGHT JOIN
SELECT Employee.ID, Employee.FirstName, Employee.LastName, Employee.Position,
       Employer.Name, Employer.Industry, Employer.Address
FROM Employee
RIGHT JOIN Employer ON Employee.EmployerID = Employer.ID;

-- FULL OUTER JOIN (MySQL equivalent using UNION)
SELECT Employee.ID, Employee.FirstName, Employee.LastName, Employee.Position,
       Employer.Name, Employer.Industry, Employer.Address
FROM Employee
LEFT JOIN Employer ON Employee.EmployerID = Employer.ID
UNION
SELECT Employee.ID, Employee.FirstName, Employee.LastName, Employee.Position,
       Employer.Name, Employer.Industry, Employer.Address
FROM Employee
RIGHT JOIN Employer ON Employee.EmployerID = Employer.ID;

-- SELF JOIN
SELECT e1.FirstName AS EmployeeName,
       e2.FirstName AS SameSalaryEmployee,
       e1.Salary
FROM Employee e1
JOIN Employee e2
  ON e1.Salary = e2.Salary
 AND e1.ID <> e2.ID
ORDER BY e1.Salary DESC, e1.FirstName;

-- CROSS JOIN
SELECT Employee.FirstName, Employee.LastName, Employer.Name AS EmployerName
FROM Employee
CROSS JOIN Employer
ORDER BY Employee.FirstName, Employer.Name;

-- IMPLICIT JOIN (older style, but still valid)
SELECT Employee.FirstName, Employee.LastName, Employer.Name AS EmployerName
FROM Employee, Employer
WHERE Employee.EmployerID = Employer.ID
ORDER BY Employee.FirstName;

-- ANTI JOIN (employees without an employer)
SELECT Employee.FirstName, Employee.LastName
FROM Employee
LEFT JOIN Employer ON Employee.EmployerID = Employer.ID
WHERE Employer.ID IS NULL;

-- JOIN with a filter to show only employees in Technology or Healthcare
SELECT Employee.FirstName, Employee.LastName, Employer.Name, Employer.Industry
FROM Employee
INNER JOIN Employer ON Employee.EmployerID = Employer.ID
WHERE Employer.Industry IN ('Technology', 'Healthcare');

-- JOIN with ordering to make results easier to read
SELECT Employee.FirstName, Employee.LastName, Employer.Name, Employer.Industry, Employee.Salary
FROM Employee
INNER JOIN Employer ON Employee.EmployerID = Employer.ID
ORDER BY Employee.Salary DESC;