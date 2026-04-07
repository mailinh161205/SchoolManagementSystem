<%@ Page Title="" Language="C#" MasterPageFile="~/Teacher/TeacherMst.Master" AutoEventWireup="true" CodeBehind="Marks.aspx.cs" Inherits="SchoolManagementSystem.Teacher.Marks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div style="background-image: url('../Image/bg4.jpg'); width: 100%; height: 720px; background-repeat: no-repeat; background-size: cover; background-attachment: fixed;">
    
    <div class="container p-md-4 p-sm-4">

        <div>
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
        </div>

        <h3 class="text-center">Add Marks</h3>

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
                <label>Subject</label>
                <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-control"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlSubject_SelectedIndexChanged">
                </asp:DropDownList>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                    ErrorMessage="Subject is required."
                    ControlToValidate="ddlSubject"
                    Display="Dynamic"
                    ForeColor="Red"
                    InitialValue="0"
                    SetFocusOnError="True" />
            </div>

            <div class="col-md-12 mt-2">
                <label>Student Roll Number</label>
                <asp:DropDownList ID="ddlRollNo" runat="server" CssClass="form-control">
                    <asp:ListItem Value="0">Select Roll No</asp:ListItem>
                </asp:DropDownList>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                    ErrorMessage="Roll No is required."
                    ControlToValidate="ddlRollNo"
                    InitialValue="0"
                    ForeColor="Red" />
            </div>

            <div class="col-md-6 mt-2">
                <label>Total Marks (Student Marks)</label>
                <asp:TextBox ID="txtStudMarks" runat="server"
                    CssClass="form-control"
                    placeholder="Enter Total Marks"
                    TextMode="Number" />
            </div>

            <div class="col-md-6 mt-2">
                <label>Out of Marks</label>
                <asp:TextBox ID="txtOutOfMarks" runat="server"
                    CssClass="form-control"
                    placeholder="Enter Out of Marks"
                    TextMode="Number" />
            </div>

        </div>

        <div class="row mb-3 mr-lg-5 ml-lg-5">
            <div class="col-md-3 col-md-offset-2 mb-3">
                <asp:Button ID="btnAdd" runat="server"
                    CssClass="btn btn-primary btn-block"
                    BackColor="#5558C9"
                    Text="Add Marks"
                    OnClick="btnAdd_Click" />
            </div>
        </div>

        <div class="row mb-3 mr-lg-5 ml-lg-5">
            <div class="col-md-12">

                <asp:GridView ID="GridView1" runat="server"
                    CssClass="table table-hover table-bordered"
                    EmptyDataText="No record to display!"
                    AutoGenerateColumns="False"
                    AllowPaging="True"
                    PageSize="4"
                    DataKeyNames="ExamId"
                    OnPageIndexChanging="GridView1_PageIndexChanging"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit"
                    OnRowEditing="GridView1_RowEditing"
                    OnRowUpdating="GridView1_RowUpdating"
                    OnRowDataBound="GridView1_RowDataBound">

                    <Columns>

                        <asp:BoundField DataField="Sr.No" HeaderText="Sr.No" ReadOnly="True">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

                        <asp:TemplateField HeaderText="Class">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlClassGv" runat="server"
                                    DataSourceID="SqlDataSource1"
                                    DataTextField="ClassName"
                                    DataValueField="ClassId"
                                    SelectedValue='<%# Eval("ClassId") %>'
                                    CssClass="form-control"
                                    AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlClassGv_SelectedIndexChanged">

                                    <asp:ListItem Value="0">Select Class</asp:ListItem>

                                </asp:DropDownList>

                                <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:SchoolCS %>"
                                    SelectCommand="SELECT * FROM [Class]">
                                </asp:SqlDataSource>
                            </EditItemTemplate>

                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server"
                                    Text='<%# Eval("ClassName") %>'>
                                </asp:Label>
                            </ItemTemplate>

                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Subject">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlSubjectGv" runat="server"
                                    CssClass="form-control">
                                </asp:DropDownList>
                            </EditItemTemplate>

                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server"
                                    Text='<%# Eval("SubjectName") %>'>
                                </asp:Label>
                            </ItemTemplate>

                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Roll Number">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtRollNoGv" runat="server"
    CssClass="form-control"
    Text='<%# Eval("RollNo") %>'>
</asp:TextBox>
                            </EditItemTemplate>

                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server"
    Text='<%# Eval("RollNo") %>'>
</asp:Label>
                            </ItemTemplate>

                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>




                        <asp:TemplateField HeaderText="Total Marks">
    <EditItemTemplate>
        <asp:TextBox ID="txtStudMarksGv" runat="server"
    CssClass="form-control"
    Text='<%# Eval("TotalMarks") %>'>
</asp:TextBox>
    </EditItemTemplate>

    <ItemTemplate>
       <asp:Label ID="Label4" runat="server"
    Text='<%# Eval("TotalMarks") %>'>
</asp:Label>
    </ItemTemplate>

    <ItemStyle HorizontalAlign="Center" />
</asp:TemplateField>


                                                <asp:TemplateField HeaderText="Out of Marks">
    <EditItemTemplate>
       <asp:TextBox ID="txtOutOfMarksGv" runat="server"
    CssClass="form-control"
    Text='<%# Eval("OutOfMarks") %>'>
</asp:TextBox>
    </EditItemTemplate>

    <ItemTemplate>
        <asp:Label ID="Label5" runat="server"
    Text='<%# Eval("OutOfMarks") %>'>
</asp:Label>
    </ItemTemplate>

    <ItemStyle HorizontalAlign="Center" />
</asp:TemplateField>



                        <asp:CommandField CausesValidation="false"
                            HeaderText="Operation"
                            ShowEditButton="True">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:CommandField>

                    </Columns>

                    <HeaderStyle BackColor="#5558C9" ForeColor="White" />

                </asp:GridView>

            </div>
        </div>

    </div>
</div>
</asp:Content>
