---q9

drop trigger tr_insert_Product_Subcategory
create trigger tr_insert_Product_Subcategory
on Product
after insert
as
begin
	select * from inserted  
	select i.ProductID, i.Name as ProductName, i.SubcategoryID, ps.Name as SubcategoryName, ps.Category from inserted i
	join ProductSubcategory ps on i.SubcategoryID = ps.SubcategoryID
end

