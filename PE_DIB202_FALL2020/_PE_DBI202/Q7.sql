select c.CourseID,c.Title,c.Credits,d.Name as DepartmentName,p.PersonID,p.LastName,p.FirstName, p.Discriminator,m.Grade
from Course c
join Department d
on d.DepartmentID=c.DepartmentID
join StudentGrade sg
on sg.CourseID = c.CourseID
join Person p
on p.PersonID=sg.StudentID
join (select CourseID,max(Grade) as Grade
from StudentGrade
group by CourseID) m
on m.CourseID=c.CourseID and m.Grade=sg.Grade
group by c.CourseID,c.Title,c.Credits,d.Name,p.PersonID,p.LastName,p.FirstName, p.Discriminator,m.Grade
order by DepartmentName asc,Title asc, FirstName asc
