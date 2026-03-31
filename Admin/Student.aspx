<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="Student.aspx.cs" Inherits="SchoolManagementSystem.Admin.Student" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div style="background-image: url('../Image/bg4.jpg'); width: 100%; min-height: 720px; background-size: cover; background-attachment: fixed;">
    
<div class="container p-4">

    <asp:Label ID="lblMsg" runat="server"></asp:Label>

    <h3 class="text-center mb-4">Add Student</h3>

    <!-- NAME + DOB -->
    <div class="row mb-3">
        <div class="col-md-6">
            <label>Name</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:RequiredFieldValidator ID="rfvName" runat="server"
                ControlToValidate="txtName"
                ErrorMessage="Name is required"
                ForeColor="Red"
                ValidationGroup="AddStudent" />

            <asp:RegularExpressionValidator ID="revName" runat="server"
                ControlToValidate="txtName"
                ValidationExpression="^(?!\s*$)[a-zA-ZÀ-ỹ\s]+$"
                ErrorMessage="Name only contains letters"
                ForeColor="Red"
                ValidationGroup="AddStudent" />
        </div>

        <div class="col-md-6">
            <label>Date of Birth</label>
            <asp:TextBox ID="txtDoB" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>

            <asp:RequiredFieldValidator ID="rfvDob" runat="server"
                ControlToValidate="txtDoB"
                ErrorMessage="Date of Birth is required"
                ForeColor="Red"
                ValidationGroup="AddStudent" />
        </div>
    </div>

    <!-- GENDER + MOBILE -->
    <div class="row mb-3">
        <div class="col-md-6">
            <label>Gender</label>
            <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">Select Gender</asp:ListItem>
                <asp:ListItem>Male</asp:ListItem>
                <asp:ListItem>Female</asp:ListItem>
                <asp:ListItem>Other</asp:ListItem>
            </asp:DropDownList>

            <asp:RequiredFieldValidator ID="rfvGender" runat="server"
                ControlToValidate="ddlGender"
                InitialValue="0"
                ErrorMessage="Gender is required"
                ForeColor="Red"
                ValidationGroup="AddStudent" />
        </div>

        <div class="col-md-6">
            <label>Mobile</label>
            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:RequiredFieldValidator ID="rfvMobile" runat="server"
                ControlToValidate="txtMobile"
                ErrorMessage="Mobile is required"
                ForeColor="Red"
                ValidationGroup="AddStudent" />

            <asp:RegularExpressionValidator ID="revMobile" runat="server"
                ControlToValidate="txtMobile"
                ValidationExpression="^[0-9]{10,15}$"
                ErrorMessage="10-15 digits required"
                ForeColor="Red"
                ValidationGroup="AddStudent" />
        </div>
    </div>

    <!-- ROLL + CLASS -->
    <div class="row mb-3">
        <div class="col-md-6">
            <label>Roll Number</label>
            <asp:TextBox ID="txtRoll" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:RequiredFieldValidator ID="rfvRoll" runat="server"
                ControlToValidate="txtRoll"
                ErrorMessage="Roll Number is required"
                ForeColor="Red"
                ValidationGroup="AddStudent" />

            <asp:RegularExpressionValidator ID="revRoll" runat="server"
                ControlToValidate="txtRoll"
                ValidationExpression="^BH[0-9]{5}$"
                ErrorMessage="Roll must be like BH00001"
                ForeColor="Red"
                ValidationGroup="AddStudent" />
        </div>

        <div class="col-md-6">
            <label>Class</label>
            <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-control"></asp:DropDownList>

            <asp:RequiredFieldValidator ID="rfvClass" runat="server"
                ControlToValidate="ddlClass"
                InitialValue="0"
                ErrorMessage="Class is required"
                ForeColor="Red"
                ValidationGroup="AddStudent" />
        </div>
    </div>

    <!-- ADDRESS -->
    <div class="row mb-3">
        <div class="col-md-12">
            <label>Address</label>
            <asp:TextBox ID="txtAddress" runat="server"
                CssClass="form-control"
                TextMode="MultiLine"
                Rows="3"></asp:TextBox>

            <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                ControlToValidate="txtAddress"
                ErrorMessage="Address is required"
                ForeColor="Red"
                ValidationGroup="AddStudent" />
        </div>
    </div>

    <!-- BUTTON -->
    <div class="row mb-4">
        <div class="col-md-3">
            <asp:Button ID="btnAdd" runat="server"
                CssClass="btn btn-primary w-100"
                BackColor="#5558C9"
                Text="Add Student"
                ValidationGroup="AddStudent"
                OnClick="btnAdd_Click" />
        </div>
    </div>

    <!-- SEARCH -->
    <div class="row mb-3">
        <div class="col-md-6">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" Placeholder="Search by Name or RollNo"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:Button ID="btnSearch" runat="server"
                Text="Search"
                CssClass="btn btn-info w-100"
                OnClick="btnSearch_Click" />
        </div>
        <div class="col-md-2">
            <asp:Button ID="btnReset" runat="server"
                Text="Reset"
                CssClass="btn btn-secondary w-100"
                OnClick="btnReset_Click" />
        </div>
    </div>

    <!-- GRID -->
    <asp:GridView ID="GridView1" runat="server"
        CssClass="table table-bordered table-hover"
        AutoGenerateColumns="False"
        DataKeyNames="StudentId"
        AllowPaging="True"
        PageSize="5"

        OnPageIndexChanging="GridView1_PageIndexChanging"
        OnRowEditing="GridView1_RowEditing"
        OnRowDeleting="GridView1_RowDeleting"
        OnRowCancelingEdit="GridView1_RowCancelingEdit"
        OnRowUpdating="GridView1_RowUpdating"
        OnRowDataBound="GridView1_RowDataBound">

        <Columns>

            <asp:BoundField DataField="Sr.No" HeaderText="No" ReadOnly="True" />

            <asp:TemplateField HeaderText="Name">
                <EditItemTemplate>
                    <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control"/>
                </EditItemTemplate>
                <ItemTemplate><%# Eval("Name") %></ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Mobile">
                <EditItemTemplate>
                    <asp:TextBox ID="txtMobile" runat="server" Text='<%# Bind("Mobile") %>' CssClass="form-control"/>
                </EditItemTemplate>
                <ItemTemplate><%# Eval("Mobile") %></ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Roll">
                <EditItemTemplate>
                    <asp:TextBox ID="txtRollNo" runat="server" Text='<%# Bind("RollNo") %>' CssClass="form-control"/>
                </EditItemTemplate>
                <ItemTemplate><%# Eval("RollNo") %></ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Class">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-control"></asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate><%# Eval("ClassName") %></ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Address">
                <EditItemTemplate>
                    <asp:TextBox ID="txtAddress" runat="server" Text='<%# Bind("Address") %>' CssClass="form-control"/>
                </EditItemTemplate>
                <ItemTemplate><%# Eval("Address") %></ItemTemplate>
            </asp:TemplateField>

            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"/>

        </Columns>

        <HeaderStyle BackColor="#5558C9" ForeColor="White" />

    </asp:GridView>

</div>
</div>

</asp:Content>