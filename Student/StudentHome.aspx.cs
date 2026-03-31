using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static SchoolManagementSystem.Models.CommonFn;

namespace SchoolManagementSystem.Student
{
    public partial class StudentHome : System.Web.UI.Page
    {
        Commonfnx fn = new Commonfnx();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Student")
            {
                Response.Redirect("~/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadStudent();
                LoadDashboard();
            }
        }

        private void LoadStudent()
        {
            string id = Session["RefId"].ToString();
            DataTable dt = fn.Fetch("SELECT Name FROM Student WHERE StudentId=" + id);

            if (dt.Rows.Count > 0)
            {
                lblName.Text = dt.Rows[0]["Name"].ToString();
            }
        }

        private void LoadDashboard()
        {
            string id = Session["RefId"].ToString();

            lblSubjects.Text = fn.Fetch("SELECT COUNT(*) FROM StudentSubject WHERE StudentId=" + id)
                                .Rows[0][0].ToString();

            string roll = fn.Fetch("SELECT RollNo FROM Student WHERE StudentId=" + id)
                            .Rows[0][0].ToString();

            lblMarks.Text = fn.Fetch("SELECT COUNT(*) FROM Exam WHERE RollNo='" + roll + "'")
                                .Rows[0][0].ToString();

            DataTable att = fn.Fetch("SELECT COUNT(*) total, SUM(CASE WHEN Status=1 THEN 1 ELSE 0 END) present FROM StudentAttendance WHERE RollNo='" + roll + "'");

            if (att.Rows.Count > 0 && att.Rows[0]["total"] != DBNull.Value)
            {
                int total = Convert.ToInt32(att.Rows[0]["total"]);
                int present = att.Rows[0]["present"] != DBNull.Value ? Convert.ToInt32(att.Rows[0]["present"]) : 0;

                lblAttendance.Text = total > 0 ? ((present * 100) / total).ToString() + "%" : "0%";
            }

            lblFees.Text = fn.Fetch(@"SELECT FeesAmount FROM Fees f 
                                    INNER JOIN Student s ON f.ClassId = s.ClassId 
                                    WHERE s.StudentId=" + id)
                            .Rows[0][0].ToString() + " VND";
        }
    }
}