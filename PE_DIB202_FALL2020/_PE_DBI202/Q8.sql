create proc Proc2
@Title nvarchar(100),
@numberOfEnrolledPersons int output
as
	begin
		select @numberOfEnrolledPersons =  m.NumberOfEnrolled from
		(
				select c.Title,count(EnrollmentID) as NumberOfEnrolled
				from Course c
				join StudentGrade sg
				on sg.CourseID = c.CourseID
				group by c.Title
		) m
		where m.Title = @Title
	end