using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolManagementSystem.Admin
{
    public partial class Teacher : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolCS"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("~/Login.aspx");
            }
            if (!IsPostBack)
            {
                GetTeachers();
            }
        }

        // ================= LOAD DATA =================
        private void GetTeachers()
        {
            SqlDataAdapter da = new SqlDataAdapter(@"SELECT 
                ROW_NUMBER() OVER(ORDER BY TeacherId) AS [Sr.No],
                TeacherId, Name, DOB, Gender, Mobile, Email, Address, Password 
                FROM Teacher", con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        // ================= INSERT =================
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlGender.SelectedValue == "0")
                {
                    lblMsg.Text = "Gender is required!";
                    lblMsg.CssClass = "alert alert-danger";
                    return;
                }

                string email = txtEmail.Text.Trim();

                // CHECK EMAIL
                SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Teacher WHERE Email=@Email", con);
                checkCmd.Parameters.AddWithValue("@Email", email);

                con.Open();
                int count = (int)checkCmd.ExecuteScalar();
                con.Close();

                if (count > 0)
                {
                    lblMsg.Text = "Email already exists!";
                    lblMsg.CssClass = "alert alert-danger";
                    return;
                }

                DateTime dob = Convert.ToDateTime(txtDoB.Text);

                SqlCommand cmd = new SqlCommand(@"INSERT INTO Teacher
                (Name, DOB, Gender, Mobile, Email, Address, Password)
                VALUES (@Name, @DOB, @Gender, @Mobile, @Email, @Address, @Password)", con);

                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@DOB", dob);
                cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
                cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                lblMsg.Text = "Inserted Successfully!";
                lblMsg.CssClass = "alert alert-success";

                ClearForm();
                GetTeachers();
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        // ================= CLEAR =================
        private void ClearForm()
        {
            txtName.Text = "";
            txtDoB.Text = "";
            txtMobile.Text = "";
            txtEmail.Text = "";
            txtAddress.Text = "";
            txtPassword.Text = "";
            ddlGender.SelectedIndex = 0;
        }

        // ================= PAGING =================
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetTeachers();
        }

        // ================= EDIT =================
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetTeachers();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetTeachers();
        }

        // ================= UPDATE =================
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                int teacherId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

                string name = (row.FindControl("txtName") as TextBox).Text.Trim();
                string mobile = (row.FindControl("txtMobile") as TextBox).Text.Trim();
                string password = (row.FindControl("txtPassword") as TextBox).Text.Trim();
                string address = (row.FindControl("txtAddress") as TextBox).Text.Trim();

                SqlCommand cmd = new SqlCommand(@"UPDATE Teacher SET 
                    Name=@Name,
                    Mobile=@Mobile,
                    Address=@Address,
                    Password=@Password
                    WHERE TeacherId=@TeacherId", con);

                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Mobile", mobile);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@TeacherId", teacherId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                lblMsg.Text = "Updated Successfully!";
                lblMsg.CssClass = "alert alert-success";

                GridView1.EditIndex = -1;
                GetTeachers();
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        // ================= DELETE =================
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int teacherId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

                SqlCommand cmd = new SqlCommand("DELETE FROM Teacher WHERE TeacherId=@TeacherId", con);
                cmd.Parameters.AddWithValue("@TeacherId", teacherId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                lblMsg.Text = "Deleted Successfully!";
                lblMsg.CssClass = "alert alert-success";

                GetTeachers();
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }
    }
}