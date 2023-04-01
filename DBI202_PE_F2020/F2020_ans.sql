--Q2
select *
from ranking_criteria

--Q3
select ranking_system_id, criteria_name
from ranking_criteria
where ranking_system_id = 1 or ranking_system_id =2
order by ranking_system_id asc, criteria_name asc


--Q4
select university.id as university_id, university.university_name, university_year.year, 
university_year.num_students, university_year.pct_international_students
from university
inner join university_year
on university.id = university_year.university_id
where university_year.year = 2016 and university_year.pct_international_students > 30
order by university.university_name asc


--Q5
select ra.ranking_system_id, r.system_name, count(*) as numberOfCriteria
from ranking_criteria ra, ranking_system r
where ra.ranking_system_id = r.id
group by ra.ranking_system_id, r.system_name
order by numberOfCriteria desc


--Q6
select u.id as university_id, u.university_name, y.year, y.student_staff_ratio
from university u, university_year y
where u.id = y.university_id and y.year = 2015 
and y.student_staff_ratio in (select min(university_year.student_staff_ratio)
                              from university_year)


--Q7
select u.id as university_id, u.university_name, ur.ranking_criteria_id, c.criteria_name, ur.year, ur.score
from university u, university_ranking_year ur, ranking_criteria c
where u.id = ur.university_id and ur.ranking_criteria_id = c.id
and ur.year = 2016 and c.criteria_name = 'Teaching'
and ur.score in (select ur.score
                  from)
order by ur.score desc


--Q8
drop proc proc_university_year
create proc proc_university_year @year int, @pct_international_students int, @nbUniversity int output
as
begin
	declare @count1 int
	select @count1 = count(*) from university_year u where u.year = @year and u.pct_international_students > @pct_international_students
	set @nbUniversity = @count1
end

declare @out int
exec proc_university_year 2011,30, @out output
select @out as NumberOfUniversities


--Q9
drop trigger tr_insert_university_ranking 
create trigger tr_insert_university_ranking 
on university_ranking_year instead of insert
as 
begin
 select * from inserted
	order by score ASC
end

insert into university_ranking_year(university_id, ranking_criteria_id, year, score) values(1,1,2020, 99)
,(12,2,2020, 67)

--Q10
insert into ranking_system(id, system_name)
VALUES (4, 'QS World University Rankings')



