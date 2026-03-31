<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" 
AutoEventWireup="true" CodeBehind="Teacher.aspx.cs" 
Inherits="SchoolManagementSystem.Admin.Teacher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div style="background-image: url('../Image/bg4.jpg'); width: 100%; min-height: 720px; background-size: cover; background-attachment: fixed;">
    
<div class="container p-4">

    <!-- MESSAGE -->
    <asp:Label ID="lblMsg" runat="server"></asp:Label>

    <h3 class="text-center mb-4">Add Teacher</h3>

    <!-- NAME + DOB -->
    <div class="row mb-3">
        <div class="col-md-6">
            <label>Name</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:RequiredFieldValidator ID="rfvName" runat="server"
                ControlToValidate="txtName"
                ErrorMessage="Name is required"
                ForeColor="Red" Display="Dynamic" />

            <asp:RegularExpressionValidator ID="revName" runat="server"
                ControlToValidate="txtName"
                ValidationExpression="^[\p{L}\s]+$"
                ErrorMessage="Only letters allowed"
                ForeColor="Red" Display="Dynamic" />
        </div>

        <div class="col-md-6">
            <label>Date of Birth</label>
            <asp:TextBox ID="txtDoB" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
        </div>
    </div>

    <!-- GENDER + MOBILE -->
    <div class="row mb-3">
        <div class="col-md-6">
            <label>Gender</label>
            <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">Select Gender</asp:ListItem>
                <asp:ListItem Value="Male">Male</asp:ListItem>
                <asp:ListItem Value="Female">Female</asp:ListItem>
                <asp:ListItem Value="Other">Other</asp:ListItem>
            </asp:DropDownList>

            <asp:RequiredFieldValidator ID="rfvGender" runat="server"
                ControlToValidate="ddlGender"
                InitialValue="0"
                ErrorMessage="Gender is required"
                ForeColor="Red" Display="Dynamic" />
        </div>

        <div class="col-md-6">
            <label>Mobile</label>
            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:RequiredFieldValidator ID="rfvMobile" runat="server"
                ControlToValidate="txtMobile"
                ErrorMessage="Mobile is required"
                ForeColor="Red" Display="Dynamic" />

            <!-- FIX: 10–15 số -->
            <asp:RegularExpressionValidator ID="revMobile" runat="server"
                ControlToValidate="txtMobile"
                ValidationExpression="^[0-9]{10,15}$"
                ErrorMessage="10-15 digits required"
                ForeColor="Red" Display="Dynamic" />
        </div>
    </div>

    <!-- EMAIL + PASSWORD -->
    <div class="row mb-3">
        <div class="col-md-6">
            <label>Email</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="Email is required"
                ForeColor="Red" Display="Dynamic" />

            <!-- FIX: validate email -->
            <asp:RegularExpressionValidator ID="revEmail" runat="server"
                ControlToValidate="txtEmail"
                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                ErrorMessage="Invalid Email"
                ForeColor="Red" Display="Dynamic" />
        </div>

        <div class="col-md-6">
            <label>Password</label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>

            <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                ControlToValidate="txtPassword"
                ErrorMessage="Password is required"
                ForeColor="Red" Display="Dynamic" />
        </div>
    </div>

    <!-- ADDRESS -->
    <div class="row mb-3">
        <div class="col-md-12">
            <label>Address</label>
            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>

            <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                ControlToValidate="txtAddress"
                ErrorMessage="Address is required"
                ForeColor="Red" Display="Dynamic" />
        </div>
    </div>

    <!-- BUTTON -->
    <div class="row mb-4">
        <div class="col-md-3">
            <asp:Button ID="btnAdd" runat="server"
                CssClass="btn btn-primary w-100"
                BackColor="#5558C9"
                Text="Add Teacher"
                OnClick="btnAdd_Click" />
        </div>
    </div>

    <!-- GRID -->
    <asp:GridView ID="GridView1" runat="server"
        CssClass="table table-bordered table-hover"
        AutoGenerateColumns="False"
        DataKeyNames="TeacherId"
        AllowPaging="True"
        PageSize="5"
        EmptyDataText="No record to display!"

        OnPageIndexChanging="GridView1_PageIndexChanging"
        OnRowEditing="GridView1_RowEditing"
        OnRowCancelingEdit="GridView1_RowCancelingEdit"
        OnRowUpdating="GridView1_RowUpdating"
        OnRowDeleting="GridView1_RowDeleting">

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

            <asp:BoundField DataField="Email" HeaderText="Email" ReadOnly="True" />

            <asp:TemplateField HeaderText="Password">
                <EditItemTemplate>
                    <asp:TextBox ID="txtPassword" runat="server" Text='<%# Bind("Password") %>' CssClass="form-control"/>
                </EditItemTemplate>
                <ItemTemplate><%# Eval("Password") %></ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Address">
                <EditItemTemplate>
                    <asp:TextBox ID="txtAddress" runat="server" Text='<%# Bind("Address") %>' 
                        CssClass="form-control" TextMode="MultiLine" Rows="2"/>
                </EditItemTemplate>
                <ItemTemplate><%# Eval("Address") %></ItemTemplate>
            </asp:TemplateField>

            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" HeaderText="Action" />

        </Columns>

        <HeaderStyle BackColor="#5558C9" ForeColor="White" />

    </asp:GridView>

</div>
</div>

</asp:Content>