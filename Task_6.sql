CREATE TABLE Departments (
    DeptID INTEGER PRIMARY KEY,
    DeptName TEXT,
    Location TEXT
);
CREATE TABLE Employees (
    EmpID INTEGER PRIMARY KEY,
    Name TEXT,
    Salary INTEGER,
    DeptID INTEGER,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);
INSERT INTO Departments VALUES (1, 'HR', 'NY'), (2, 'Engineering', 'SF'), (3, 'Sales', 'LA');
INSERT INTO Employees VALUES 
    (1, 'Alice', 60000, 1),
    (2, 'Bob', 50000, 2),
    (3, 'Charlie', 55000, 1),
    (4, 'David', 65000, 3),
    (5, 'Eve', 70000, 1);
SELECT 
    Name,
    Salary,
    DeptID,
    (SELECT AVG(Salary) FROM Employees e2 WHERE e2.DeptID = e1.DeptID) AS AvgDeptSalary
FROM Employees e1;
SELECT Name
FROM Employees
WHERE DeptID IN (SELECT DeptID FROM Departments WHERE DeptName IN ('HR', 'Sales'));
SELECT Name
FROM Employees e
WHERE EXISTS (
    SELECT 1 FROM Departments d WHERE d.DeptID = e.DeptID AND d.Location = 'NY'
);
SELECT DeptName, AvgSalary
FROM (
    SELECT d.DeptName, AVG(e.Salary) AS AvgSalary
    FROM Departments d
    JOIN Employees e ON d.DeptID = e.DeptID
    GROUP BY d.DeptName
) AS DeptAvg
WHERE AvgSalary > 60000;
SELECT Name, Salary
FROM Employees e1
WHERE Salary > (
    SELECT AVG(Salary) FROM Employees e2 WHERE e2.DeptID = e1.DeptID
);
