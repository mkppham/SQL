USE MSQL Lab12
GO

--Tạo bảng Employyee
CREATE TABLE Employee (
	EmployeeID INT PRIMARY KEY,
	Name VARCHAR(90) NOT NULL,
	Tel CHAR(11),
	Email VARCHAR(90)
);
GO

INSERT INTO Employee VALUES (1, 'Pham Van A', '0981516778', 'PVA@gmail.com');
INSERT INTO Employee VALUES (2, 'Pham Van B', '0981516768', 'NAD@gmail.com');
INSERT INTO Employee VALUES (3, 'Pham Van C', '0971516778', 'DDT@gmail.com');
INSERT INTO Employee VALUES (4, 'Pham Van D', '0981526778', 'CVA@gmail.com');


DROP TABLE Employee

--Tạo bảng Group
CREATE TABLE Groups (
    GroupID int PRIMARY KEY,
    GroupName varchar(40),
    LeaderID int,
    ProjectID int,
    FOREIGN KEY (LeaderID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);
GO

INSERT INTO Groups VALUES ('1', 'Group 1', '1', '01')
INSERT INTO Groups VALUES ('2', 'Group 2', '2', '02')
INSERT INTO Groups VALUES ('3', 'Group 3', '3', '03')
INSERT INTO Groups VALUES ('4', 'Group 4', '4', '04')

--Tạo bảng Project
CREATE TABLE Project (
    ProjectID int PRIMARY KEY,
    ProjectName varchar(90),
    StartDate datetime,
    EndDate datetime,
    Period int,
    Cost money
);
GO

INSERT INTO Project VALUES ('01', 'Project 1', '2023-10-28', '2023-12-28', '2', '100')
INSERT INTO Project VALUES ('02', 'Project 2', '2023-05-04', '2023-05-21', '3', '600')
INSERT INTO Project VALUES ('03', 'Project 3', '2023-07-24', '2023-10-30', '1', '1000')
INSERT INTO Project VALUES ('04', 'Project 4', '2023-01-14', '2023-03-12', '4', '300')
INSERT INTO Project VALUES ('05', 'Chính phủ điện tử', '2023-02-02', '2023-03-21', '3', '9000')

--Tạo bảng GroupDetail
CREATE TABLE GroupDetail (
    GroupID int,
    EmployeeID int,
    Status CHAR(60),
    PRIMARY KEY (GroupID, EmployeeID),
    FOREIGN KEY (GroupID) REFERENCES Groups(GroupID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);
GO

INSERT INTO GroupDetail VALUES ('1', '03', 'Finish')
INSERT INTO GroupDetail VALUES ('2', '07', 'unfinished')
INSERT INTO GroupDetail VALUES ('3', '02', 'in process')

--(3a)    Xem bảng 
SELECT * FROM Employee
SELECT * FROM Project
SELECT * FROM Groups
SELECT * FROM GroupDetail


--3b
SELECT Employee.* FROM Employee
JOIN GroupDetail ON Employee.EmployeeID = GroupDetail.EmployeeID
JOIN Groups ON GroupDetail.GroupID = Groups.GroupID
JOIN Project ON Groups.ProjectID = Project.ProjectID
WHERE Project.ProjectName = 'Chính phủ điện tử'

--3c
SELECT Groups.GroupID, Groups.GroupName, Count(GroupDetail.EmployeeID) AS So_luong_nhan_vien_lam_viec_moi_nhom
FROM Groups
JOIN GroupDetail ON Groups.GroupID = GroupDetail.GroupID
GROUP BY Groups.GroupID, Groups.GroupName;

--3d 
SELECT Employee.* FROM Employee
JOIN Groups ON Employee.EmployeeID = Groups.LeaderID

--3e
SELECT G.GroupID,G.GroupName,GD.EmployeeID,E.Name,P.ProjectID,P.ProjectName,P.StartDate
FROM Groups G
JOIN
	GroupDetail GD ON G.GroupID = GD.GroupID
JOIN 
	Employee E ON GD.EmployeeID = E.EmployeeID
JOIN 
	Project P ON G.ProjectID = P.ProjectID

WHERE StartDate < '2010-10-20'

--3g
SELECT Employee.*, Groups.*, Project.*  FROM Employee 
JOIN GroupDetail ON Employee.EmployeeID = GroupDetail.EmployeeID
JOIN Groups ON GroupDetail.GroupID = Groups.GroupID
JOIN Project ON Groups.ProjectID = Project.ProjectID
WHERE GroupDetail.Status = 'Finish';

--3f
SELECT * FROM Employee E
LEFT JOIN GroupDetail GD ON E.EmployeeID = GD.EmployeeID
WHERE GD.EmployeeID IS NULL

--4a
ALTER TABLE Employee
ALTER COLUMN Name VARCHAR(100) NOT NULL;


--4b
SELECT * FROM Project
WHERE Cost > 1000