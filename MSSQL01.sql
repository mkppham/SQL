USE MSSQL01;

SELECT * FROM KhachHang;
SELECT * FROM SanPham;
SELECT * FROM DonHang;
SELECT * FROM ThongTinDonHang;

--Tạo bảng khách hàng
CREATE TABLE KhachHang (
	IDKhachHang INT PRIMARY KEY,
	TenKhachHang NVARCHAR(50),
	DiaChi NVARCHAR(50),
	SDT VARCHAR(12)
);

INSERT INTO KhachHang VALUES (1, 'Nguyễn Văn An', '111 Nguyễn Trãi, Thanh Xuân, Hà Nội', 987654321);
INSERT INTO KhachHang VALUES (2, 'Nguyễn Anh Dũng', '12 Phú Lương, Đông Hưng, Thái Bình', 973749843);
INSERT INTO KhachHang VALUES (3, 'Vũ Hay Ho', '11 Thượng Thanh, Long Biên, Hà Nội', 9072576321);

--Tạo bảng SanPham
CREATE TABLE SanPham (
	IDSanPham INT PRIMARY KEY,
	TenSP NVARCHAR(100),
	MieuTa NVARCHAR (100),
	Donvi NVARCHAR (100),
	Gia INT,
	SoLuong INT
);

INSERT INTO SanPham VALUES (1, 'Máy Tính T450', 'Máy nhập mới', 'chiếc', 1000, 20);
INSERT INTO SanPham VALUES (2, 'Điện Thoại Nokia 5670', 'Điện thoại đang hot', 'chiếc', 200, 10);
INSERT INTO SanPham VALUES (3, 'Máy In Samsung 450', 'Máy in đang ế', 'chiếc', 100, 15);
INSERT INTO SanPham VALUES (4, 'RogPhone 5', 'GamingPhone', 'chiếc', 500, 27);
INSERT INTO SanPham VALUES (5, 'Card RTX4090', 'Card màn hình mới nhất từ NIVIDIA', 'chiếc', 300, 10);

DROP TABLE DonHang;

--Tạo bảng đơn hàng
CREATE TABLE DonHang (
	IDDonHang INT PRIMARY KEY,
	IDKhachHang INT,
	NgayDatHang DATE
	FOREIGN KEY (IDKhachHang) REFERENCES KhachHang (IDKhachHang)
);

INSERT INTO DonHang VALUES (1, 2, '12-12-07');
INSERT INTO DonHang VALUES (14, 3, '1-12-09');
INSERT INTO DonHang VALUES (12, 1, '12-11-25');

--Tạo bảng ChiTietDonHang
CREATE TABLE ChiTietDonHang (
	IDDonHang INT,
	IDSanPham INT,
	Gia INT,
	SoLuong INT,
	PRIMARY KEY (IDDonHang, IDSanPham),
	FOREIGN KEY (IDDonHang) REFERENCES DonHang (IDDonHang),
	FOREIGN KEY (IDSanPham) REFERENCES SanPham (IDSanPham)
);

INSERT INTO ChiTietDonHang VALUES (1, 1, 1000, 20);
INSERT INTO ChiTietDonHang VALUES (14, 2, 200, 10);
INSERT INTO ChiTietDonHang VALUES (12, 3, 100, 15);

--4a

SELECT * FROM KhachHang
WHERE IDKhachHang IN (SELECT IDKhachHang FROM DonHang);

--4b

SELECT IDSanPham, TenSP
FROM SanPham;

--4c

SELECT * FROM DonHang;

--5a

SELECT * FROM KhachHang ORDER BY TenKhachHang;

--5b

SELECT * FROM SanPham ORDER BY Gia DESC;

--5c

SELECT * FROM SanPham
WHERE IDSanPham IN (
	SELECT IDSanPham
	FROM ChiTietDonHang
	WHERE IDDonHang IN (
		SELECT IDDonHang
		FROM DonHang
		WHERE IDKhachHang = 3
	)
);

--6a

SELECT DISTINCT COUNT(IDKhachHang) FROM DonHang;

--6b

SELECT DISTINCT COUNT(IDSanPham) FROM SanPham;

--6c

SELECT IDDonHang, SUM(Gia) AS TongTienDonHang
FROM ChiTietDonHang
GROUP BY IDDonHang;