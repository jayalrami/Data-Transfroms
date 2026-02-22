:

📊 DataTransform SQL Project
📌 Project Overview

This project demonstrates SQL database creation, table relationships, data insertion, and advanced queries using MySQL.
It covers joins, subqueries, window functions, CTEs, aggregate functions, and CASE statements.

🗄️ Database Name

DATATRANSFORM

🏗️ Database Structure
1️⃣ Customers Table

Stores customer details.

Column Name	Data Type	Description
CustomerID	INT (PK)	Unique customer ID
FirstName	VARCHAR(50)	Customer first name
LastName	VARCHAR(50)	Customer last name
Email	VARCHAR(100)	Customer email
RegistrationDate	DATE	Date of registration
2️⃣ Orders Table

Stores order details.

Column Name	Data Type	Description
OrderID	INT (PK)	Unique order ID
CustomerID	INT (FK)	References Customers table
OrderDate	DATE	Order date
TotalAmount	DECIMAL(10,2)	Order amount
3️⃣ Employees Table

Stores employee information.

Column Name	Data Type	Description
EmployeeID	INT (PK)	Unique employee ID
FirstName	VARCHAR(50)	First name
LastName	VARCHAR(50)	Last name
Department	VARCHAR(50)	Department name
HireDate	DATE	Hiring date
Salary	DECIMAL(10,2)	Employee salary
📥 Sample Data

10 Customers

10 Orders

10 Employees

🔎 SQL Queries Implemented
✅ 1. INNER JOIN

Displays matching records from Customers and Orders.

✅ 2. LEFT JOIN

Displays all customers, including those without orders.

✅ 3. FULL OUTER JOIN (MySQL Compatible)

Implemented using LEFT JOIN + UNION ALL + RIGHT condition.

✅ 4. Customers With Orders Above Average

Uses subquery with AVG().

✅ 5. Employees Salary Above Average

Uses Common Table Expression (CTE).

✅ 6. Extract Year & Month

Uses YEAR() and MONTH() functions.

✅ 7. Date Difference

Uses DATEDIFF() function.

✅ 8. Running Total

Uses window function:

SUM() OVER (PARTITION BY CustomerID ORDER BY OrderDate)
✅ 9. Rank Orders

Uses:

DENSE_RANK() OVER (ORDER BY TotalAmount DESC)
✅ 10. Discount Calculation

Uses CASE statement for conditional discount logic.

✅ 11. Employee Salary Category

Categorizes employees as:

High

Medium

Low

🧠 Concepts Covered

Database Creation

Primary & Foreign Keys

Joins (INNER, LEFT, FULL OUTER)

Subqueries

Aggregate Functions

Window Functions

CTE (Common Table Expressions)

CASE Statements

Date Functions

String Functions
