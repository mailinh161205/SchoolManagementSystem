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
    public partial class StudentAttendanceUC : System.Web.UI.UserControl
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
                txtMonth.Text = DateTime.Now.ToString("yyyy-MM");
            }
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
            ddlRollNo.Items.Clear();

            if (ddlClass.SelectedValue != "0")
            {
                DataTable dtSub = fn.Fetch("SELECT SubjectId, SubjectName FROM Subject WHERE ClassId = " + ddlClass.SelectedValue);

                ddlSubject.DataSource = dtSub;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();

                DataTable dtRoll = fn.Fetch("SELECT RollNo, Name FROM Student WHERE ClassId = " + ddlClass.SelectedValue);

                ddlRollNo.DataSource = dtRoll;
                ddlRollNo.DataTextField = "RollNo"; 
                ddlRollNo.DataValueField = "RollNo";
                ddlRollNo.DataBind();
            }

            ddlSubject.Items.Insert(0, new ListItem("Select Subject", "0"));
            ddlRollNo.Items.Insert(0, new ListItem("Select Roll No", "0"));
        }

        protected void btnCheckAttendance_Click(object sender, EventArgs e)
        {
            lblMsg.Text = "";

            if (ddlClass.SelectedValue == "0" ||
                ddlSubject.SelectedValue == "0" ||
                ddlRollNo.SelectedValue == "0")
            {
                lblMsg.Text = "Please select all fields!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (!DateTime.TryParse(txtMonth.Text + "-01", out DateTime selectedDate))
            {
                lblMsg.Text = "Invalid Month!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int year = selectedDate.Year;
            int month = selectedDate.Month;

            string query = @"SELECT 
                                ROW_NUMBER() OVER(ORDER BY sa.Date) AS SrNo,
                                s.Name,
                                sa.Status,
                                sa.Date
                            FROM StudentAttendance sa
                            INNER JOIN Student s ON s.RollNo = sa.RollNo
                            WHERE sa.ClassId = @ClassId
                                AND sa.RollNo = @RollNo
                                AND sa.SubjectId = @SubjectId
                                AND DATEPART(YEAR, sa.Date) = @Year
                                AND DATEPART(MONTH, sa.Date) = @Month";

            System.Data.SqlClient.SqlParameter[] param =
            {
                new System.Data.SqlClient.SqlParameter("@ClassId", ddlClass.SelectedValue),
                new System.Data.SqlClient.SqlParameter("@RollNo", ddlRollNo.SelectedValue),
                new System.Data.SqlClient.SqlParameter("@SubjectId", ddlSubject.SelectedValue),
                new System.Data.SqlClient.SqlParameter("@Year", year),
                new System.Data.SqlClient.SqlParameter("@Month", month)
            };

            DataTable dt = fn.Fetch(query, param);

            GridView1.DataSource = dt;
            GridView1.DataBind();

            if (dt.Rows.Count == 0)
            {
                lblMsg.Text = "No attendance found!";
                lblMsg.ForeColor = System.Drawing.Color.Orange;
            }
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count > 0)
            {
                GridView1.UseAccessibleHeader = true;
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }
    }
}
