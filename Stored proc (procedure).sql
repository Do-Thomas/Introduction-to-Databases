declare @empname nvarchar(50), @empSalary float
set @empname = N'Lê Hồng Kỳ'
set @empSalary = 2000

print @empname
print @empSalary

--Assign (gán) a value into a variable using SQL command: SELECT
declare @empname1 nvarchar(50)
select @empname1 = empName
from tblEmployee
where empName = N'Mai Duy An'

print @empname1


--Assign a value into a variable using SQL command: UPDATE
/*gán gtri băng câu lệnh SELECT: chỉ có thể gán giá trị cho biến
  gán giá trị băng UPDATE: có thể gán giá trị và update thông tin*/
  declare @counter int = 0
  UPDATE tblEmployee
  SET empSalary = 1.1 * empSalary, 
      @counter = @counter + 1
  WHERE empSSN = 30121050004
  PRINT @counter

  -- IF else statement
  declare @workHours decimal, @bonus decimal
  select @workHours = sum (workHours)
  from tblWorksOn
  where empSSN = 30121050027
  group by empSSN

  if(@workHours <300)
     set @bonus = 1000
  else if (@workHours < 500)
     set @bonus = 1500
  else
     BEGIN
	   set @bonus = 2000
	   print 'done'
	 END

print @bonus

-- CASE ... WHEN (tương tự SWITCH_CASE)
declare @depNum decimal, @str NVARCHAR(30)
SET @str = 
     CASE @depNum
	    WHEN 1 THEN N'Phòng ban số 1'
	    WHEN 2 THEN N'Phòng ban số 2'
	    ELSE N'Mã phòng khác 1,2'
     END
PRINT @str

--WHILE statement (ví dụ giai thừa không liên quan đến các table)
declare @factorial int, @n int
set @n = 5
set @factorial = 1
while (@n>1)
    BEGIN
	   SET @factorial = @factorial*@n
	   SET @n = @n - 1
    END
PRINT @factorial

-- Create a procedure to insert an employee
drop PROC insert_employee
CREATE PROCEDURE insert_employee (@id DECIMAL (18,0)
                            , @name NVARCHAR(50)
                            , @address NVARCHAR(5)
                            , @salary DECIMAL(18,0)
                            , @sex char(1)
                            , @birthday DATETIME
                            , @dept int
                            , @supervisor DECIMAL(18,0)
                            , @startdate DATETIME)
as 
    INSERT INTO tblEmployee 
    VALUES (@id, @name, @address, @salary, @sex, @birthday, @dept, @supervisor, @startdate)

EXEC insert_employee 30121050983, N'Kỳ Lê', 'HCM', 1000, 1, '1984-02-16', 1, 30121050004, '2022-07-31'
EXEC insert_employee 30121050984, N'Thùy Trang', 'HCM', 2000, 2, '2002-08-25', 2, 30121050004, '2022-08-01'


--create SCALAR FUNCTIONS 
--Đếm số lượng nhân viên theo giới tính
if(OBJECT_ID('fb_count_employee') is not NULL)
    drop FUNCTION fn_count_employee
GO
CREATE FUNCTION fn_count_employee(@gender CHAR(1))
RETURN INT
BEGIN
    declare @cnt INT = 0
	set @cnt = (select count(*)
	from tblEmployee




