use [PE_DBI202_F2021]

select * from Product

--2
select * from ProductSubcategory 
where Category = 'Accessories'

--3
select pro.ProductID, proi.LocationID, proi.Quantity from product pro
join ProductInventory proi 
on pro.ProductID = proi.ProductID
where proi.LocationID = 7 and proi.Quantity >= 250
order by quantity desc

--4
select pro.ProductID,pro.Name,pro.Cost,pro.Price,proi.LocationID,lo.Name,proi.Shelf,proi.Bin, proi.Quantity
from product pro
left join ProductInventory proi 
on pro.ProductID = proi.ProductID
left join Location lo on proi.LocationID = lo.LocationID
where color = 'yellow' and cost <= 400

--5
select prom.ModelID , prom.Name,  count(distinct pro.ProductID) as 'NumberOfProduct' from ProductModel prom
join Product pro on prom.ModelID = pro.ModelID
group by prom.ModelID , prom.Name
having prom.name like 'Mountain%' or prom.name like 'ML mountain%' 
order by count(distinct pro.ProductID) desc

--6

select ProductID, Name, s.TotalQuantity from (select pro.ProductID, pro.Name, sum(proi.Quantity) as TotalQuantity 
from product pro
join ProductInventory proi on pro.ProductID = proi.ProductID
group by pro.ProductID, pro.Name) s
where (TotalQuantity >= All(select TotalQuantity from (select pro.ProductID, pro.Name, sum(proi.Quantity) as TotalQuantity 
from product pro
join ProductInventory proi on pro.ProductID = proi.ProductID
group by pro.ProductID, pro.Name) s) )

--7
select table1.LocationID, lct.Name, prdI.ProductID, prd.Name, table1.Quantity 
	 from (select lct.LocationID, max(prdI.Quantity) as Quantity
	 from Product prd inner join ProductInventory prdI on prd.ProductID = prdI.ProductID
	 inner join Location lct on prdI.LocationID = lct.LocationID
	 group by lct.LocationID) table1
	 inner join ProductInventory prdI on table1.LocationID = prdI.LocationID
	 inner join Product prd on prdI.ProductID = prd.ProductID
	 inner join Location lct on prdI.LocationID = lct.LocationID
	   where prdI.Quantity = table1.Quantity
	   order by lct.Name , prd.Name desc


		


