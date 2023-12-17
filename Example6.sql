USE AdventureWorks2022
GO 

--Lấy ra dữ liệu của bảng Contact có ContactID >= 100 và ContactID <= 200
SELECT * 
FROM Person.Person
WHERE BusinessEntityID >= 100 AND BusinessEntityID <= 200

--Lấy ra dữ liệu của bảng Contact có ContactID trong khoảng [100, 200]
SELECT * FROM Person.Person
WHERE BusinessEntityID BETWEEN 100 AND 200

SELECT *
FROM Person.Person
WHERE BusinessEntityID BETWEEN 10 AND 20

--Lấy ra dữ liệu của bảng Contact có ContactID trong tập hợp (100, 107, 200)
SELECT * FROM Person.Person
WHERE BusinessEntityID IN (100, 107, 200, 2210)

SELECT *
FROM Person.Person
WHERE MiddleName IN ('B','M','T')

--Lấy ra những Contact có LastName kết thúc bởi ký tự e (WILDCARD LIKE SQL Microsoft)
SELECT * FROM Person.Person
WHERE LastName LIKE '%e'
--Lấy ra những Contact có LastName bắt đầu bởi ký tự R hoặc A kết thúc bởi ký tự e
SELECT * FROM Person.Person
WHERE LastName LIKE '[RA]%e'
--Lấy ra những Contact có 4 ký tự bắt đầu bởi ký tự R hoặc A kết thúc bởi ký tự e
SELECT * FROM Person.Person
WHERE LastName LIKE '[RA]__e'

--Sử dụng DISTINCT các dữ liệu trùng lặp bị loại bỏ
SELECT DISTINCT Title FROM Person.Person

--Sử dụng GROUP BY các dữ liệu trùng lặp được gộp thành một nhóm 
-- aggregate function : sum, max, min, count, avg ..
SELECT Count(BusinessEntityID) as TotalID, Title
FROM Person.Person
GROUP BY Title

--do đó ta có thể sử dụng được các hàm tập hợp 
SELECT Title, Count(*) [Title Number]
FROM Person.Person
GROUP BY Title

SELECT * FROM Sales.SalesPerson
SELECT * FROM Person.Person

SELECT * FROM Person.Person
WHERE BusinessEntityID IN (1,4,99)

SELECT * FROM Person.Person
WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM Sales.SalesPerson)


SELECT * FROM Person.Person INNER JOIN Sales.SalesPerson
ON Person.BusinessEntityID = SalesPerson.BusinessEntityID

SELECT * FROM Person.Person LEFT OUTER JOIN Sales.SalesPerson
ON Person.BusinessEntityID = SalesPerson.BusinessEntityID

SELECT * FROM Person.Person RIGHT OUTER JOIN Sales.SalesPerson
ON Person.BusinessEntityID = SalesPerson.BusinessEntityID
--Ta có thể sử dụng mệnh đề WHERE để thỏa mãn điều kiện tìm kiếm 
SELECT Title, COUNT(*)
FROM Person.Person
GROUP BY Title

SELECT Count(BusinessEntityID) AS CountBUS, Title
FROM Person.Person
WHERE EmailPromotion IN (1,2)
GROUP BY Title
HAVING COUNT(BusinessEntityID) > 100

SELECT * FROM Person.Person

--GROUP BY với ALL sẽ lấy ra các hàng bị loại bởi mệnh đề WHERE 
--( Vì mệnh đề WHERE sẽ lọc kết quả sau khi được gộp nhóm )
SELECT Title, COUNT(*) [Title Number]
FROM Person.Person
WHERE Title LIKE 'Mr%'
GROUP BY Title

SELECT * FROM Person.Person

--GROUP BY với HAVING: mệnh đề HAVING sẽ lọc kết quả trong lúc được gộp nhóm 
SELECT Title,COUNT(*) [Title Number]
FROM Person.Person
GROUP BY ALL Title
HAVING Title LIKE 'Mr%'

SELECT Title, COUNT(*) [Title Number]
FROM Person.Person
-- WHERE COUNT(*) > 10 
GROUP BY ALL Title
HAVING Title LIKE 'Mr%' OR COUNT(*) > 10

--GROUP BY với CUBE: Sẽ có thêm các hàng siêu kết hợp gộp tất cả các hàng trong tập trả về 
SELECT Title, COUNT(*) [Title Number]
FROM Person.Person
GROUP BY Title WITH CUBE

--GROUP BY với CUBE: Sẽ có thêm các hàng siêu kết hợp gộp tất cả các hàng trong tập trả về 
SELECT Title, COUNT(*) [Title Number]
FROM Person.Person
GROUP BY Title WITH ROLLUP

--ORDER BY dùng để sắp sếp kết quả trả về
SELECT * FROM Person.Person 
ORDER BY FirstName, LastName DESC

/* 
	Truy vấn từ nhiều bảng
	Lấy toàn bộ Contact của nhân viên (HumanResources.Employee)
*/
--Truy vấn con 
SELECT * FROM Person.Person
WHERE BusinessEntityID in (
	SELECT BusinessEntityID
	FROM HumanResources.Employee)
SELECT * FROM HumanResources.Employee
-- SubQuery MSDN (docs microsof sql)
-- Truy vấn quan hệ sử dụng EXIST 
SELECT * FROM Person.Person P
WHERE EXISTS (
		SELECT BusinessEntityID
		FROM HumanResources.Employee
		WHERE BusinessEntityID=P.BusinessEntityID)

--Kết hợp dữ liệu sử dụng UNION
SELECT BusinessEntityID, FirstName
FROM Person.Person
WHERE BusinessEntityID IN (1,2,3,4,5,6)
UNION
SELECT BusinessEntityID, FirstName
FROM Person.Person
WHERE BusinessEntityID IN (1,3,5,7) AND FirstName LIKE '%A%'

--UNION với ALL không loại bỏ giá trị trùng lặp 
SELECT BusinessEntityID, FirstName
FROM Person.Person
WHERE BusinessEntityID IN (1,2,3,4,5,6)
UNION ALL 
SELECT BusinessEntityID, FirstName
FROM Person.Person
WHERE BusinessEntityID IN (1,3,5,7)

--Sử dụng INNER JOIN 
SELECT Person.Person.*, E.*
FROM Person.Person P INNER JOIN HumanResources.Employee E ON
	P.BusinessEntityID=E.BusinessEntityID

SELECT * FROM Person.Person
SELECT * FROM Person.PersonPhone
SELECT Per.BusinessEntityID, Per.FirstName, Phone.PhoneNumber
	FROM Person.Person Per
INNER JOIN Person.PersonPhone Phone ON 
 Per.BusinessEntityID = Phone.BusinessEntityID

-- SELECT * FROM
 SELECT Per.BusinessEntityID, Per.FirstName, Phone.PhoneNumber
 FROM Person.Person Per
RIGHT OUTER JOIN Person.PersonPhone Phone ON 
 Per.BusinessEntityID = Phone.BusinessEntityID

 SELECT Per.BusinessEntityID, Per.FirstName, Phone.PhoneNumber
 FROM Person.Person Per
 RIGHT OUTER JOIN Person.PersonPhone Phone ON
 Per.BusinessEntityID = Phone.BusinessEntityID

 --Sử dụng OUTER JOIN 
 SELECT Person.Person.*
 FROM Person.Person LEFT OUTER JOIN HumanResources.Employee ON 
    Person.Person.BusinessEntityID=HumanResources.Employee.BusinessEntityID

--Làm rõ kết quả trả về với AS
SELECT C.*
FROM Person.Person AS C LEFT OUTER JOIN HumanResources.Employee AS E ON 
    C.BusinessEntityID= E.BusinessEntityID