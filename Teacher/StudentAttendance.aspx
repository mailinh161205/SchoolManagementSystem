<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher/TeacherMst.Master"
    AutoEventWireup="true" CodeBehind="StudentAttendance.aspx.cs"
    Inherits="SchoolManagementSystem.Teacher.StudentAttendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div style="background-image: url('../Image/bg4.jpg'); width: 100%; height: 720px;
     background-repeat: no-repeat; background-size: cover; background-attachment: fixed;">

<div class="container p-md-4 p-sm-4">

    <asp:Label ID="lblMsg" runat="server"></asp:Label>

    <div class="text-right">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick" />
                <asp:Label ID="lblTime" runat="server" Font-Bold="true" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <h3 class="text-center">Student Attendance</h3>

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

    <div class="row mt-3">
        <div class="col-md-3">
            <asp:Button ID="btnSubmit" runat="server"
                CssClass="btn btn-primary btn-block"
                BackColor="#5558C9"
                Text="Load Students"
                OnClick="btnSubmit_Click" />
        </div>
    </div>

    <div class="mt-4">

        <asp:GridView ID="GridView1" runat="server"
            CssClass="table table-bordered table-hover"
            AutoGenerateColumns="False"
            EmptyDataText="No students found!"
            DataKeyNames="StudentId">

            <Columns>

                <asp:BoundField DataField="StudentId" Visible="false" />

                <asp:BoundField DataField="RollNo" HeaderText="Roll No" />
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Mobile" HeaderText="Mobile" />

                <asp:TemplateField HeaderText="Attendance">
                    <ItemTemplate>
                        <asp:RadioButton ID="rbPresent" runat="server"
                            Text="Present"
                            GroupName='<%# Eval("StudentId") %>'
                            Checked="true" />

                        <asp:RadioButton ID="rbAbsent" runat="server"
                            Text="Absent"
                            GroupName='<%# Eval("StudentId") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

            <HeaderStyle BackColor="#5558C9" ForeColor="White" />

        </asp:GridView>

    </div>

    <div class="mt-3">
    <asp:Button ID="btnMarkAttendance" runat="server"
        CssClass="btn btn-primary btn-block" BackColor="#5558C9"
        Text="Mark Attendance"
        OnClick="btnMarkAttendance_Click" />
</div>

</div>
</div>

</asp:Content>