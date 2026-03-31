<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMst.Master" AutoEventWireup="true" CodeBehind="StudentHome.aspx.cs" Inherits="SchoolManagementSystem.Student.StudentHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    .hero {
        background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)), url('../Image/bg3.jpg');
        background-size: cover;
        background-position: center;
        padding: 80px 30px;
        color: white;
        border-radius: 12px;
    }

    .card-dashboard {
        border-radius: 12px;
        padding: 20px;
        color: white;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        transition: 0.3s;
    }

    .card-dashboard:hover {
        transform: translateY(-5px);
    }

    .bg-blue { background: #4e73df; }
    .bg-green { background: #1cc88a; }
    .bg-orange { background: #f6c23e; }
    .bg-red { background: #e74a3b; }

    .card-icon {
        font-size: 30px;
    }

    .card-title {
        font-size: 18px;
    }

    .card-value {
        font-size: 26px;
        font-weight: bold;
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">

    <div class="hero mb-4">
        <h2>Welcome back</h2>
        <h3><asp:Label ID="lblName" runat="server"></asp:Label></h3>
        <p>Here is your academic overview</p>
    </div>

    <div class="row">

        <div class="col-md-3 mb-4">
            <div class="card-dashboard bg-blue">
                <div class="card-icon"><i class="fas fa-book"></i></div>
                <div class="card-title">Subjects</div>
                <div class="card-value"><asp:Label ID="lblSubjects" runat="server" /></div>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="card-dashboard bg-green">
                <div class="card-icon"><i class="fas fa-chart-line"></i></div>
                <div class="card-title">Exams</div>
                <div class="card-value"><asp:Label ID="lblMarks" runat="server" /></div>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="card-dashboard bg-orange">
                <div class="card-icon"><i class="fas fa-calendar-check"></i></div>
                <div class="card-title">Attendance</div>
                <div class="card-value"><asp:Label ID="lblAttendance" runat="server" /></div>
            </div>
        </div>

        <div class="col-md-3 mb-4">
            <div class="card-dashboard bg-red">
                <div class="card-icon"><i class="fas fa-money-bill"></i></div>
                <div class="card-title">Fees</div>
                <div class="card-value"><asp:Label ID="lblFees" runat="server" /></div>
            </div>
        </div>

    </div>

</div>

</asp:Content>