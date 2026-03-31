<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMst.Master" AutoEventWireup="true" CodeBehind="Marks.aspx.cs" Inherits="SchoolManagementSystem.Student.Marks" %>

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
            background-color: #4e73df;
            color: white;
            text-align: center;
        }

        .table td {
            text-align: center;
            vertical-align: middle;
        }

        .badge-pass {
            background-color: #28a745;
            color: white;
            padding: 5px 10px;
            border-radius: 6px;
        }

        .badge-fail {
            background-color: #dc3545;
            color: white;
            padding: 5px 10px;
            border-radius: 6px;
        }

        .percentage {
            font-weight: bold;
            color: #007bff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-4">

        <div class="mb-4">
            <h2 class="text-primary">
                <i class="fas fa-chart-line"></i> My Academic Results
            </h2>
            <p class="text-muted">Overview of your subject performance</p>
        </div>

        <div class="card card-custom">
            <div class="card-header bg-primary text-white">
                <i class="fas fa-clipboard-list"></i> Marks Table
            </div>

            <div class="card-body">

                <asp:GridView ID="gvMarks" runat="server" CssClass="table table-hover table-bordered"
                    AutoGenerateColumns="False">

                    <Columns>

                        <asp:BoundField DataField="SubjectName" HeaderText="Subject" />

                        <asp:BoundField DataField="TotalMarks" HeaderText="Marks" />

                        <asp:BoundField DataField="OutOfMarks" HeaderText="Out Of" />

                        <asp:TemplateField HeaderText="Percentage">
                            <ItemTemplate>
                                <span class="percentage">
                                    <%# String.Format("{0:0.00}%", Eval("Percentage")) %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Result">
                            <ItemTemplate>
                                <%# Eval("Result").ToString() == "Pass" 
                                    ? "<span class='badge-pass'>Pass</span>" 
                                    : "<span class='badge-fail'>Fail</span>" %>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </div>
        </div>

    </div>

</asp:Content>