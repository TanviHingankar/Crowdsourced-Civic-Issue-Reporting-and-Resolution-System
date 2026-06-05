using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

public partial class User_Default : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        // Check login
        if (Session["user_id"] == null)
        {
            Response.Redirect("../Login.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadUserProfile();
            LoadUserReports();
        }
    }
    protected string GetStatusClass(string status)
    {
        if (status == "Resolved")
            return "status-resolved";
        else if (status == "In Progress")
            return "status-progress";
        else
            return "status-progress"; // default
    }
    private void LoadUserReports()
    {
        string userId = Session["user_id"].ToString();

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT IssueType, Status, Photo
                         FROM UserIssue
                         WHERE UserID=@UserID
                         ORDER BY IssueID DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                System.Data.DataTable dt = new System.Data.DataTable();
                da.Fill(dt);

                rptReports.DataSource = dt;
                rptReports.DataBind();
            }
        }
    }
    protected void LoadUserProfile()
    {
        string id = Session["user_id"].ToString();
        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();
            string query = @"select uname,photo,Date from Registration where user_id=@id";

            using(SqlCommand cmd = new SqlCommand(query,con))

            {
                cmd.Parameters.AddWithValue("@id", id);

                SqlDataReader dr = cmd.ExecuteReader();

                if(dr.Read())
                {
                    lblUsername.Text = dr["uname"].ToString();
                    lblMemberSince.Text = dr["Date"].ToString();
                    // Load Photo
                    if (dr["photo"] != DBNull.Value && dr["photo"].ToString() != "")
                    {
                        imgProfile.ImageUrl = "../UserPhotos/" + dr["photo"].ToString();
                    }
                    else
                    {
                        imgProfile.ImageUrl = "../UserPhotos/user.jpg"; // Default image
                    }
                }
            }
        }

    }
}
