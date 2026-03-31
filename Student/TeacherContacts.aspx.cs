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
    public partial class TeacherContacts : System.Web.UI.Page
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
                LoadTeachers();
            }
        }

        private void LoadTeachers()
        {
            string id = Session["RefId"].ToString();

            string query = @"
        SELECT DISTINCT t.Name, t.Email, t.Mobile
        FROM Teacher t
        INNER JOIN TeacherSubject ts ON t.TeacherId = ts.TeacherId
        INNER JOIN Student s ON ts.ClassId = s.ClassId
        WHERE s.StudentId = " + id;

            DataTable dt = fn.Fetch(query);

            if (dt.Rows.Count > 0)
            {
                rptTeachers.DataSource = dt;
                rptTeachers.DataBind();

                pnlEmpty.Visible = false;
            }
            else
            {
                rptTeachers.DataSource = null;
                rptTeachers.DataBind();

                pnlEmpty.Visible = true;
            }
        }
    }
}