create trigger insertCourseInstructor
on CourseInstructor
for insert 
as
	begin
		select i.CourseID,c.Title,i.PersonID,p.FirstName,p.LastName
		from inserted i
		join Course c
		on c.CourseID=i.CourseID
		join Person p
		on p.PersonID=i.PersonID
	end

