<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StudentAttendanceUC.ascx.cs" Inherits="SchoolManagementSystem.StudentAttendanceUC" %>

<div style="background-image: url('../Image/bg4.jpg'); width: 100%; height: 720px;
     background-repeat: no-repeat; background-size: cover; background-attachment: fixed;">

<div class="container p-md-4 p-sm-4">

    <asp:Label ID="lblMsg" runat="server"></asp:Label>

    <h3 class="text-center">Student Attendance Details</h3>

    <div class="row mt-4">

        <div class="col-md-6">
            <label>Class</label>
            <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-control"
                AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged" />
        </div>

        <div class="col-md-6">
            <label>Subject</label>
            <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-control" />
        </div>

    </div>

    <div class="row mt-4">

    <div class="col-md-6">
        <label>Roll Number</label>
        <asp:DropDownList ID="ddlRollNo" runat="server" CssClass="form-control">
        </asp:DropDownList>
    </div>

    <div class="col-md-6">
        <label>Month</label>
        <asp:TextBox ID="txtMonth" runat="server" CssClass="form-control" TextMode="Month"></asp:TextBox>
    </div>

</div>

    <div class="row mt-3">
        <div class="col-md-3">
            <asp:Button ID="btnCheckAttendance" runat="server"
                CssClass="btn btn-primary btn-block"
                BackColor="#5558C9"
                Text="Check Attendance"
                OnClick="btnCheckAttendance_Click"/>
        </div>
    </div>

    <div class="mt-4">
        <asp:GridView ID="GridView1" runat="server"
            CssClass="table table-hover table-bordered"
            EmptyDataText="No record to display!"
            AutoGenerateColumns="False"
            UseAccessibleHeader="true"
            OnPreRender="GridView1_PreRender">

            <Columns>

                <asp:BoundField DataField="SrNo" HeaderText="Sr.No" />

                <asp:BoundField DataField="Name" HeaderText="Name" />

                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server"
                            Text='<%# Convert.ToBoolean(Eval("Status")) ? "Present" : "Absent" %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Date">
                    <ItemTemplate>
                        <%# Eval("Date") != DBNull.Value ?
                        Convert.ToDateTime(Eval("Date")).ToString("dd MMM yyyy", System.Globalization.CultureInfo.InvariantCulture)
                        : "" %>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

            <HeaderStyle BackColor="#5558C9" ForeColor="White" />

        </asp:GridView>
    </div>

</div>
</div>