<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="MarkDetails.aspx.cs" Inherits="SchoolManagementSystem.Admin.MarkDetails" %>

<%@ Register TagPrefix="uc" TagName="MarksDetail" Src="~/MarksDetailUserControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<%--<div style="background-image: url('../Image/bg4.jpg'); width: 100%; height: 720px; background-repeat: no-repeat; background-size: cover; background-attachment: fixed;">
    
    <div class="container p-md-4 p-sm-4">

        <div>
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
        </div>

        <h3 class="text-center">Mark Details</h3>

        <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">

            <div class="col-md-6">
                <label>Class</label>
                <asp:DropDownList ID="ddlClass" runat="server" CssClass="form-control"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                </asp:DropDownList>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                    ErrorMessage="Class is required."
                    ControlToValidate="ddlClass"
                    Display="Dynamic"
                    ForeColor="Red"
                    InitialValue="0"
                    SetFocusOnError="True" />
            </div>

            <div class="col-md-6">
                <label>Student Roll Number</label>
                <asp:DropDownList ID="ddlRollNo" runat="server" CssClass="form-control">
                    <asp:ListItem Value="0">Select Roll No</asp:ListItem>
                </asp:DropDownList>
            </div>

        </div>

        <div class="row mb-3 mr-lg-5 ml-lg-5">
            <div class="col-md-3 col-md-offset-2 mb-3">
                <asp:Button ID="btnAdd" runat="server"
                    CssClass="btn btn-primary btn-block"
                    BackColor="#5558C9"
                    Text="Get Marks"
                    OnClick="btnAdd_Click" />
            </div>
        </div>

        <div class="row mb-3 mr-lg-5 ml-lg-5">
            <div class="col-md-12">

                <asp:GridView ID="GridView1" runat="server"
                    CssClass="table table-hover table-bordered"
                    EmptyDataText="No record to display!"
                    AutoGenerateColumns="False"
                    AllowPaging="true"
                    PageSize="8"
                    OnPageIndexChanging="GridView1_PageIndexChanging">

                    <Columns>

                        <asp:BoundField DataField="Sr.No" HeaderText="Sr.No">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

                        <asp:BoundField DataField="ExamId" HeaderText="ExamId">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

                        <asp:BoundField DataField="ClassName" HeaderText="Class">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

                        <asp:BoundField DataField="SubjectName" HeaderText="Subject">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

                        <asp:BoundField DataField="RollNo" HeaderText="Roll Number">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

                        <asp:BoundField DataField="TotalMarks" HeaderText="Total Marks">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

                        <asp:BoundField DataField="OutOfMarks" HeaderText="Out Of Marks">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

                    </Columns>

                    <HeaderStyle BackColor="#5558C9" ForeColor="White"/>

                </asp:GridView>

            </div>
        </div>

    </div>

</div>--%>


        <uc:MarksDetail runat="server" ID="MarksDetail1" />


</asp:Content>