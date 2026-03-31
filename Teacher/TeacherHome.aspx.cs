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
    public partial class TeacherHome : System.Web.UI.Page
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
                LoadDashboard();
            }
        }

        private void LoadDashboard()
        {
            string teacherId = Session["RefId"].ToString();

            DataTable dtName = fn.Fetch("SELECT Name FROM Teacher WHERE TeacherId=" + teacherId);
            if (dtName.Rows.Count > 0)
            {
                lblName.Text = dtName.Rows[0]["Name"].ToString();
            }

            DataTable dtStudents = fn.Fetch(@"
                SELECT COUNT(DISTINCT s.StudentId)
                FROM Student s
                INNER JOIN TeacherSubject ts ON s.ClassId = ts.ClassId
                WHERE ts.TeacherId = " + teacherId);

            lblStudents.Text = dtStudents.Rows[0][0].ToString();

            DataTable dtSubjects = fn.Fetch(@"
                SELECT COUNT(DISTINCT SubjectId)
                FROM TeacherSubject
                WHERE TeacherId = " + teacherId);

            lblSubjects.Text = dtSubjects.Rows[0][0].ToString();

            DataTable dtAttendance = fn.Fetch(@"
                SELECT COUNT(*)
                FROM StudentAttendance
                WHERE CAST(Date AS DATE) = CAST(GETDATE() AS DATE)");

            lblAttendance.Text = dtAttendance.Rows[0][0].ToString();
        }
    }
}