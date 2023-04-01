--Q2
select * 
from products
where category_name = 'Cyclocross Bicycles'

--Q3
select product_name, model_year, list_price, brand_name
from products
where brand_name = 'Trek' and model_year = 2018 and list_price > 3000
order by list_price asc

--Q4
select orders.order_id, orders.order_date,customers.customer_id, customers.first_name, customers.last_name, stores.store_name
from orders
inner join stores
on orders.store_id = stores.store_id
inner join customers
on customers.customer_id = orders.order_id
where month(orders.order_date) = 1 and year(orders.order_date) = 2016 and stores.store_name = 'Santa Cruz Bikes'

--Q5
select stores.store_id, stores.store_name, count(orders.order_id) as NumberOfOrdersIn2018
from orders
inner join stores
on orders.store_id = stores.store_id
where year(orders.order_date) = 2018
group by stores.store_id, stores.store_name
order by NumberOfOrdersIn2018 desc

--Q6: in ra nhung gtri lon nhat cua sum(quantity)
select products.product_id, products.product_name, products.model_year, sum(stocks.quantity) as TotalStockQuantity
from products
full join stocks
on products.product_id = stocks.product_id
group by products.product_id, products.product_name, products.model_year
having sum(stocks.quantity) in (select top 1 sum(stocks.quantity) 
                               from products, stocks
							   where products.product_id = stocks.product_id
							   group by products.product_id
							   order by sum(stocks.quantity) desc)

					
--Q7
select * 
from (select s.store_name, o.staff_id, st.first_name, st.last_name, count(s.store_name) as NumberOfOrders  
     from orders o, stores s, staffs st
     where st.staff_id = o.staff_id and o.store_id = s.store_id
     group by s.store_name, o.staff_id, st.first_name, st.last_name
     having count(s.store_name) in (select max(a.NumberOfOrders) 
	                                from (select s.store_name, count(*) as NumberOfOrders  from orders o, stores s
                                          where o.store_id = s.store_id
                                          group by s.store_name, o.staff_id) as a
                                    group by a.store_name)) as c
order by c.store_name ASC

--Q8
drop  proc pr1
create proc pr1 @store_id int, @numberOfStaffs int out
as
begin
    set @numberOfStaffs = (select count(staffs.staff_id)
	                        from staffs, stores
							where staffs.store_id = stores.store_id and staffs.store_id = @store_id)
end

declare @x int
exec pr1 3, @x output
select @x as NumberOfStaffs


--Q9
drop trigger Tr2
create trigger Tr2
on stocks after delete
as
begin
    select d.product_id, p.product_name, d.store_id, s.store_name, d.quantity 
	from products p, deleted d, stores s
	where  p.product_id = d.product_id and s.store_id=d.store_id 
end

delete from stocks
where store_id = 1 and product_id in (10,11,12)

--Q10: Update stocks quantity =30 for all products of the category 'Cruisers Bicycles' and store_id =1
update stocks
set quantity = 30
where store_id = 1 and product_id in (select p.product_id
                                      from products p, stocks s
									  where p.product_id = s.product_id 
									  and p.category_name = 'Cruisers Bicycles' and s.store_id = 1)


