--Question 1
--Đối với những bảng là weak entity(2 hình chữ nhật lồng nhau) thì khóa chính của nó sẽ đc bổ sung thêm là khóa chính(ví dụ như bảng Payments bên trên là weak entity thì khóa chính của bảng Payments là primary key(PaymentNo, LoanNumber),)
-- Đối với những ERD không ghi rõ 1 – N thì tạo bảng được trỏ đến theo chiều mũi tên
--Đối với những relasionship có các thuộc tính riêng(hình thoi), ta cần tạo thêm bảng có tên là nội dung bên trong hình thoi và nó được tạo sau các bảng được nối với nó, ngoài ra thêm primary key là các khóa chính của các bảng nối tới nó
-- Đối với những ERD ghi rõ mqh 1 – N thì tạo từ bảng 1 trước , bảng N sau, rồi nối từ bảng N đến bảng 1 qua khóa ngoại, được nối thông qua thuộc tính là khóa chính của bảng 1
--example 1 bang co hinh chu nhat long nhau tai dependants
create table Departments
(
	DeptID varchar(20) primary key,
	name nvarchar(200),
	office nvarchar(100)
)

create table Employees (
	EmpCode varchar(20) primary key,
	[Name] nvarchar(50),
	BirthDate date,
	DeptID varchar(20),
	foreign key (DeptID) references Departments(DeptID)
)

create table Dependants
(
	Number int identity(1,1) primary key,
	Name nvarchar(50),
	BirthDate Date,
	Rote nvarchar(30),
	EmpCode varchar(20)
	foreign key (EmpCode) references Employees(EmpCode)
)
--example 2 bang co mui ten
create table Departments
(
	DeptID varchar(15) primary key,
	Name nvarchar(60),	
)

create table Offices
(
	OfficeNumber int identity(1,1) primary key,
	Address nvarchar(30),
	Phone varchar(15),
	DeptID varchar(15),
	foreign key (DeptID) references Departments(DeptID)
)

create table Employees
(
	EmployeeID int identity(1,1) primary key,
	FullName nvarchar(50),
	OfficeNumber int
	foreign key (OfficeNumber) references Offices(OfficeNumber)
)


create table WorkFor
(
	[From] Date ,
	Salary float,
	[To] Date,
	EmployeeID int,
	DeptID varchar(15),
	primary key([From],EmployeeID, DeptID)
	foreign key (EmployeeID) references Employees(EmployeeID),
	foreign key (DeptID) references Departments(DeptID)
)
--example 3 lồng  1-N vs 2 hình chữ nhật lồng nhau
create table Customers
(
	SSN varchar(20) primary key,
	[Name] nvarchar(50),
	[Address] nvarchar(255)
)

create table Loans
(
	LoanNumber varchar(20) primary key,
	Amount float, 
	[Date] Date,
	Branch nvarchar(100),
	SSN varchar(20),
	foreign key (SSN) references Customers(SSN)
)

create table Payments
(
	PaymentNo varchar(30),
	Amount float,
	[Date] Date,
	LoanNumber varchar(20),
primary key(PaymentNo, LoanNumber),
	foreign key (LoanNumber) references Loans(LoanNumber)
)

--Question 2
select * from ProductSubcategory
where Category = 'Accessories'

--Question 3
select ProductID, LocationID, Quantity from ProductInventory
where LocationID = '7' and Quantity > 250 
Order by Quantity DESC

--Question 4
select p.ProductID, p.name as ProductName, p.Price, pm.name as ModelName, ps.name as SubCategoryName, ps.Category from Product  p
full join ProductModel pm on (pm.ModelID = p.ModelID) or (p.ModelID = NULL)
full join ProductSubcategory ps on ps.SubcategoryID = p. SubcategoryID
where p.Price < 100 and Color = 'Black'

--Question 5
select ps.SubcategoryID, ps.name as SubCategoryName, ps.Category, count(p.ProductID) as NumberOfProducts from ProductSubcategory ps
join Product p on ps.SubcategoryID = p.SubcategoryID
group by ps.SubcategoryID, ps.Name, ps.Category
order by Category asc, NumberOfProducts desc, SubcategoryID asc


--Question 6
select  pl.LocationID, pl.name as LocationName, count(p.ProductID) as NumberOfProducts from Location pl
full join ProductInventory p on (pl.LocationID = p.LocationID)
group by pl.LocationID, pl.Name
having count(p.ProductID) = (
select top 1  counts.NumberOfProducts from
(select pl.LocationID, pl.name as LocationName, count(p.ProductID) as NumberOfProducts from Location pl
full join ProductInventory p on (pl.LocationID = p.LocationID)
group by pl.LocationID, pl.Name) as counts)


--Question 7
select ps.Category, ps.name as SubcategoryName, count(p.ProductID) as NumberOfProducts from ProductSubcategory ps
full join Product p on (ps.SubcategoryID = p.SubcategoryID)
group by ps.Category, ps.Name
having count(p.ProductID) = (
select MAX(counts.NumberOfProducts) from
(select ps.Category, ps.name as SubcategoryName, count(p.ProductID) as NumberOfProducts from ProductSubcategory ps
full join Product p on (ps.SubcategoryID = p.SubcategoryID)
where ps.Category = 'Components'
group by ps.Category, ps.Name) as counts)
union
select ps.Category, ps.name as SubcategoryName, count(p.ProductID) as NumberOfProducts from ProductSubcategory ps
full join Product p on (ps.SubcategoryID = p.SubcategoryID)
group by ps.Category, ps.Name
having count(p.ProductID) = (
select MAX(counts.NumberOfProducts) from
(select ps.Category, ps.name as SubcategoryName, count(p.ProductID) as NumberOfProducts from ProductSubcategory ps
full join Product p on (ps.SubcategoryID = p.SubcategoryID)
where ps.Category = 'Bikes'
group by ps.Category, ps.Name) as counts)
union
select ps.Category, ps.name as SubcategoryName, count(p.ProductID) as NumberOfProducts from ProductSubcategory ps
full join Product p on (ps.SubcategoryID = p.SubcategoryID)
group by ps.Category, ps.Name
having count(p.ProductID) = (
select MAX(a.NumberOfProducts) from
(select ps.Category, ps.name as SubcategoryName, count(p.ProductID) as NumberOfProducts from ProductSubcategory ps
full join Product p on (ps.SubcategoryID = p.SubcategoryID)
where ps.Category = 'Accessories'
group by ps.Category, ps.Name) as a)
order by NumberOfProducts DESC

--Question 7 cach 2
select b.Category, c.Name as 'SubcategoryName', b.NumberOfProduct from (select a.Category, max(a.Count) as 'NumberOfProduct' from (select s.Category, s.Name, count(s.SubcategoryID) as 'Count' from ProductSubcategory s, Product p
where s.SubcategoryID = p.SubcategoryID
group by s.Category, s.Name) as a
group by a.Category) as b, (select s.Category, s.Name, count(s.SubcategoryID) as 'Count' from ProductSubcategory s, Product p
where s.SubcategoryID = p.SubcategoryID
group by s.Category, s.Name) as c
where b.Category = c.Category and b.NumberOfProduct = c.Count
order by NumberOfProduct desc

--Question 8
go
create proc proc_product_model
@modelID int,
@numberOfProducts int Output
as 
begin
set @numberOfProducts = (select count(ProductID) from Product where ModelID = @modelID)
end
go
declare @x int 
exec proc_product_model 9, @x output
select @x as NumberOfProducts

-- Question 9
--drop trigger tr_insert_Product_Subcategory
go
create trigger tr_insert_Product_Subcategory
on Product
after insert
as
begin
select i.ProductID, i.Name as ProductName, i.SubcategoryID, ps.Name as SubcategoryName, ps.Category from inserted i
join ProductSubcategory ps on i.SubcategoryID = ps.SubcategoryID
end

insert into Product(ProductID, Name, Cost, Price, SubcategoryID, SellStartDate)
values(10125,'Product Test', 12,15,1,'2021-10-25')


--Question 10
delete from ProductInventory
where ProductID in (
select pi.ProductID from ProductInventory pi
join Product p on p.ProductID = pi.ProductID 
where p.ModelID = 33)
