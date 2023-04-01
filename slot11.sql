USE FUH_COMPANY

SELECT empName
FROM tblEmployee
WHERE empSex LIKE N'%F' AND  depNum = 1

SELECT empName,empBirthdate ,empAddress
FROM tblEmployee
WHERE empName LIKE N'%John'

SELECT empName, empSalary
FROM tblEmployee
WHERE depNum = 5 AND empSalary BETWEEN 30000 AND 400000

/*Write a query to retrieve the name of each employee who has a dependent with the
 same sex as the employee. */
SELECT e.empSSN
FROM tblEmployee e, tblDependent d
WHERE e.empSSN = d.empSSN
/*Q4: Hiển thị tất cả thông của những người ko có phụ thuộc*/
SELECT *
FROM tblEmployee e, tblDependent d
EXCEPT 
SELECT *
FROM tblEmployee e, tblDependent d
WHERE e.empSSN = d.empSSN

/* Q2*/
SELECT e.empName, e.empSex
FROM tblEmployee e, tblDependent d
WHERE e.empSex = d.depSex AND e.empSSN = d.empSSN

/*Q5:  */
SELECT empName
FROM tblEmployee
WHERE empSalary > ALL(SELECT empSalary
					FROM tblEmployee
					WHERE depNum = 5)


SELECT e.empSSN
FROM tblEmployee e, tblDependent d
EXCEPT 
SELECT e.empSSN
FROM tblEmployee e, tblDependent d
WHERE e.empSSN  = d.empSSN

-- Lấy thông tin Employees and the projacts... Q1/ slot 12
SELECT empName, proName, empSalary
FROM tblEmployee a, tblProject b
WHERE a.depNum=b.depNum

order by empName, empSalary desc

SELECT*
FROM tblEmployee e LEFT OUTER JOIN tblDependent d
	ON  e.empSSN = d.empSSN
	WHERE depName IS NULL

SELECT tblEmployee.depNum, AVG(empSalary) as AvgSalary, max(empSalary) as MaxSalary
FROM tblEmployee
INNER JOIN tblDepartment
ON tblEmployee.depNum = tblDepartment.depNum
Group By tblEmployee.depNum

SELECT tblEmployee.empName, SUM(tblWorksOn.workHours) AS SumWorks
FROM tblEmployee
INNER JOIN tblWorksOn
ON tblEmployee.empSSN = tblWorksOn.empSSN
GROUP BY tblEmployee.empName
HAVING SUM(tblWorksOn.workHours) > 40

SELECT 
FROM tblEmployee
INNER JOIN tblDepartment
ON tblDepartment.depNum = tblEmployee.depNum

--Chapter 8
SET @empName = N'Mai Duy An'
SELECT @empSalary = 2000

SELECT @empName = empName, @empSalary = empSalary
FROM tblEmployee
WHERE empName = N'Mai Duy An'

UPDATE tblEmployee
SET @empName = empName, @empSalary = empSalary
WHERE empName = N'Mai Duy An'

Declare @empName NVARCHAR(20), @empSalary Decimal
set @empName = N'Mai Duy An'
set

--khai bao biến
declare @name nvarchar(30), @salary decimal
--Gán giá trị cho biến
SELECT @name=empName, @salary=empSalary
FROM tblEmployee
WHERE empSalary=(select max(empSalary)
					from tblEmployee)
--Xử lý
print 'Your name: '+ @name + ' salary: ' + convert(varchar, @salary)

--IF.... ELSE statement
Declare @workHours Decimal, @bonus Decimal
Select @workHours=SUM(workHours)
From tblWorksOn
where empSSN = 30121050027
Group by empSSN

IF (@workHours > 300)
	set @bonus = 1000
ELSE 
	set @bonus = 500
print @bonus
declare @name nvarchar(30), @salary decimal, @avgSalary decimal
SELECT @name=empName, @salary=empSalary
FROM tblEmployee
WHERE empSalary='30121050027'
--average salary
select @avgSalary = avg(empsalary)
from tblEmployee
where depNum=(select depNum 
				from tblEmployee
				where empSSN='30121050027')
--Xử lý
IF @salary >= @avgSalary
	print 'High salary'
ELSE
	print 'Low salary'