create proc proc_product_quantity
@productID int, @totalQuantity int output
as 
begin
	set @totalQuantity = (select SUM([PI].Quantity)
	from ProductInventory [PI]
	WHERE [PI].ProductID = @productID)
END

