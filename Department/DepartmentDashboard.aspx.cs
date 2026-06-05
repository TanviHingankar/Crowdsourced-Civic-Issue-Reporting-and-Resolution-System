using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Department_DepartmentDashboard : System.Web.UI.Page
{
    string connectionString =
        ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        // 🔐 Session Check
        if (Session["dept_id"] == null)
        {
            Response.Redirect("~/Department/Default.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadDashboardCounts();
        }
    }

    private void LoadDashboardCounts()
    {
        string departmentId = Session["dept_id"].ToString();

        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();

            // ✅ TOTAL Complaints
            string totalQuery = @"SELECT COUNT(*) 
                                  FROM UserIssue 
                                  WHERE DepartmentID=@DepartmentID";

            using (SqlCommand cmd = new SqlCommand(totalQuery, con))
            {
                cmd.Parameters.AddWithValue("@DepartmentID", departmentId);
                lblTotal.Text = cmd.ExecuteScalar().ToString();
            }

            // ✅ PENDING Issues
            string pendingQuery = @"SELECT COUNT(*) 
                                    FROM UserIssue 
                                    WHERE DepartmentID=@DepartmentID 
                                    AND Status='Pending'";

            using (SqlCommand cmd = new SqlCommand(pendingQuery, con))
            {
                cmd.Parameters.AddWithValue("@DepartmentID", departmentId);
                lblPending.Text = cmd.ExecuteScalar().ToString();
            }

            // ✅ IN PROGRESS Issues
            string progressQuery = @"SELECT COUNT(*) 
                                     FROM UserIssue 
                                     WHERE DepartmentID=@DepartmentID 
                                     AND Status='In Progress'";

            using (SqlCommand cmd = new SqlCommand(progressQuery, con))
            {
                cmd.Parameters.AddWithValue("@DepartmentID", departmentId);
                lblProgress.Text = cmd.ExecuteScalar().ToString();
            }

            // ✅ RESOLVED Issues
            string resolvedQuery = @"SELECT COUNT(*) 
                                     FROM UserIssue 
                                     WHERE DepartmentID=@DepartmentID 
                                     AND Status='Completed'";

            using (SqlCommand cmd = new SqlCommand(resolvedQuery, con))
            {
                cmd.Parameters.AddWithValue("@DepartmentID", departmentId);
                lblResolved.Text = cmd.ExecuteScalar().ToString();
            }
        }
    }
}