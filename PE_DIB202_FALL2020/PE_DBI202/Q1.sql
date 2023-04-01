----Q1-----
create table Roles
(
RoleID int primary key,
[name] nvarchar(100)
)

create table Users
(
Username varchar(30) primary key,
[Password] nvarchar(20),
Email nvarchar(200),
RoleID int foreign key references Roles(RoleID)
)

create table [Permissions]
(
permissionID int primary key,
[name] nvarchar(50)
)

create table hasPermission
(
permissionID int foreign key references [Permissions](permissionID),
RoleID int foreign key references Roles(RoleID),
primary key(permissionID,RoleID)
)