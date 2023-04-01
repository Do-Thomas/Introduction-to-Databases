Create table Departments(
DeptID varchar(20) primary key,
[name] nvarchar(200),
office nvarchar(100)
)

Create table Employees(
EmpCode varchar(20) primary key,
[Name] nvarchar(50),
BirthDate date,
DeptID varchar(20) foreign key references Departments(DeptID)
)

create table Dependants(
Number int primary key,
[Name] nvarchar(50) ,
BirthDate Date,
Role nvarchar(30),
EmpCode varchar(20) foreign key references Employees(EmpCode)
)