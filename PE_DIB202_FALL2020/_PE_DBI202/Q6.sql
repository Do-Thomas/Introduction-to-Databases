select  top (1) d.DepartmentID,d.Name, count(oc.CourseID) as NumberOfOnlineCourse
from OnlineCourse oc
join Course c
on c.CourseID=oc.CourseID
join Department d
on d.DepartmentID=c.DepartmentID
group by d.DepartmentID,d.Name
