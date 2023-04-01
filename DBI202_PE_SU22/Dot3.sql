CREATE DATABASE SU22

CREATE TABLE Departments
( DEptID varchar(20) PRIMARY KEY,
  name nvarchar(200),
  office nvarchar(100),
  EmpCode varchar(20)
)

CREATE TABLE Employees
( EmpCode varchar(20) PRIMARY KEY,
  name nvarchar(50),
  BirthDate date, 
)