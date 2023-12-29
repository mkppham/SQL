CREATE DATABASE EmployeeDB
GO

USE EmployeeDB 
GO

CREATE TABLE Department(
	Departld INT PRIMARY KEY,
	DepartName VARCHAR(50) NOT NULL,
	Description VARCHAR(100) NOT NULL
);

INSERT INTO Department VALUES ('1', 'DepartName 1', 'Description 1');
INSERT INTO Department VALUES ('2', 'DepartName 2', 'Description 2');
INSERT INTO Department VALUES ('3', 'DepartName 3', 'Description 3');

DROP TABLE Department

CREATE TABLE Employee(
	EmpCode CHAR(6) PRIMARY KEY,
	FirstName VARCHAR(30) NOT NULL,
	LastName VARCHAR(30) NOT NULL,
	Birthday SMALLDATETIME NOT NULL,
	Gender Bit DEFAULT 1,
	Address VARCHAR(100),
	DepartID INT,
	Salary MONEY,
	FOREIGN KEY (DepartID) REFERENCES Department(DepartID) 
);

INSERT INTO Employee VALUES ('1', 'FirstName 1', 'Last Name 1', '2005-08-03', '1', 'Address 1', '1', '200');
INSERT INTO Employee VALUES ('2', 'FirstName 2', 'Last Name 2', '2005-01-02', '2', 'Address 2', '2', '500');
INSERT INTO Employee VALUES ('3', 'FirstName 3', 'Last Name 3', '2000-18-12', '3', 'Address 3', '3', '300');

DROP TABLE Employee

--4
Update Employee
SET Salary = Salary * 1.1 SELECT * FROM Employee

--5
ALTER TABLE Employee
ADD CONSTRAINT CheckSalary Check (Salary > 0)