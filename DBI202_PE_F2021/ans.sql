/*Q2: */
Select SubcategoryID, Category, Name
from ProductSubcategory
where Category = 'Accessories'

/*Q3: */
select ProductID, LocationID, Quantity
from ProductInventory
where LocationID=7 and Quantity > 250
order by Quantity desc

/*Q4: */
select E.ProductID, E.Name as ProductName, E.Color, E.Cost, E.Price, L.LocationID, L.Name as LocationName, I.Shelf, I.Bin, I.Quantity
from ProductInventory I
full join Product E
on E.ProductID = I.ProductID
full join Location L
on L.LocationID = I.LocationID
where E.Color = 'yellow' and E.Cost < 400

/*Q5:*/
select ProductModel.ModelID, ProductModel.Name , count(*) as 'NumberOfProducts'
from ProductModel
left join Product
on Product.ModelID = ProductModel.ModelID
where ProductModel.Name in (select ProductModel.Name
                from ProductModel
				where ProductModel.Name like  'Mountain%'
				or ProductModel.Name like  'ML Mountain%')
group by   ProductModel.ModelID, ProductModel.Name 

order by count(*) desc, ProductModel.Name asc


/*Q6: */
select Product.ProductID, Product.Name, sum(ProductInventory.Quantity) as 'TotalQunatity'
from Product
inner join ProductInventory
on Product.ProductID = ProductInventory.ProductID
group by Product.ProductID, Product.Name
having Product.ProductID in (SELECT TOP 1 Product.ProductID
                            FROM Product, ProductInventory
							WHERE Product.ProductID = ProductInventory.ProductID
							GROUP BY Product.ProductID
							ORDER BY SUM(ProductInventory.Quantity) DESC)


/*Q7: */
select *
from ( select  distinct Location.LocationID, Location.Name as 'LocationName',Product.ProductID, Product.Name as 'ProductName', ProductInventory.Quantity
from ProductInventory
inner join Product
on ProductInventory.ProductID = Product.ProductID
inner join Location
on ProductInventory.LocationID = Location.LocationID
group by Location.LocationID, Location.Name ,Product.ProductID, Product.Name, ProductInventory.Quantity
having ProductInventory.Quantity in (select top 1 ProductInventory.Quantity
                                     from (select Location.LocationID from Location, ProductInventory
									       where Location.LocationID = ProductInventory.LocationID
										   group by Location.LocationID, ProductInventory.Quantity) as a
									        group by a.LocationID
											order by ProductInventory.Quantity desc)) as c
											order by c.LocationName asc, c.ProductName desc


--Q8

create proc proc_product_quantity @productID int, @totalQuantity int out
as
begin
    set @totalQuantity = (select sum(ProductInventory.Quantity)
	                      from Product, ProductInventory
						  where Product.ProductID = ProductInventory.ProductID)
end

declare @x int
exec proc_product_quantity 1, @x output
select @x as TotalQuantity


--Q9
drop trigger tr_insert_Product
create trigger tr_insert_Product
on Product after insert
as
begin
    select i.ProductID, i.Name as ProductName, i.ModelID, m.Name as ModelName
	from inserted i, ProductModel m
	where i.ModelID = m.ModelID
end

insert into Product(ProductID, Name, Cost, Price, ModelID, SellStartDate) 
values(1000, 'Product Test', 12.5, 15.5, 1, '2021-10-25')


--Q10
delete ProductInventory 
from ProductInventory
inner join Location
on ProductInventory.LocationID = Location.LocationID
where Location.Name = 'Tool Crib'


/*Update:
Update tenbang
Set gtri = …
Where 
--------------
update stocks 
set quantity = 30
where store_id = 1 and product_id in (select p.product_id from products p
where p.category_name = 'Cruisers Bicycles')
*/