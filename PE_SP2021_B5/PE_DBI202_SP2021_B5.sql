--1. Create table for ERD
Create table items (
	itemID int primary key,
	name nvarchar(255), 
	price float
	foreign key catID references categories)

Create table itemVariants(
	variantID int primary key,
	detail nvarchar(200),
	color nvarchar(50),
	size nvarchar(30),
	foreign key itemID references items)

Create table categories(
	catID int primary key,
	name nvarchar(255),
	foreign key itemID references items)
--2.Select all employees having Salary greater than 9000.
Select *
From Employees
Where Salary > 9000
--3. Write a query to select JobID, JobTitle, min_salary of all 'Manager' jobs
-- min_salary > 5000, desc
--asc JobTitle 
Select JobID, JobTitle, min_salary
From Jobs 
Where min_salary > 5000 and JobTitle like '%Manager'
Order by min_salary desc, JobTitle asc 
--4. Witew a query to display EmployeeID, FirstName, LastName, Salary,
--DepartmentName, StateProvince, CountryID
--Salary > 3000, departments in the 'Washington' of 'US'
Select e.EmployeeID, e.FirstName, e.LastName, e.Salary, d.DepartmentName, l.StateProvince, l.CountryID
From Departments d
Inner join Employees e
On d.DepartmentID = e.DepartmentID
Inner join Locations l
On d.LocationID = l.LocationID
Where e.Salary > 3000 AND l.LocationID = 1700
--5.display LocationID, StreetAddress, City, StateProvince, CountryID, NumberOfDepartments
--NumberOfDepartments desc, LocationID asc
Select l.LocationID, l.StreetAddress, l.City, l.StateProvince, l.CountryID, Count(d.LocationID) AS NumberOfDepartments
From Locations l
full join Departments d
On l.LocationID = d.LocationID
Group by l.LocationID, l.StreetAddress, l.City, l.StateProvince, l.CountryID
Order by NumberOfDepartments desc, l.LocationID asc
--6. JobID, JobTitle, NumberOfEmployees
--Jobs having the maximum number of employees
Select j.JobID, j.JobTitle, Count(e.JobID) as NumberOfEmloyees
From Jobs j
full join Employees e
On j.JobID = e.JobID
Group by j.JobID, j.JobTitle
Having Count(e.JobID) = (Select Max(c.max1)
						From (Select Count(e.JobID) as max1
							  From Employees e, Jobs j
							  Where j.JobID = e.JobID
							  Group by e.JobID) as c)

--7.EmployeeID, FirstName, LastName, Salary, DepartmentID,
--DepartmentName, NumberOfSubordinates
--who manages at least one other employee : NumberOfSubordinates
--who has the Salary > 10000
--NumberOfSubordinates is the number of employees that he/she manages
-- NumberOfSubordinates desc, LastName asc
Select e.EmployeeID, e.FirstName, e.LastName, e.Salary, d.DepartmentID, d.DepartmentName, count(d.ManagerID) AS NumberOfSubordinates
From Employees e
Inner join Departments d
On e.DepartmentID = d.DepartmentID
Where Count(d.ManagerID) > 1 And e.Salary > 10000
Group by e.EmployeeID, e.FirstName, e.LastName, e.Salary, d.DepartmentID, d.DepartmentName
Order by NumberOfSubordinates desc, e.LastName asc
-------------------------------------------------------------------------------------
select * from(select v.EmployeeID,v.FirstName, v.LastName, v.Salary, v.DepartmentID, v.DepartmentName, count(a.ManagerID) as NumberOfSubordinates from
(select e.EmployeeID, e.FirstName, e.LastName, e.Salary,d.DepartmentID, d.DepartmentName from Employees e, Departments d where d.DepartmentID = e.DepartmentID) as v
inner join (select e.EmployeeID, e.FirstName, e.LastName, e.Salary, e.ManagerID from Employees e) as a
on v.EmployeeID = a.ManagerID 
group by v.EmployeeID,v.FirstName, v.LastName, v.Salary, v.DepartmentID, v.DepartmentName) as f
union
select * from(select v.EmployeeID,v.FirstName, v.LastName, v.Salary, v.DepartmentID, v.DepartmentName, count(a.ManagerID) as NumberOfSubordinates from
(select e.EmployeeID, e.FirstName, e.LastName, e.Salary,d.DepartmentID, d.DepartmentName from Employees e, Departments d where d.DepartmentID = e.DepartmentID and e.Salary>10000) as v
left join (select e.EmployeeID, e.ManagerID from Employees e) as a
on v.EmployeeID = a.ManagerID 
group by v.EmployeeID,v.FirstName, v.LastName, v.Salary, v.DepartmentID, v.DepartmentName) as g
order by NumberOfSubordinates DESC
--8.Create a stored procedure named pr1 to calculate the number of deparments 
--in a given country where @countryID varchar(10): input
--@numberOfDepartments int: output
Drop proc pr1
Create proc pr1 @countryID varchar(10), @numberOfDepartments int output
as 
begin
	set @numberOfDepartments = (select COunt(d.DepartmentID)
								from Departments d, Locations l
								Where d.LocationID = l.LocationID and l.CountryID = @countryID)
end

declare @x int
exec pr1 'US', @x output
select @x as NumberOfDepartments

--9.Create a trigger named Tr1 for the insert Employees 
--we inserted one or more employees into Employees
--EmployeeID, FirstName, LastName, DepartmentID, DepartmentName
drop trigger Tr1
create trigger Tr1
on Employees
for insert
as 
begin
		select e.EmployeeID, e.FirstName, e.LastName, e.DepartmentID, d.DepartmentName
		from inserted i
		join Employees e
		On e.EmployeeID = i.EmployeeID
		join Departments d
		On e.DepartmentID = d.DepartmentID
end
-------------------------------------------------------------------------------------------
drop trigger Tr1
create trigger Tr1 
on Employees after insert
as 
begin
	select i.EmployeeID, i.FirstName, i.LastName, d.DepartmentID, d.DepartmentName  
	from inserted i, Departments d
	where i.DepartmentID = d.DepartmentID
end

Insert into Employees(EmployeeID, FirstName, LastName, Email, JobID, DepartmentID)
Values(1003, 'Alain', 'Boucher', 'alain.boucher@gmail.com','SH_CLERK', 50)
Insert into Employees(EmployeeID, FirstName, LastName, Email, JobID, DepartmentID)
Values (1004, 'Muriel', 'Visani','muriel.visani@gmail.com','SA_REP', null)


Delete from Employees
Where EmployeeID = 1003 
Delete from Employees
Where EmployeeID = 1004
--10. Remove Departments all department which has no employees
Delete from Departments
Where ManagerID = NULL