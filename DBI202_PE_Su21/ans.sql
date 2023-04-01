--2.Select all products of the category 'Cyclocross Bicycles'
Select *
From products
Where category_name Like 'Cyclocross Bicycles'
--3. product_name, model_year, list_price, brand_name
--the brand 'Trek' and model_year= 2018, list_price > 3000
--order by list_price asc
Select product_name, model_year, list_price, brand_name
From products
Where brand_name LIKE 'Trek%' and model_year = 2018 and list_price >3000
Order by list_price asc
--4. order_i, order_date, customer_id, first name, last_name, store_name
--order_date: 2016-01-..
--store_name: Santa Cruz Bikes
Select o.order_id, o.order_date, c.customer_id, c.first_name, c.last_name, s.store_name
From orders o
Inner join customers c
On o.customer_id = c.customer_id
Inner join stores s
On o.store_id = s.store_id
Where o.order_date Like '2016-01%' and s.store_name Like 'Santa Cruz Bikes'
--5. store_id, store_name, NumberOfOrdersIn2018
--NumberOfOrdersIn2018: is the number of orders made in 2018 in each store
--NumberOfOrdersIn2018 desc
Select s.store_id, s.store_name, Count(o.order_id) as NumberOfOrdersIn2018
From stores s
Inner join orders o
On s.store_id = o.store_id
Where o.order_date LIKE '2018%'
Group by s.store_id, s.store_name
Order by NumberOfOrdersIn2018 desc
--6.product_id, product_name, model_year, TotalStockQuantity
--TotalStockQuantity: is the total stock quantity of the products
Select p.product_id, p.product_name, p.model_year, Count(s.quantity) as TotalStockQuantity
From products p
Inner join stocks s
On p.product_id = s.product_id
Group by p.product_id, p.product_name, p.model_year

--7.
Select s.store_name, st.staff_id, st.first_name, st.last_name , Count(o.order_id) as NumberOfOrders
From staffs st
Inner join stores s
On st.store_id = s.store_id
Inner join orders o
On st.staff_id = o.staff_id
Group by s.store_name , st.staff_id, st.first_name, st.last_name
Having Count(s.store_name) in (select max(a.max1) from (
														select	s.store_name, o.staff_id, count(*)  as max1
														from orders o
														full join stores s
														ON o.store_id = s.store_id
														group by s.store_name, o.staff_id) as a
							 Group by a.store_name)
Order by s.store_name asc
							 ---
--8. stored procedure named pr1 to calculate the number of staffs
--@store_id int: input, @numberOfStaffs int: output
Drop proc pr1
Create proc pr1 @store_id int, @numberOfStaffs int output
as 
begin
	set @numberOfStaffs = (select min(s.store_id) as NumberOfStaffs
							from staffs st inner join stores s
							on st.store_id = s.store_id
							where s.store_id = @store_id
							group by s.store_id)
end

-------------------------------------------------------------------
declare @x int
exec pr1 3, @x output
select @x as NumberOfStaffs

--9. Create trigger Tr2 to delete Stocks
Create trigger Tr2 
on stocks
for delete 
as 
begin 
	select d.product_id, p.product_name, s.store_id, s.store_name, d.quantity
	from deleted d, products p, stores s
	where d.product_id = p.product_id and s.store_id = d.store_id
end

---------------------------------
select *from stocks
delete from stocks
where store_id = 1 and product_id in (10,11,12)

--10.update the stock quantity = 30 for all products of the category
--'Cruisers Bicycles' in the store with store_id = 1

update stocks
set quantity = 30
where store_id = 1 and product_id in (select p.product_id
									   from products p
									   where p.category_name LIKE 'Cruisers Bicycles')