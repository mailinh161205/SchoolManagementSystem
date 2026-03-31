<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher/TeacherMst.Master" AutoEventWireup="true" CodeBehind="TeacherHome.aspx.cs" Inherits="SchoolManagementSystem.Teacher.TeacherHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>
    .bg-page {
        background: url('../Image/bg3.jpg') no-repeat center center fixed;
        background-size: cover;
        min-height: 100vh;
        position: relative;
    }

    .bg-overlay {
        background: rgba(0,0,0,0.4);
        min-height: 100vh;
        padding: 30px;
    }

    .dashboard-card {
        border-radius: 12px;
        padding: 20px;
        text-align: center;
        transition: 0.3s;
        background: white;
        box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    }

    .dashboard-card:hover {
        transform: translateY(-5px);
    }

    .icon-box {
        font-size: 28px;
        margin-bottom: 10px;
    }

    .bg-blue { color: #4e73df; }
    .bg-green { color: #1cc88a; }
    .bg-orange { color: #f6c23e; }

    .welcome-box {
        background: rgba(78,115,223,0.9);
        color: white;
        border-radius: 12px;
        padding: 25px;
        backdrop-filter: blur(5px);
    }
</style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="bg-page">
    <div class="bg-overlay">

        <div class="container">

            <div class="welcome-box mb-4">
                <h3>
                    Welcome, <asp:Label ID="lblName" runat="server"></asp:Label>
                </h3>
                <p>Manage your teaching activities easily</p>
            </div>

            <div class="row">

                <div class="col-md-4 mb-4">
                    <div class="dashboard-card">
                        <div class="icon-box bg-blue">
                            <i class="fas fa-users"></i>
                        </div>
                        <h5>Total Students</h5>
                        <asp:Label ID="lblStudents" runat="server" CssClass="h4"></asp:Label>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="dashboard-card">
                        <div class="icon-box bg-green">
                            <i class="fas fa-book"></i>
                        </div>
                        <h5>Total Subjects</h5>
                        <asp:Label ID="lblSubjects" runat="server" CssClass="h4"></asp:Label>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="dashboard-card">
                        <div class="icon-box bg-orange">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h5>Today's Attendance</h5>
                        <asp:Label ID="lblAttendance" runat="server" CssClass="h4"></asp:Label>
                    </div>
                </div>

            </div>

        </div>

    </div>
</div>

</asp:Content>