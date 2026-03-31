using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static SchoolManagementSystem.Models.CommonFn;

namespace SchoolManagementSystem.Admin
{
    public partial class Student : System.Web.UI.Page
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
                GetStudents();
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

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (ddlGender.SelectedValue == "0" || ddlClass.SelectedValue == "0")
            {
                lblMsg.Text = "Please fill all required fields!";
                lblMsg.CssClass = "alert alert-danger";
                return;
            }

            string rollNo = txtRoll.Text.Trim();

            DataTable dt = fn.Fetch("SELECT * FROM Student WHERE ClassId='" + ddlClass.SelectedValue + "' AND RollNo='" + rollNo + "'");

            if (dt.Rows.Count > 0)
            {
                lblMsg.Text = "Roll No already exists!";
                lblMsg.CssClass = "alert alert-danger";
                return;
            }

            string query = "INSERT INTO Student VALUES (N'" + txtName.Text.Trim() + "','" +
                txtDoB.Text + "',N'" + ddlGender.SelectedValue + "','" +
                txtMobile.Text + "',N'" + rollNo + "',N'" +
                txtAddress.Text + "','" + ddlClass.SelectedValue + "')";

            fn.Query(query);

            lblMsg.Text = "Inserted Successfully!";
            lblMsg.CssClass = "alert alert-success";

            Clear();
            GetStudents();
        }

        private void Clear()
        {
            txtName.Text = "";
            txtDoB.Text = "";
            txtMobile.Text = "";
            txtRoll.Text = "";
            txtAddress.Text = "";
            ddlGender.SelectedIndex = 0;
            ddlClass.SelectedIndex = 0;
        }

        private void GetStudents()
        {
            DataTable dt = fn.Fetch(@"SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [Sr.No],
                s.StudentId,s.Name,s.Mobile,s.RollNo,s.Address,c.ClassName,c.ClassId
                FROM Student s INNER JOIN Class c ON s.ClassId=c.ClassId");

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string key = txtSearch.Text.Trim();

            string query = @"SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [Sr.No],
                s.StudentId,s.Name,s.Mobile,s.RollNo,s.Address,c.ClassName,c.ClassId
                FROM Student s INNER JOIN Class c ON s.ClassId=c.ClassId
                WHERE s.Name LIKE N'%" + key + "%' OR s.RollNo LIKE N'%" + key + "%'";

            GridView1.DataSource = fn.Fetch(query);
            GridView1.DataBind();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            GetStudents();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            fn.Query("DELETE FROM Student WHERE StudentId='" + id + "'");

            lblMsg.Text = "Deleted!";
            lblMsg.CssClass = "alert alert-danger";

            GetStudents();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetStudents();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetStudents();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView1.Rows[e.RowIndex];

            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            string name = ((TextBox)row.FindControl("txtName")).Text;
            string mobile = ((TextBox)row.FindControl("txtMobile")).Text;
            string roll = ((TextBox)row.FindControl("txtRollNo")).Text;
            string address = ((TextBox)row.FindControl("txtAddress")).Text;

            DropDownList ddl = (DropDownList)row.FindControl("ddlClass");

            string query = "UPDATE Student SET Name=N'" + name + "',Mobile='" + mobile +
                "',RollNo=N'" + roll + "',Address=N'" + address +
                "',ClassId='" + ddl.SelectedValue + "' WHERE StudentId='" + id + "'";

            fn.Query(query);

            lblMsg.Text = "Updated!";
            lblMsg.CssClass = "alert alert-success";

            GridView1.EditIndex = -1;
            GetStudents();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetStudents();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton btn = e.Row.Cells[0].Controls.OfType<LinkButton>()
                    .FirstOrDefault(x => x.CommandName == "Delete");

                if (btn != null)
                {
                    btn.OnClientClick = "return confirm('Delete this student?');";
                }
            }

            if (e.Row.RowType == DataControlRowType.DataRow && GridView1.EditIndex == e.Row.RowIndex)
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("ddlClass");

                DataTable dt = fn.Fetch("SELECT * FROM Class");

                ddl.DataSource = dt;
                ddl.DataTextField = "ClassName";
                ddl.DataValueField = "ClassId";
                ddl.DataBind();

                string classId = DataBinder.Eval(e.Row.DataItem, "ClassId").ToString();
                ddl.SelectedValue = classId;
            }
        }
    }
}
