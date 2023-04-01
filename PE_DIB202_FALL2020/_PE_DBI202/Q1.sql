create table Departments 
(
DepartmentID varchar(15) primary key,
[Name] nvarchar(100),
)

create table Projects
(
ProjectCode varchar(15) primary key,
Title nvarchar(200) ,
DepartmentID varchar(15) foreign key references Departments(DepartmentID)
)

create table Students
(
StudentCode varchar(10) primary key,
[Name] nvarchar(100),
Class varchar(7),
DepartmentID varchar(15) foreign key references Departments(DepartmentID)
)
create table Participate
(
Create table Participate
( ProjectCode varchar(15),
  StudentCode varchar(10),
  Primary key (ProjectCode, StudentCode),
  foreign key (ProjectCode) references Projects,
  foreign key (StudentCode) references Students)
)