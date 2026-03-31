<%@ Page Title="" Language="C#" MasterPageFile="~/Student/StudentMst.Master" AutoEventWireup="true" CodeBehind="AttendanceReport.aspx.cs" Inherits="SchoolManagementSystem.Student.AttendanceReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">

    <div class="card shadow-sm mb-4">
        <div class="card-body d-flex justify-content-between align-items-center">
            <div>
                <h4 class="mb-1">Attendance Report</h4>
                <small class="text-muted">Your attendance details</small>
            </div>
            <div>
                <span class="badge bg-success p-2">Present: <asp:Label ID="lblPresent" runat="server"></asp:Label></span>
                <span class="badge bg-danger p-2">Absent: <asp:Label ID="lblAbsent" runat="server"></asp:Label></span>
                <span class="badge bg-primary p-2">Total: <asp:Label ID="lblTotal" runat="server"></asp:Label></span>
            </div>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <asp:GridView ID="gvAttendance" runat="server" CssClass="table table-hover table-bordered"
                AutoGenerateColumns="False" EmptyDataText="No attendance data found">

                <Columns>
                    <asp:BoundField DataField="SubjectName" HeaderText="Subject" />

                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server"
                                Text='<%# Convert.ToBoolean(Eval("Status")) ? "Present" : "Absent" %>'
                                CssClass='<%# Convert.ToBoolean(Eval("Status")) ? "badge bg-success" : "badge bg-danger" %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="Date" HeaderText="Date"
                        DataFormatString="{0:dd/MM/yyyy}" />
                </Columns>

            </asp:GridView>
        </div>
    </div>

</div>

</asp:Content>