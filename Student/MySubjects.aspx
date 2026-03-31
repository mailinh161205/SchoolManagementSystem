<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMst.Master" AutoEventWireup="true" CodeBehind="MySubjects.aspx.cs" Inherits="SchoolManagementSystem.Student.MySubjects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card-custom {
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .card-header {
            font-size: 20px;
            font-weight: bold;
        }

        .table th {
            background-color: #17a2b8;
            color: white;
            text-align: center;
        }

        .table td {
            text-align: center;
            vertical-align: middle;
        }

        .subject-badge {
            background-color: #6f42c1;
            color: white;
            padding: 6px 12px;
            border-radius: 8px;
            font-weight: 500;
        }

        .empty-box {
            text-align: center;
            padding: 40px;
            color: gray;
        }

        .empty-box i {
            font-size: 40px;
            margin-bottom: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">

        <div class="mb-4">
            <h2 class="text-info">
                <i class="fas fa-book"></i> My Subjects
            </h2>
            <p class="text-muted">List of subjects you are enrolled in</p>
        </div>

        <div class="card card-custom">
            <div class="card-header bg-info text-white">
                <i class="fas fa-list"></i> Subjects Overview
            </div>

            <div class="card-body">

                <asp:GridView ID="gvSubjects" runat="server"
                    CssClass="table table-hover table-bordered"
                    AutoGenerateColumns="False"
                    EmptyDataText="">

                    <Columns>

                        <asp:BoundField DataField="STT" HeaderText="#" />

                        <asp:TemplateField HeaderText="Subject Name">
                            <ItemTemplate>
                                <span class="subject-badge">
                                    <%# Eval("SubjectName") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                    <EmptyDataTemplate>
                        <div class="empty-box">
                            <i class="fas fa-book-open"></i>
                            <h5>No subjects found</h5>
                            <p>You are not enrolled in any subjects yet.</p>
                        </div>
                    </EmptyDataTemplate>

                </asp:GridView>

            </div>
        </div>

    </div>

</asp:Content>