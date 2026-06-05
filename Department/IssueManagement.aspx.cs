using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Department_IssueManagement : System.Web.UI.Page
{
    string connectionString = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["dept_id"] == null)
            {
                Response.Redirect("~/Department/Default.aspx");
                return;
            }
            LoadIssues();
        }
    }

    private void LoadIssues()
    {
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"SELECT IssueID, Description, Address, Photo, Status, Latitude, Longitude
FROM UserIssue
WHERE DepartmentID=@DepartmentID
ORDER BY CreatedDate DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@DepartmentID", Session["dept_id"].ToString());
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
        }

        // Prepend folder path to Photo column
        foreach (DataRow row in dt.Rows)
        {
            if (row["Photo"] != DBNull.Value && !string.IsNullOrEmpty(row["Photo"].ToString()))
            {
                // Only prepend once, store full virtual path
                row["Photo"] = "~/IssuePhotos/" + row["Photo"].ToString();
            }
            else
            {
                row["Photo"] = "~/IssuePhotos/no-image.png";
            }
        }
        rptIssues.DataSource = dt;
        rptIssues.DataBind();
    }

    protected string GetStatusClass(string status)
    {
        switch (status)
        {
            case "Pending":
                return "text-warning";
            case "In Progress":
                return "text-success";
            case "Completed":
                return "text-primary";
            default:
                return "text-muted";
        }
    }
}