CREATE DATABASE EmpManagement;

USE EmpManagement;

CREATE TABLE tblEmployee (
	IdEmp INT identity(1,1) PRIMARY KEY,
	EmpName nvarchar(50) NOT NULL,
	DOB date CHECK(year(getdate())-year(DOB)>=18),
	PhoneNo char(12) Unique,
	Addr nvarchar(50) DEFAULT N'Hồ Chí Minh' 
);

/* coi bảng đã tạo */
select *from tblEmployee
/*5.1*/
SELECT * FROM tblEmployee WHERE	EmpName = N'Võ Việt Anh';
SELECT * FROM tblEmployee WHERE empName LIKE N'%Anh';

ALTER TABLE tblEmployee ADD Sex Bit

