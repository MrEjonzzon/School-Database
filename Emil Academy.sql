--Början av Script
GO

--Skapar Databasen Emil Academy
CREATE DATABASE [Emil Academy]

GO
USE [Emil Academy]

--Skapar tabeller--------------------------------------------------------------------------------------------------------

--Lärare
CREATE TABLE Teacher
(
	TeacherID INT IDENTITY(101, 1) NOT NULL,
	FirstName VARCHAR(25) NOT NULL,
	LastName VARCHAR(25) NOT NULL,
	Phone VARCHAR(20) NOT NULL,
	Email VARCHAR(50), 
	Salary INT NOT NULL
	PRIMARY KEY (TeacherID)
)

-------------------------------------------------------------------------------------------------------------------------

--Kurser
CREATE TABLE Course
(
	CourseID INT IDENTITY(1, 1) NOT NULL,
	CourseName VARCHAR(50) NOT NULL,
	CourseTeacher INT NOT NULL
	PRIMARY KEY(CourseID)
	FOREIGN KEY (CourseTeacher) REFERENCES Teacher(TeacherID)
)

-------------------------------------------------------------------------------------------------------------------------

--Elever
CREATE TABLE Student
(
	StudentID INT IDENTITY(1001, 1) NOT NULL,
	FirstName VARCHAR(25) NOT NULL,
	LastName VARCHAR(25) NOT NULL,
	Phone VARCHAR(20) NOT NULL,
	Email VARCHAR(50)
	PRIMARY KEY(StudentID)
)

-------------------------------------------------------------------------------------------------------------------------

--Skapar Elevlista
CREATE TABLE StudentIndex
(
	StudentIndexID INT NOT NULL,
	TeacherIndexID INT NOT NULL,
	CourseIndexID  INT NOT NULL
	FOREIGN KEY(StudentIndexID) REFERENCES Student(StudentID),
	FOREIGN KEY(TeacherIndexID) REFERENCES Teacher(TeacherID),
	FOREIGN KEY(CourseIndexID) REFERENCES Course(CourseID)
)

--Inserts -------------------------------------------------------------------------------------------------------------

--Lärare
GO
INSERT INTO Teacher (FirstName, LastName, Phone, Salary) 
	VALUES
	('Brad', 'Pitt', '+4669696969', 69000),
	('Alexander', 'Gustafsson', '+4697345720', 500000),
	('Jeff', 'King', '+4600000000', 10),
	('Linus', 'Sebastian', '+4613371337', 1337000),
	('Tristian', 'Gallant', '+4634343434', 34000),
	('Gordon', 'Ramsay', '+4659832345', 666000)

--Sätter mail dynamiskt
UPDATE Teacher SET Email = CONCAT(CONCAT(FirstName, '.'), CONCAT(LastName, '@emiljacademy.com'))

-------------------------------------------------------------------------------------------------------------------------

--Kurser
GO
INSERT INTO Course (CourseName, CourseTeacher) 
	VALUES
	('Pickup Artistry', 101), ('Mixed Martial Arts', 102), ('Programming', 103), 
	('PC Building', 104), ('Finding Good Anime', 105), ('Coffe Making', 106)

-------------------------------------------------------------------------------------------------------------------------

--Elever

--Kontaktinformation
GO
INSERT INTO Student (FirstName, LastName, Phone) 
	VALUES 
	('Emil', 'Jonsson', '+46735021603'),
	('Sada', 'Fessehazion', '+46739164165'),
	('Vamsikrisna', 'Savaaram', '+46700536555'),
	('Donald', 'Trump', '+46785493001'),
	('Stefan', 'Löfven', '+46712345678'),
	('Kim', 'Jong-un', '+46745676767'),
	('Will', 'Smith', '+46757486938'),
	('Anakin', 'Skywalker', '+46734567987'),
	('Barack', 'Obama', '+46786597964'),
	('Mikael', 'Lönnroos', '+4656783423'),
	('Michael', 'Jackson', '+46789898989'),
	('Jesus', 'Christ', '+46766666669')

--Sätter mail dynamiskt
GO 
UPDATE Student SET Email = CONCAT(CONCAT(FirstName, '.'), CONCAT(LastName, '@emiljacademy.com'))

------------------------------------------------------------------------------------------------------------------------

--Elev Lista
GO
INSERT INTO StudentIndex (StudentIndexID, TeacherIndexID, CourseIndexID) 
	VALUES
		--Student 1
		(1001,  101, 1),
		(1001, 102, 2),
		(1001, 103, 3),
		(1001, 104, 4),
		(1001, 105, 5),
		(1001, 106, 6),
	--Student 2
		(1002, 101, 1),
		(1002, 103, 3), 
		(1002, 106, 6),

	--Student 3
		(1003, 101, 1),
		(1003, 103, 3),
		(1003, 104, 4),
		(1003, 106, 6),
	--Student 4
		(1004, 101, 1),
		(1004, 105, 5),
	--Student 5
		(1005, 105, 5),
		(1005, 106, 6),
	--Student 6
		(1006, 101, 1),
		(1006, 102, 2),
		(1006, 103, 3),
		(1006, 104, 4),
		(1006, 105, 5),
		(1006, 106, 6),
	--Student 7 
		(1007, 101, 1),
		(1007, 102, 2),
		(1007, 103, 3),
		(1007, 104, 4),
	--Student 8
		(1008,  101, 1),
		(1008,  102, 2),
		(1008,  103, 3),
		(1008,  104, 4),
		(1008,  105, 5),
		--Student 9
		(1009,  103, 3),
		(1009,  104, 4),
		(1009,  106, 6),
		--Student 10
		(1010, 101, 1),
		(1010, 103, 3),
		(1010, 104, 4),
		(1010, 106, 6),
		--Student 11
		(1011, 101, 1),
		(1011, 102, 2),
		(1011, 106, 6),
		--Student 12
		(1012, 101, 1),
		(1012, 102, 2),
		(1012, 103, 3),
		(1012, 104, 4),
		(1012, 105, 5),
		(1012, 106, 6)

--Views & Procedures --------------------------------------------------------------------------------------------------

GO
--Víew som gömmer lön
CREATE VIEW No_Salary
	AS
	SELECT TeacherID, FirstName, LastName, Phone, Email
	FROM Teacher
	
-------------------------------------------------------------------------------------------------------------------------

GO
--Procedure som visar Lärare utan lön
CREATE PROCEDURE Show_All_Teachers
	AS
	SELECT * FROM No_Salary 
	ORDER BY LastName

-------------------------------------------------------------------------------------------------------------------------

GO
--Procedure som visar Course Table
CREATE PROCEDURE Show_All_Courses
	AS
	SELECT * FROM Course

-------------------------------------------------------------------------------------------------------------------------

GO
--Procedure som visar Student Table
CREATE PROCEDURE Show_All_Students
	AS
	SELECT * FROM Student

-------------------------------------------------------------------------------------------------------------------------

GO
--Procedure som visar StudentIndex Table
CREATE PROCEDURE Show_Student_Index
	AS
	SELECT * FROM StudentIndex

-------------------------------------------------------------------------------------------------------------------------

GO
--Procedure som visar vilka lärare en elev har med namn som input
CREATE PROCEDURE Student_Search
@Firstname varchar(25)
	AS
		DECLARE @Amount INT
		SELECT @Amount = COUNT(*) FROM STUDENT WHERE Firstname = @Firstname
	IF @Amount > 0
	BEGIN
	SELECT
		(S.Firstname + ' ' + S.LastName) AS 'Student Name',
		(T.FirstName + ' ' + T.Lastname) AS 'Teacher Name',
		C.CourseName AS 'Course Name'
	FROM Student AS S
	INNER JOIN StudentIndex AS SI
		ON S.StudentID = SI.StudentIndexID
	INNER JOIN Course AS C
		ON C.CourseID = SI.CourseIndexID
	INNER JOIN Teacher AS T
		ON T.TeacherID = SI.TeacherIndexID
	WHERE S.FirstName = @Firstname 
	END
	ELSE
		SELECT 'Student does not exist' AS 'Result'

-------------------------------------------------------------------------------------------------------------------------

--Index
CREATE INDEX IDX_Teacher_LastName ON Teacher(Lastname)
CREATE INDEX IDX_Student_FirstName ON Student(FirstName)

--User, Login, och Roll------------------------------------------------------------------------------------------------

--Student User och Login
	--Användare som endast kan köra EXECUTE
	--Kör först
	CREATE LOGIN [Username] WITH PASSWORD = 'Password',
	DEFAULT_DATABASE = [Emil Academy]
	
	--Sedan detta
	CREATE USER Username FOR LOGIN Username

--Roll för studender, i praktiken borde det vara fler användare såklart
	CREATE ROLE [Student]
	EXECUTE sp_addrolemember 'Student', 'Username'
	GRANT EXECUTE TO Student

/*
--Test Kod-------------------------------------------------------------------------------------------------------------
--Select på tables
select * from Course
select * from Teacher
select * from Student
select * from StudentIndex

-Drop på tables
drop table Course
drop table Teacher
drop table Student
drop table StudentIndex

-Select/Execute på view och procedure
select * from No_Salary
execute Show_All_Courses
execute Show_All_Teachers <---------------- Denna är uppgiften
execute Show_All_Students
execute Student_Search '' --Tar Elevs förnamn som input <---------------- Denna är uppgiften

-Drop på view och procedure
drop view No_Salary
drop procedure Show_All_Teachers
drop procedure Show_All_Courses
drop procedure Show_All_Students
drop procedure Student_Search


drop login StudentName
drop user StudentName
drop role Student
revoke execute to StudentName
revoke execute to StudentName
*/
