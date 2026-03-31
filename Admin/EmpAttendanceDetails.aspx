<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMst.Master" AutoEventWireup="true" CodeBehind="EmpAttendanceDetails.aspx.cs" Inherits="SchoolManagementSystem.Admin.EmpAttendanceDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div style="background-image: url('../Image/bg4.jpg'); width: 100%; height: 720px; background-repeat: no-repeat; background-size: cover; background-attachment: fixed;">
    
    <div class="container p-md-4 p-sm-4">

        <div>
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
        </div>

        <h3 class="text-center">Teacher Attendance Details</h3>

        <div class="row mb-3 mr-lg-5 ml-lg-5 mt-md-5">

             <div class="col-md-6">
                <label for="ddlTeacher">Teacher</label>
                <asp:DropDownList ID="ddlTeacher" runat="server" CssClass="form-control">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                    ErrorMessage="Teacher is required." 
                    ControlToValidate="ddlTeacher" Display="Dynamic" 
                    ForeColor="Red" InitialValue="0" SetFocusOnError="True" />
            </div>

            <div class="col-md-6">
                <label>Month</label>
                <asp:TextBox ID="txtMonth" CssClass="form-control" runat="server" TextMode="Month">
                </asp:TextBox>
            </div>
  
        </div>

        <div class="row mb-3 mr-lg-5 ml-lg-5">
            <div class="col-md-3 col-md-offset-2 mb-3">
                <asp:Button ID="btnCheckAttendance" runat="server"
                    CssClass="btn btn-primary btn-block"
                    BackColor="#5558C9"
                    Text="Check Attendance"
                    OnClick="btnCheckAttendance_Click" />
            </div>
        </div>

       <div class="row mb-3 mr-lg-5 ml-lg-5">
            <div class="col-md-12">

                <asp:GridView ID="GridView1" runat="server"
                    CssClass="table table-hover table-bordered"
                    EmptyDataText="No record to display!"
                    AutoGenerateColumns="False"
                    UseAccessibleHeader="true"
                    OnPreRender="GridView1_PreRender">

    <Columns>

         <asp:BoundField DataField="SrNo" HeaderText="Sr.No">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

                        <asp:BoundField DataField="Name" HeaderText="Name">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>

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
            Convert.ToDateTime(Eval("Date")).ToString("dd MMMM yyyy", System.Globalization.CultureInfo.InvariantCulture) 
            : "" %>
    </ItemTemplate>
    <ItemStyle HorizontalAlign="Center" />
</asp:TemplateField>

    </Columns>

    <HeaderStyle BackColor="#5558C9" ForeColor="White" />

</asp:GridView>

            </div>
        </div>

    </div>
</div>


</asp:Content>
