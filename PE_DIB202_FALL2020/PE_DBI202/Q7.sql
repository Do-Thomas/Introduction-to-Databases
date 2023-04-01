---Q7---
select py.LocationID, ln.[Name] AS LocationName, py.ProductID, pt.[Name] AS ProductName, Quantity
from ProductInventory py
join [Location] ln on py.LocationID = ln.LocationID
join Product pt on py.ProductID = pt.ProductID
join (select LocationID, max(quantity) AS MQ
              from ProductInventory
              group by LocationID) fm
on py.LocationID = fm.LocationID
where Quantity = MQ
order by LocationName , ProductName DESC