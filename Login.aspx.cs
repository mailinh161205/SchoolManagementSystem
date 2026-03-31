using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static SchoolManagementSystem.Models.CommonFn;

namespace SchoolManagementSystem
{
    public partial class Login : System.Web.UI.Page
    {
        Commonfnx fn = new Commonfnx();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.Clear();
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = inputEmail.Value.Trim();
            string password = inputPassword.Value.Trim();

            if (username == "" || password == "")
            {
                lblMsg.Text = "Please enter Username and Password!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            try
            {
                string query = "SELECT TOP 1 Username, Role, RefId " +
                               "FROM Account " +
                               "WHERE Username = N'" + username + "' AND Password = N'" + password + "'";

                DataTable dt = fn.Fetch(query);

                if (dt.Rows.Count == 1)
                {
                    string role = dt.Rows[0]["Role"].ToString().Trim();

                    Session["Username"] = dt.Rows[0]["Username"].ToString();
                    Session["Role"] = role;
                    Session["RefId"] = dt.Rows[0]["RefId"] != DBNull.Value
                                        ? dt.Rows[0]["RefId"].ToString()
                                        : "";

                    RedirectByRole(role);
                }
                else
                {
                    lblMsg.Text = "Invalid Username or Password!";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        private void RedirectByRole(string role)
        {
            switch (role)
            {
                case "Admin":
                    Response.Redirect("~/Admin/AdminHome.aspx");
                    break;

                case "Teacher":
                    Response.Redirect("~/Teacher/TeacherHome.aspx");
                    break;

                case "Student":
                    Response.Redirect("~/Student/StudentHome.aspx");
                    break;

                default:
                    lblMsg.Text = "Role not valid!";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                    break;
            }
        }
    }
}