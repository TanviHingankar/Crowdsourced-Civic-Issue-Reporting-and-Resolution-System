
    
    using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_NewMess : System.Web.UI.Page
{
    string connectionString =
        ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["user_id"].ToString()== null)
        {
            Response.Redirect("../Default3.aspx");
        }
        if (!IsPostBack)
        {
            LoadCompletedIssues();
        }
    }

    private void LoadCompletedIssues()
    {
        string userId = Session["user_id"].ToString();

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"SELECT IssueID, Description
                             FROM UserIssue
                             WHERE UserID=@UserID
                             AND Status='Completed'";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();
                ddlIssue.DataSource = cmd.ExecuteReader();
                ddlIssue.DataTextField = "Description";
                ddlIssue.DataValueField = "IssueID";
                ddlIssue.DataBind();
            }
        }

        ddlIssue.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Issue --", ""));
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (ddlIssue.SelectedValue == "")
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                "alert('Please select issue');", true);
            return;
        }

        string userId = Session["user_id"].ToString();
        int issueId = Convert.ToInt32(ddlIssue.SelectedValue);
        int rating = Convert.ToInt32(ddlRating.SelectedValue);
        string comments = txtComments.Text.Trim();

        int departmentId = GetDepartmentId(issueId);

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"INSERT INTO Feedback
                            (IssueID, UserID, DepartmentID, Rating, Comments)
                            VALUES
                            (@IssueID, @UserID, @DepartmentID, @Rating, @Comments)";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@IssueID", issueId);
                cmd.Parameters.AddWithValue("@UserID", userId);
                cmd.Parameters.AddWithValue("@DepartmentID", departmentId);
                cmd.Parameters.AddWithValue("@Rating", rating);
                cmd.Parameters.AddWithValue("@Comments", comments);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        ClientScript.RegisterStartupScript(this.GetType(), "alert",
            "alert('Feedback Submitted Successfully!');", true);

        txtComments.Text = "";
        ddlIssue.SelectedIndex = 0;
    }
    private int GetDepartmentId(int issueId)
    {
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"SELECT DepartmentID
                         FROM UserIssue
                         WHERE IssueID=@IssueID ";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@IssueID", issueId);
                
                con.Open();
                object result = cmd.ExecuteScalar();

                return result != null ? Convert.ToInt32(result) : 0;
            }
        }
    }


    protected void btnview_Click(object sender, EventArgs e)
    {
        Response.Redirect("ViewMyFeedbacks.aspx");
    }
}
