using System;
using System.Data;
using System.Web.UI.WebControls;
using static SchoolManagementSystem.Models.CommonFn;

namespace SchoolManagementSystem.Admin
{
    public partial class EmpAttendanceDetails : System.Web.UI.Page
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
                LoadTeachers();
                txtMonth.Text = DateTime.Now.ToString("yyyy-MM");
            }
        }

        private void LoadTeachers()
        {
            DataTable dt = fn.Fetch("SELECT TeacherId, Name FROM Teacher");
            ddlTeacher.DataSource = dt;
            ddlTeacher.DataTextField = "Name";
            ddlTeacher.DataValueField = "TeacherId";
            ddlTeacher.DataBind();

            ddlTeacher.Items.Insert(0, new ListItem("Select Teacher", "0"));
        }

        protected void btnCheckAttendance_Click(object sender, EventArgs e)
        {
            lblMsg.Text = ""; 

            if (ddlTeacher.SelectedValue == "0" || string.IsNullOrEmpty(txtMonth.Text))
            {
                lblMsg.Text = "Please select Teacher and Month!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (!DateTime.TryParse(txtMonth.Text + "-01", out DateTime selectedDate))
            {
                lblMsg.Text = "Invalid Month format!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int year = selectedDate.Year;
            int month = selectedDate.Month;
            int teacherId = Convert.ToInt32(ddlTeacher.SelectedValue);

            string query = @"SELECT ROW_NUMBER() OVER(ORDER BY ta.Date) AS SrNo, t.Name, ta.Status, ta.Date
                     FROM TeacherAttendance ta
                     INNER JOIN Teacher t ON t.TeacherId = ta.TeacherId
                     WHERE DATEPART(yy, ta.Date) = @Year 
                       AND DATEPART(M, ta.Date) = @Month
                       AND ta.TeacherId = @TeacherId";

            System.Data.SqlClient.SqlParameter[] param = {
        new System.Data.SqlClient.SqlParameter("@Year", year),
        new System.Data.SqlClient.SqlParameter("@Month", month),
        new System.Data.SqlClient.SqlParameter("@TeacherId", teacherId)
    };

            DataTable dt = fn.Fetch(query, param);
            GridView1.DataSource = dt;
            GridView1.DataBind();
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