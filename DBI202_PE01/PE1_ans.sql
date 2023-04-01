Create table Employees (
EmpID int not null primary key,
salary money not null,
name nvarchar(50) not null
)

create table Managers (
bonus money ,
foreign key EmpID int references Employees(EmpID)
)

Create table Projects(
ProjectID int not null primary key,
name nvarchar(200) not null

)

create table Works 
(
hours int,
ProjectID int, 
EmpID int,
primary key (ProjectID, EmpID),
foreign key ProjectID int references Projects(ProjectID),
foreign key EmpID int references Employees(EmpID)

)

--Q2
select LocationID, Name, CostRate, Availability
from Location
where CostRate > 0

--Q3
select Product.ProductID, Product.Price, ProductPriceHistory.StartDate, ProductPriceHistory.EndDate
from Product
full join ProductPriceHistory
on Product.ProductID = ProductPriceHistory.ProductID
where YEAR(EndDate) >= 2003 and Product.Price < 100
order by Product.Price desc

--Q4
select Product.ProductID, Product.Name as ProductName, Product.Color, 
ProductSubcategory.SubcategoryID,ProductSubcategory.Name as SubCategoryName, ProductSubcategory.Category,
ProductPriceHistory.StartDate, ProductPriceHistory.EndDate, ProductPriceHistory.Price as HistoryCost
from Product
full join ProductPriceHistory
on Product.ProductID = ProductPriceHistory.ProductID
full join ProductSubcategory
on Product.SubcategoryID = ProductSubcategory.SubcategoryID
where Product.Color = 'Black' and Product.Name like 'HL%'

--Q5
select Location.LocationID,   Location.Name  , count(ProductInventory.Quantity) as NumberOfProducts
from Location
inner join ProductInventory
on Location.LocationID = ProductInventory.LocationID
group by Location.LocationID, Location.Name
order by count(ProductInventory.Quantity) desc, Location.Name asc

--Q7
select ProductModel.ModelID, ProductModel.Name as ModelName,Product.ProductID, Product.Name as ProductNameventory, count(Product.ProductID) as NumberOfLocations
from ProductInventory 
left join Product 
on ProductInventory.ProductID = Product.ProductID 
right join ProductModel
on  ProductModel.ModelID = Product.ModelID
where ProductModel.Name like 'HL Mountain%'
group by   ProductModel.ModelID, ProductModel.Name,Product.ProductID, Product.Name

--Q8
drop proc proc_product_subcategory  
/*sau khi run create thi run drop ben tren va luc nop bai thi xoa dong drop tren*/
create proc proc_product_subcategory @subcategoryID int, @numberOfProduct int out
as
begin
   set @numberOfProduct = (select count(p.ProductID) from ProductSubcategory ps, Product p
                           where p.SubcategoryID = ps.SubcategoryID and ps.SubcategoryID = @subcategoryID)
end

declare @x int
exec proc_product_subcategory 1, @x output
select @x as NumberOfProducts

--Q9
drop trigger tr_delete_productInventory_location
create trigger tr_delete_productInventory_location
ON ProductInventory instead of delete
as 
begin
   select d.ProductID, d.LocationID,  l.Name as LocationName, d.Shelf, d.Shelf, d.Quantity 
   from deleted d, Product p, Location l
   where d.ProductID = p.ProductID and l.LocationID = d.LocationID
end

delete from ProductInventory
where ProductID=1 and LocationID=1