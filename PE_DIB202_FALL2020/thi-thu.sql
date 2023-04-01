--Question 1
create table Permissions(
permissionID int primary key,
[name] nvarchar(50)
)
create table Roles(
RoleID int primary key,
[name] nvarchar(100),
permissionID int,
foreign key(permissionID) references Permissions(permissionID)
)
create table Users(
Username varchar(30) primary key,
[Password] nvarchar(20),
Email nvarchar(200),
RoleID int,
foreign key(RoleID) references Roles(RoleID)
)
create table hasPermission(
permissionID int,
RoleID int,
primary key(permissionID, RoleID),
foreign key(permissionID) references Permissions(permissionID),
foreign key(RoleID) references Roles(RoleID)
)
==================================================
Question 1:
Create table Roles(
 RoleID int primary key,
 name nvarchar(100))

Create table Users(
 Username varchar(30) primary key,
 Password nvarchar(20),
 Email nvarchar(200),
 RoleID int,
 Foreign key(RoleID) references Roles)

Create table Permissions(
 permissionID int primary key,
 name nvarchar(50))

Create table hasPermission (
 RoleID int NOT NULL,
 permissionID int NOT NULL,
 PRIMARY KEY(RoleID, permissionID),
 FOREIGN KEY(RoleID) REFFERENCES Roles,
 FOREIGN KEY(permissionID) REFERENCES Permissions)

--Question 2
select * from Product
where Color = 'Blue'

--Question 3
select ProductID, LocationID, Quantity from ProductInventory
where LocationID = 7 and Quantity > 250
Order by Quantity DESC

--Question 4
select p.ProductID, p.Name as ProductName, p.Color, p.Cost, p.Price, py.LocationID, l.name as LocationName, py.Shelf, py.Bin, py.Quantity from Product p
full join ProductInventory py on p.ProductID = py.ProductID
full join Location l on py.LocationID = l.LocationID
where Color = 'Yellow' and Cost < 400

--Question 5
select pm.ModelID, pm.Name as ModelName, count(p.ProductID) as NumberOfProducts from ProductModel pm
left join Product p on pm.ModelID = p.ModelID
where pm.Name like 'Mountain%' or pm.Name like  'ML Mountain%'
group by pm.ModelID, pm.Name
order by NumberOfProducts DESC, pm.Name ASC

--Question 6
SELECT  p.ProductID, p.name as 'Name', sum(py.Quantity) AS TotalQuantity FROM Product p
full JOIN ProductInventory py ON p.ProductID = py.ProductID
GROUP BY p.ProductID, p.name
having sum(py.Quantity) = (
select top 1 counts.TotalQuantity from
(SELECT  p.ProductID, p.name as 'Name', sum(py.Quantity) AS TotalQuantity FROM Product p
full JOIN ProductInventory py ON p.ProductID = py.ProductID
GROUP BY p.ProductID, p.name) as counts
order by TotalQuantity DESC)

--Question 7
select py.LocationID, ln.[Name] AS LocationName, py.ProductID, pt.[Name] AS ProductName, Quantity
from ((ProductInventory py join [Location] ln 
		ON py.LocationID = ln.LocationID) join Product pt 
		ON py.ProductID = pt.ProductID)
		join (select LocationID, max(quantity) AS MQ
              from ProductInventory
              group by LocationID) fm
			  on py.LocationID = fm.LocationID
where Quantity = MQ
order by LocationName, ProductName DESC

-- Question 8
go
create proc proc_product_quantity
@productID int,
@totalQuantity int Output
as
begin
set @totalQuantity = (
select sum(py.Quantity) from ProductInventory py where ProductID = @productID)
end
go
declare @x int
exec proc_product_quantity 1,@x output
select @x as TotalQuantity

-- Question 9
--drop trigger tr_insert_Product
go
create trigger tr_insert_Product
on Product
after insert
as
begin
select i.ProductID, i.Name as ProductName, pm.ModelID, pm.Name as ModelName from inserted i
join ProductModel pm on i.ModelID = pm.ModelID
end
go
insert into Product(ProductID, Name, Cost, Price, ModelID, SellStartDate)
values(1023, 'Product Test', 12.5, 15.5, 1, '2021-10-25')

--Question 10
delete from ProductInventory
where ProductID in (
select pi.ProductID from ProductInventory pi
join Product p on p.ProductID = pi.ProductID 
where p.ModelID = 33)
