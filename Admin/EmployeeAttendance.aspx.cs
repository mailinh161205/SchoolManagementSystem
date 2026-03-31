using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static SchoolManagementSystem.Models.CommonFn;

namespace SchoolManagementSystem.Admin
{
    public partial class EmployeeAttendance : System.Web.UI.Page
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
                BindAttendance();
            }
        }

        private void BindAttendance()
        {
            DataTable dt = fn.Fetch("SELECT TeacherId, Name, Mobile, Email FROM Teacher");
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void btnMarkAttendance_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                int teacherId = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);

                RadioButton rbPresent = row.FindControl("RadioButton1") as RadioButton;
                // RadioButton rbAbsent = row.FindControl("RadioButton2") as RadioButton; 

                int status = (rbPresent != null && rbPresent.Checked) ? 1 : 0;

                string dateTimeStr = DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss tt", new CultureInfo("en-US"));

                string query = "INSERT INTO TeacherAttendance (TeacherId, Status, Date) VALUES (" +
                                teacherId + ", " + status + ", '" + dateTimeStr + "')";
                fn.Query(query);
            }

            lblMsg.Text = "Attendance marked successfully!";
            lblMsg.CssClass = "alert alert-success";
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblTime.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt", new CultureInfo("en-US"));
        }
    
    }
}