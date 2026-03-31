School Management System

A web-based School Management System built using ASP.NET Web Forms and SQL Server, designed to manage students, teachers, attendance, marks, and fees efficiently.

📌 Features
Role-based system:
👨‍💼 Admin
👨‍🏫 Teacher
👨‍🎓 Student
Attendance management
Marks management
Fees management
Subject & class management


🛠 Technologies Used
ASP.NET Web Forms (C#)
SQL Server
ADO.NET
Bootstrap (UI Styling)


⚙️ Setup Database
Open SQL Server Management Studio (SSMS)

Open file:

Database/SchoolSysDB.sql
Click Execute to run the script
Database SchoolSysDB will be created automatically



🚀 How to Run the Project

Clone this repository:
git clone https://github.com/mailinh161205/SchoolManagementSystem.git
Open solution file in Visual Studio

Update connection string in Web.config:
<connectionStrings>
  <add name="conn"
       connectionString="Data Source=.;Initial Catalog=SchoolSysDB;Integrated Security=True"/>
</connectionStrings>
Press F5 to run the project
