USE MSQL Lab12
GO

--Tạo bảng Employyee
CREATE TABLE Employee (
	EmployeeID INT PRIMARY KEY,
	Name VARCHAR(100) NOT NULL,
	Tel CHAR(11),
	Email VARCHAR(30)
);
GO

INSERT INTO Employee (EmployeeID, Name, Tel, Email)
VALUES (1, 'Pham Van A', '0981516778', 'PVA@gmail.com');

SELECT * FROM Employee;
Go

DROP TABLE Employee

--Tạo bảng Group
CREATE TABLE Groups (
    GroupID int PRIMARY KEY,
    GroupName varchar(30),
    LeaderID int,
    ProjectID int,
    FOREIGN KEY (LeaderID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);
GO

--Tạo bảng Project
CREATE TABLE Project (
    ProjectID int PRIMARY KEY,
    ProjectName varchar(30),
    StartDate datetime,
    EndDate datetime,
    Period int,
    Cost money
);
GO

--Tạo bảng GroupDetail
CREATE TABLE GroupDetail (
    GroupID int,
    EmployeeID int,
    Status char(20),
    PRIMARY KEY (GroupID, EmployeeID),
    FOREIGN KEY (GroupID) REFERENCES Groups(GroupID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);