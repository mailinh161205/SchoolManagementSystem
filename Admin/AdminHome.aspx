<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="AdminHome.aspx.cs" Inherits="SchoolManagementSystem.Admin.AdminHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>

    .bg-page {
        background: url('../Image/bg3.jpg') no-repeat center center fixed;
        background-size: cover;
        min-height: 100vh;
    }

    .bg-overlay {
        background: rgba(0,0,0,0.45);
        min-height: 100vh;
        padding-top: 20px;
    }

    .dashboard-card {
        border-radius: 12px;
        padding: 20px;
        color: white;
        box-shadow: 0 4px 12px rgba(0,0,0,0.25);
        transition: 0.3s;
    }

    .dashboard-card:hover {
        transform: translateY(-5px);
    }

    .bg-blue { background: #4e73df; }
    .bg-green { background: #1cc88a; }
    .bg-orange { background: #f6c23e; }
    .bg-red { background: #e74a3b; }

    .card-title {
        font-size: 15px;
        opacity: 0.9;
    }

    .card-value {
        font-size: 28px;
        font-weight: bold;
    }

    .section-title {
        font-size: 20px;
        font-weight: bold;
        margin-bottom: 15px;
        color: white;
    }

    .table-box {
        background: rgba(255,255,255,0.95);
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.25);
    }

    .welcome-box {
        background: rgba(78,115,223,0.9);
        color: white;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 20px;
    }

</style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="bg-page">
<div class="bg-overlay">

<div class="container mt-4">

    <div class="welcome-box">
        <h3>Welcome, Admin</h3>
        <p class="text-light">Overview of your system</p>
    </div>

    <div class="row text-center">

        <div class="col-md-3 mb-3">
            <div class="dashboard-card bg-blue">
                <div class="card-title">Total Students</div>
                <div class="card-value">
                    <asp:Label ID="lblStudents" runat="server"></asp:Label>
                </div>
            </div>
        </div>

        <div class="col-md-3 mb-3">
            <div class="dashboard-card bg-green">
                <div class="card-title">Total Teachers</div>
                <div class="card-value">
                    <asp:Label ID="lblTeachers" runat="server"></asp:Label>
                </div>
            </div>
        </div>

        <div class="col-md-3 mb-3">
            <div class="dashboard-card bg-orange">
                <div class="card-title">Total Classes</div>
                <div class="card-value">
                    <asp:Label ID="lblClasses" runat="server"></asp:Label>
                </div>
            </div>
        </div>

        <div class="col-md-3 mb-3">
            <div class="dashboard-card bg-red">
                <div class="card-title">Total Subjects</div>
                <div class="card-value">
                    <asp:Label ID="lblSubjects" runat="server"></asp:Label>
                </div>
            </div>
        </div>

    </div>

    <div class="mt-4">
        <div class="section-title">
            <i class="fas fa-users"></i> Recent Students
        </div>

        <div class="table-box">
            <asp:GridView ID="gvStudents" runat="server"
                CssClass="table table-hover table-bordered"
                AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Student Name" />
                    <asp:BoundField DataField="RollNo" HeaderText="Roll No" />
                    <asp:BoundField DataField="Mobile" HeaderText="Mobile" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

</div>

</div>
</div>

</asp:Content>