select p.ProductID, p.Name,Price
from Product p  join ProductInventory pn on p.ProductID = pn.ProductID 
 join Location l on pn.LocationID = l.LocationID
where l.Name = 'Paint Shop'
order by Price desc