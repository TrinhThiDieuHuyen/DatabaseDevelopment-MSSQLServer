--Create new database.
CREATE DATABASE OnlineLibrarySystem
GO

--Use database.
USE OnlineLibrarySystem
GO

--Create table, primary key, foreign key
--Create books table.
CREATE TABLE Books(
    bookID      VARCHAR(10) PRIMARY KEY,
	bookName    NVARCHAR(255),
	authorName  NVARCHAR(255),
	bookEdition NVARCHAR(255),

--Use Unique.
	ISBN        SMALLINT UNIQUE
)
GO

--Create borrows table.
CREATE TABLE Borrows(
    borrowID   VARCHAR(10) PRIMARY KEY,
	borrowDate DATETIME,
	expiryDate DATETIME,
	bookID     VARCHAR(10) NOT NULL,
	studentID  VARCHAR(10) NOT NULL

--Create Foreign key.
	FOREIGN KEY (studentID) REFERENCES Students(studentID),
	FOREIGN KEY (bookID)    REFERENCES Books(bookID),
)
GO

--Create students table.
CREATE TABLE Students(
    studentID VARCHAR(10) PRIMARY KEY,
	departmentID VARCHAR(10) NOT NULL,
	studentName NVARCHAR(255),
	studentAddress NVARCHAR(255),
	studentPhone INT,

--Use Check.
	studentGender VARCHAR(10) CHECK (studentGender IN ('Male','Female'))

--Use Unique.
	CONSTRAINT unique_studentPhone UNIQUE(studentPhone)

--Create Foreign key.
	FOREIGN KEY (departmentID) REFERENCES Departments(departmentID),
)
GO

--Create departments table.
CREATE TABLE Departments(
    departmentID   VARCHAR(10) PRIMARY KEY,
	departmentName NVARCHAR(50)
)
GO

--Create returns table.
CREATE TABLE [Returns](
    returnID   VARCHAR(10) PRIMARY KEY,
	bookID     VARCHAR(10) NOT NULL,
	borrowID   VARCHAR(10) NOT NULL,
	staffID    VARCHAR(10) NOT NULL,
	studentID  VARCHAR(10) NOT NULL,
	returnDate DATETIME

--Create Foreign key.
	FOREIGN KEY (bookID)    REFERENCES Books(bookID),
	FOREIGN KEY (borrowID)  REFERENCES Borrows(borrowID),
	FOREIGN KEY (staffID)  REFERENCES Staffs(staffID),
	FOREIGN KEY (studentID) REFERENCES Students(studentID),
)
GO
--Create staffs table.
CREATE TABLE Staffs(
    staffID VARCHAR(10) PRIMARY KEY,
	staffName NVARCHAR(50),
	staffAddress NVARCHAR(50),
	staffGender VARCHAR(10) CHECK (staffGender IN ('Male','Female')),
	staffPhone INT,
	designation NVARCHAR(50),

--Use Unique.
	UNIQUE (staffPhone,designation)
)
GO

--Add CHECK in Borrows.
ALTER TABLE dbo.Borrows ADD CONSTRAINT CK_Date
CHECK (borrowDate < expiryDate AND expiryDate > borrowDate)

--Add UNIQUE in Departments.
ALTER TABLE dbo.Departments
ADD CONSTRAINT unique_department UNIQUE(departmentName);

--Add StaffID into table borrows.
ALTER TABLE dbo.Borrows
ADD staffID VARCHAR(10)

--INSERT: input data 
--Table books
INSERT INTO Books(bookID,bookName,authorName,bookEdition,ISBN)
VALUES ('K2002','Jane Eyre','Charlotte Bronte','First',2589)
GO
INSERT INTO Books(bookID,bookName,ISBN) VALUES 
('K2012','.Net & C#',1579),
('K2013','Java & php',1679),
('K2014','AI-My life',1570)
GO
INSERT INTO Books VALUES 
('K2015','Love or you','Mino Song','Second',3003),
('K2016','Fiance','Mino Song','Second',2412),
('K2017','Ah yeah','Winner','First',5790)
GO
INSERT INTO Books VALUES ('K2003','The Adventures of Huckleberry Finn','Mark Twain','Second',2590)
GO
INSERT INTO Books VALUES ('K2004','Of Mice and Men','John Steinbeck','Third',2365)
GO
INSERT INTO Books VALUES ('K2005','Paradise Lost','John Milton','Fourth',8354)
GO
INSERT INTO Books VALUES ('K2006','The Communist Manifesto','Karl Marx','First',2889)
GO
INSERT INTO Books VALUES ('K2007','Frankenstein','Mary Wollstonecraft Shelley','Second',6754)
GO
INSERT INTO Books VALUES ('K2008','The Epic of Gilgamesh','Anonymous','First',7908)
GO
INSERT INTO Books VALUES ('K2009','Lolita','Vladimir Nabokov','Second',7872)
GO
INSERT INTO Books VALUES ('K2010','Tuesdays with Morrie','Mitch Albom','First',2679)
GO
INSERT INTO Books VALUES ('K2011','The Story of a Seagull and the Cat Who Taught Her to Fly','Luis Sepulveda','First',9964)
GO

--Table departments.
INSERT INTO Departments VALUES ('D1','Information Technology')
GO
INSERT INTO Departments VALUES ('D2','Math')
GO
INSERT INTO Departments VALUES ('D3','Art')
GO
INSERT INTO Departments VALUES ('D4','Commerce')
GO
INSERT INTO Departments VALUES ('D5','Islamic')
GO
INSERT INTO Departments VALUES ('D6','Urdu')
GO
INSERT INTO Departments VALUES ('D7','Education')
GO
INSERT INTO Departments VALUES ('D8','Economics')
GO
INSERT INTO Departments VALUES ('D9','Physics')
GO
INSERT INTO Departments VALUES ('D10','Food Science')
GO

--Table students.
INSERT INTO Students VALUES ('S100','D2','Smith Caleb','Alabama',2051001010,'Male')
GO
INSERT INTO Students VALUES ('S101','D5','Blake Johnson','California',2090101010,'Female')
GO
INSERT INTO Students VALUES ('S112','D1','Williams Berel','Hawaii',2081010101,'Female')
GO
INSERT INTO Students VALUES ('S113','D8','Jones Cayden','Alabama',2012020200,'Male')
GO
INSERT INTO Students VALUES ('S105','D9','Brown Cedric','California',2130200202,'Female')
GO
INSERT INTO Students VALUES ('S107','D3','Davis Berwin','New York',2101111111,'Male')
GO
INSERT INTO Students VALUES ('S116','D4','Miller Chanan','Alabama',2101020100,'Female')
GO
INSERT INTO Students VALUES ('S117','D6','Wilson Cameron','Alaska',1075746382,'Female')
GO
INSERT INTO Students VALUES ('S118','D10','Moore Abraham','California',1187264585,'Male')
GO
INSERT INTO Students VALUES ('S119','D7','Taylor Calev','California',2004856243,'Female')
GO

--Table borrows.
INSERT INTO Borrows VALUES ('B001','07/01/2019','07/02/2019','K2004','S113')
GO
INSERT INTO Borrows VALUES ('B002','10/03/2019','10/04/2019','K2007','S119')
GO
INSERT INTO Borrows VALUES ('B003','10/03/2019','10/04/2019','K2003','S101')
GO
INSERT INTO Borrows VALUES ('B004','07/01/2019','07/02/2019','K2007','S101')
GO
INSERT INTO Borrows VALUES ('B005','12/02/2019','03/01/2020','K2004','S112')
GO
INSERT INTO Borrows VALUES ('B006','01/01/2019','03/02/2019','K2005','S113')
GO
INSERT INTO Borrows VALUES ('B007','07/01/2019','07/02/2019','K2006','S119')
GO
INSERT INTO Borrows VALUES ('B008','12/02/2019','06/06/2020','K2008','S118')
GO
INSERT INTO Borrows VALUES ('B009','08/03/2019','12/06/2019','K2004','S105')
GO
INSERT INTO Borrows VALUES ('B010','09/01/2019','10/05/2019','K2004','S116')
GO

--Table staffs.
INSERT INTO Staffs VALUES ('TF01','Kamboj Zane','New York','Male',2111572010,'Librairan')
GO
INSERT INTO Staffs VALUES ('TF02','Dua Padraig','Hawaii','Male',1051044480,'Sweeper')
GO
INSERT INTO Staffs VALUES ('TF03','Smith Roderick','California','Female',1151811010,'Manager')
GO
INSERT INTO Staffs VALUES ('TF04','Thind Roderick','Alabama','Male',2022221010,'Bookeeper')
GO
INSERT INTO Staffs VALUES ('TF05','Bhatia Phillip','Hawaii','Female',2051012220,'Naibqasid')
GO
INSERT INTO Staffs VALUES ('TF06','Kamboh Oliver','Alaska','Male',1151011010,'Accountant')
GO
INSERT INTO Staffs VALUES ('TF07','Smith Frederick','Alabama','Male',2057711010,'Manage')
GO
INSERT INTO Staffs VALUES ('TF08','Thind Gideon','Hawaii','Female',2001011010,'Secretary')
GO
INSERT INTO Staffs VALUES ('TF09','Shetty Caleb','Alaska','Female',2052221010,'Assistant')
GO
INSERT INTO Staffs VALUES ('TF010','Smith Ezra','Alabama','Male',2051221010,'Guard')
GO

--Table returns.
INSERT INTO [Returns] VALUES ('RT001','K2004','B005','TF010','S112','01/01/2020')
GO
INSERT INTO [Returns] VALUES ('RT002','K2003','B003','TF010','S101','04/10/2019')
GO
INSERT INTO [Returns] VALUES ('RT003','K2004','B001','TF01','S113','02/07/2019')
GO
INSERT INTO [Returns] VALUES ('RT004','K2008','B008','TF02','S118','01/01/2020')
GO
INSERT INTO [Returns] VALUES ('RT005','K2007','B004','TF01','S101','02/07/2019')
GO
INSERT INTO [Returns] VALUES ('RT006','K2004','B009','TF02','S105','09/09/2019')
GO
INSERT INTO [Returns] VALUES ('RT007','K2004','B010','TF01','S116','01/10/2019')
GO
INSERT INTO [Returns] VALUES ('RT008','K2006','B007','TF03','S119','02/07/2019')
GO
INSERT INTO [Returns] VALUES ('RT009','K2007','B002','TF01','S119','04/10/2019')
GO
INSERT INTO [Returns] VALUES ('RT010','K2005','B006','TF01','S113','01/02/2019')
GO

--SELECT: show data.
SELECT * FROM Students
GO
SELECT * FROM Staffs
GO
SELECT * FROM Books
GO
SELECT * FROM Borrows
GO
SELECT * FROM [Returns]
GO
SELECT * FROM Departments
GO

--List of year borrowed book less than or equal to 2020 and have studentID = 'S113'
SELECT*
FROM dbo.Borrows
WHERE YEAR(borrowDate) <= 2020
AND Borrows.studentID='S113'

--List of other expiring year 2019
SELECT*
FROM dbo.Borrows
WHERE YEAR(expiryDate) <> 2019

--List of other expiring year 20120
SELECT*
FROM dbo.Borrows
WHERE YEAR(expiryDate) != 2020 --'!=' the same '<>'

--List of return book dates is greater than or equal to 7 and has studentID = 'S119'
SELECT*
FROM dbo.[Returns]
WHERE DAY(returnDate) >= 7
AND [Returns].studentID='S119'

--List of returning book with month equal to 4
SELECT*
FROM dbo.[Returns]
WHERE MONTH(returnDate) = 4

--Show all Staff whose names start as Smith
SELECT * FROM Staffs
WHERE staffName LIKE 'Smith%'
GO
--
SELECT studentID, studentName, studentAddress FROM Students
GO
--
SELECT * FROM Staffs
WHERE staffAddress IN ('Alaska','Alabama')
AND staffName LIKE 'Smith%'
GO
--
SELECT studentID, COUNT(*) AS TotalBorrows
FROM Borrows
GROUP BY studentID
HAVING COUNT(*) >=2
GO
--
SELECT TOP(2) bookID, COUNT(*) AS TotalBorrows
FROM Borrows
GROUP BY bookID
ORDER BY COUNT(*) DESC
GO
--
SELECT bookID, COUNT(*) AS TotalBorrows
FROM Borrows
GROUP BY bookID
ORDER BY COUNT(*)
GO
--
SELECT * FROM Staffs
WHERE staffName LIKE '[^KS]%'
GO
--
SELECT * FROM Staffs
WHERE staffName LIKE '[DT]%G'
GO
--
SELECT * FROM Staffs
WHERE staffName LIKE '_H%K'
GO
--
SELECT * FROM Staffs
WHERE staffName LIKE '%Smith%'
GO
--
SELECT * FROM [Returns]
WHERE returnDate BETWEEN '01/01/2019' AND '02/03/2019'
GO
--
SELECT * FROM Students
WHERE studentAddress = 'Alaska' OR
      studentAddress = 'Hawaii'  OR
	  studentAddress = 'New York'
GO

--Queries across multiple tables--
--List of students who return books in detail
SELECT*FROM dbo.Students AS stu, dbo.Staffs AS sta, dbo.Books AS bok, dbo.[Returns] AS rt
WHERE stu.studentID=rt.studentID
AND sta.staffID=rt.staffID
AND bok.bookID=rt.bookID
GO

--Combine two table are Borrows and Students according condition. If which side without data will NULL
SELECT * FROM 
dbo.Borrows FULL OUTER JOIN dbo.Students
ON Borrows.studentID=Students.studentID

--Combination each record of the Staffs table with all records of the Borrows table
SELECT * FROM 
dbo.Staffs CROSS JOIN dbo.Borrows
--List of students who return books in detail with condition is bookID = 'K2004'
SELECT*FROM dbo.Students AS stu, dbo.Staffs AS sta, dbo.Books AS bok, dbo.[Returns] AS rt
WHERE stu.studentID=rt.studentID
AND sta.staffID=rt.staffID
AND bok.bookID=rt.bookID
AND bok.bookID='K2004'
GO

--
SELECT Students.* FROM Students, Staffs, Books, [Returns]
WHERE Students.studentID=[Returns].studentID
AND Staffs.staffID=[Returns].staffID
AND Books.bookID=[Returns].bookID
AND Books.bookID='K2004'
AND Students.studentID='S113'
GO
--
SELECT [Returns].* FROM Students, Staffs, Books, [Returns]
WHERE Students.studentID=[Returns].studentID
AND Staffs.staffID=[Returns].staffID
AND Books.bookID=[Returns].bookID
AND Students.studentID='S113'
GO
--
SELECT [Returns].* FROM Students, Staffs, Books, [Returns]
WHERE Students.studentID=[Returns].studentID
AND Staffs.staffID=[Returns].staffID
AND Books.bookID=[Returns].bookID
AND Students.studentID='S112'
AND Books.bookID='K2005'
GO
--
SELECT * FROM 
dbo.Students INNER JOIN dbo.Borrows
ON Students.studentID=Borrows.studentID
--
SELECT * FROM 
dbo.Books INNER JOIN dbo.[Returns]
ON Books.bookID=[Returns].bookID
AND [Returns].bookID='K2007'

--UPDATE: edit data.
UPDATE Borrows
SET staffID = 'TF01'
WHERE bookID = 'K2004'
GO
--
UPDATE [Returns]
SET staffID = 'TF01'
WHERE bookID = 'K2004'
GO
--
UPDATE Students
SET studentPhone = studentPhone + 2
GO
--
UPDATE Staffs
SET staffGender = 'Female'
GO
--
UPDATE Staffs
SET staffGender = 'Male'
WHERE staffAddress = 'Alaska'
GO
--
UPDATE [Returns]
SET staffID = 'TF03'
WHERE returnDate = '02/07/2019'
GO
--
UPDATE Departments
SET departmentName = 'Marketing'
WHERE departmentID = 'D4'
GO
--
UPDATE Borrows
SET bookID = 'K2005'
WHERE studentID = 'S113'
GO
--
UPDATE Books
SET authorName = 'JUJU'
WHERE bookID = 'K2013'
GO
--
UPDATE Borrows
SET staffID = 'TF05'
WHERE studentID = 'S101'
GO
--
UPDATE [Returns]
SET staffID = 'TF05'
WHERE studentID = 'S101'
GO

--DELETE: remove data.
DELETE FROM [Returns]
WHERE staffID = 'TF03'
GO
--
DELETE FROM [Returns]
WHERE bookID = 'K2004'
GO
--
DELETE FROM Borrows
WHERE borrowID = 'B001'
GO
--
DELETE FROM Borrows
WHERE studentID = 'S118'
GO
--
DELETE FROM [Returns]
WHERE bookID = 'K2007'
GO
--
DELETE FROM Students
WHERE departmentID = 'D3'
GO
--
DELETE FROM Borrows
WHERE StaffID = 'TF05'
GO
--
DELETE FROM Students
WHERE studentID = 'S100'
GO
--
DELETE FROM Borrows
WHERE StaffID = 'TF010'
GO
--
DELETE FROM [Returns]
WHERE StaffID = 'TF02'
GO
--Advanced queries
SELECT * FROM Staffs
WHERE staffAddress = (SELECT staffAddress
                      FROM   Staffs
					  WHERE  staffID = 'TF04')
GO
--
SELECT * FROM Students
WHERE studentGender IN 
      (SELECT studentGender
       FROM   Students
	   WHERE  studentID = 'S113' 
	   OR     studentID = 'S118')
GO
--Function
--Create function no have parameter
CREATE FUNCTION UF_SelectAllStudent()
RETURNS TABLE 
AS RETURN SELECT * FROM dbo.Students
GO
--Use function
SELECT * FROM UF_SelectAllStudent()
--
--Create function with parameter
CREATE FUNCTION UF_SelectStudentPhone (@studentID VARCHAR(10))
RETURNS INT 
AS 
BEGIN
     DECLARE @studentPhone INT
	 SELECT @studentPhone = studentPhone FROM dbo.Students
	 WHERE studentID = @studentID
	 RETURN @studentPhone
END
GO
--Use function
SELECT dbo.UF_SelectStudentPhone('S113') AS PhoneNumber
--Delete function or store
DROP FUNCTION UF_SelectAllStudent

--Trigger
ALTER TABLE dbo.Students
ADD Date_of_birth DATETIME
GO

UPDATE Students
SET Date_of_birth = '05/10/1999'
WHERE studentID = 'S105'
GO
UPDATE Students
SET Date_of_birth = '08/09/1996'
WHERE studentID = 'S118'
GO
UPDATE Students
SET Date_of_birth = '07/05/2019'
WHERE studentID = 'S117'
GO
---Create trigger don't drop student bigger than 18 age.
CREATE TRIGGER UTG_AbortOlderThan18
ON dbo.Students
FOR DELETE
AS
BEGIN
     DECLARE @Count INT = 0
	 
	 SELECT @Count = COUNT(*) FROM deleted
	 WHERE YEAR(GETDATE()) - YEAR(deleted.Date_of_birth) < 18

	 IF (@Count > 0)
	 BEGIN
	 PRINT 'DO NOT DELETE PEOPLE BIGGER THAN 18 AGE'
	       ROLLBACK TRAN
	 END
END
---Test trigger new create
DELETE dbo.Students WHERE studentID = 'S117'

--Test case-- 
--Query1 
INSERT INTO Staffs(staffID,staffName,designation,staffAddress,staffGender)
VALUES ('TF22','Joy Park','Architecture','Alaska','Male')
GO
--Query2
INSERT INTO Students(studentID,studentName)
VALUES ('S222','Shawn Mendes')
GO
--Query3
ALTER TABLE Staffs 
ADD Year_of_Birth INT
GO
--Query4
SELECT  
DISTINCT  
Constraint_Name AS [Constraint],  
Table_Schema AS [Schema],  
Table_Name AS [TableName] FROM INFORMATION_SCHEMA.[KEY_COLUMN_USAGE]  
GO
--Query5
DELETE FROM Departments 
WHERE departmentName = 'Art'
GO
--Query6
ALTER TABLE dbo.Borrows
DROP CONSTRAINT CK_Date
GO
--Query7
EXEC sp_rename 'Departments', 'dp.Departments';

--Query8
UPDATE Students
SET Date_of_birth = '02/02/1992'
WHERE studentID = 'S119'
GO
--Query9
UPDATE Students
SET Date_of_birth = '06/06/1996'
WHERE studentID = 'S119'
GO
--Query10
SELECT * FROM dbo.[Returns]
GO

--Test logs--
--Query1
SELECT  
DISTINCT  
Constraint_Name AS [Constraint],  
Table_Schema AS [Schema],  
Table_Name AS [TableName] FROM INFORMATION_SCHEMA.[KEY_COLUMN_USAGE]  
WHERE INFORMATION_SCHEMA.[KEY_COLUMN_USAGE].[TABLE_NAME]='Returns'
GO
--Query2
SELECT sob.name AS Table_Name,  
SUM(sys.length) AS [Size_Table(Bytes)]  
FROM sysobjects sob, syscolumns sys   
WHERE sob.xtype='u' AND sys.id=sob.id  
GROUP BY sob.name
--Query3
SELECT * FROM dbo.Staffs
GO
--Query4
SELECT * FROM dbo.Students
WHERE studentID = 'S113'
GO
--Query5
INSERT INTO Staffs(staffAddress,staffGender)
VALUES ('Hawaii','Male')
GO
--Query6
UPDATE Students
SET Date_of_birth = '03/30/1993'
WHERE studentID = 'S113'
GO
--Query7
DELETE FROM Staffs 
WHERE designation = 'Guard'
GO
--Query8 the same Query7 at test case (EXEC sp_rename 'Departments', 'dp.Departments';)

--Query9 the same Query6 at test case (ALTER TABLE dbo.Borrows DROP CONSTRAINT CK_Date GO)

--Query10
INSERT INTO Staffs(staffID,staffName,designation,staffAddress,staffGender,Year_of_Birth)
VALUES ('TF888','Lalisa Mannoban','Doctor','New York','Male',1996)
GO
--------------------------------------P5--------------------------------
--Create new database
CREATE DATABASE testDB;
--Create new table
USE testDB
GO
CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    [Address] varchar(255),
    City varchar(255)
);
--Insert data
--Ways 1
INSERT INTO Persons(LastName, FirstName, [Address], City)
VALUES ('Kim', 'Jinu', 'Seoul', 'Korea');
--Ways 2
INSERT INTO Persons
VALUES ('1', 'Lee', 'Seunghoon', 'Busan', 'Korea');
--Show data
--Ways 1
SELECT City, LastName FROM Persons;
--Ways 2
SELECT * FROM Persons;
--Update data
UPDATE Persons
SET LastName = 'Kang', FirstName= 'SeungYoon'
WHERE PersonID = 1;
--Delete data
DELETE FROM Persons WHERE PersonID='1';