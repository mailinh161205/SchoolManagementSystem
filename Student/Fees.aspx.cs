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
    public partial class Fees : System.Web.UI.Page
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
                LoadFees();
            }
        }

        private void LoadFees()
        {
            try
            {
                string studentId = Session["RefId"].ToString();

                string query = @"SELECT c.ClassName, f.FeesAmount
                                 FROM Fees f
                                 INNER JOIN Student s ON f.ClassId = s.ClassId
                                 INNER JOIN Class c ON c.ClassId = s.ClassId
                                 WHERE s.StudentId = " + studentId;

                DataTable dt = fn.Fetch(query);

                gvFees.DataSource = dt;
                gvFees.DataBind();

                decimal total = 0;
                foreach (DataRow row in dt.Rows)
                {
                    total += Convert.ToDecimal(row["FeesAmount"]);
                }

                lblTotalFees.Text = total.ToString("N0") + " VNĐ";
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}