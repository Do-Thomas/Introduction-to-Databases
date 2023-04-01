
Create table Managers
( bonus money,
  projectID int,
  empID int,
)

create table Employees
( empID int PRIMARY KEY,
  name nvarchar(50),
  salary money
)

Create table Works
( hours int,
  empID int PRIMARY KEY,
  projectID int PRIMARY KEY
)

Create table Project
( projectID int PRIMARY KEY,
  name nvarchar(200)
)

USE 
--Q2: Select all locations having the CostRate greater than 0 as follows:
SELECT LocationID, Name, CostRate, Availability
FROM Location 
WHERE CostRate > 0

--Q3: all product price histories having the EndDate in 2003
--having the price smaller than 100.
SELECT pph.ProductID, pph.Price, pph.StartDate, pph.EndDate
FROM ProductPriceHistory pph
WHERE pph.Price < 100  AND YEAR(pph.EndDate) =2003
ORDER BY pph.Price DESC

--Q4: Display the history costs all products having the 'Black' color
--name begining with 'HL' 
SELECT p.ProductID, p.Name AS 'ProductName', p.Color, ps.SubcategoryID, ps.Name AS SubCategoryName, ps.Category, pch.StartDate, pch.EndDate, pch.Cost AS HistoryCost
FROM Product p
LEFT JOIN ProductSubcategory ps
ON ps.SubcategoryID = p.SubcategoryID
LEFT JOIN ProductCostHistory pch
ON pch.ProductID = p.ProductID
WHERE p.Color = 'Black' AND p.Name LIKE 'HL%'

--Q5: Display LocationID, LocationName, NumberOfProducts
--correponding to each location where NumberOfProducts is 
--count of distinct products in each location.
SELECT l.LocationID, l.Name as LocationName, COUNT(*) AS NumberOfProducts
FROM ProductInventory pdi, Location l
WHERE pdi.LocationID = l.LocationID
GROUP BY l.LocationID, l.Name
ORDER BY NumberOfProducts DESC, l.Name ASC

--Q7: Display product model having the name beginning with 'HL Mountain'
--Display: ModelID, ModelName, ProductID, ProductName, NumberOfLocation
SELECT pm.ModelID, pm.Name AS ModelName, p.ProductID, p.Name AS ProductName, COUNT(p.ProductID) AS NumberOfLocations
FROM ProductInventory pdi
LEFT JOIN Product p
ON pdi.ProductID = p.ProductID
RIGHT JOIN ProductModel pm
ON pm.ModelID = p.ModelID
WHERE pm.Name LIKE 'HL Mount%'
GROUP BY pm.ModelID, pm.Name, p.ProductID, p.Name

--Q8: Calculating the number of distinct products of 
-- a given subcategory
Create proc proc_product_subcategory @subcategoryID int, @NumberOfProduct int out
AS 
BEGIN 
	set @NumberOfProduct = ( select COUNT(p.ProductID) from ProductSubcategory ps, Product p
							Where p.SubcategoryID = ps.SubcategoryID AND ps.SubcategoryID = @subcategoryID)
END
--Nộp phần create...end.
declare @x int
exec proc_product_subcategory 1, @x output
select @x as NumberOfProducts

--Q9: trigger tr_delete_productInventory_location
create trigger tr_delete_productInventory_location
ON ProductInventory instead of delete
AS
Begin 
	select d.ProductID, d.LocationID, l.Name AS LocationName, d.Shelf, d.Bin,  d.Quantity
	from deleted d, Product p, Location l 
	where d.ProductID = p.ProductID AND l.LocationID = d.LocationID
end
--Nộp phần trên create....end
delete from ProductInventory
where ProductID = 1 And LocationID = 1

--Q10: Update ProductInventory, quantity = 2000 for all products
-- belonging to the model having ModelID = 33
Update ProductInventory
set Quantity = 2000
Where ProductID in (select p.ProductID from Product p
where p.ModelID = 33)