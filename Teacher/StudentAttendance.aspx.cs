using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static SchoolManagementSystem.Models.CommonFn;

namespace SchoolManagementSystem.Teacher
{
    public partial class StudentAttendance : System.Web.UI.Page
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
                btnMarkAttendance.Visible = false;
            }
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss", new CultureInfo("en-US"));
        }

        private void GetClass()
        {
            DataTable dt = fn.Fetch("SELECT ClassId, ClassName FROM Class");

            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "ClassName";
            ddlClass.DataValueField = "ClassId";
            ddlClass.DataBind();

            ddlClass.Items.Insert(0, new ListItem("Select Class", "0"));
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlSubject.Items.Clear();

            if (ddlClass.SelectedValue != "0")
            {
                DataTable dt = fn.Fetch("SELECT SubjectId, SubjectName FROM Subject WHERE ClassId = " + ddlClass.SelectedValue);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();
            }

            ddlSubject.Items.Insert(0, new ListItem("Select Subject", "0"));
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblMsg.Text = "";

            if (ddlClass.SelectedValue == "0" || ddlSubject.SelectedValue == "0")
            {
                lblMsg.Text = "Please select Class and Subject!";
                lblMsg.CssClass = "alert alert-danger";
                return;
            }

            string query = "SELECT StudentId, RollNo, Name, Mobile FROM Student WHERE ClassId = " + ddlClass.SelectedValue;

            DataTable dt = fn.Fetch(query);

            GridView1.DataSource = dt;
            GridView1.DataBind();

            btnMarkAttendance.Visible = dt.Rows.Count > 0;
        }

        protected void btnMarkAttendance_Click(object sender, EventArgs e)
        {
            bool isInserted = false;
            bool alreadyMarked = false;

            foreach (GridViewRow row in GridView1.Rows)
            {
                string rollNo = row.Cells[1].Text.Trim();

                RadioButton rbPresent = row.FindControl("rbPresent") as RadioButton;

                int status = (rbPresent != null && rbPresent.Checked) ? 1 : 0;

                string checkQuery = @"SELECT COUNT(*) 
                                      FROM StudentAttendance 
                                      WHERE RollNo = '" + rollNo + @"' 
                                      AND CAST(Date AS DATE) = CAST(GETDATE() AS DATE)";

                DataTable checkDt = fn.Fetch(checkQuery);

                int count = 0;
                if (checkDt.Rows.Count > 0)
                {
                    int.TryParse(checkDt.Rows[0][0].ToString(), out count);
                }

                if (count == 0)
                {
                    string insertQuery = @"INSERT INTO StudentAttendance 
                        (ClassId, SubjectId, RollNo, Status, Date) 
                        VALUES (" +
                        ddlClass.SelectedValue + ", " +
                        ddlSubject.SelectedValue + ", '" +
                        rollNo + "', " +
                        status + ", GETDATE())";

                    fn.Query(insertQuery);
                    isInserted = true;
                }
                else
                {
                    alreadyMarked = true;
                }
            }

            if (isInserted)
            {
                lblMsg.Text = "Attendance marked successfully!";
                lblMsg.CssClass = "alert alert-success";
            }
            else if (alreadyMarked)
            {
                lblMsg.Text = "Attendance already marked today!";
                lblMsg.CssClass = "alert alert-warning";
            }
            else
            {
                lblMsg.Text = "Something went wrong!";
                lblMsg.CssClass = "alert alert-danger";
            }
        }
    }
}