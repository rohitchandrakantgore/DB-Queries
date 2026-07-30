/* Used to combine data from two or more tables based on a related column between them. */

-- using database
USE Company;

SHOW TABLES;

DESCRIBE Employee;
DESCRIBE Employer;

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