<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="ExpenseDetails.aspx.cs" Inherits="SchoolManagementSystem.Admin.ExpenseDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css" rel="stylesheet"/>

    <script type="text/javascript">
        $(document).ready(function () {

            var table = $('#<%= GridView1.ClientID %>');

            if ($.fn.DataTable.isDataTable(table)) {
                table.DataTable().destroy();
            }

            if (table.find("thead").length === 0) {
                table.prepend($("<thead></thead>").append(table.find("tr:first")));
            }

            table.DataTable({
                paging: true,
                ordering: true,
                searching: true
            });

        });
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div style="background-image: url('../Image/bg4.jpg'); width: 100%; height: 720px; background-repeat: no-repeat; background-size: cover; background-attachment: fixed;">
    
    <div class="container p-md-4 p-sm-4">

        <h3 class="text-center">Expense Details</h3>

        <div class="row mb-3 mr-lg-5 ml-lg-5">
            <div class="col-md-12">

                <asp:GridView ID="GridView1" runat="server"
                    CssClass="table table-hover table-bordered"
                    EmptyDataText="No record to display!"
                    AutoGenerateColumns="False"
                    UseAccessibleHeader="true"
                    OnPreRender="GridView1_PreRender">

                    <Columns>

                        <asp:BoundField DataField="Sr.No" HeaderText="Sr.No">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

                        <asp:BoundField DataField="ClassName" HeaderText="Class">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

                        <asp:BoundField DataField="SubjectName" HeaderText="Subject">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

                        <asp:BoundField DataField="ChargeAmount" HeaderText="Charge Amt (Per Lecture)">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

                    </Columns>

                    <HeaderStyle BackColor="#5558C9" ForeColor="White" />

                </asp:GridView>

            </div>
        </div>

    </div>
</div>

</asp:Content>