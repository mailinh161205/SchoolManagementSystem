USE master;
GO

ALTER DATABASE SchoolSysDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

DROP DATABASE SchoolSysDB;

Create Database SchoolSysDB
Go

Use SchoolSysDB
Go

CREATE TABLE Account(
    AccountId INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50),
    Password NVARCHAR(50),
    Role NVARCHAR(20), 
    RefId INT NULL 
)ALTER TABLE Account ADD CONSTRAINT UQ_Username UNIQUE (Username)

Create Table Class(
    ClassId int primary key identity(1,1) not null,
    ClassName nvarchar(50) null
)

Create table Subject (
    SubjectId int primary key identity(1,1) not null,
    ClassId int foreign key references Class (ClassId) null,
    SubjectName nvarchar(50) null
)

Create table Student(
    StudentId int primary key identity(1,1) not null,
    Name nvarchar(50) null,
    DOB date null,
    Gender nvarchar(50) null,
    Mobile varchar(15) null, 
    RollNo nvarchar(50) null,
    Address nvarchar(max) null,
    ClassId int foreign key references Class (ClassId) null
)

Create table Teacher(
    TeacherId int primary key identity(1,1) not null,
    Name nvarchar(50) null,
    DOB date null,
    Gender nvarchar(50) null,
    Mobile varchar(15) null,
    Email varchar(50) null,
    Address nvarchar(max) null,
   Password varchar(20) null
)

ALTER TABLE Teacher ADD CONSTRAINT UQ_Email UNIQUE (Email);

Create table TeacherSubject(
    Id int primary key identity(1,1) not null,
    ClassId int foreign key references Class (ClassId) null,
    SubjectId int foreign key references Subject (SubjectId) null,
    TeacherId int foreign key references Teacher (TeacherId) null
)

Create table TeacherAttendance(
    Id int primary key identity(1,1) not null,
    TeacherId int foreign key references Teacher(TeacherId) null,
    Status bit null,
    Date date null
)
ALTER TABLE TeacherAttendance
ALTER COLUMN Date datetime NULL;

Create table StudentAttendance(
    Id int primary key identity(1,1) not null,
    ClassId int foreign key references Class (ClassId) null,
    SubjectId int foreign key references Subject(SubjectId) null,
    RollNo nvarchar(20) null,
    Status bit null,
    Date date null
)

ALTER TABLE StudentAttendance
ALTER COLUMN Date datetime NULL;

Create Table Fees(
    FeesId int primary key identity(1,1) not null,
    ClassId int foreign key references Class (ClassId) null,
    FeesAmount int null
)

Create table Exam(
    ExamId int primary key identity (1,1) not null,
    ClassId int foreign key references Class (ClassId) null,
    SubjectId int foreign key references Subject(SubjectId) null,
    RollNo nvarchar(20) null,
    TotalMarks int null,
    OutOfMarks int null
)

Create table Expense(
    ExpenseId int primary key identity(1,1) not null,
    ClassId int foreign key references Class (ClassId) null,
    SubjectId int foreign key references Subject(SubjectId) null,
    ChargeAmount int null
)

ALTER TABLE Student ADD CONSTRAINT UQ_RollNo UNIQUE (RollNo);


CREATE TABLE StudentSubject(
    Id INT PRIMARY KEY IDENTITY(1,1),
    StudentId INT FOREIGN KEY REFERENCES Student(StudentId),
    SubjectId INT FOREIGN KEY REFERENCES Subject(SubjectId)
)
















USE SchoolSysDB;
GO


-- 1. Insert Classes
INSERT INTO Class (ClassName) VALUES 
('SE07301'), ('SE07302'), ('SE07303'), ('SE07304'), ('SE07305'),
('SE07306'), ('SE07307'), ('SE07308'), ('SE07309'), ('SE073010');
GO

-- 2. Insert Subjects
-- Class 1
INSERT INTO Subject (ClassId, SubjectName) VALUES (1, 'Mathematics'), (1, 'English'), (1, 'Programming Fundamentals'), (1, 'Database Basics');
-- Class 2
INSERT INTO Subject (ClassId, SubjectName) VALUES (2, 'Mathematics'), (2, 'English'), (2, 'OOP'), (2, 'Data Structures');
-- Class 3
INSERT INTO Subject (ClassId, SubjectName) VALUES (3, 'Discrete Math'), (3, 'Java Programming'), (3, 'Database Systems'), (3, 'Web Design');
-- Class 4
INSERT INTO Subject (ClassId, SubjectName) VALUES (4, 'C# Programming'), (4, 'SQL Server'), (4, 'Web Development'), (4, 'Software Engineering');
-- Class 5
INSERT INTO Subject (ClassId, SubjectName) VALUES (5, 'ASP.NET'), (5, 'Entity Framework'), (5, 'UI/UX Design'), (5, 'Project Management');
-- Class 6
INSERT INTO Subject (ClassId, SubjectName) VALUES (6, 'Advanced Java'), (6, 'Spring Boot'), (6, 'Microservices'), (6, 'Cloud Basics');
-- Class 7
INSERT INTO Subject (ClassId, SubjectName) VALUES (7, 'Python'), (7, 'Data Analysis'), (7, 'Machine Learning'), (7, 'AI Basics');
-- Class 8
INSERT INTO Subject (ClassId, SubjectName) VALUES (8, 'Network Security'), (8, 'Ethical Hacking'), (8, 'Cryptography'), (8, 'System Security');
-- Class 9
INSERT INTO Subject (ClassId, SubjectName) VALUES (9, 'Mobile Development'), (9, 'Flutter'), (9, 'Android'), (9, 'iOS Basics');
-- Class 10
INSERT INTO Subject (ClassId, SubjectName) VALUES (10, 'Final Project'), (10, 'Internship'), (10, 'Software Testing'), (10, 'DevOps');
GO

-- 3. Insert Fees
INSERT INTO Fees (ClassId, FeesAmount)
SELECT 
    ClassId,
    500000 + (ClassId * 100000) + (ABS(CHECKSUM(NEWID())) % 50000)
FROM Class;

-- 4. Insert Teachers
INSERT INTO Teacher (Name, DOB, Gender, Mobile, Email, Address, Password) VALUES
(N'James Anderson','1980-02-15','Male','0911000001','james.anderson@gmail.com',N'New York, USA','123'),
(N'Emma Wilson','1985-06-20','Female','0911000002','emma.wilson@gmail.com',N'London, UK','123'),
(N'Oliver Brown','1979-09-12','Male','0911000003','oliver.brown@gmail.com',N'Sydney, Australia','123'),
(N'Sophia Taylor','1988-01-30','Female','0911000004','sophia.taylor@gmail.com',N'Toronto, Canada','123'),
(N'William Thomas','1982-04-10','Male','0911000005','william.thomas@gmail.com',N'Chicago, USA','123'),

(N'Isabella White','1987-03-18','Female','0911000006','isabella.white@gmail.com',N'Paris, France','123'),
(N'Lucas Harris','1981-07-25','Male','0911000007','lucas.harris@gmail.com',N'Berlin, Germany','123'),
(N'Mia Martin','1990-05-14','Female','0911000008','mia.martin@gmail.com',N'Rome, Italy','123'),
(N'Ethan Thompson','1983-08-09','Male','0911000009','ethan.thompson@gmail.com',N'Madrid, Spain','123'),
(N'Amelia Garcia','1986-11-11','Female','0911000010','amelia.garcia@gmail.com',N'Barcelona, Spain','123'),

(N'Noah Martinez','1984-02-22','Male','0911000011','noah.martinez@gmail.com',N'Los Angeles, USA','123'),
(N'Charlotte Robinson','1989-06-05','Female','0911000012','charlotte.robinson@gmail.com',N'Dublin, Ireland','123'),
(N'Liam Clark','1982-10-17','Male','0911000013','liam.clark@gmail.com',N'Edinburgh, Scotland','123'),
(N'Ava Rodriguez','1987-12-29','Female','0911000014','ava.rodriguez@gmail.com',N'Mexico City, Mexico','123'),
(N'Benjamin Lewis','1981-03-03','Male','0911000015','benjamin.lewis@gmail.com',N'Vancouver, Canada','123');
GO

-- 5. Insert TeacherSubject
INSERT INTO TeacherSubject (ClassId, SubjectId, TeacherId)
SELECT 
    s.ClassId,
    s.SubjectId,
    (ABS(CHECKSUM(NEWID())) % 15) + 1
FROM Subject s;


-- 6. Insert Expenses
DECLARE @i INT = 1;

WHILE @i <= 3
BEGIN
    INSERT INTO Expense (ClassId, SubjectId, ChargeAmount)
    SELECT 
        s.ClassId,
        s.SubjectId,
        80000 + (ABS(CHECKSUM(NEWID())) % 200000)
    FROM Subject s;

    SET @i = @i + 1;
END

-- 7. Insert Students 
INSERT INTO Student (Name, DOB, Gender, Mobile, RollNo, Address, ClassId) VALUES

-- CLASS 1 (USA)
(N'John Smith','2005-03-15','Male','0987654321','BH00001','123 Main St, New York, USA',1),
(N'Emily Johnson','2005-07-22','Female','0978123456','BH00002','456 Park Ave, New York, USA',1),
(N'Michael Brown','2005-11-10','Male','0967345678','BH00003','789 Broadway, New York, USA',1),
(N'Sophia Williams','2005-01-05','Female','0956234567','BH00004','321 Madison Ave, New York, USA',1),
(N'William Jones','2005-06-18','Male','0945123456','BH00005','654 Lexington Ave, New York, USA',1),

-- CLASS 2 (UK)
(N'Oliver Taylor','2006-03-12','Male','0934567891','BH00006','10 Downing St, London, UK',2),
(N'Amelia Wilson','2006-05-25','Female','0934567892','BH00007','221B Baker St, London, UK',2),
(N'Harry Davies','2006-08-30','Male','0934567893','BH00008','15 Oxford St, London, UK',2),
(N'Isla Evans','2006-09-10','Female','0934567894','BH00009','25 Regent St, London, UK',2),
(N'Jack Thomas','2006-12-01','Male','0934567895','BH00010','40 Piccadilly, London, UK',2),

-- CLASS 3 (CANADA)
(N'Liam Anderson','2005-04-18','Male','0923456781','BH00011','100 King St, Toronto, Canada',3),
(N'Emma Martin','2005-06-22','Female','0923456782','BH00012','200 Queen St, Toronto, Canada',3),
(N'Noah Thompson','2005-07-30','Male','0923456783','BH00013','300 Bay St, Toronto, Canada',3),
(N'Olivia White','2005-09-11','Female','0923456784','BH00014','400 Bloor St, Toronto, Canada',3),
(N'Lucas Harris','2005-12-19','Male','0923456785','BH00015','500 Yonge St, Toronto, Canada',3),

-- CLASS 4 (AUSTRALIA)
(N'Ethan Clark','2006-02-14','Male','0912345671','BH00016','12 George St, Sydney, Australia',4),
(N'Ava Lewis','2006-03-20','Female','0912345672','BH00017','22 Pitt St, Sydney, Australia',4),
(N'Mason Walker','2006-05-25','Male','0912345673','BH00018','35 Sussex St, Sydney, Australia',4),
(N'Mia Hall','2006-07-30','Female','0912345674','BH00019','48 Kent St, Sydney, Australia',4),
(N'James Allen','2006-10-10','Male','0912345675','BH00020','60 York St, Sydney, Australia',4),

-- CLASS 5 (GERMANY)
(N'Alexander Schmidt','2005-01-15','Male','0909876541','BH00021','Alexanderplatz, Berlin, Germany',5),
(N'Sophie Müller','2005-03-22','Female','0909876542','BH00022','Potsdamer Platz, Berlin, Germany',5),
(N'Max Weber','2005-06-10','Male','0909876543','BH00023','Unter den Linden, Berlin, Germany',5),
(N'Anna Fischer','2005-08-18','Female','0909876544','BH00024','Friedrichstrasse, Berlin, Germany',5),
(N'Leon Hoffmann','2005-11-25','Male','0909876545','BH00025','Checkpoint Charlie, Berlin, Germany',5);


-- 8. Insert StudentSubject
INSERT INTO StudentSubject (StudentId, SubjectId)
SELECT s.StudentId, sub.SubjectId
FROM Student s
INNER JOIN Subject sub ON s.ClassId = sub.ClassId;

-- 9. Insert Exam with random TotalMarks
INSERT INTO Exam (ClassId, SubjectId, RollNo, TotalMarks, OutOfMarks)
SELECT 
    s.ClassId,
    sub.SubjectId,
    s.RollNo,
    ABS(CHECKSUM(NEWID())) % 50 + 50,
    100
FROM Student s
INNER JOIN Subject sub ON s.ClassId = sub.ClassId;

-- 10. Student Attendance
DECLARE @d INT = 1;

WHILE @d <= 30
BEGIN
    INSERT INTO StudentAttendance (ClassId, SubjectId, RollNo, Status, Date)
    SELECT 
        s.ClassId,
        sub.SubjectId,
        s.RollNo,
        CASE WHEN ABS(CHECKSUM(NEWID())) % 2 = 0 THEN 1 ELSE 0 END,
        DATEADD(DAY, -@d, GETDATE())
    FROM Student s
    INNER JOIN Subject sub ON s.ClassId = sub.ClassId;

    SET @d = @d + 1;
END

-- 11. Teacher Attendance
DECLARE @t INT = 1;

WHILE @t <= 30
BEGIN
    INSERT INTO TeacherAttendance (TeacherId, Status, Date)
    SELECT 
        TeacherId,
        CASE WHEN ABS(CHECKSUM(NEWID())) % 2 = 0 THEN 1 ELSE 0 END,
        DATEADD(DAY, -@t, GETDATE())
    FROM Teacher;

    SET @t = @t + 1;
END


-- 12. Account

INSERT INTO Account (Username, Password, Role)
VALUES ('admin@gmail.com', 'admin123', 'Admin') 

INSERT INTO Account (Username, Password, Role, RefId)
SELECT Email, Password, 'Teacher', TeacherId
FROM Teacher

INSERT INTO Account (Username, Password, Role, RefId)
SELECT RollNo, '123', 'Student', StudentId
FROM Student

SELECT * FROM Account