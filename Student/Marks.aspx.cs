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
    public partial class Marks : System.Web.UI.Page
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
                LoadMarks();
            }
        }

        private void LoadMarks()
        {
            string roll = fn.Fetch("SELECT RollNo FROM Student WHERE StudentId=" + Session["RefId"])
                            .Rows[0][0].ToString();

            string query = @"
                SELECT 
                    s.SubjectName,
                    e.TotalMarks,
                    e.OutOfMarks,
                    (CAST(e.TotalMarks AS FLOAT) / e.OutOfMarks) * 100 AS Percentage
                FROM Exam e
                INNER JOIN Subject s ON e.SubjectId = s.SubjectId
                WHERE e.RollNo = '" + roll + "'";

            DataTable dt = fn.Fetch(query);

            dt.Columns.Add("Result");

            foreach (DataRow row in dt.Rows)
            {
                double percent = Convert.ToDouble(row["Percentage"]);
                row["Result"] = percent >= 50 ? "Pass" : "Fail";
            }

            gvMarks.DataSource = dt;
            gvMarks.DataBind();
        }
    }
}