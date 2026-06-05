using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class User_ViewMyFeedbacks : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["user_id"] == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }
            LoadDepartments();
            LoadFeedbacks();
        }
    }

    private void LoadDepartments()
    {
        int userID = Convert.ToInt32(Session["user_id"]);

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT DISTINCT d.DepartmentID, d.DepartmentName FROM Feedback f INNER JOIN Department d ON f.DepartmentID=d.DepartmentID WHERE f.UserID=@UserID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@UserID", userID);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            ddlDepartmentFilter.Items.Clear();
            ddlDepartmentFilter.Items.Add(new System.Web.UI.WebControls.ListItem("All Departments", ""));
            while (dr.Read())
            {
                ddlDepartmentFilter.Items.Add(new System.Web.UI.WebControls.ListItem(dr["DepartmentName"].ToString(), dr["DepartmentID"].ToString()));
            }
        }
    }

    private void LoadFeedbacks(int departmentID = 0, int rating = 0)
    {
        int userID = Convert.ToInt32(Session["user_id"]);

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"
                SELECT f.FeedbackID, f.IssueID, d.DepartmentName, f.Rating, f.Comments, f.FeedbackDate
                FROM Feedback f
                INNER JOIN Department d ON f.DepartmentID = d.DepartmentID
                WHERE f.UserID=@UserID";

            if (departmentID > 0)
                query += " AND d.DepartmentID=@DeptID";
            if (rating > 0)
                query += " AND f.Rating=@Rating";

            query += " ORDER BY f.FeedbackDate DESC";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@UserID", userID);
            if (departmentID > 0)
                cmd.Parameters.AddWithValue("@DeptID", departmentID);
            if (rating > 0)
                cmd.Parameters.AddWithValue("@Rating", rating);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvFeedback.DataSource = dt;
            gvFeedback.DataBind();
        }
    }

    protected void ddlDepartmentFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        int deptID = string.IsNullOrEmpty(ddlDepartmentFilter.SelectedValue) ? 0 : Convert.ToInt32(ddlDepartmentFilter.SelectedValue);
        int rating = string.IsNullOrEmpty(ddlRatingFilter.SelectedValue) ? 0 : Convert.ToInt32(ddlRatingFilter.SelectedValue);
        LoadFeedbacks(deptID, rating);
    }

    protected void ddlRatingFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        int deptID = string.IsNullOrEmpty(ddlDepartmentFilter.SelectedValue) ? 0 : Convert.ToInt32(ddlDepartmentFilter.SelectedValue);
        int rating = string.IsNullOrEmpty(ddlRatingFilter.SelectedValue) ? 0 : Convert.ToInt32(ddlRatingFilter.SelectedValue);
        LoadFeedbacks(deptID, rating);
    }
}