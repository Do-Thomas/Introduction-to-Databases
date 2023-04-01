Create database Event
Use Event
--1.Create table ERD
Create table Locations(
	locationID varchar(20) primary key,
	Name nvarchar(100),
	Address nvarchar(255))

Create table Events(
	eventID int primary key,
	name nvarchar(255),
	EndTime DateTime, 
	StartTime DateTime,
	locationID varchar(20),
	foreign key locationID references Locations)
--	foreign key staffID refences Staffs)

Create table Staffs(
	staffID int primary key,
	name nvarchar(255), 
	Phone varchar(15),
	foreign key (eventID) references Events(eventID))

Create table workFor(
	role nvarchar(30),
	eventID int,
	staffID int
	primary key(role, eventID, staffID),
	foreign key (eventID) references Events(eventID),
	foreign key (staffID) references Staffs(staffID))