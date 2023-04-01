CREATE DATABASE CarManage
USE CarManage

CREATE TABLE Cars
(
 SerialNo int identity(1, 1) PRIMARY KEY,
 Price decimal(12),
 Model varchar(50)
)

CREATE TABLE Options
(
 OptionName varchar(100) PRIMARY KEY,
 Price decimal(8),
 SerialNo int,
 foreign key (SerialNo) references Cars(SerialNo)
)

CREATE TABLE Salespersons
(
 SalespersonID int identity(1, 1) PRIMARY KEY,
 Name varchar(100)
)

CREATE TABLE Sales
(
 Saledate date,
 SerialNo int,
 SalespersonID int,
 foreign key (SerialNo) references Cars(SerialNo),
 foreign key (SalespersonID) references Salespersons(SalespersonID)
)
