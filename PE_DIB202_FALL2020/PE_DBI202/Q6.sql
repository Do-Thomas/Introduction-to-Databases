----Q6--
select top 1 p.ProductID, p.Name,sum(Quantity) as TotalQuantity
from Product p  join ProductInventory pn on p.ProductID = pn.ProductID 
 join Location l on pn.LocationID = l.LocationID
 group by p.ProductID, p.Name
order by TotalQuantity desc