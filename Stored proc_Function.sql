use FUH_COMPANY1
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


/**create SCALAR FUNCTIONS*/ 
--Đếm số lượng nhân viên theo giới tính
if(OBJECT_ID('fb_count_employee') is not NULL)
    drop FUNCTION fn_count_employee
GO
CREATE FUNCTION fn_count_employee(@gender CHAR(1))
RETURNS INT
BEGIN
    declare @cnt INT = 0
	set @cnt = (select count(*)
	from tblEmployee
	where empSex = @gender)

	return @cnt
END

--Test
select dbo.fn_count_employee('F') as NumberOfFemales
select dbo.fn_count_employee('M') as NumberOfMales

/*TABLE- VALUED Functions*/
if (OBJECT_ID('fn_get_employee_by_deptid') is not NULL) 
    drop FUNCTION fn_get_employee_by_deptid
GO    
CREATE FUNCTION fn_get_employee_by_deptid(@depnum int)
RETURNS table
RETURN (
    SELECT e.empSSN, e.empName, e.empSex, d.depName
    from tblEmployee e INNER join tblDepartment d on e.depNum = d.depNum
    WHERE e.depNum = @depnum
) 

--Test
SELECT * from dbo.fn_get_employee_by_deptid(2)



--MULTI-statement TABLE VALUED functions
if (OBJECT_ID('fn_count_department') is not NULL) 
    drop FUNCTION fn_count_department
GO 
CREATE FUNCTION fn_count_department (@quantity int)
RETURNS @resultTable TABLE (
    deptName NVARCHAR(50), quantity INT, sizeLevel CHAR(10)
) AS
BEGIN
    INSERT into @resultTable 
        select d.depName, SUM(e.depNum), null
        From tblEmployee e INNER JOIN tblDepartment d
            on e.depNum = d.depNum
        group by d.depName

    update @resultTable 
    SET sizeLevel = 
        case when quantity > @quantity then 'Big'
        ELSE
            'Small'
        END
    RETURN
END
--Test
SELECT * from dbo.fn_count_department (15)
select * from dbo.fn_count_department(10)

/*
    The main benefit of the multi-statement table-valued functions enables us to modify 
the return/output table in the function body so that we can generate more complicated resultset
*/