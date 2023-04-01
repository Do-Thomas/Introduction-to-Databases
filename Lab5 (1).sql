use ABCCompany
select * from dbo.CHITIETHOADON 


-- 1.	Write function name: StudenID_ Func1 with parameter @mavt, return the sum
-- of sl*giaban corresponding.


IF object_id('StudentID_Func1', 'FN') IS NOT NULL
BEGIN
    DROP FUNCTION [dbo].[StudentID_Func1]
END
GO
CREATE FUNCTION StudentID_Func1(@mavt nvarchar(10))
returns int
BEGIN 
    RETURN (select sum(d.cal) as summ 
    from (
        select MaVT, SL*GiaBan as cal FROM dbo.CHITIETHOADON
        ) d 
    where d.MaVT like @mavt )
END

print 'Tong tien: ' + CONVERT(varchar, dbo.StudentID_Func1('VT01'))


-- 2.	Write  function to return a total of the HoaDon (@MahD is a parameter) 
select * from CHITIETHOADON
CREATE FUNCTION total_HD (@MahD nvarChar(10))
returns int
begin
    return (
        select count(MaHD) FROM CHITIETHOADON where MaHD like @MahD
    )
end 

print 'Tong hoa don: '+ CONVERT(varchar, dbo.total_HD('HD001'))


-- 3.	Write procedure name: StudenId _Proc1, parameter @makh, @diachi. This procedure help user update @diachi corresponding @makh.
select * from KHACHHANG

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'StudentID_Proc1')
DROP PROCEDURE StudentID_Proc1
GO

CREATE PROCEDURE   StudentID_Proc1 @makh NVARCHAR(5), @diachi NVARCHAR(50)
as 
UPDATE dbo.KHACHHANG SET DiaChi = @diachi WHERE MaKH = @makh

EXEC StudentID_Proc1 @makh = 'KH01', @diachi = 'Thanh Pho Da nang'

-- 4.	Write procedure to add an item into Hoadon
select * from HOADON
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'addHD')
DROP PROCEDURE addHD
GO
CREATE PROCEDURE addHD @mahd  NVARCHAR(10), 
@date DATETIME, @maKH NVARCHAR(5), @TongTG int
as 
INSERT INTO dbo.HOADON (MaHD, Ngay, MaKH, TongTG) 
VALUES ( @mahd, @date, @maKH, @TongTG)

EXEC addHD @mahd = 'HD11', @date = '2001-7-5', @maKH = 'KH02', @TongTG = NULL

-- 5. Write trigger name: StudenId_ Trig1 on table Chitiethoadon, when user insert data into Chitiethoadon
-- the trigger will update the Tongtien in HoaDon(student should add Tongtien column into Hoadon, tongtien=sum(sl*giaban).

select * from CHITIETHOADON 
select * from HOADON

INSERT INTO CHITIETHOADON (MaHD, MaVT, SL, KhuyenMai, GiaBan) VALUES ('HD011', 'VT03', 40, Null, 6000)
INSERT INTO CHITIETHOADON (MaHD, MaVT, SL, KhuyenMai, GiaBan) VALUES ('HD011', 'VT03', 40, Null, 6000)

if OBJECT_ID('StudenId_Trig1','TR') is not null
drop trigger StudenId_Trig1
go
create trigger StudenId_Trig1 on CHITIETHOADON
after insert
as
	declare @mahd nvarchar(5),@tongtien bigint;
	select @mahd=MaHD from inserted
	select @tongtien=sum(SL*GiaBan)
	from CHITIETHOADON
	where MaHD=@mahd
	update HOADON
	set TongTG=@tongtien
	where MaHD = @mahd
go

select sum(SL*GiaBan)
from CHITIETHOADON
where MaHD='HD004'
insert into CHITIETHOADON(MaHD,MaVT,SL,GiaBan) values('HD004','VT01',7,60000)
select TongTG
from HOADON
where MaHD='HD004'


-- 6.	Write view name: StudentID_View1 to extract list of customers who bought ‘Gach Ong’

if OBJECT_ID('StudentID_View1','V') is not null
drop view StudentID_View1
go
create view StudentID_View1
as
select TenKH
from KHACHHANG k join HOADON h on k.MaKH=h.MaKH join CHITIETHOADON ct on h.MaHD=ct.MaHD
where ct.MaVT=(select MaVT from VATTU where TenVT='GACH ONG') 
go
select*from StudentID_View1