
---Q4---
select p.ProductID, p.Name as ProductName, Color,Cost,Price,l.LocationID,l.Name as LocationName,
Shelf,Bin,Quantity
from Product p left join ProductInventory pn on p.ProductID = pn.ProductID 
left join Location l on pn.LocationID = l.LocationID
where Color = 'Yellow' and Cost < 400