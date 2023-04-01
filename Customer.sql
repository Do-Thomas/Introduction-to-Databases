CREATE DATABASE Customers;

USE Customers;

CREATE TABLE Customers(
	CustID int identity(1,1) PRIMARY KEY,
	City varchar(100),
	Cname varchar(100),
)

CREATE TABLE Orders(
	OderID int PRIMARY KEY,
	Odate date,
	CustID int,
	FOREIGN KEY(CustID) REFERENCES Customers(CustID),
)

CREATE TABLE Items (
	ItemID int PRIMARY KEY, 
	Unit_Price decimal(10),
)

CREATE TABLE Order_Item(
	ItemID int,
	OrderID int,
	Odate date,
	CustId int,
	/*Primary key(orderID, custID),
	Foreign key(custID)*/
	foreign key(ItemID) references Items(ItemID),
	foreign key (OrderID) references Orders(OderID),
)