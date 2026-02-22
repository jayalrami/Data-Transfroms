-- ==============================
-- DATABASE CREATION
-- ==============================

CREATE DATABASE DATATRANSFORMS;
USE DATATRANSFORMS;

-- ==============================
-- TABLE CREATION
-- ==============================

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    RegistrationDate DATE
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10,2)
);

-- ==============================
-- INSERT DATA
-- ==============================

INSERT INTO Customers VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '2022-03-15'),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '2021-11-02'),
(3, 'Raj', 'Patel', 'raj.patel@email.com', '2022-06-10'),
(4, 'Amit', 'Sharma', 'amit.sharma@email.com', '2023-01-20'),
(5, 'Priya', 'Verma', 'priya.verma@email.com', '2021-09-25'),
(6, 'Neha', 'Singh', 'neha.singh@email.com', '2022-12-05'),
(7, 'Arjun', 'Mehta', 'arjun.mehta@email.com', '2023-03-18'),
(8, 'Karan', 'Joshi', 'karan.joshi@email.com', '2022-07-30'),
(9, 'Pooja', 'Desai', 'pooja.desai@email.com', '2023-05-11'),
(10, 'Rahul', 'Kumar', 'rahul.kumar@email.com', '2021-04-14');

INSERT INTO Orders VALUES
(101, 1, '2023-07-01', 150.50),
(102, 2, '2023-07-03', 200.75),
(103, 3, '2023-07-05', 500.00),
(104, 4, '2023-07-07', 1200.00),
(105, 5, '2023-07-10', 300.25),
(106, 6, '2023-07-12', 750.40),
(107, 7, '2023-07-15', 900.00),
(108, 8, '2023-07-18', 100.00),
(109, 9, '2023-07-20', 50.50),
(110, 10, '2023-07-22', 600.00);

INSERT INTO Employees VALUES
(1, 'Mark', 'Johnson', 'Sales', '2020-01-15', 50000),
(2, 'Susan', 'Lee', 'HR', '2021-03-20', 55000),
(3, 'Ankit', 'Patel', 'IT', '2019-08-10', 65000),
(4, 'Ravi', 'Kumar', 'Finance', '2022-02-25', 45000),
(5, 'Sneha', 'Shah', 'HR', '2021-12-01', 48000),
(6, 'Vikas', 'Singh', 'Sales', '2018-07-17', 70000),
(7, 'Nisha', 'Mehta', 'IT', '2020-09-09', 62000),
(8, 'Aarti', 'Joshi', 'Marketing', '2023-01-10', 40000),
(9, 'Manoj', 'Verma', 'Finance', '2017-05-05', 80000),
(10, 'Rohit', 'Desai', 'IT', '2022-06-30', 55000);

-- ==============================
-- PROJECT QUERIES
-- ==============================

-- 1. INNER JOIN
SELECT 
    c.CustomerID,
    CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM Customers c
JOIN Orders o 
ON c.CustomerID = o.CustomerID;

-- 2. LEFT JOIN
SELECT 
    c.CustomerID,
    c.FirstName,
    o.OrderID,
    IFNULL(o.TotalAmount,0) AS TotalAmount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;

-- 3. FULL OUTER JOIN (MySQL Compatible)
SELECT c.*, o.*
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID

UNION ALL

SELECT c.*, o.*
FROM Orders o
LEFT JOIN Customers c ON c.CustomerID = o.CustomerID
WHERE c.CustomerID IS NULL;

-- 4. Customers With Order Above Average
SELECT c.CustomerID, c.FirstName, o.TotalAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.TotalAmount > (SELECT AVG(TotalAmount) FROM Orders);

-- 5. Employees Salary Above Average
WITH AvgSalary AS (
    SELECT AVG(Salary) AS AvgSal FROM Employees
)
SELECT e.*
FROM Employees e, AvgSalary a
WHERE e.Salary > a.AvgSal;

-- 6. Extract Year & Month
SELECT 
    OrderID,
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth
FROM Orders;

-- 7. Date Difference
SELECT 
    OrderID,
    DATEDIFF(CURDATE(), OrderDate) AS DaysSinceOrder
FROM Orders;

-- 8. Running Total (Per Customer)
SELECT 
    CustomerID,
    OrderID,
    TotalAmount,
    SUM(TotalAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS RunningTotal
FROM Orders;

-- 9. Rank Orders by Amount
SELECT 
    OrderID,
    TotalAmount,
    DENSE_RANK() OVER (ORDER BY TotalAmount DESC) AS OrderRank
FROM Orders;

-- 10. Discount Calculation
SELECT 
    OrderID,
    TotalAmount,
    CASE 
        WHEN TotalAmount > 1000 THEN TotalAmount * 0.90
        WHEN TotalAmount > 500 THEN TotalAmount * 0.95
        ELSE TotalAmount
    END AS FinalAmount
FROM Orders;

-- 11. Employee Salary Category
SELECT 
    EmployeeID,
    FirstName,
    Salary,
    CASE 
        WHEN Salary >= 70000 THEN 'High'
        WHEN Salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS SalaryCategory
FROM Employees;