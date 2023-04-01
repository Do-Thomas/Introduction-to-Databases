Create database Assignment
Use Assignment

Create table Unilever
( ID nvarchar(10) not null primary key,
  NoUni int)

Create table NhaPhanPhoi
( ID_PP nvarchar(10) not null primary key,
  ID nvarchar(10) not null,
  ID_KH nvarchar(10) not null,
  Doanhso_BH int,
  No int,
  HangTonKho int,
  foreign key (ID) references Unilever)


Create table NhanVienBanHang
( ID_NV nvarchar(10) not null primary key,
  ID_PP nvarchar(10) not null,
  ID_KH nvarchar(10) not null,
  Tên_NV nvarchar(30) not null,
  Doanhso_NV int,
  NoNV int,
  Foreign key (ID_PP) References NhaPhanPhoi)

Create table KhachHang
( ID_KH nvarchar(10) not null primary key,
  ID_PP nvarchar(10) not null,
  ID_NV nvarchar(10) not null,
  MucDoMuaHang nvarchar(20),
  NoKH int, 
  Phone int,
  Foreign key (ID_PP) References NhaPhanPhoi,
  Foreign key (ID_NV) References NhanVienBanHang)

Create table PhanPhoi
( ID_Pro nvarchar(10) not null primary key,
  ID_PP nvarchar(10) not null,
  Ngay date,
  DonGia int,
  Foreign key (ID_PP) References NhaPhanPhoi)

Create table QuanLy
( ID_PP nvarchar(10) not null primary key,
  ID_KH nvarchar(10) not null,
  MucDoMuaHang nvarchar(20),
  NoPP int
  Foreign key (ID_KH) References KhachHang)

ALTER TABLE Unilever
DROP Column  NoUni;
-------------------------------------------------------------------
Insert into NhanVienBanHang (ID_NV, ID_PP, ID_KH, Ten_NV, Doanhso_NV, NoNV)
Values ('NV01', 'NPP01','KH01', 'Nguyen Linh Chi', '100','4')
Insert into NhanVienBanHang (ID_NV, ID_PP, ID_KH, Ten_NV, Doanhso_NV, NoNV)
Values ('NV02', 'NPP02','KH02', 'Le Diem My', '54','0')
Insert into NhanVienBanHang (ID_NV, ID_PP, ID_KH, Ten_NV, Doanhso_NV, NoNV)
Values ('NV03', 'NPP02','KH03', 'Tran Binh Trong', '80','10')
Insert into NhanVienBanHang (ID_NV, ID_PP, ID_KH, Ten_NV, Doanhso_NV, NoNV)
Values ('NV04', 'NPP01','KH04', 'Đo Mai Huong', '45','')
Insert into NhanVienBanHang (ID_NV, ID_PP, ID_KH, Ten_NV, Doanhso_NV, NoNV)
Values ('NV05', 'NPP05','KH05', 'Ha Thien Nhien', '234','')


Insert into KhachHang (ID_KH, ID_PP, ID_NV, MucDoMuaHang, NoKH, Phone)
Values ('KH01', 'NPP01', 'NV01', 'Tot', 0, '0912345678') 
Insert into KhachHang (ID_KH, ID_PP, ID_NV, MucDoMuaHang, NoKH, Phone)
Values ('KH02', 'NPP02', 'NV02', 'Trung Binh', 0, '09888854') 
Insert into KhachHang (ID_KH, ID_PP, ID_NV, MucDoMuaHang, NoKH, Phone)
Values ('KH03', 'NPP01', 'NV02', 'Tot', 0, '07555598') 
Insert into KhachHang (ID_KH, ID_PP, ID_NV, MucDoMuaHang, NoKH, Phone)
Values ('KH04', 'NPP03', 'NV02', 'Kem', 0, '08999938') 
Insert into KhachHang (ID_KH, ID_PP, ID_NV, MucDoMuaHang, NoKH, Phone)
Values ('KH05', 'NPP04', 'NV03', 'Tot', 0, '05477775') 
Insert into KhachHang (ID_KH, ID_PP, ID_NV, MucDoMuaHang, NoKH, Phone)
Values ('KH06', 'NPP03', 'NV04', 'Trung Binh', 0, '05989875') 
Insert into KhachHang (ID_KH, ID_PP, ID_NV, MucDoMuaHang, NoKH, Phone)
Values ('KH07', 'NPP05', 'NV05', 'Kem', 0, '06272772') 
Insert into KhachHang (ID_KH, ID_PP, ID_NV, MucDoMuaHang, NoKH, Phone)
Values ('KH08', 'NPP04', 'NV04', 'Trung Binh', 0, '02787898')
Insert into KhachHang (ID_KH, ID_PP, ID_NV, MucDoMuaHang, NoKH, Phone)
Values ('KH09', 'NPP04', 'NV03', 'Tot', 0, '09854658')
Insert into KhachHang (ID_KH, ID_PP, ID_NV, MucDoMuaHang, NoKH, Phone)
Values ('KH010', 'NPP01', 'NV04', 'Tot', 0, '091212923')

Insert into NhaPhanPhoi(ID_PP, ID, ID_KH, Doanhso_BH, No,  HangTonKho)
Values ('NPP01', 'Un01','KH01', 1000, 0, 231)
Insert into NhaPhanPhoi(ID_PP, ID, ID_KH, Doanhso_BH, No,  HangTonKho)
Values ('NPP02', 'Un02','KH03', 500, 50, 800)
Insert into NhaPhanPhoi(ID_PP, ID, ID_KH, Doanhso_BH, No,  HangTonKho)
Values ('NPP03', 'Un03','KH02', 5000, 1000, 4000)
Insert into NhaPhanPhoi(ID_PP, ID, ID_KH, Doanhso_BH, No,  HangTonKho)
Values ('NPP05', 'Un04','KH04', 1500, 200, 2100)
Insert into NhaPhanPhoi(ID_PP, ID, ID_KH, Doanhso_BH, No,  HangTonKho)
Values ('NPP04', 'Un05','KH05', 3000, 900, 5000)

Insert into Unilever (ID)
Values ('Un01') 
Insert into Unilever (ID)
Values ('Un02') 
Insert into Unilever (ID)
Values ('Un03') 
Insert into Unilever (ID)
Values ('Un04')
Insert into Unilever (ID)
Values ('Un05') 

Insert into QuanLy(ID_PP, ID_KH, MucDoMuaHang, NoPP)
Values ('NPP01','KH01','Tot',0)
Insert into QuanLy(ID_PP, ID_KH, MucDoMuaHang, NoPP)
Values ('NPP02','KH04','Trung Binh',50)
Insert into QuanLy(ID_PP, ID_KH, MucDoMuaHang, NoPP)
Values ('NPP04','KH09','Tot',20)

Insert into PhanPhoi(ID_Pro, ID_PP, Ngay, DonGia)
Values ('SP01','NPP01','2022-11-5',2000)
Insert into PhanPhoi(ID_Pro, ID_PP, Ngay, DonGia)
Values ('SP03','NPP03','2022-11-3',2500)
Insert into PhanPhoi(ID_Pro, ID_PP, Ngay, DonGia)
Values ('SP02','NPP02','2022-10-25',2000)


--Cho số nhân viên thuộc quản lí của nhà phân phối 01.
Select nv.ID_PP, nv.ID_NV, nv.Ten_NV
From NhaPhanPhoi np
join NhanVienBanHang nv
On np.ID_PP = nv.ID_PP
Where nv.ID_PP = 'NPP01'

--Cho biết những nhân viên bán hàng có chức ‘e’ . Thông tin yêu cầu: mã nhân viên, tên nhân viên
select nv.Ten_NV
from NhanVienBanHang nv
where nv.Ten_NV like '%e%'
