with T as
(select P.ProductID, P.Name , sum(PI.Quantity) as TotalQuantity
from Product P,[Location] L, ProductInventory [PI]
where L.LocationID = PI.LocationID and P.ProductID = PI.ProductID
group by P.ProductID, P.Name )
Select T.*
from T 
where T.TotalQuantity = (Select Max(T.TotalQuantity) from T)

