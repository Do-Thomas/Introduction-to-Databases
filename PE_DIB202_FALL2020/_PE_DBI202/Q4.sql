select p.PersonID, p.LastName,p.FirstName,p.HireDate,p.Discriminator,ci.CourseID,c.Title,c.DepartmentID
from Person p 
left join CourseInstructor ci
on ci.PersonID=p.PersonID
left join Course c
on c.CourseID=ci.CourseID
where Discriminator = 'Instructor'
order by DepartmentID desc, Title
