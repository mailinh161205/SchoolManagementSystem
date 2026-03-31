<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMst.Master" AutoEventWireup="true" CodeBehind="Fees.aspx.cs" Inherits="SchoolManagementSystem.Student.Fees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">

    <div class="card shadow-sm mb-4">
        <div class="card-body d-flex justify-content-between align-items-center">
            <div>
                <h4 class="mb-1">Tuition Fees</h4>
                <small class="text-muted">Your class fee information</small>
            </div>
            <div>
                <span class="badge bg-primary p-3 fs-6">
                    Total: <asp:Label ID="lblTotalFees" runat="server"></asp:Label>
                </span>
            </div>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <asp:GridView ID="gvFees" runat="server"
                CssClass="table table-hover table-bordered"
                AutoGenerateColumns="False"
                EmptyDataText="No fee data found">

                <Columns>
                    <asp:BoundField DataField="ClassName" HeaderText="Class" />

                    <asp:TemplateField HeaderText="Fees Amount">
                        <ItemTemplate>
                            <span class="badge bg-success">
                                <%# String.Format("{0:N0} VNĐ", Eval("FeesAmount")) %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>

            </asp:GridView>
        </div>
    </div>

</div>

</asp:Content>