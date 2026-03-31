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
    public partial class TeacherSubject : System.Web.UI.Page
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
                GetClass();
                GetTeacher();
                GetTeacherSubject();
            }
        }

        private void GetClass()
        {
            DataTable dt = fn.Fetch("SELECT * FROM Class");

            ddlClass.DataSource = dt;
            ddlClass.DataTextField = "ClassName";
            ddlClass.DataValueField = "ClassId";
            ddlClass.DataBind();

            ddlClass.Items.Insert(0, new ListItem("Select Class", "0"));
        }

        private void GetTeacher()
        {
            DataTable dt = fn.Fetch("SELECT * FROM Teacher");

            ddlTeacher.DataSource = dt;
            ddlTeacher.DataTextField = "Name";
            ddlTeacher.DataValueField = "TeacherId";
            ddlTeacher.DataBind();

            ddlTeacher.Items.Insert(0, new ListItem("Select Teacher", "0"));
        }

        private void GetTeacherSubject()
        {
            DataTable dt = fn.Fetch(@"
                SELECT 
                    ROW_NUMBER() OVER(ORDER BY (Select 1)) AS [Sr.No], 
                    ts.Id, 
                    ts.ClassId, 
                    c.ClassName, 
                    ts.SubjectId, 
                    s.SubjectName, 
                    ts.TeacherId, 
                    t.Name 
                FROM TeacherSubject ts
                INNER JOIN Class c ON ts.ClassId = c.ClassId
                INNER JOIN Subject s ON ts.SubjectId = s.SubjectId
                INNER JOIN Teacher t ON ts.TeacherId = t.TeacherId");

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlSubject.Items.Clear();
            ddlSubject.Items.Insert(0, new ListItem("Select Subject", "0"));

            if (ddlClass.SelectedValue != "0")
            {
                string classId = ddlClass.SelectedValue;

                DataTable dt = fn.Fetch("SELECT * FROM Subject WHERE ClassId = " + classId);

                ddlSubject.DataSource = dt;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataBind();

                ddlSubject.Items.Insert(0, new ListItem("Select Subject", "0"));
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlClass.SelectedValue == "0" || ddlSubject.SelectedValue == "0" || ddlTeacher.SelectedValue == "0")
                {
                    lblMsg.Text = "All fields are required!";
                    lblMsg.CssClass = "alert alert-danger";
                    return;
                }

                string classId = ddlClass.SelectedValue;
                string subjectId = ddlSubject.SelectedValue;
                string teacherId = ddlTeacher.SelectedValue;

                DataTable dt = fn.Fetch("SELECT * FROM TeacherSubject WHERE ClassId = " + classId +
                                        " AND SubjectId = " + subjectId +
                                        " AND TeacherId = " + teacherId);


                if (dt.Rows.Count == 0)
                {
                    string query = "INSERT INTO TeacherSubject (ClassId, SubjectId, TeacherId) VALUES ("
                                    + classId + "," + subjectId + "," + teacherId + ")";

                    fn.Query(query);

                    lblMsg.Text = "Inserted Successfully!";
                    lblMsg.CssClass = "alert alert-success";

                    ddlClass.SelectedIndex = 0;
                    ddlSubject.Items.Clear();
                    ddlSubject.Items.Insert(0, new ListItem("Select Subject", "0"));
                    ddlTeacher.SelectedIndex = 0;

                    GetTeacherSubject();
                }
                else
                {
                    lblMsg.Text = "This Teacher Subject already exists!";
                    lblMsg.CssClass = "alert alert-danger";
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GetTeacherSubject();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int teacherSubjectId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

                fn.Query("DELETE FROM TeacherSubject WHERE Id = " + teacherSubjectId);

                lblMsg.Text = "Teacher Subject Deleted Successfully!";
                lblMsg.CssClass = "alert alert-success";
                GridView1.EditIndex = -1;
                GetTeacherSubject();
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;
                lblMsg.CssClass = "alert alert-danger";
            }
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GetTeacherSubject();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GetTeacherSubject();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                int teacherSubjectId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

                DropDownList ddlClassGv = (DropDownList)row.FindControl("ddlClassGv");
                DropDownList ddlSubjectGv = (DropDownList)row.FindControl("ddlSubjectGv");
                DropDownList ddlTeacherGv = (DropDownList)row.FindControl("ddlTeacherGv");

                string classId = ddlClassGv.SelectedValue;
                string subjectId = ddlSubjectGv.SelectedValue;
                string teacherId = ddlTeacherGv.SelectedValue;

                fn.Query(@"Update TeacherSubject set ClassId = '" + classId + "', SubjectId = '" + subjectId + "', TeacherId = '"+ teacherId+"' " +
                    "where Id = '" + teacherSubjectId + "'");
                lblMsg.Text = "Record Updated Succesffully!";
                lblMsg.CssClass = "alert alert-success";
                GridView1.EditIndex = -1;
                GetTeacherSubject();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void ddlClassGv_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlClassSelected = (DropDownList)sender;
            GridViewRow row = (GridViewRow)ddlClassSelected.NamingContainer;
            if (row != null)
            {
                if ((row.RowState & DataControlRowState.Edit) > 0)
                {
                    DropDownList ddlSubjectGV = (DropDownList)row.FindControl("ddlSubjectGv");
                    DataTable dt = fn.Fetch("Select * from Subject where ClassId = '" + ddlClassSelected.SelectedValue + "'");
                    ddlSubjectGV.DataSource = dt;
                    ddlSubjectGV.DataTextField = "SubjectName";
                    ddlSubjectGV.DataValueField = "SubjectId";
                    ddlSubjectGV.DataBind();
                }
            }
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow &&
                (e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                DropDownList ddlClass = (DropDownList)e.Row.FindControl("ddlClassGv");
                DropDownList ddlSubject = (DropDownList)e.Row.FindControl("ddlSubjectGv");

                if (ddlClass != null && ddlSubject != null)
                {
                    DataTable dt = fn.Fetch("Select * from Subject where ClassId = " + ddlClass.SelectedValue);

                    ddlSubject.DataSource = dt;
                    ddlSubject.DataTextField = "SubjectName";
                    ddlSubject.DataValueField = "SubjectId";
                    ddlSubject.DataBind();

                    object subjectObj = DataBinder.Eval(e.Row.DataItem, "SubjectName");
                    if (subjectObj != null)
                    {
                        ListItem item = ddlSubject.Items.FindByText(subjectObj.ToString());
                        if (item != null)
                        {
                            ddlSubject.ClearSelection();
                            item.Selected = true;
                        }
                    }
                }
            }
        }
    }
}