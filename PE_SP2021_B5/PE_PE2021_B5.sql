--Q2
select *
from Employees
where Salary > 9000


--Q3
select *
from Jobs
where JobTitle like '%Manager' and min_salary > 5000


--Q4
select Employees.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Salary,
Departments.DepartmentName, Locations.StateProvince, Locations.CountryID
from Employees
inner join Departments
on Employees.DepartmentID = Departments.DepartmentID
inner join Locations
on Locations.LocationID = Departments.LocationID
where Employees.Salary > 3000 and Locations.StateProvince = 'Washington' and Locations.CountryID = 'US'


--Q5
select Locations.LocationID, Locations.StreetAddress, Locations.City,
Locations.StateProvince, Locations.CountryID, count(Departments.DepartmentID) as NumberOfDepartment
from Locations
left join Departments
on Locations.LocationID = Departments.LocationID
group by Locations.LocationID, Locations.StreetAddress, Locations.City,
Locations.StateProvince, Locations.CountryID
order by NumberOfDepartment desc, Locations.LocationID asc


--Q6
select Jobs.JobID, Jobs.JobTitle, count(Employees.EmployeeID) as NumberOfEmployees
from Jobs
left join Employees
on Jobs.JobID = Employees.JobID
group by Jobs.JobID, Jobs.JobTitle
having count(Employees.EmployeeID) in (select top 1 count(Employees.EmployeeID)
                                     from  Employees, Jobs
									 where Jobs.JobID = Employees.JobID
									 group by Jobs.JobID
									 order by count(Employees.EmployeeID) desc)


--Q7
select * from(select v.EmployeeID,v.FirstName, v.LastName, v.Salary, v.DepartmentID, v.DepartmentName, count(a.ManagerID) as NumberOfSubordinates 
              from (select e.EmployeeID, e.FirstName, e.LastName, e.Salary,d.DepartmentID, d.DepartmentName 
			        from Employees e, Departments d 
					where d.DepartmentID = e.DepartmentID) as v
              inner join (select e.EmployeeID, e.FirstName, e.LastName, e.Salary, e.ManagerID from Employees e) as a
              on v.EmployeeID = a.ManagerID 
              group by v.EmployeeID,v.FirstName, v.LastName, v.Salary, v.DepartmentID, v.DepartmentName) as f
union
select * from(select v.EmployeeID,v.FirstName, v.LastName, v.Salary, v.DepartmentID, v.DepartmentName, count(a.ManagerID) as NumberOfSubordinates 
              from (select e.EmployeeID, e.FirstName, e.LastName, e.Salary,d.DepartmentID, d.DepartmentName from Employees e, Departments d where d.DepartmentID = e.DepartmentID and e.Salary>10000) as v
              left join (select e.EmployeeID, e.ManagerID from Employees e) as a
              on v.EmployeeID = a.ManagerID 
              group by v.EmployeeID,v.FirstName, v.LastName, v.Salary, v.DepartmentID, v.DepartmentName) as g
order by NumberOfSubordinates DESC



--Q8
drop proc pr1
create proc pr1 @countryID varchar(10), @numberOfDepartmnets int out
as
begin
    set @numberOfDepartmnets = (select count(Departments.DepartmentID)
	                            from Departments, Locations
								where Departments.LocationID = Locations.LocationID
								and Locations.CountryID = @countryID)
end

declare @x int 
exec pr1 'US', @x output
select @x as NumberOfDepartments


--Q9
drop Trigger Tr1
create Trigger Tr1
on Employees after insert
as 
begin
    select i.EmployeeID, i.FirstName, i.LastName, de.DepartmentID, de.DepartmentName
	from inserted i, Departments de
	where i.DepartmentID = de.DepartmentID
end

insert into Employees(EmployeeID,FirstName,LastName,Email,JobID,DepartmentID) values
(1003,'Alain','Boucher','alain.boucher@gmail.com','SH_CLERK',50),
(1004,'Muriel','Visani','muriel.visani@gmail.com','SA_REP',null)

--Q10
Delete from Departments
where ManagerID = null