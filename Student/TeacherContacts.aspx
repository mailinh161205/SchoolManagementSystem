<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMst.Master" AutoEventWireup="true" CodeBehind="TeacherContacts.aspx.cs" Inherits="SchoolManagementSystem.Student.TeacherContacts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<style>
    .card-teacher {
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        transition: 0.3s;
        text-align: center;
    }

    .card-teacher:hover {
        transform: translateY(-5px);
    }

    .avatar {
        width: 70px;
        height: 70px;
        border-radius: 50%;
        background-color: #4e73df;
        color: white;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 28px;
        margin: auto;
    }

    .teacher-name {
        font-size: 18px;
        font-weight: bold;
        margin-top: 10px;
    }

    .info {
        font-size: 14px;
        color: gray;
    }

    .info i {
        margin-right: 5px;
        color: #17a2b8;
    }

    .empty-box {
        text-align: center;
        padding: 50px;
        color: gray;
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">

    <div class="mb-4">
        <h2 class="text-primary">
            <i class="fas fa-address-book"></i> Teacher Contacts
        </h2>
        <p class="text-muted">Contact your teachers easily</p>
    </div>

    <div class="row">

    <asp:Repeater ID="rptTeachers" runat="server">
        <ItemTemplate>
            <div class="col-md-4 mb-4">

                <div class="card-teacher">

                    <div class="avatar">
                        <%# Eval("Name").ToString().Substring(0,1) %>
                    </div>

                    <div class="teacher-name">
                        <%# Eval("Name") %>
                    </div>

                    <div class="info">
                        <i class="fas fa-envelope"></i>
                        <%# Eval("Email") %>
                    </div>

                    <div class="info">
                        <i class="fas fa-phone"></i>
                        <%# Eval("Mobile") %>
                    </div>

                </div>

            </div>
        </ItemTemplate>
    </asp:Repeater>

</div>

<asp:Panel ID="pnlEmpty" runat="server" Visible="false" CssClass="empty-box">
    <i class="fas fa-user-slash fa-3x"></i>
    <h5>No teachers found</h5>
    <p>No teachers assigned to your class.</p>
</asp:Panel>

</div>

</asp:Content>