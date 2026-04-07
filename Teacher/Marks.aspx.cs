using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static SchoolManagementSystem.Models.CommonFn;

namespace SchoolManagementSystem.Teacher
{
    public partial class Marks : System.Web.UI.Page
    {
        Commonfnx fn = new Commonfnx();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Teacher")
            {
                Response.Redirect("~/Login.aspx");
            }
            if (!IsPostBack)
            {
                GetClass();
                GetMarks();
            }
        }

        private void GetMarks()
        {
            DataTable dt = fn.Fetch(@"
                SELECT ROW_NUMBER() OVER(ORDER BY (Select 1)) AS [Sr.No], 
                       e.ExamId, 
                       e.ClassId,
                       c.ClassName,
                       e.SubjectId, 
                       s.SubjectName,
                       e.RollNo,
                       e.TotalMarks,
                       e.OutOfMarks
                FROM Exam e
                INNER JOIN Class c ON e.ClassId = c.ClassId
                INNER JOIN Subject s ON e.SubjectId = s.SubjectId");

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
            ddlSubject.Items.Clear();
            ddlRollNo.Items.Clear();

            ddlSubject.Items.Add(new ListItem("Select Subject", "0"));
            ddlRollNo.Items.Add(new ListItem("Select Roll No", "0"));

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

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlRollNo.Items.Clear();
            ddlRollNo.Items.Add(new ListItem("Select Roll No", "0"));

            if (ddlClass.SelectedValue != "0" && ddlSubject.SelectedValue != "0")
            {

                DataTable dt = fn.Fetch(@"SELECT DISTINCT s.RollNo FROM Student s
                    INNER JOIN StudentSubject ss ON s.StudentId = ss.StudentId
                    WHERE s.ClassId = " + ddlClass.SelectedValue + " AND ss.SubjectId = " + ddlSubject.SelectedValue);


                /* DataTable dt = fn.Fetch("SELECT RollNo FROM Student WHERE ClassId = " + ddlClass.SelectedValue); */

                ddlRollNo.DataSource = dt;
                ddlRollNo.DataTextField = "RollNo";
                ddlRollNo.DataValueField = "RollNo";
                ddlRollNo.DataBind();

                ddlRollNo.Items.Insert(0, new ListItem("Select Roll No", "0"));
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string classId = ddlClass.SelectedValue;
                string subjectId = ddlSubject.SelectedValue;
                string rollNo = ddlRollNo.SelectedValue;
                string studMarks = txtStudMarks.Text.Trim();
                string outOfMarks = txtOutOfMarks.Text.Trim();

                DataTable dttbl = fn.Fetch("SELECT * FROM Student WHERE ClassId = " + classId +
                                          " AND RollNo = '" + rollNo + "'");

                if (dttbl.Rows.Count > 0)
                {
                    DataTable dt = fn.Fetch("SELECT * FROM Exam WHERE ClassId = " + classId +
                        " AND SubjectId = " + subjectId +
                        " AND RollNo = '" + rollNo + "'");

                    if (dt.Rows.Count == 0)
                    {
                        string query = "INSERT INTO Exam (ClassId, SubjectId, RollNo, TotalMarks, OutOfMarks) VALUES (" +
                                       classId + "," + subjectId + ",'" + rollNo + "'," + studMarks + "," + outOfMarks + ")";

                        fn.Query(query);

                        lblMsg.Text = "Inserted Successfully!";
                        lblMsg.CssClass = "alert alert-success";

                        ddlClass.SelectedIndex = 0;

                        ddlSubject.Items.Clear();
                        ddlSubject.Items.Add(new ListItem("Select Subject", "0"));

                        ddlRollNo.Items.Clear();
                        ddlRollNo.Items.Add(new ListItem("Select Roll No", "0"));

                        txtStudMarks.Text = "";
                        txtOutOfMarks.Text = "";

                        GetMarks();
                    }
                    else
                    {
                        lblMsg.Text = "Data already exists!";
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }
                else
                {
                    lblMsg.Text = "Entered RollNo <b>" + rollNo + "</b> does not exist for selected Class!";
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
            GetMarks();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetMarks();

        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetMarks();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            DropDownList ddlClass = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlClassGv");
            DropDownList ddlSubject = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlSubjectGv");

            TextBox txtRoll = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtRollNoGv");
            TextBox txtMarks = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtStudMarksGv");
            TextBox txtOut = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtOutOfMarksGv");

            string query = @"UPDATE Exam SET ClassId = " + ddlClass.SelectedValue + ", SubjectId = " + ddlSubject.SelectedValue + ", RollNo = '" + txtRoll.Text + @"', TotalMarks = " + txtMarks.Text + @", OutOfMarks = " + txtOut.Text + @" WHERE ExamId = " + id;

            fn.Query(query);

            GridView1.EditIndex = -1;
            GetMarks();

            lblMsg.Text = "Updated Successfully!";
            lblMsg.CssClass = "alert alert-success";
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex == GridView1.EditIndex)
            {
                DropDownList ddlClass = (DropDownList)e.Row.FindControl("ddlClassGv");
                DropDownList ddlSubject = (DropDownList)e.Row.FindControl("ddlSubjectGv");

                string classId = ddlClass.SelectedValue;

                DataTable dt = fn.Fetch("SELECT * FROM Subject WHERE ClassId = " + classId);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();

                string subjectId = DataBinder.Eval(e.Row.DataItem, "SubjectId").ToString();
                ddlSubject.SelectedValue = subjectId;
            }
        }

        protected void ddlClassGv_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlClass = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddlClass.NamingContainer;

            DropDownList ddlSubject = (DropDownList)row.FindControl("ddlSubjectGv");

            ddlSubject.Items.Clear();
            ddlSubject.Items.Add(new ListItem("Select Subject", "0"));

            DataTable dt = fn.Fetch("SELECT * FROM Subject WHERE ClassId = " + ddlClass.SelectedValue);

            ddlSubject.DataSource = dt;
            ddlSubject.DataTextField = "SubjectName";
            ddlSubject.DataValueField = "SubjectId";
            ddlSubject.DataBind();

            ddlSubject.Items.Insert(0, new ListItem("Select Subject", "0"));
        }


    }
}
