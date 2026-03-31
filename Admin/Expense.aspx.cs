using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static SchoolManagementSystem.Models.CommonFn;

namespace SchoolManagementSystem.Admin
{
    public partial class Expense : System.Web.UI.Page
    {

        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx");
            }
            if (!IsPostBack)
            {
                GetClass();
                GetExpense();
            }
        }

        private void GetClass()
        {
            DataTable dt = fn.Fetch("SELECT * FROM Class");

            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "ClassName";
            ddlClass.DataValueField = "ClassId";
            ddlClass.DataBind();

            ddlClass.Items.Insert(0, new ListItem("Select Class", "0"));
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlSubject.Items.Clear();
            ddlSubject.Items.Insert(0, new ListItem("Select Subject", "0"));

            if (ddlClass.SelectedValue != "0")
            {
                DataTable dt = fn.Fetch("SELECT * FROM Subject WHERE ClassId = " + ddlClass.SelectedValue);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();

                ddlSubject.Items.Insert(0, new ListItem("Select Subject", "0"));
            }
        }

        private void GetExpense()
        {
            DataTable dt = fn.Fetch(@"
                SELECT ROW_NUMBER() OVER(ORDER BY e.ExpenseId) AS [Sr.No], 
                       e.ExpenseId, 
                       e.ClassId,
                       c.ClassName,
                       e.SubjectId, 
                       s.SubjectName,
                       e.ChargeAmount
                FROM Expense e
                INNER JOIN Class c ON e.ClassId = c.ClassId
                INNER JOIN Subject s ON e.SubjectId = s.SubjectId");

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string classId = ddlClass.SelectedValue;
                string subjectId = ddlSubject.SelectedValue;
                string chargeAmt = txtExpenseAmt.Text.Trim();

                if (classId == "0" || subjectId == "0" || string.IsNullOrEmpty(chargeAmt))
                {
                    lblMsg.Text = "Please fill all fields!";
                    lblMsg.CssClass = "alert alert-danger";
                    return;
                }

                DataTable dt = fn.Fetch("SELECT * FROM Expense WHERE ClassId = " + classId +
                                        " AND SubjectId = " + subjectId);

                if (dt.Rows.Count == 0)
                {
                    string query = "INSERT INTO Expense (ClassId, SubjectId, ChargeAmount) VALUES (" +
                                    classId + "," + subjectId + "," + chargeAmt + ")";

                    fn.Query(query);

                    lblMsg.Text = "Inserted Successfully!";
                    lblMsg.CssClass = "alert alert-success";

                    ddlClass.SelectedIndex = 0;
                    ddlSubject.Items.Clear();
                    ddlSubject.Items.Insert(0, new ListItem("Select Subject", "0"));
                    txtExpenseAmt.Text = "";

                    GetExpense();
                }
                else
                {
                    lblMsg.Text = "Data already exists!";
                    lblMsg.CssClass = "alert alert-danger";
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetExpense();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetExpense();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetExpense();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int expenseId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

                fn.Query("DELETE FROM Expense WHERE ExpenseId = " + expenseId);

                lblMsg.Text = "Expense deleted Successfully!";
                lblMsg.CssClass = "alert alert-success";

                GetExpense();
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];

                int expenseId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

                DropDownList ddlClassGv = (DropDownList)row.FindControl("ddlClassGv");
                DropDownList ddlSubjectGv = (DropDownList)row.FindControl("ddlSubjectGv");
                TextBox txtAmt = (TextBox)row.FindControl("txtExpenseAmt");

                string classId = ddlClassGv.SelectedValue;
                string subjectId = ddlSubjectGv.SelectedValue;
                string chargeAmt = txtAmt.Text.Trim();

                fn.Query(@"UPDATE Expense SET 
                            ClassId = " + classId + @",
                            SubjectId = " + subjectId + @",
                            ChargeAmount = " + chargeAmt + @"
                           WHERE ExpenseId = " + expenseId);

                lblMsg.Text = "Record Updated Successfully!";
                lblMsg.CssClass = "alert alert-success";

                GridView1.EditIndex = -1;
                GetExpense();
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        protected void ddlClassGv_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlClassSelected = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddlClassSelected.NamingContainer;

            if (row != null)
            {
                DropDownList ddlSubjectGV = (DropDownList)row.FindControl("ddlSubjectGv");

                DataTable dt = fn.Fetch("SELECT * FROM Subject WHERE ClassId = " + ddlClassSelected.SelectedValue);

                ddlSubjectGV.DataSource = dt;
                ddlSubjectGV.DataTextField = "SubjectName";
                ddlSubjectGV.DataValueField = "SubjectId";
                ddlSubjectGV.DataBind();

                ddlSubjectGV.Items.Insert(0, new ListItem("Select Subject", "0"));
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow &&
                (e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                DropDownList ddlClass = (DropDownList)e.Row.FindControl("ddlClassGv");
                DropDownList ddlSubject = (DropDownList)e.Row.FindControl("ddlSubjectGv");

                DataTable dt = fn.Fetch("SELECT * FROM Subject WHERE ClassId = " + ddlClass.SelectedValue);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();

                ddlSubject.Items.Insert(0, new ListItem("Select Subject", "0"));

                string selectedSubjectId = DataBinder.Eval(e.Row.DataItem, "SubjectId").ToString();

                if (ddlSubject.Items.FindByValue(selectedSubjectId) != null)
                {
                    ddlSubject.SelectedValue = selectedSubjectId;
                }
            }
        }
    }
}