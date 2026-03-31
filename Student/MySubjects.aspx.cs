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
    public partial class MySubjects : System.Web.UI.Page
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
                LoadSubjects();
            }
        }

        private void LoadSubjects()
        {
            string id = Session["RefId"].ToString();

            string query = @"
                SELECT s.SubjectName
                FROM StudentSubject ss
                INNER JOIN Subject s ON ss.SubjectId = s.SubjectId
                WHERE ss.StudentId = " + id;

            DataTable dt = fn.Fetch(query);

            dt.Columns.Add("STT");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["STT"] = i + 1;
            }

            gvSubjects.DataSource = dt;
            gvSubjects.DataBind();
        }
    }
}