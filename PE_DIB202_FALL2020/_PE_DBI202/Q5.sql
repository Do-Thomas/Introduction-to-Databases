select c.CourseID,c.Title,c.Credits,c.DepartmentID,count(ci.PersonID) as NumberOfInstructors,count(sg.StudentID) as NumberOfStudents
from Course	 c
left join CourseInstructor ci
on c.CourseID = ci.CourseID
left join StudentGrade sg
on sg.CourseID = c.CourseID
group by c.CourseID,c.Title,c.Credits,c.DepartmentID
order by DepartmentID, NumberOfStudents desc,Title