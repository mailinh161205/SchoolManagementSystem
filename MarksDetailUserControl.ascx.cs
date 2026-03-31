using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static SchoolManagementSystem.Models.CommonFn;

namespace SchoolManagementSystem
{
    public partial class MarksDetailUserControl : System.Web.UI.UserControl
    {
        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            //{
            //    Response.Redirect("~/Login.aspx");
            //}
            if (!IsPostBack)
            {
                GetClass();
                GetMarks();
            }
        }

        private void GetMarks()
        {
            DataTable dt = fn.Fetch(@"
                SELECT 
                    ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [Sr.No],
                    e.ExamId, 
                    e.ClassId, 
                    c.ClassName, 
                    e.SubjectId,
                    s.SubjectName, 
                    e.RollNo, 
                    e.TotalMarks, 
                    e.OutOfMarks 
                FROM Exam e
                INNER JOIN Class c ON c.ClassId = e.ClassId 
                INNER JOIN Subject s ON s.SubjectId = e.SubjectId");

            GridView1.DataSource = dt;
            GridView1.DataBind();
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
            ddlRollNo.Items.Clear();

            if (ddlClass.SelectedValue != "0")
            {
                DataTable dt = fn.Fetch("SELECT RollNo FROM Student WHERE ClassId = " + ddlClass.SelectedValue);

                ddlRollNo.DataSource = dt;
                ddlRollNo.DataTextField = "RollNo";
                ddlRollNo.DataValueField = "RollNo";
                ddlRollNo.DataBind();

            }

            ddlRollNo.Items.Insert(0, new ListItem("Select Roll No", "0"));

            GridView1.DataSource = null;
            GridView1.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlClass.SelectedValue == "0")
                {
                    lblMsg.Text = "Please select class!";
                    lblMsg.CssClass = "alert alert-warning";
                    return;
                }

                if (ddlRollNo.SelectedValue == "0")
                {
                    lblMsg.Text = "Please select roll number!";
                    lblMsg.CssClass = "alert alert-warning";
                    return;
                }

                string classId = ddlClass.SelectedValue;
                string rollNo = ddlRollNo.SelectedValue;

                string query = @"
            SELECT 
                ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [Sr.No],
                e.ExamId, 
                e.ClassId, 
                c.ClassName, 
                e.SubjectId,
                s.SubjectName, 
                e.RollNo, 
                e.TotalMarks, 
                e.OutOfMarks 
            FROM Exam e
            INNER JOIN Class c ON c.ClassId = e.ClassId 
            INNER JOIN Subject s ON s.SubjectId = e.SubjectId
            WHERE e.ClassId = " + classId + " AND e.RollNo = '" + rollNo + "'";

                DataTable dt = fn.Fetch(query);

                if (dt.Rows.Count > 0)
                {
                    GridView1.DataSource = dt;
                    GridView1.DataBind();

                    lblMsg.Text = "Data found!";
                    lblMsg.CssClass = "alert alert-success";
                }
                else
                {
                    GridView1.DataSource = null;
                    GridView1.DataBind();

                    lblMsg.Text = "No record found!";
                    lblMsg.CssClass = "alert alert-warning";
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

            btnAdd_Click(null, null);
        }
    }
}