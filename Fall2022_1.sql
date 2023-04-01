--Fall2022 - Đợt 1
--Q2: In department 5, salary is between 30000 and 40000
Select *
From EMPLOYEE e
Where e.Dno = 5 and e.Salary between 30000 and 40000
--Q3: Write a query to retrieve the first, last employee's
--or his or her immediate supervisor
--descending Firstname
select e1.Fname, e1.Lname, e2.Fname, e2.Lname
from EMPLOYEE e1
join EMPLOYEE e2 on e1.Super_ssn = e2.Ssn
order by e1.Fname desc
--Q4: Name  of employee who has a dependent with the same
--first name and is the same sex as the employee
select e.Fname, e.Lname
from EMPLOYEE e
join [DEPENDENT] d on e.Ssn = d.Essn
where e.Fname = d.Dependent_name and e.Sex = d.Sex
--Q5: Dnumber, Dname, NumOfEmployees
-- Each department that has more than 5 employees
--NumberOfEmployees: count of employees who are malding > $40000
--NumberOfEmployees descending
select a.Dno,a.Dname,b.NumberOfEmployee from
(select distinct e.Dno,d.Dname from EMPLOYEE e, DEPARTMENT d
where e.Dno = d.Dnumber
group by e.Dno,d.Dname
having count(distinct Ssn) > 5) as a
join
(select Dno,count(ssn) as NumberOfEmployee from EMPLOYEE
where Salary > 40000
group by Dno) as b
on a.Dno = b.Dno
--Q6: Fname, Lname, Salary, Dname of highest paid employee of
--each department
with t as (select e.Fname,e.Lname,e.Salary,d.Dname from EMPLOYEE e, DEPARTMENT d
where e.Dno = d.Dnumber
group by e.Fname,e.Lname,e.Salary,d.Dname)

select * from t t1 
where t1.Salary = (select max(t2.Salary)
from t t2 
where t1.Dname = t2.Dname)
--Q7: Dnumber, Dname of the department that has no employees
--involved in a project named ProductX
select Dnumber,Dname from DEPARTMENT
where Dnumber not in(
select d.Dnumber from DEPARTMENT d inner join PROJECT p on d.Dnumber=p.Dnum
where p.Pname='ProductX')
--Q8: Create stored pro proc_CountEmp to calculate the count of 
--employees Department where 
--@depNo int: input, @numOfEmps int output
create proc proc_CountEmp (@depNo int, @numOfEmps int output)
as
begin
set @numOfEmps = (select count(*)
from DEPARTMENT d
join EMPLOYEE e on e.Dno = d.Dnumber
where d.Dnumber = @depNo)
end
--Q9:Create a trigger tr_checkWage for the insert Employess
-- Display 'High salary' if the newly added employees's salary
-- is greater than the employee's salary is greater than the
--employee's direct manager's salary,
--otherwise 'Normal salary'
create trigger tr_checkWage on Employee
for insert
as
begin
if (select e2.Salary - i.Salary
from EMPLOYEE e1
join EMPLOYEE e2 on e1.Super_ssn = e2.Ssn
join inserted i on i.Ssn = e1.Ssn) >= 0
	begin
		select 'Normal salary' as [Salary level]
	end
else
	begin
		select 'High salary' as [Salary level]
	end
end