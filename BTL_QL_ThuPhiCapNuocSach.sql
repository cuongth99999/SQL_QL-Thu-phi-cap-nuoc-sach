-- Tạo Database
CREATE DATABASE BTL_QL_ThuPhiCapNuocSach
USE BTL_QL_ThuPhiCapNuocSach
GO

-- Tạo bảng tblPhongBan
CREATE TABLE tblPhongBan
(
	sMaPB varchar(20) NOT NULL PRIMARY KEY,
	sTenPB nvarchar(50),
	sKhuVuc nvarchar(30)
	fTongSoNV float
)

-- Tạo bảng tblNhanVien
CREATE TABLE tblNhanVien
(
	sMaNV varchar(20) NOT NULL PRIMARY KEY,
	sMaPB varchar(20) NOT NULL,
	sHoTen nvarchar(50) NOT NULL,
	sSDT varchar(10),
	sDiaChi nvarchar(50),
	sGioiTinh nvarchar(3),
	fHSL float,
	fPhuCap float,
	dNgaySinh Date,
	dNgayVaoLam Date,
)

-- Tạo bảng tblKhachHang
CREATE TABLE tblKhachHang
(
	sMaKH varchar(20) NOT NULL PRIMARY KEY,
	sHoTen nvarchar(50) NOT NULL,
	sSDT varchar(10),
	sDiaChi nvarchar(50),
	sDoiTuong nvarchar(20)
)

-- Tạo bảng tblTuyenDuong
CREATE TABLE tblTuyenDuong
(
	sMaTuyenDuong varchar(20) NOT NULL PRIMARY KEY,
	fDoDaiOng float,
	fKhoiLuongCC float,
	sMaPB varchar(20) NOT NULL
)

-- Tạo bảng tblHoaDon
CREATE TABLE tblHoaDon
(
	iMaHD int NOT NULL PRIMARY KEY,
	sMaNV varchar(20) NOT NULL,
	sMaKH varchar(20) NOT NULL,
	sMaTuyenDuong varchar(20) NOT NULL,
	iThangThu int,
	iNamThu int,
	dNgayNopTien date,
	sHinhThucThanhToan nvarchar(25)
)

-- Tạo bảng tblChiTietHoaDon
CREATE TABLE tblChiTietHoaDon
(
	iMaHD int NOT NULL,
	fChiSoDau float,
	fChiSoCuoi float,
	fLuongTieuThu float DEFAULT 0,
	fDonGia float,
	fThanhTien float DEFAULT 0
)

-- Tạo ràng buộc Foreign Key
ALTER TABLE tblNhanVien ADD CONSTRAINT FK_PhongBan_NhanVien FOREIGN KEY (sMaPB)
REFERENCES tblPhongBan (sMaPB)

ALTER TABLE tblTuyenDuong ADD CONSTRAINT FK_PhongBan_TuyenDuong FOREIGN KEY (sMaPB)
REFERENCES tblPhongBan (sMaPB)

ALTER TABLE tblHoaDon ADD CONSTRAINT FK_NhanVien_HoaDon FOREIGN KEY (sMaNV)
REFERENCES tblNhanVien (sMaNV)

ALTER TABLE tblHoaDon ADD CONSTRAINT FK_KhachHang_HoaDon FOREIGN KEY (sMaKH)
REFERENCES tblKhachHang (sMaKH)

ALTER TABLE tblHoaDon ADD CONSTRAINT FK_TuyenDuong_HoaDon FOREIGN KEY (sMaTuyenDuong)
REFERENCES tblTuyenDuong (sMaTuyenDuong)

ALTER TABLE tblChiTietHoaDon ADD CONSTRAINT FK_HoaDon_ChiTietHoaDon FOREIGN KEY (iMaHD)
REFERENCES tblHoaDon (iMaHD)

-- Tạo ràng buộc Primary Key
ALTER TABLE tblChiTietHoaDon ADD CONSTRAINT PK_iMaHD PRIMARY KEY (iMaHD);

-- Tạo ràng buộc Check
ALTER TABLE tblNhanVien ADD CONSTRAINT CK_NgayVaoLam CHECK (DATEDIFF(DAY, dNgaySinh, dNgayVaoLam)/365 >=18);

ALTER TABLE tblKhachHang ADD CONSTRAINT CK_DoiTuong CHECK (sDoiTuong IN (N'Hộ dân', N'Hộ kinh doanh', N'Hộ sản xuất'));
GO

-- Chèn dữ liệu cho các bảng
INSERT INTO tblPhongBan (sMaPB, sTenPB, sKhuVuc)
VALUES  ('PB01', N'Phòng ban 1',  'KV1'),
		('PB02', N'Phòng ban 2',  'KV2'),
		('PB03', N'Phòng ban 3',  'KV3'),
		('PB04', N'Phòng ban 4',  'KV4'),
		('PB05', N'Phòng ban 5',  'KV5');
GO

INSERT INTO tblTuyenDuong(sMaTuyenDuong, fDoDaiOng, fKhoiLuongCC, sMaPB)
VALUES  ('TD01', 3,  700, 'PB01'),
		('TD02', 2,  600, 'PB02'),
		('TD03', 3,  750, 'PB03'),
		('TD04', 4,  850, 'PB04'),
		('TD05', 5,  900, 'PB05');
GO

INSERT INTO tblNhanVien (sMaNV, sMaPB, sHoTen, sSDT,  sDiaChi, sGioiTinh, fHSL, fPhuCap, dNgaySinh, dNgayVaoLam)
VALUES  ('NV01', 'PB01', N'Tạ Hữu Cường', '0866466298', N'Hà Nội', N'Nam', 100, 20, '03/04/2003', '03/04/2022')		
GO
INSERT INTO tblNhanVien (sMaNV, sMaPB, sHoTen, sSDT,  sDiaChi, sGioiTinh, fHSL, fPhuCap, dNgaySinh, dNgayVaoLam)
VALUES ('NV02', 'PB02', N'Nguyễn Văn Dũng', '0963356534', N'Hà Nội', N'Nam', 100, 20, '11/11/2003', '12/05/2021')
GO
INSERT INTO tblNhanVien (sMaNV, sMaPB, sHoTen, sSDT,  sDiaChi, sGioiTinh, fHSL, fPhuCap, dNgaySinh, dNgayVaoLam)
VALUES ('NV03', 'PB03', N'Nguyễn Thị Loan', '0397935715', N'Hải Phòng', N'Nữ', 100, 10, '06/14/2002', '10/06/2022')
GO
INSERT INTO tblNhanVien (sMaNV, sMaPB, sHoTen, sSDT,  sDiaChi, sGioiTinh, fHSL, fPhuCap, dNgaySinh, dNgayVaoLam)
VALUES ('NV04', 'PB04', N'Trần Văn Quân', '0984587261', N'Bắc Ninh', N'Nam', 100, 20, '05/11/2001', '09/08/2022')
GO
INSERT INTO tblNhanVien (sMaNV, sMaPB, sHoTen, sSDT,  sDiaChi, sGioiTinh, fHSL, fPhuCap, dNgaySinh, dNgayVaoLam)
VALUES ('NV05', 'PB05', N'Nguyễn Văn Hảo', '0586987564', N'Hải Dương', N'Nam', 100, 20, '10/05/2001', '10/06/2022')
GO
INSERT INTO tblNhanVien (sMaNV, sMaPB, sHoTen, sSDT,  sDiaChi, sGioiTinh, fHSL, fPhuCap, dNgaySinh, dNgayVaoLam)
VALUES ('NV06', 'PB01', N'Phí Thị Oanh', '0866458213', N'Bắc Giang', N'Nữ', 100, 20, '01/05/2002', '06/09/2021')
GO
INSERT INTO tblNhanVien (sMaNV, sMaPB, sHoTen, sSDT,  sDiaChi, sGioiTinh, fHSL, fPhuCap, dNgaySinh, dNgayVaoLam)
VALUES ('NV07', 'PB01', N'Nguyễn Thị Dịu', '0758689556', N'Bắc Ninh', N'Nữ', 100, 10, '01/12/2002', '06/09/2022')
GO
INSERT INTO tblNhanVien (sMaNV, sMaPB, sHoTen, sSDT,  sDiaChi, sGioiTinh, fHSL, fPhuCap, dNgaySinh, dNgayVaoLam)
VALUES ('NV08', 'PB02', N'Đinh Văn Nghĩa', '0963578691', N'Phú Thọ', N'Nam', 100, 10, '11/09/2002', '08/07/2021')
GO
INSERT INTO tblNhanVien (sMaNV, sMaPB, sHoTen, sSDT,  sDiaChi, sGioiTinh, fHSL, fPhuCap, dNgaySinh, dNgayVaoLam)
VALUES ('NV09', 'PB03', N'Nguyễn Văn Đại', '0986734584', N'TP HCM', N'Nam', 100, 20, '05/05/2000', '01/09/2021')
GO
INSERT INTO tblNhanVien (sMaNV, sMaPB, sHoTen, sSDT,  sDiaChi, sGioiTinh, fHSL, fPhuCap, dNgaySinh, dNgayVaoLam)
VALUES ('NV10', 'PB04', N'Mua Thị Dua', '0587566876', N'Lào Cai', N'Nữ', 100, 20, '12/09/2002', '10/10/2021')

INSERT INTO tblKhachHang (sMaKH, sHoTen, sSDT, sDiaChi, sDoiTuong)
VALUES  ('KH01', N'Trần Quốc Nam', '0958796432', N'Hoài Đức', N'Hộ dân'),
		('KH02', N'Nguyễn Thị Thắm', '0865462151', N'Hoàng Mai', N'Hộ dân'),
		('KH03', N'Tạ Huy Hoàng', '0964751351', N'Thanh Xuân', N'Hộ kinh doanh'),
		('KH04', N'Vũ Anh Tuấn', '0385671985', N'Hà Đông', N'Hộ sản xuất'),
		('KH05', N'Nguyễn Văn Hảo', '0125763859', N'Cầu Giấy', N'Hộ kinh doanh'),
		('KH06', N'Hoàng Huy Quang', '0987563657', N'Long Biên', N'Hộ sản xuất'),
		('KH07', N'Trần Thái Ninh', '0865845369', N'Hoài Đức', N'Hộ dân'),
		('KH08', N'Nguyễn Hữu Nam', '0356987589', N'Tây Hồ', N'Hộ kinh doanh'),
		('KH09', N'Tạ Quang Hiếu', '0963588456', N'Đội Cân', N'Hộ dân'),
		('KH10', N'Nguyễn Văn Lợi', '0587599548', N'Đống Đa', N'Hộ sản xuất');
GO

INSERT INTO tblHoaDon (iMaHD, sMaNV, sMaKH,  sMaTuyenDuong,  iThangThu, iNamThu, dNgayNopTien, sHinhThucThanhToan)
VALUES  (1, 'NV01', 'KH01', 'TD01', 1, 2022, '02/01/2022', N'Thanh toán tiền mặt'),
		(2, 'NV02', 'KH02', 'TD02', 2, 2022, '03/01/2022', N'Thanh toán chuyển khoản'),
		(3, 'NV03', 'KH03', 'TD03', 3, 2022, '04/01/2022', N'Thanh toán tiền mặt'),
		(4, 'NV04', 'KH04', 'TD04', 4, 2022, '05/01/2022', N'Thanh toán chuyển khoản'),
		(5, 'NV05', 'KH05', 'TD05', 5, 2022, '06/01/2022', N'Thanh toán tiền mặt'),
		(6, 'NV06', 'KH06', 'TD01', 6, 2022, '07/01/2022', N'Thanh toán chuyển khoản'),
		(7, 'NV01', 'KH01', 'TD01', 2, 2022, '03/01/2022', N'Thanh toán chuyển khoản');
GO

INSERT INTO tblHoaDon (iMaHD, sMaNV, sMaKH,  sMaTuyenDuong,  iThangThu, iNamThu, dNgayNopTien, sHinhThucThanhToan)
VALUES  (8, 'NV01', 'KH01', 'TD01', 3, 2022, '04/01/2022', N'Thanh toán tiền mặt') 

INSERT INTO tblChiTietHoaDon (iMaHD, fChiSoDau, fChiSoCuoi)
VALUES	(1, 100, 156)
GO
INSERT INTO tblChiTietHoaDon (iMaHD, fChiSoDau, fChiSoCuoi)
VALUES	(2, 123, 186)
GO
INSERT INTO tblChiTietHoaDon (iMaHD, fChiSoDau, fChiSoCuoi)
VALUES	(3, 150, 255)
GO
INSERT INTO tblChiTietHoaDon (iMaHD, fChiSoDau, fChiSoCuoi)
VALUES	(4, 251, 356)
GO
INSERT INTO tblChiTietHoaDon (iMaHD, fChiSoDau, fChiSoCuoi)
VALUES	(5, 189, 310)
GO
INSERT INTO tblChiTietHoaDon (iMaHD, fChiSoDau, fChiSoCuoi)
VALUES	(6, 210, 330)
GO
INSERT INTO tblChiTietHoaDon (iMaHD, fChiSoDau, fChiSoCuoi)
VALUES	(7, 157, 235)
		

GO

UPDATE tblChiTietHoaDon SET fLuongTieuThu = fChiSoCuoi - fChiSoDau
UPDATE tblChiTietHoaDon SET fThanhTien = fLuongTieuThu * fDonGia
GO

--Trigger
-- 1. Tạo trigger để khi nhập 1 thông tin nhân viên ở bảng tblNhanVien thì tổng số
-- NV ở bảng phòng ban của phòng ban chưa nhân viên đó tăng lên 1 
CREATE TRIGGER trg_TangTS_NV 
ON tblNhanVien
AFTER INSERT
AS
DECLARE @sMaPB varchar(20)
SELECT @sMaPB = sMaPB FROM inserted
UPDATE tblPhongBan
SET fTongSoNV +=1
WHERE sMaPB = @sMaPB

-- 2. Tạo trigger để khi xóa 1 ở bảng tblNhanVien thì tổng số
-- NV ở bảng phòng ban của phòng ban chưa nhân viên đó giảm 1 
CREATE TRIGGER trg_GiamTS_NV 
ON tblNhanVien
AFTER DELETE
AS
DECLARE @sMaPB varchar(20)
SELECT @sMaPB = sMaPB FROM deleted
UPDATE tblPhongBan
SET fTongSoNV -=1
WHERE sMaPB = @sMaPB

-- 3. Tạo trigger để khi nhập 1 bản ghi ở bảng tblChiTietHoaDon thì chỉ số đầu phải nhỏ hơn chỉ số cuối
CREATE TRIGGER trg_Dau_nho_hon_Cuoi
ON tblChiTietHoaDon
AFTER INSERT
AS
DECLARE @fChiSoDau float, @fChiSoCuoi float
SELECT @fChiSoDau = fChiSoDau, @fChiSoCuoi = fChiSoCuoi FROM inserted
IF(@fChiSoCuoi < @fChiSoDau)
	BEGIN
		PRINT N'Chỉ số đầu phải lớn hơn chỉ số cuối'
		ROLLBACK
	END

-- 4. Tạo trigger khi tạo 1 bản ghi ở bảng tblChiTietHoaDon sẽ kiểm tra đối tượng khách 
-- hàng và đưa ra đơn giá đã quy định(dân:10k, kinh doanh: 15k, sản xuất 18k)
CREATE TRIGGER trg_DonGia_DoiTuong
ON tblChiTietHoaDon
AFTER INSERT
AS
DECLARE @iMaHD int, @sMaKH varchar(20), @sDoiTuong nvarchar(20)
SELECT @iMaHD = iMaHD FROM inserted
SELECT @sMaKH = sMaKH FROM tblHoaDon WHERE @iMaHD = iMaHD
SELECT @sDoiTuong = sDoiTuong FROM tblKhachHang WHERE @sMaKH = sMaKH
IF(@sDoiTuong = N'Hộ dân')
	BEGIN
		UPDATE tblChiTietHoaDon
		SET fDonGia = 10000
		WHERE iMaHD = @iMaHD
	END
IF(@sDoiTuong = N'Hộ kinh doanh')
	BEGIN
		UPDATE tblChiTietHoaDon
		SET fDonGia = 15000
		WHERE iMaHD = @iMaHD
	END
IF(@sDoiTuong = N'Hộ sản xuất')
	BEGIN
		UPDATE tblChiTietHoaDon
		SET fDonGia = 18000
		WHERE iMaHD = @iMaHD
	END

-- 5. Tạo trigger tính lượng tiêu thụ bằng chỉ số cuối – chỉ số đầu
CREATE TRIGGER trg_LuongTieuThu
ON tblChiTietHoaDon
AFTER INSERT
AS
DECLARE @iMaHD int
SELECT @iMaHD = iMaHD FROM inserted
UPDATE tblChiTietHoaDon
SET fLuongTieuThu = fChiSoCuoi - fChiSoDau
WHERE iMaHD = @iMaHD

-- 6. Tạo trigger tính thành tiền(=Lượng tiêu thụ * đơn giá)
CREATE TRIGGER trg_ThanhTien
ON tblChiTietHoaDon
AFTER INSERT
AS
DECLARE @iMaHD int
SELECT @iMaHD = iMaHD FROM inserted
UPDATE tblChiTietHoaDon
SET fThanhTien = fDonGia * fLuongTieuThu
WHERE iMaHD = @iMaHD

-- 7. Tạo trigger đảm bảo mỗi khách hàng chỉ nộp phí hóa đơn nước 1 lần của 1 tháng trong năm
ALTER TRIGGER trg_KH_co_1_Thang
ON tblHoaDon
INSTEAD OF INSERT
AS
DECLARE @iThangThu int, @iNamThu int, @sMaKH varchar(20)
SELECT @iThangThu = iThangThu, @iNamThu = iNamThu, @sMaKH = sMaKH FROM inserted
IF( @iThangThu IN (SELECT iThangThu FROM tblHoaDon WHERE sMaKH = @sMaKH AND iNamThu = @iNamThu))
	BEGIN
		PRINT N'Khách hàng đã nộp tiền tháng này, không thể tạo hóa đơn mới'
		ROLLBACK
	END
ELSE
INSERT INTO tblHoaDon SELECT * FROM inserted

/* Truy vấn dữ liệu */
-- Truy vẫn dữ liệu từ 1 bảng:
-- 1. Lấy ra họ tên, giới tính, ngày sinh của nhân viên
SELECT sHoTen, sGioiTinh, dNgaySinh FROM tblNhanVien

-- 2. Lấy ra những nhân viên sinh năm 2002
SELECT * FROM tblNhanVien WHERE YEAR(dNgaySinh) = 2002

-- 3. Lấy ra những hóa đơn được lập trong tháng 1 năm 2022
SELECT * FROM tblHoaDon WHERE iThangThu = 1 AND iNamThu = 2022

-- 4. Đưa ra những chi tiết hóa đơn có đơn giá = 10000
SELECT * FROM tblChiTietHoaDon WHERE fDonGia = 10000

-- 5. Lấy ra những khách hàng có địa chỉ ở Hà Đông
SELECT * FROM tblKhachHang WHERE sDiaChi = N'Hà Đông'

-- Truy vẫn dữ liệu từ nhiều bảng:
-- 1. Lấy ra Tên, mã hóa đơn của những khách hàng đã có hóa đơn trong năm 2022
SELECT sHoTen, iMaHD, iNamThu AS [Năm thu] FROM tblKhachHang INNER JOIN tblHoaDon 
ON tblKhachHang.sMaKH = tblHoaDon.sMaKH WHERE iNamThu = 2022

-- 2. Lấy ra Mã khách hàng, Tên khách hàng, Hình thức thanh toán của các khách hàng
SELECT tblKhachHang.sMaKH, sHoTen, sHinhThucThanhToan FROM tblKhachHang INNER JOIN tblHoaDon
ON tblKhachHang.sMaKH = tblHoaDon.sMaKH

-- 3. Đếm số hóa đơn đã lập của từng nhân viên
SELECT tblNhanVien.sMaNV, sHoTen, COUNT(tblHoaDon.iMaHD) AS [Tổng số HĐ đã lập] FROM tblNhanVien INNER JOIN tblHoaDon
ON tblNhanVien.sMaNV = tblHoaDon.sMaNV GROUP BY tblNhanVien.sMaNV, sHoTen ORDER BY COUNT(tblHoaDon.iMaHD) DESC

-- 4. Cho biết danh sách mã hóa đơn có nhân viên lập là giới tính Nữ
SELECT tblHoaDon.iMaHD, tblNhanVien.sHoTen, tblNhanVien.sGioiTinh FROM tblHoaDon INNER JOIN tblNhanVien
ON tblHoaDon.sMaNV = tblNhanVien.sMaNV WHERE sGioiTinh = N'Nữ' 

-- 5. Cho biết Mã hóa đơn, Tên khách hàng có hóa đơn có Thành Tiền lớn nhất
SELECT TOP 1 tblHoaDon.iMaHD, tblKhachHang.sMaKH, tblKhachHang.sHoTen, MAX(tblChiTietHoaDon.fThanhTien) AS [Thanh tien]
FROM tblHoaDon INNER JOIN tblKhachHang ON tblHoaDon.sMaKH = tblKhachHang.sMaKH
INNER JOIN tblChiTietHoaDon ON tblHoaDon.iMaHD = tblChiTietHoaDon.iMaHD 
GROUP BY tblHoaDon.iMaHD, tblKhachHang.sMaKH, tblKhachHang.sHoTen ORDER BY [Thanh tien] DESC

GO

/* Xây dựng các View cho CSDL */
-- 1. Tạo view cho biết 3 khách hàng có hóa đơn thành tiền nhiều nhất
CREATE VIEW vw_Top3KH_ThanhTien_Max
AS
SELECT TOP 3 tblHoaDon.iMaHD, tblKhachHang.sMaKH, tblKhachHang.sHoTen, MAX(tblChiTietHoaDon.fThanhTien) AS [Thanh tien]
FROM tblHoaDon INNER JOIN tblKhachHang ON tblHoaDon.sMaKH = tblKhachHang.sMaKH
INNER JOIN tblChiTietHoaDon ON tblHoaDon.iMaHD = tblChiTietHoaDon.iMaHD 
GROUP BY tblHoaDon.iMaHD, tblKhachHang.sMaKH, tblKhachHang.sHoTen ORDER BY [Thanh tien] DESC

SELECT * FROM vw_Top3KH_ThanhTien_Max

-- 2. Tạo view thống kê số lượng nhân viên theo giới tính
CREATE VIEW vw_SoLuongNV_GioiTinh
AS
SELECT tblNhanVien.sGioiTinh, COUNT(tblNhanVien.sMaNV) AS [So Luong]
FROM tblNhanVien WHERE sGioiTinh = N'Nam' OR sGioiTinh = N'Nữ'
GROUP BY tblNhanVien.sGioiTinh

SELECT * FROM vw_SoLuongNV_GioiTinh

-- 3. Tạo view thống kê số lượng nhân viên theo phòng ban
CREATE VIEW vw_SoLuongNV_PhongBan
AS
SELECT tblNhanVien.sMaPB, tblPhongBan.sTenPB, COUNT(tblNhanVien.sMaNV) AS [So Luong]
FROM tblNhanVien INNER JOIN tblPhongBan ON tblNhanVien.sMaPB = tblPhongBan.sMaPB
GROUP BY tblNhanVien.sMaPB, tblPhongBan.sTenPB

SELECT * FROM vw_SoLuongNV_PhongBan

-- 4. Tạo view thống kê số lượng khách hàng theo đối tượng
CREATE VIEW vw_SoLuongKhachHang_DoiTuong
AS
SELECT sDoiTuong, COUNT(sMaKH) AS [So Luong]
FROM tblKhachHang GROUP BY sDoiTuong

SELECT * FROM vw_SoLuongKhachHang_DoiTuong

-- 5. Tạo view tính trung bình cộng thành tiền các hóa đơn của 1 khách hàng trong 1 năm (2022)
CREATE VIEW vw_TBCThanhTien_Trong1Nam
AS
SELECT tblKhachHang.sMaKH, tblKhachHang.sHoTen, AVG(tblChiTietHoaDon.fThanhTien) AS [TBC thanh tien] 
FROM tblKhachHang
INNER JOIN tblHoaDon ON tblKhachHang.sMaKH = tblHoaDon.sMaKH
INNER JOIN tblChiTietHoaDon ON tblHoaDon.iMaHD = tblChiTietHoaDon.iMaHD
WHERE tblHoaDon.iNamThu = 2022
GROUP BY tblKhachHang.sMaKH, tblKhachHang.sHoTen

SELECT * FROM vw_TBCThanhTien_Trong1Nam

-- 6. Tạo view cho biết nhân viên có tuổi cao nhất
CREATE VIEW vw_TuoiNhanVien_Max
AS
SELECT TOP 1 sMaNV, sHoTen, YEAR(GETDATE()) - YEAR(dNgaySinh) AS [Tuoi] FROM tblNhanVien
ORDER BY Tuoi DESC

SELECT * FROM vw_TuoiNhanVien_Max

-- 7. Tạo view đưa ra tên những những khách hàng, mã hóa đơn có lượng tiêu thụ lớn hơn 100
CREATE VIEW vw_TenKhachHang_LuongTieuThuLonHon100
AS
SELECT tblHoaDon.iMaHD, tblKhachHang.sHoTen, tblChiTietHoaDon.fLuongTieuThu FROM tblHoaDon
INNER JOIN tblKhachHang ON tblHoaDon.sMaKH = tblKhachHang.sMaKH
INNER JOIN tblChiTietHoaDon ON tblHoaDon.iMaHD = tblChiTietHoaDon.iMaHD
WHERE tblChiTietHoaDon.fLuongTieuThu > 100

SELECT * FROM vw_TenKhachHang_LuongTieuThuLonHon100

-- 8. Tạo view đưa ra danh sách những khách hàng chưa được lập hóa đơn
CREATE VIEW vw_KhachHang_ChuaCoHoaDon
AS
SELECT tblKhachHang.sMaKH, tblKhachHang.sHoTen FROM tblKhachHang
WHERE tblKhachHang.sMaKH NOT IN (SELECT sMaKH FROM tblHoaDon)

SELECT * FROM vw_KhachHang_ChuaCoHoaDon

/* Xây dựng các Procedure cho CSDL */
--1. Tạo thủ tục có tham số truyền vào là năm và tính trung bình cộng thành tiền của các khách hàng trong năm đó
CREATE PROC pr_TBCThanhTien_KH_Trong1Nam
@iNam int
AS
SELECT tblKhachHang.sMaKH, tblKhachHang.sHoTen, AVG(tblChiTietHoaDon.fThanhTien) AS [TBC thanh tien] 
FROM tblKhachHang
INNER JOIN tblHoaDon ON tblKhachHang.sMaKH = tblHoaDon.sMaKH
INNER JOIN tblChiTietHoaDon ON tblHoaDon.iMaHD = tblChiTietHoaDon.iMaHD
WHERE tblHoaDon.iNamThu = @iNam
GROUP BY tblKhachHang.sMaKH, tblKhachHang.sHoTen

EXEC pr_TBCThanhTien_KH_Trong1Nam 2022

--2.Tạo thủ tục thêm 1 phòng ban mới
CREATE PROC pr_insertPB
@sMaPB varchar(20),
@sTenPB nvarchar(50),
@sKhucVuc nvarchar(30)
AS
BEGIN
	IF EXISTS (SELECT * From tblPhongBan WHERE sMaPB = @sMaPB)
		PRINT N'Phòng ban này đã tồn tại'
	ELSE
		BEGIN
		INSERT INTO tblPhongBan (sMaPB,sTenPB,sKhuVuc) VALUES (@sMaPB,@sTenPB,@sKhucVuc)
		PRINT N'Thêm mới phòng ban thành công'
		END
END

EXEC pr_insertPB 'PB06', 'Phòng ban 6', 'KV06'
--3.Tạo thủ tục đưa ra các chi tiết hóa đơn của 1 khách nào nào đó với tham số
--truyền vào là mã khách hàng
CREATE PROC pr_CT_HoaDon_KH
@sMaKH varchar(20)
AS
BEGIN
PRINT N'Các chi tiết hóa đơn của khách hàng này là'
SELECT tblChiTietHoaDon.iMaHD, fChiSoDau, fChiSoCuoi, fLuongTieuThu, fDonGia, fThanhTien, iThangThu, iNamThu
FROM tblChiTietHoaDon INNER JOIN tblHoaDon ON tblChiTietHoaDon.iMaHD = tblHoaDon.iMaHD
WHERE sMaKH = @sMaKH
END

EXEC pr_CT_HoaDon_KH 'KH03'

--4.Tạo thủ tục cho biết mã nhân viên, họ tên, hệ số lương, phụ cấp của các nhân viên trong
--1 phòng ban nào đó với mã PB là tham số truyền vào
CREATE PROC pr_NV_PB
@sMaPB varchar(20)
AS
BEGIN
PRINT N'Các nhân viên thuộc phòng ban này là'
SELECT sMaNV, sHoTen, fHSL, fPhuCap FROM tblNhanVien WHERE sMaPB = @sMaPB
END

EXEC pr_NV_PB 'PB01'
--5.Tạo thủ tục cho biết những khách hàng đã nộp tiền nhiều hơn 1 số nào đó trong 1 năm nào đó
CREATE PROC pr_KH_NopNhieuHon_Nam
@fSoTien float,
@iNam int
AS
BEGIN
	IF NOT EXISTS (SELECT tblKhachHang.sMaKH, tblKhachHang.sHoTen, tblHoaDon.iNamThu,
									SUM(tblChiTietHoaDon.fThanhTien) AS [Tổng số tiền đã nộp]
			FROM tblKhachHang INNER JOIN tblHoaDon ON tblKhachHang.sMaKH = tblHoaDon.sMaKH
			INNER JOIN tblChiTietHoaDon ON tblHoaDon.iMaHD = tblChiTietHoaDon.iMaHD
			WHERE tblHoaDon.iNamThu = @iNam
			GROUP BY tblKhachHang.sMaKH, tblHoaDon.iNamThu, tblKhachHang.sHoTen
			HAVING SUM(tblChiTietHoaDon.fThanhTien) > @fSoTien)
		BEGIN
			PRINT N'Không có khách hàng nào thỏa mãn'
		END
	ELSE
		SELECT tblKhachHang.sMaKH, tblKhachHang.sHoTen, tblHoaDon.iNamThu, SUM(tblChiTietHoaDon.fThanhTien) AS [Tổng số tiền đã nộp]
		FROM tblKhachHang INNER JOIN tblHoaDon ON tblKhachHang.sMaKH = tblHoaDon.sMaKH
		INNER JOIN tblChiTietHoaDon ON tblHoaDon.iMaHD = tblChiTietHoaDon.iMaHD
		WHERE tblHoaDon.iNamThu = @iNam
		GROUP BY tblKhachHang.sMaKH, tblHoaDon.iNamThu, tblKhachHang.sHoTen
		HAVING SUM(tblChiTietHoaDon.fThanhTien) > @fSoTien
END

EXEC pr_KH_NopNhieuHon_Nam 1000200, 2022

/* Phân tán */
CREATE LOGIN BTL 
WITH PASSWORD = '123456'

CREATE USER BTL FOR LOGIN BTL

GRANT ALL TO BTL

-- 1. Phân tán ngang bảng nhân viên, insert nhân viên vào đúng máy trạm tương ứng
-- Nếu nhân viên có địa chỉ Hà Nội insert vào trạm 1, không ở Hà Nội vào trạm 2

CREATE TABLE tblNhanVienPhanTan
(
	sMaNV varchar(20) NOT NULL PRIMARY KEY,
	sMaPB varchar(20) NOT NULL,
	sHoTen nvarchar(50) NOT NULL,
	sSDT varchar(10),
	sDiaChi nvarchar(50),
	sGioiTinh nvarchar(3),
	fHSL float,
	fPhuCap float,
	dNgaySinh Date,
	dNgayVaoLam Date,
)

ALTER TABLE tblNhanVienPhanTan ADD CONSTRAINT CK_NgayVaoLamPT CHECK (DATEDIFF(DAY, dNgaySinh, dNgayVaoLam)/365 >=18);

ALTER TABLE tblNhanVienPhanTan ADD CONSTRAINT CK_DiaChi CHECK (sDiaChi LIKE N'Hà Nội')

GRANT ALL ON tblNhanVienPhanTan TO BTL
GRANT ALL ON tblNhanVien TO BTL

-- Phân tán ngang
INSERT INTO tblNhanVienPhanTan SELECT * FROM tblNhanVien WHERE sDiaChi LIKE N'Hà Nội'

INSERT INTO QLBTL.BTL_QL_ThuPhiCapNuocSach.dbo.tblNhanVienPhanTan SELECT * FROM dbo.tblNhanVien WHERE sDiaChi NOT LIKE N'Hà Nội'
INSERT INTO QLBTL2.BTL_QL_ThuPhiCapNuocSach.dbo.tblNhanVienPhanTan SELECT * FROM dbo.tblNhanVien WHERE sDiaChi LIKE N'Hà Nội'

SELECT *
FROM  QLBTL.BTL_QL_ThuPhiCapNuocSach.dbo.tblNhanVienPhanTan
UNION 
SELECT *
FROM tblNhanVienPhanTan

-- 2. Viết thủ tục thêm khách hàng vào máy trạm tương ứng
-- (Khách hàng có đối tượng là hộ dân thì thêm vào trạm 1, khác hộ dân thì thêm vào trạm 2)
CREATE TABLE tblKhachHangPhanTan_DoiTuong
(
	sMaKH varchar(20) NOT NULL PRIMARY KEY,
	sHoTen nvarchar(50) NOT NULL,
	sSDT varchar(10),
	sDiaChi nvarchar(50),
	sDoiTuong nvarchar(20)
)
ALTER TABLE tblKhachHangPhanTan_DoiTuong ADD CONSTRAINT CK_DoiTuongPT CHECK (sDoiTuong LIKE N'Hộ dân');

ALTER PROCEDURE pr_ThemKhachHang_PhanTan_DoiTuong
@sMaKH varchar(20), @sHoTen nvarchar(50), @sSDT varchar(10), @sDiaChi nvarchar(50), @sDoiTuong nvarchar(20)
AS
IF EXISTS (SELECT * FROM tblKhachHang WHERE sMaKH = @sMaKH
UNION
SELECT * FROM tblKhachHangPhanTan_DoiTuong WHERE sMaKH = @sMaKH
UNION
SELECT * FROM QLBTL.BTL_QL_ThuPhiCapNuocSach.dbo.tblKhachHangPhanTan_DoiTuong WHERE sMaKH = @sMaKH)
	BEGIN
		PRINT N'Mã khách hàng đã tồn tại'
		ROLLBACK
	END
ELSE
	BEGIN
		INSERT INTO dbo.tblKhachHang VALUES(@sMaKH, @sHoTen, @sSDT, @sDiaChi, @sDoiTuong)
		IF @sDoiTuong LIKE N'Hộ dân'
		BEGIN
			INSERT INTO dbo.tblKhachHangPhanTan_DoiTuong 
			VALUES(@sMaKH, @sHoTen, @sSDT, @sDiaChi, @sDoiTuong)
		END
		ELSE
		BEGIN
		    INSERT INTO QLBTL.BTL_QL_ThuPhiCapNuocSach.dbo.tblKhachHangPhanTan_DoiTuong 
			VALUES(@sMaKH, @sHoTen, @sSDT, @sDiaChi, @sDoiTuong)
		END
		PRINT N'Phân tán thành công!'
	END

GO
EXECUTE pr_ThemKhachHang_PhanTan_DoiTuong 'KH17', N'Nguyễn Thị Ngân', '0896564386', N'Hoàn Kiếm', N'Hộ kinh doanh'
EXECUTE pr_ThemKhachHang_PhanTan_DoiTuong 'KH18', N'Nguyễn Văn Trỗi', '0896878598', N'Phố Nhổn', N'Hộ dân'

-- 3. - Viết Trigger kiểm tra Insert khách hàng vào máy trạm tương ứng
-- (Khách hàng có địa chỉ là Hoàng Mai vào trạm 1, khác Hoàng Mai thì thêm vào trạm 2)
CREATE TABLE tblKhachHangPhanTan_DiaChi
(
	sMaKH varchar(20) NOT NULL PRIMARY KEY,
	sHoTen nvarchar(50) NOT NULL,
	sSDT varchar(10),
	sDiaChi nvarchar(50),
	sDoiTuong nvarchar(20)
)
ALTER TABLE tblKhachHangPhanTan_DiaChi ADD CONSTRAINT CK_DiaChiPT CHECK (sDiaChi LIKE N'Hoàng Mai');

ALTER TRIGGER trg_ThemKhachHang_PhanTan_DiaChi
ON tblKhachHang
INSTEAD OF INSERT
AS
DECLARE @sMaKH varchar(20), @sHoTen nvarchar(50), @sSDT varchar(10), @sDiaChi nvarchar(50), @sDoiTuong nvarchar(20)
SELECT @sMaKH = sMaKH FROM inserted
SELECT @sHoTen = sHoTen FROM inserted
SELECT @sSDT = sSDT FROM inserted
SELECT @sDiaChi = sDiaChi FROM inserted
SELECT @sDoiTuong = sDoiTuong FROM inserted
BEGIN
	IF EXISTS (SELECT * FROM tblKhachHang WHERE sMaKH = @sMaKH)
		BEGIN
			PRINT N'Mã khách hàng đã tồn tại'
			ROLLBACK
		END
	ELSE
		BEGIN
			INSERT INTO tblKhachHang SELECT * FROM inserted
			IF @sDiaChi LIKE N'Hoàng Mai'
			BEGIN
				INSERT INTO dbo.tblKhachHangPhanTan_DiaChi SELECT * FROM inserted
			END
			ELSE
			BEGIN
				INSERT INTO QLBTL.BTL_QL_ThuPhiCapNuocSach.dbo.tblKhachHangPhanTan_DiaChi 
				(sMaKH, sHoTen, sSDT, sDiaChi, sDoiTuong)
				VALUES (@sMaKH, @sHoTen, @sSDT, @sDiaChi, @sDoiTuong)
			END
			PRINT N'Phân tán thành công!'
		END
END

INSERT INTO tblKhachHang (sMaKH, sHoTen, sSDT, sDiaChi, sDoiTuong)
VALUES  ('KH13', N'Đinh Văn Huy', '0989878589', N'Hoàng Mai', N'Hộ dân')

INSERT INTO tblKhachHang (sMaKH, sHoTen, sSDT, sDiaChi, sDoiTuong)
VALUES  ('KH16', N'Nguyễn Thị Hoài', '0758968955', N'Hai Bà Trưng', N'Hộ sản xuất')

GO


CREATE TABLE tblPhanTanNV_Doc_ThongTin
(
	sMaNV varchar(20) NOT NULL PRIMARY KEY,
	sMaPB varchar(20) NOT NULL,
	sHoTen nvarchar(50) NOT NULL,
	sSDT varchar(10),
	sDiaChi nvarchar(50),
	sGioiTinh nvarchar(3),
	dNgaySinh Date,
	dNgayVaoLam Date,
)
ALTER TABLE tblPhanTanNV_Doc_ThongTin ADD CONSTRAINT FK_PhongBan_NhanVienPT_Doc FOREIGN KEY (sMaPB)
REFERENCES tblPhongBan (sMaPB)

ALTER TABLE tblPhanTanNV_Doc_ThongTin ADD CONSTRAINT CK_NgayVaoLam_PT_Doc CHECK (DATEDIFF(DAY, dNgaySinh, dNgayVaoLam)/365 >=18);

CREATE PROCEDURE pr_ThemNV_PhanTanDoc
@sMaNV varchar(20), @sMaPB varchar(20), @sHoTen nvarchar(50), @sSDT varchar(10), @sDiaChi nvarchar(50), @sGioiTinh nvarchar(3),
@fHSL float, @fPhuCap float, @dNgaySinh Date, @dNgayVaoLam Date
AS
BEGIN
	INSERT INTO tblNhanVien VALUES (@sMaNV, @sMaPB, @sHoTen, @sSDT, @sDiaChi, @sGioiTinh, @fHSL, @fPhuCap, @dNgaySinh, @dNgayVaoLam)

	INSERT INTO dbo.tblPhanTanNV_Doc_ThongTin VALUES (@sMaNV, @sMaPB, @sHoTen, @sSDT, @sDiaChi, @sGioiTinh, @dNgaySinh, @dNgayVaoLam)
	INSERT INTO QLBTL.BTL_QL_ThuPhiCapNuocSach.dbo.tblPhanTanNV_Doc_Luong VALUES (@sMaNV, @fHSL, @fPhuCap)
END

EXECUTE pr_ThemNV_PhanTanDoc 'NV11', 'PB03', N'Nguyễn Văn Tâm', '0986878989', N'Vĩnh Phúc', N'Nam', 100, 20, '12/03/2003', '05/19/2022'

SELECT a.*, b.fHSL, b.fPhuCap
FROM tblPhanTanNV_Doc_ThongTin AS a INNER JOIN QLBTL.BTL_QL_ThuPhiCapNuocSach.dbo.tblPhanTanNV_Doc_Luong AS b
ON a.sMaNV = b.sMaNV

GO

ALTER TRIGGER trg_KhongVuotQuaNV_PB
ON tblNhanVien
INSTEAD OF INSERT
AS
DECLARE @sMaPB varchar(20)
SELECT @sMaPB = sMaPB FROM inserted
BEGIN
IF (SELECT fTongSoNV FROM tblPhongBan WHERE sMaPB = @sMaPB) > 5
	BEGIN
		PRINT N'Vượt quá số lượng nhân viên vòng ban'
		ROLLBACK
	END
ELSE
	INSERT INTO tblNhanVien SELECT * FROM inserted
END

INSERT INTO tblNhanVien (sMaNV, sMaPB, sHoTen, sSDT,  sDiaChi, sGioiTinh, fHSL, fPhuCap, dNgaySinh, dNgayVaoLam)
VALUES ('NV12', 'PB03', N'Mua Thị Dua', '0587566876', N'Lào Cai', N'Nữ', 100, 20, '12/09/2002', '10/10/2021')

GO

-- Câu 1:
ALTER TABLE tblPhongBan
ADD iTongSoTD int DEFAULT 0

UPDATE tblPhongBan SET iTongSoTD = 0

CREATE VIEW vw_TongTD_TD
AS
SELECT sMaPB, COUNT(sMaPB) AS TongSoTD FROM tblTuyenDuong
GROUP BY sMaPB

SELECT * FROM vw_TongTD_TD

UPDATE tblPhongBan
SET iTongSoTD = vw_TongTD_TD.TongSoTD
FROM vw_TongTD_TD 
WHERE vw_TongTD_TD.sMaPB = tblPhongBan.sMaPB

SELECT * FROM tblPhongBan

-- Câu 2:
CREATE TRIGGER trg_TangTS_PB
ON tblTuyenDuong
AFTER INSERT
AS
DECLARE @sMaPB varchar(20)
SELECT @sMaPB = sMaPB FROM inserted
UPDATE tblPhongBan
SET iTongSoTD +=1
WHERE sMaPB = @sMaPB

INSERT INTO tblTuyenDuong(sMaTuyenDuong, fDoDaiOng, fKhoiLuongCC, sMaPB)
VALUES  ('TD06', 3,  600, 'PB01')

INSERT INTO tblTuyenDuong(sMaTuyenDuong, fDoDaiOng, fKhoiLuongCC, sMaPB)
VALUES  ('TD07', 2,  800, 'PB05')

INSERT INTO tblTuyenDuong(sMaTuyenDuong, fDoDaiOng, fKhoiLuongCC, sMaPB)
VALUES  ('TD09', 1,  800, 'PB03')

SELECT * FROM tblPhongBan

-- Câu 3:
CREATE VIEW vw_PhanTanKH_DiaChi
AS
SELECT sMaKH, sHoTen, sDiaChi, sSDT
FROM tblKhachHangPhanTan_DiaChi
UNION 
SELECT sMaKH, sHoTen, sDiaChi, sSDT
FROM  QLBTL.BTL_QL_ThuPhiCapNuocSach.dbo.tblKhachHangPhanTan_DiaChi

SELECT * FROM vw_PhanTanKH_DiaChi
