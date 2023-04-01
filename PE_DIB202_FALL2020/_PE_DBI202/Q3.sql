select oc.CourseID, c.Title, c.Credits,de.DepartmentID,oc.URL
from OnlineCourse oc
join Course c
on oc.CourseID=c.CourseID
join Department de
on de.DepartmentID=c.DepartmentID
order by de.DepartmentID,c.Title