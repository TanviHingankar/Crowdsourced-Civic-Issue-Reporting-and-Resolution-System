using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class User_TrackIssue : System.Web.UI.Page
{
    string connectionString = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user_id"] == null)
        {
            // User not logged in, redirect to login page
            Response.Redirect("~/Default3.aspx");
            return;
        }
        if (!IsPostBack)
        {
            LoadUserIssues();
        }
    }

    private void LoadUserIssues()
    {
        DataTable dt = new DataTable();

        string userId = Session["user_id"].ToString(); // Assuming you store logged-in user ID in Session

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"
    SELECT ui.IssueID, 
           ui.Description, 
           ui.Address, 
           ui.Photo, 
           ui.CompletionPhoto,
           ia.Status, 
           ia.Remarks, 
           ia.ActionDate
    FROM UserIssue ui
    LEFT JOIN (
        SELECT IssueID, Status, Remarks, ActionDate
        FROM IssueActions
        WHERE ActionID IN (
            SELECT MAX(ActionID) 
            FROM IssueActions 
            GROUP BY IssueID
        )
    ) ia ON ui.IssueID = ia.IssueID
    WHERE ui.UserID = @UserID
    ORDER BY ui.CreatedDate DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
        }

        // Prepend folder path for images
        foreach (DataRow row in dt.Rows)
        {
            if (row["Photo"] != DBNull.Value && !string.IsNullOrEmpty(row["Photo"].ToString()))
            {
                row["Photo"] = ResolveUrl("~/IssuePhotos/" + row["Photo"].ToString());
            }
            else
            {
                row["Photo"] = ResolveUrl("~/IssuePhotos/no-image.png");
            }
            // Completion Photo
            if (row["CompletionPhoto"] != DBNull.Value &&
                !string.IsNullOrEmpty(row["CompletionPhoto"].ToString()))
            {
                row["CompletionPhoto"] = ResolveUrl("~/CompletionPhotos/" + row["CompletionPhoto"].ToString());
            }
        }

        rptTrack.DataSource = dt;
        rptTrack.DataBind();
    }

    protected string GetStatusClass(string status)
    {
        switch (status)
        {
            case "Pending":
                return "text-warning fw-bold";
            case "In Progress":
                return "text-primary fw-bold";
            case "Completed":
                return "text-success fw-bold";
            default:
                return "text-muted";
        }
    }
}