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
    public partial class AttendanceReport : System.Web.UI.Page
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
                LoadAttendance();
            }
        }

        private void LoadAttendance()
        {
            try
            {
                string studentId = Session["RefId"].ToString();

                string roll = fn.Fetch("SELECT RollNo FROM Student WHERE StudentId=" + studentId)
                                .Rows[0][0].ToString();

                string query = @"SELECT SubjectName, Status, Date
                                 FROM StudentAttendance sa
                                 INNER JOIN Subject s ON sa.SubjectId = s.SubjectId
                                 WHERE RollNo = '" + roll + "' ORDER BY Date DESC";

                DataTable dt = fn.Fetch(query);

                gvAttendance.DataSource = dt;
                gvAttendance.DataBind();

                int total = dt.Rows.Count;
                int present = 0;
                int absent = 0;

                foreach (DataRow row in dt.Rows)
                {
                    if (Convert.ToBoolean(row["Status"]))
                        present++;
                    else
                        absent++;
                }

                lblTotal.Text = total.ToString();
                lblPresent.Text = present.ToString();
                lblAbsent.Text = absent.ToString();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}