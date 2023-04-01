USE ABCCompany
-- 1.Write function name: StudenID_ Func1 with parameter @mavt, return the sum
--of sl*giaban corresponding
Create function StudenID_Func1
(@mavt Nvarchar(10))
Returns int
Begin
	Return (Select sum(d.TongGia)
			From (select MaVT, SL*GiaBan as TongGia
				 from dbo.CHITIETHOADON) d
			Where d.MaVT like @mavt)
End

print 'Tong tien: ' + CONVERT(varchar, dbo.StudenID_Func1('VT01'))

--2.Write  function to return a total of the HoaDon (@MahD is a parameter) 
create function Total_Func2
( @MahD nvarchar(10))
returns int 
Begin
	return (Select Count(MaHD)
			From CHITIETHOADON
			Where MaHD like @MahD)
	
End
print 'Tong hoa don: '+ CONVERT(varchar, dbo.Total_Func2('HD001'))


--3.Write procedure name: StudenId _Proc1, parameter @makh, @diachi. This procedure
--help user update @diachi corresponding @makh.
Create proc StudenId_Proc1 @makh nvarchar(5), @diachi nvarchar(50)
AS
Begin 
	if exists (select MaKH from KHACHHANG where @makh = MaKH)
	Begin 
		Update dbo.KHACHHANG
		Set DiaChi = @diachi
		Where MaKH = @makh
	End 
End

Exec StudenId_Proc1 'KH06','Thanh Pho Thu Duc'
--4.Write procedure to add an item into Hoadon
Create proc addHoadon @mahd nvarchar(10),@date DATE, @makh nvarchar(5), @tongtg int
As 
Insert into dbo.HOADON (MaHD, Ngay, MaKH, TongTG)
Values (@mahd, @date, @makh, @tongtg)
EXEC addHoadon @mahd = 'HD011', @date = '2001-7-5', @maKH = 'KH02', @TongTG = NULL

--5.Write trigger name: StudenId_ Trig1 on table Chitiethoadon, when user insert data into Chitiethoadon, the trigger will update the Tongtien in HoaDon(student should add Tongtien column into Hoadon, tongtien=sum(sl*giaban).
Drop trigger StudenID_Trig1

ALTER TABLE HOADON
ADD TongTien int 

Create trigger StudenID_Trig1
On CHITIETHOADON instead of insert
As
Begin	

	Declare @tongtien int, @mahd nvarchar(5)
	Set @tongtien = ( Select d.MaHD, Sum(d.Total)
					  From (Select MaHD, SL*GiaBan As Total
							from CHITIETHOADON
							Group by MaHD, SL*GiaBan) d
					  Group by MaHD) 
	--Update HOADON
	
	/*Set TongTien = ( Select Sum(d.Total)
					  From (Select MaHD, SL*GiaBan As Total
							from CHITIETHOADON
							Group by MaHD, SL*GiaBan) d
					  Group by MaHD) */
	--Where MaHD = @mahd


End

insert into CHITIETHOADON(MaHD,MaVT,SL,GiaBan) values('HD004','VT01',7,60000)
Delete from HOADON Where MaHD = 'HD011'

INSERT INTO CHITIETHOADON (MaHD, MaVT, SL, KhuyenMai, GiaBan) 
VALUES ('HD011', 'VT03', 40, Null, 6000)
--6.Write view name: StudentID_View1 to extract list of customers who bought ‘Gach Ong’.
CREATE VIEW StudentID_View1
AS
Select kh.TenKH
FROM KHACHHANG kh
Inner Join HOADON hd
ON kh.MaKH = hd.MaKH
Inner join CHITIETHOADON ctd
ON ctd.MaHD = hd.MaHD
WHERE ctd.MaVT = (Select MaVT 
				  from  VATTU 
				  where TenVT = 'Gach Ong')

Select * from StudentID_View1