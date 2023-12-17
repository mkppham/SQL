IF EXISTS (SELECT * FROM sys.databases WHERE Name LIKE 'Example')
	DROP DATABASE Example5
GO
CREATE DATABASE Example5
GO
USE Example5
GO
--DDL: CREATE, ALTER, DROP
--DML: INSERT, UPDATE, DELETE
--CTRL + /
--DATATYPE IN SQL
-- Tao Bang Lop Hoc
CREATE TABLE LopHoc(
	MaLopHoc INT PRIMARY KEY IDENTITY,
	TenLopHoc VARCHAR(10)
)
GO
SELECT * FROM LopHoc
GO
INSERT INTO LopHoc(TenLopHoc) VALUES ('T2009M')
SELECT * FROM LopHoc
UPDATE LopHoc SET TenLopHoc = 'T2209M'
 WHERE MaLopHoc = 1002
DELETE FROM LopHoc WHERE MaLopHoc = 1002
GO
--San Pham(masp, tensp, gia, loai)

--Tao Bang Sinh Vien Co Khoa Ngoai La Cot MaLopHoc, Noi Voi Bang LopHoc
--composite primary key
DROP TABLE SinhVien
CREATE TABLE SinhVien(
	MaSV int PRIMARY KEY,
	TenSV nvarchar(250),
	ClassCode int,
	CONSTRAINT fk FOREIGN KEY (ClassCode) REFERENCES LopHoc(MaLopHoc)
	)
	GO
	INSERT INTO SinhVien(MaSV, TenSV, ClassCode) VALUES (1,'Kien', 1);
	INSERT INTO SinhVien(MaSV, TenSV, ClassCode) VALUES (3,'Kim', 1004);
	INSERT INTO SinhVien(MaSV, TenSV, ClassCode) VALUES (14,'Pham',1007),(16,'Dead',1006);
	SELECT * FROM SinhVien
	SELECT * FROM LopHoc
	GO
