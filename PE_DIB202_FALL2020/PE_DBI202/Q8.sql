---q8---
create proc proc_product_quantity @productID int, @totalQuantity int output
as
begin
     set @totalQuantity = (

	         select sum(Quantity)
            from Product p  join ProductInventory pn on p.ProductID = pn.ProductID 
			join Location l on pn.LocationID = l.LocationID
			where p.ProductID = @productID
	 )
end