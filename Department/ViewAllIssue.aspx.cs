using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Department_ViewAllIssue : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDepartmentIssues();
        }
    }

    private void LoadDepartmentIssues()
    {
        // Assuming department ID is stored in session after login
        if (Session["dept_id"] == null)
        {
            Response.Redirect("~/Login.aspx");
            return;
        }

        int departmentID = Convert.ToInt32(Session["dept_id"]);
        DataTable dt = new DataTable();

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT IssueID, Description, Status, DepartmentID
                             FROM UserIssue
                             WHERE DepartmentID=@DepartmentID
                             ORDER BY CreatedDate DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@DepartmentID", departmentID);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
        }

        rptDepartmentIssues.DataSource = dt;
        rptDepartmentIssues.DataBind();
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