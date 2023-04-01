USE [master]
GO

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'PE_DBI202_Su2022')
BEGIN
	ALTER DATABASE [PE_DBI202_Su2022] SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE [PE_DBI202_Su2022] SET ONLINE;
	DROP DATABASE [PE_DBI202_Su2022];
END

GO

CREATE DATABASE [PE_DBI202_Su2022]
GO

USE [PE_DBI202_Su2022]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*******************************************************************************
	Drop tables if exists
*******************************************************************************/
DECLARE @sql nvarchar(MAX) 
SET @sql = N'' 

SELECT @sql = @sql + N'ALTER TABLE ' + QUOTENAME(KCU1.TABLE_SCHEMA) 
    + N'.' + QUOTENAME(KCU1.TABLE_NAME) 
    + N' DROP CONSTRAINT ' -- + QUOTENAME(rc.CONSTRAINT_SCHEMA)  + N'.'  -- not in MS-SQL
    + QUOTENAME(rc.CONSTRAINT_NAME) + N'; ' + CHAR(13) + CHAR(10) 
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS RC 

INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS KCU1 
    ON KCU1.CONSTRAINT_CATALOG = RC.CONSTRAINT_CATALOG  
    AND KCU1.CONSTRAINT_SCHEMA = RC.CONSTRAINT_SCHEMA 
    AND KCU1.CONSTRAINT_NAME = RC.CONSTRAINT_NAME 

EXECUTE(@sql) 

GO
DECLARE @sql2 NVARCHAR(max)=''

SELECT @sql2 += ' Drop table ' + QUOTENAME(TABLE_SCHEMA) + '.'+ QUOTENAME(TABLE_NAME) + '; '
FROM   INFORMATION_SCHEMA.TABLES
WHERE  TABLE_TYPE = 'BASE TABLE'

Exec Sp_executesql @sql2 
GO 

-- Create the Department table.
CREATE TABLE [Department](
[DepartmentID] [int] NOT NULL primary key,
[Name] [nvarchar](50) NOT NULL,
[Budget] [money] NOT NULL,
[StartDate] [datetime] NOT NULL,
[Administrator] [int] NULL
)
GO

-- Create the Person table.
CREATE TABLE [Person](
[PersonID] [int] NOT NULL primary key,
[LastName] [nvarchar](50) NOT NULL,
[FirstName] [nvarchar](50) NOT NULL,
[HireDate] [datetime] NULL,
[EnrollmentDate] [datetime] NULL,
[Discriminator] [nvarchar](50) NOT NULL)
GO

-- Create the OnsiteCourse table.
CREATE TABLE [OnsiteCourse](
[CourseID] [int] NOT NULL primary key,
[Location] [nvarchar](50) NOT NULL,
[Days] [nvarchar](50) NOT NULL,
[Time] [smalldatetime] NOT NULL)
GO

-- Create the OnlineCourse table.
CREATE TABLE [OnlineCourse](
[CourseID] [int] NOT NULL primary key,
[URL] [nvarchar](100) NOT NULL)
GO

--Create the StudentGrade table.
CREATE TABLE [StudentGrade](
[EnrollmentID] [int] NOT NULL primary key,
[CourseID] [int] NOT NULL,
[StudentID] [int] NOT NULL,
[Grade] [decimal](3, 2) NULL)
GO

-- Create the CourseInstructor table.
CREATE TABLE [CourseInstructor](
[CourseID] [int] NOT NULL,
[PersonID] [int] NOT NULL,
primary key (CourseID, PersonID))
GO

-- Create the Course table.
CREATE TABLE [Course](
[CourseID] [int] NOT NULL primary key,
[Title] [nvarchar](100) NOT NULL,
[Credits] [int] NOT NULL,
[DepartmentID] [int] NOT NULL)
GO

-- Create the OfficeAssignment table.
CREATE TABLE [OfficeAssignment](
[InstructorID] [int] NOT NULL primary key,
[Location] [nvarchar](50) NOT NULL)
GO

-- Define the relationship between OnsiteCourse and Course.
ALTER TABLE [OnsiteCourse] 
ADD
CONSTRAINT [FK_OnsiteCourse_Course] FOREIGN KEY([CourseID])
REFERENCES [Course] ([CourseID])
GO

-- Define the relationship between OnlineCourse and Course.
ALTER TABLE [OnlineCourse] 
ADD
CONSTRAINT [FK_OnlineCourse_Course] FOREIGN KEY([CourseID])
REFERENCES [Course] ([CourseID])
GO

-- Define the relationship between StudentGrade and Course.
ALTER TABLE [StudentGrade] 
ADD
CONSTRAINT [FK_StudentGrade_Course] FOREIGN KEY([CourseID])
REFERENCES [Course] ([CourseID])
GO

--Define the relationship between StudentGrade and Student.
ALTER TABLE [StudentGrade] 
ADD
CONSTRAINT [FK_StudentGrade_Student] FOREIGN KEY([StudentID])
REFERENCES [Person] ([PersonID])
GO

-- Define the relationship between CourseInstructor and Course.
ALTER TABLE [CourseInstructor] 
ADD
CONSTRAINT [FK_CourseInstructor_Course] FOREIGN KEY([CourseID])
REFERENCES [Course] ([CourseID])
GO

-- Define the relationship between CourseInstructor and Person.
ALTER TABLE [CourseInstructor] 
ADD
CONSTRAINT [FK_CourseInstructor_Person] FOREIGN KEY([PersonID])
REFERENCES [Person] ([PersonID])
GO

-- Define the relationship between Course and Department.
ALTER TABLE [Course] 
ADD
CONSTRAINT [FK_Course_Department] FOREIGN KEY([DepartmentID])
REFERENCES [Department] ([DepartmentID])
GO

--Define the relationship between OfficeAssignment and Person.
ALTER TABLE [OfficeAssignment] 
ADD
CONSTRAINT [FK_OfficeAssignment_Person] FOREIGN KEY([InstructorID])
REFERENCES [Person] ([PersonID])
GO

-- Insert data into the Person table.
GO
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (1, 'Abercrombie', 'Kim', '1995-03-11', null, 'Instructor');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (2, 'Barzdukas', 'Gytis', null, '2005-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (3, 'Justice', 'Peggy', null, '2001-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (4, 'Fakhouri', 'Fadi', '2002-08-06', null, 'Instructor');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (5, 'Harui', 'Roger', '1998-07-01', null, 'Instructor');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (6, 'Li', 'Yan', null, '2002-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (7, 'Norman', 'Laura', null, '2003-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (8, 'Olivotto', 'Nino', null, '2005-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (9, 'Tang', 'Wayne', null, '2005-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (10, 'Alonso', 'Meredith', null, '2002-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (11, 'Lopez', 'Sophia', null, '2004-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (12, 'Browning', 'Meredith', null, '2000-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (13, 'Anand', 'Arturo', null, '2003-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (14, 'Walker', 'Alexandra', null, '2000-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (15, 'Powell', 'Carson', null, '2004-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (16, 'Jai', 'Damien', null, '2001-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (17, 'Carlson', 'Robyn', null, '2005-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (18, 'Zheng', 'Roger', '2004-02-12', null, 'Instructor');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (19, 'Bryant', 'Carson', null, '2001-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (20, 'Suarez', 'Robyn', null, '2004-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (21, 'Holt', 'Roger', null, '2004-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (22, 'Alexander', 'Carson', null, '2005-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (23, 'Morgan', 'Isaiah', null, '2001-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (24, 'Martin', 'Randall', null, '2005-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (25, 'Kapoor', 'Candace', '2001-01-15', null, 'Instructor');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (26, 'Rogers', 'Cody', null, '2002-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (27, 'Serrano', 'Stacy', '1999-06-01', null, 'Instructor');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (28, 'White', 'Anthony', null, '2001-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (29, 'Griffin', 'Rachel', null, '2004-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (30, 'Shan', 'Alicia', null, '2003-09-01', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (31, 'Stewart', 'Jasmine', '1997-10-12', null, 'Instructor');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (32, 'Xu', 'Kristen', '2001-7-23', null, 'Instructor');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (33, 'Gao', 'Erica', null, '2003-01-30', 'Student');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (34, 'Van Houten', 'Roger', '2000-12-07', null, 'Instructor');
INSERT INTO Person (PersonID, LastName, FirstName, HireDate, EnrollmentDate, Discriminator)
VALUES (35, 'Mickael', 'Dupont', '2003-12-07', null, 'Instructor');
GO

-- Insert data into the Department table.
INSERT INTO Department (DepartmentID, [Name], Budget, StartDate, Administrator)
VALUES (1, 'Engineering', 350000.00, '2007-09-01', 2);
INSERT INTO Department (DepartmentID, [Name], Budget, StartDate, Administrator)
VALUES (2, 'English', 120000.00, '2007-09-01', 6);
INSERT INTO Department (DepartmentID, [Name], Budget, StartDate, Administrator)
VALUES (4, 'Economics', 200000.00, '2007-09-01', 4);
INSERT INTO Department (DepartmentID, [Name], Budget, StartDate, Administrator)
VALUES (7, 'Mathematics', 250000.00, '2007-09-01', 3);
GO



-- Insert data into the Course table.
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (1050, 'Chemistry', 4, 1);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (1061, 'Physics', 4, 1);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (1045, 'Calculus', 4, 7);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (2030, 'Poetry', 2, 2);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (2021, 'Composition', 3, 2);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (2042, 'Literature', 4, 2);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (4022, 'Microeconomics', 3, 4);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (4041, 'Macroeconomics', 3, 4);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (4061, 'Quantitative', 2, 4);
INSERT INTO Course (CourseID, Title, Credits, DepartmentID)
VALUES (3141, 'Trigonometry', 4, 7);
GO

-- Insert data into the OnlineCourse table.
INSERT INTO OnlineCourse (CourseID, URL)
VALUES (2030, 'http://www.fineartschool.net/Poetry');
INSERT INTO OnlineCourse (CourseID, URL)
VALUES (2021, 'http://www.fineartschool.net/Composition');
INSERT INTO OnlineCourse (CourseID, URL)
VALUES (4041, 'http://www.fineartschool.net/Macroeconomics');
INSERT INTO OnlineCourse (CourseID, URL)
VALUES (3141, 'http://www.fineartschool.net/Trigonometry');

--Insert data into OnsiteCourse table.
INSERT INTO OnsiteCourse (CourseID, Location, Days, [Time])
VALUES (1050, '123 Smith', 'MTWH', '11:30');
INSERT INTO OnsiteCourse (CourseID, Location, Days, [Time])
VALUES (1061, '234 Smith', 'TWHF', '13:15');
INSERT INTO OnsiteCourse (CourseID, Location, Days, [Time])
VALUES (1045, '121 Smith','MWHF', '15:30');
INSERT INTO OnsiteCourse (CourseID, Location, Days, [Time])
VALUES (4061, '22 Williams', 'TH', '11:15');
INSERT INTO OnsiteCourse (CourseID, Location, Days, [Time])
VALUES (2042, '225 Adams', 'MTWH', '11:00');
INSERT INTO OnsiteCourse (CourseID, Location, Days, [Time])
VALUES (4022, '23 Williams', 'MWF', '9:00');

-- Insert data into the CourseInstructor table.
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (1050, 1);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (1061, 31);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (1045, 5);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (2030, 4);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (2021, 27);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (2042, 25);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (4022, 18);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (4041, 32);
INSERT INTO CourseInstructor(CourseID, PersonID)
VALUES (4061, 34);
GO

--Insert data into the OfficeAssignment table.
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (1, '17 Smith');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (4, '29 Adams');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (5, '37 Williams');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (18, '143 Smith');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (25, '57 Adams');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (27, '271 Williams');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (31, '131 Smith');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (32, '203 Williams');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (34, '213 Smith');
INSERT INTO OfficeAssignment(InstructorID, Location)
VALUES (35, '213 Williams');

-- Insert data into the StudentGrade table.
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (1,2021, 2, 4);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (2,2030, 2, 3.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (3,2021, 3, 3);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (4,2030, 3, 4);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (5,2021, 6, 2.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (6,2042, 6, 3.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (7,2021, 7, 3.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (8,2042, 7, 4);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (9,2021, 8, 3);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (10,2042, 8, 3);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (11,4041, 9, 3.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (12,4041, 10, null);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (13,4041, 11, 2.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (14,4041, 12, null);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (15,4061, 12, null);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (16,4022, 14, 3);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (17,4022, 13, 4);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (18,4061, 13, 4);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (19,4041, 14, 3);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (20,4022, 15, 2.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (21,4022, 16, 2);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (22,4022, 17, null);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (23,4022, 19, 3.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (24,4061, 20, 4);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (25,4061, 21, 2);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (26,4022, 22, 3);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (27,4041, 22, 3.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (28,4061, 22, 2.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (29,4022, 23, 3);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (30,1045, 23, 1.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (31,1061, 24, 4);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (32,1061, 25, 3);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (33,1050, 26, 3.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (34,1061, 26, 3);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (35,1061, 27, 3);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (36,1045, 28, 2.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (37,1050, 28, 3.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (38,1061, 29, 4);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (39,1050, 30, 3.5);
INSERT INTO StudentGrade (EnrollmentID,CourseID, StudentID, Grade)
VALUES (40,1061, 30, 4);
GO