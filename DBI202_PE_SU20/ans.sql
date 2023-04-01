--Q1
/*after run create database then delete, just submit code create table*/
-- create database ...
create table Genres (
   Genres varchar(50) primary key,
   Description nvarchar(200)
)

create table Movies(
   MovieNumber int identity(1,1) primary key,
   Tittle nvarchar(200),
   Year int,
   Genres varchar(50),
   foreign key (Genres) references Genres(Genres)
)

create table Persons(
   PersonID int identity(1,1) primary key,
   FullName nvarchar(200),
   Gender nvarchar(10)
)

create table Rate (
   Time DateTime,
   Comment text,
   NumericRating float,
   MovieNumber int,
   PersonID int,
   primary key (MovieNumber, PersonID),
   foreign key (MovieNumber) references Movies(MovieNumber),
   foreign key (PersonID) references Persons(PersonID)

)


--Q2
select *
from customers
where state = 'CA'


--Q3
select o.orderNumber, o.productCode, o.quantityOrdered, o.priceEach
from orderdetails o
where o.productCode = 'S18_1749' and o.quantityOrdered > 25
order by o.priceEach asc, o.quantityOrdered desc


--Q4
select o.orderNumber, o.orderDate, o.requiredDate, o.shippedDate, o.status, c.customerNumber, c.customerName, c.city, c.country
from orders o
inner join customers c
on o. customerNumber = c.customerNumber
where o.shippedDate is null and c.country = 'USA'
order by c.customerName asc


--Q5
select c.customerNumber, c.customerName, c.city, c.country, sum(p.amount) as totalAmountOfPayments
from customers c
left join payments p
on c.customerNumber = p.customerNumber
where country ='Germany'
group by  c.customerNumber, c.customerName, c.city, c.country
order by totalAmountOfPayments asc


--Q6
select *
from employees e
where employeeNumber not in (select e.employeeNumber
                             from employees e
							 inner join customers c
							 on c.salesRepEmployeeNumber = e.employeeNumber)



--Q8
drop proc proc_numberOfOrders
create proc proc_numberOfOrders @customerNumber int, @numberOfOrders int out
as
begin
	set @numberOfOrders = (select count(customers.customerNumber)
						from customers, orders
						 where customers.customerNumber = orders.customerNumber and customers.customerNumber = @customerNumber
						 )
end

declare @x int
exec proc_numberOfOrders 103, @x output
select @x as NumberOfOrders


--Q9
create trigger tr_insertPayment
on payments after insert
as
begin
    select i.customerNumber, c.customerName, i.checkNumber, i.paymentDate, i.amount
	from inserted i, customers c
	where i.customerNumber = c.customerNumber
end

insert into payments (customerNumber, checkNumber, paymentDate, amount)
values(103,'HQ336364','2004-10-29',1000), (112,'QM789234','2005-10-30',200)

--Q10
delete from products
where productCode not in (select productCode from orderdetails)

