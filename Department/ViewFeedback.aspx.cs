using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Department_ViewFeedback : System.Web.UI.Page
{
    string connectionString =
        ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["dept_id"] == null)
            {
                Response.Redirect("~/Department/Default.aspx");
                return;
            }
            LoadIssueTypes();
        }
    }

    private void LoadIssueTypes()
    {
        string departmentId = Session["dept_id"].ToString();

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"SELECT DISTINCT IssueType
                             FROM UserIssue
                             WHERE DepartmentID=@DepartmentID";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@DepartmentID", departmentId);
                con.Open();

                ddlIssueType.DataSource = cmd.ExecuteReader();
                ddlIssueType.DataTextField = "IssueType";
                ddlIssueType.DataValueField = "IssueType";
                ddlIssueType.DataBind();
            }
        }

        ddlIssueType.Items.Insert(0,
            new System.Web.UI.WebControls.ListItem("-- Select Issue Type --", ""));
    }

    protected void ddlIssueType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlIssueType.SelectedValue != "")
        {
            LoadFeedback(ddlIssueType.SelectedValue);
        }
    }
    protected string GetStars(int rating)
    {
        string stars = "";
        for (int i = 1; i <= 5; i++)
        {
            if (i <= rating)
                stars += "★";
            else
                stars += "☆";
        }
        return stars;
    }
    private void LoadFeedback(string issueType)
    {
        if (Session["dept_id"] == null)
        {
            Response.Redirect("~/Department/Login.aspx");
            return;
        }

        string departmentId = Session["dept_id"].ToString();

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"
        SELECT f.Rating,
               f.Comments,
               f.FeedbackDate
        FROM Feedback f
        INNER JOIN UserIssue ui ON f.IssueID = ui.IssueID
        WHERE f.DepartmentID = @DepartmentID
        AND ui.IssueType = @IssueType
        ORDER BY f.FeedbackDate DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@DepartmentID", departmentId);
                cmd.Parameters.AddWithValue("@IssueType", issueType);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptFeedback.DataSource = dt;
                rptFeedback.DataBind();

                if (dt.Rows.Count > 0)
                {
                    double avg = Convert.ToDouble(dt.Compute("AVG(Rating)", ""));
                    lblAvgRating.Text = avg.ToString("0.0");
                }
                else
                {
                    lblAvgRating.Text = "0.0";
                }
            }
        }
    }
}