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
    public partial class AdminHome : System.Web.UI.Page
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
                LoadDashboard();
                LoadStudents();
            }
        }

        private void LoadDashboard()
        {
            lblStudents.Text = fn.Fetch("SELECT COUNT(*) FROM Student").Rows[0][0].ToString();
            lblTeachers.Text = fn.Fetch("SELECT COUNT(*) FROM Teacher").Rows[0][0].ToString();
            lblClasses.Text = fn.Fetch("SELECT COUNT(*) FROM Class").Rows[0][0].ToString();
            lblSubjects.Text = fn.Fetch("SELECT COUNT(*) FROM Subject").Rows[0][0].ToString();
        }

        private void LoadStudents()
        {
            DataTable dt = fn.Fetch("SELECT TOP 5 Name, RollNo, Mobile FROM Student ORDER BY StudentId DESC");

            gvStudents.DataSource = dt;
            gvStudents.DataBind();
        }
    }
}