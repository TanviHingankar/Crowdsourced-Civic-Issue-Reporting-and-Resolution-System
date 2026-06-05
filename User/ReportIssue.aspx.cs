using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI;

public partial class User_ReportIssue : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDepartments();
            //LoadUserAddresses();
        }

        // Optional: User session check
        if (Session["user_id"] == null)
        {
            Response.Redirect("../Default3.aspx");
        }
    }

    // Populate Department dropdown
    private void LoadDepartments()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT DepartmentID, DepartmentName FROM Department ORDER BY DepartmentName";
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ddlDepartments.DataSource = dt;
            ddlDepartments.DataTextField = "DepartmentName";
            ddlDepartments.DataValueField = "DepartmentID";
            ddlDepartments.DataBind();
            ddlDepartments.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Department --", ""));
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Session["user_id"] == null)
        {
            Response.Redirect("~/Login.aspx");
            return;
        }

        int userID = Convert.ToInt32(Session["user_id"]);
        int departmentId = Convert.ToInt32(ddlDepartments.SelectedValue);

        string address = txtAddress.Text.Trim();
        string latitude = hfLatitude.Value;
        string longitude = hfLongitude.Value;
        string description = txtDescription.Text.Trim();
        string issueType = txttype.Text.Trim();
        string photoName = null;

        string folderPath = Server.MapPath("~/IssuePhotos/");
        if (!Directory.Exists(folderPath))
            Directory.CreateDirectory(folderPath);

        using (SqlConnection con = new SqlConnection(cs))
        {
            // 0️⃣ Check for duplicate issue
            string checkQuery = @"SELECT COUNT(*) FROM UserIssue
                              WHERE  
                               Address=@Address
                              AND Description=@Description
                              AND IssueType=@IssueType
                              AND Status='Pending'";

            using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
            {
                //checkCmd.Parameters.AddWithValue("@UserID", userID);
                checkCmd.Parameters.AddWithValue("@Address", address);
                checkCmd.Parameters.AddWithValue("@Description", description);
                checkCmd.Parameters.AddWithValue("@IssueType", issueType);

                con.Open();
                int count = Convert.ToInt32(checkCmd.ExecuteScalar());
                if (count > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                        "alert('You have already submitted this issue and it is pending.');", true);
                    return;
                }
                con.Close();
            }
        }

        int issueID;

        using (SqlConnection con = new SqlConnection(cs))
        {
            // 1️⃣ Insert the record WITHOUT photo first
            string query = @"INSERT INTO UserIssue
                    (UserID, DepartmentID, Address, Latitude, Longitude, 
                     Description, IssueType, Status, CreatedDate)
                    VALUES
                    (@UserID, @DepartmentID, @Address, @Latitude, @Longitude,
                     @Description, @IssueType, 'Pending', GETDATE());
                     SELECT SCOPE_IDENTITY();";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserID", userID);
                cmd.Parameters.AddWithValue("@DepartmentID", departmentId);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@Latitude", latitude);
                cmd.Parameters.AddWithValue("@Longitude", longitude);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@IssueType", issueType);

                con.Open();
                issueID = Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        // 2️⃣ Save the photo with the desired name
        string extension = ".jpg"; // default
        if (fuPhoto.HasFile)
            extension = Path.GetExtension(fuPhoto.FileName);
        else if (!string.IsNullOrEmpty(hfPhoto.Value))
            extension = ".png";

        photoName = "Issue_" + issueID + "_" + userID + "_BeforeCompletion" + extension;
        string photoPath = Path.Combine(folderPath, photoName);

        if (fuPhoto.HasFile)
            fuPhoto.SaveAs(photoPath);
        else if (!string.IsNullOrEmpty(hfPhoto.Value))
        {
            string base64 = hfPhoto.Value.Replace("data:image/png;base64,", "");
            byte[] bytes = Convert.FromBase64String(base64);
            File.WriteAllBytes(photoPath, bytes);
        }

        // 3️⃣ Update the photo column in database
        using (SqlConnection con = new SqlConnection(cs))
        {
            string updateQuery = "UPDATE UserIssue SET Photo=@Photo WHERE IssueID=@IssueID";
            using (SqlCommand cmd = new SqlCommand(updateQuery, con))
            {
                cmd.Parameters.AddWithValue("@Photo", photoName);
                cmd.Parameters.AddWithValue("@IssueID", issueID);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
            "alert('Issue Reported Successfully!');", true);

        ClearFields();
    }

    protected void btnViewDeptInfo_Click(object sender, EventArgs e)
    {
        if (ddlDepartments.SelectedIndex == 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Please select a department first.');", true);
            return;
        }

        ShowDepartmentModal();
    }
    private void ShowDepartmentModal()
    {
        if (ddlDepartments.SelectedIndex == 0) return;

        int deptID = Convert.ToInt32(ddlDepartments.SelectedValue);

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT DepartmentName, DepartmentType, Description, Status, 
                                FullAddress,  Email
                         FROM Department WHERE DepartmentID=@DeptID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@DeptID", deptID);
            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                // Escape single quotes
                string name = dr["DepartmentName"].ToString().Replace("'", "\\'");
                string type = dr["DepartmentType"].ToString().Replace("'", "\\'");
                string desc = dr["Description"].ToString().Replace("'", "\\'");
                string status = dr["Status"].ToString().Replace("'", "\\'");
                string address = dr["FullAddress"].ToString().Replace("'", "\\'");
               // string country = dr["Country"].ToString().Replace("'", "\\'");
                string email = dr["Email"].ToString().Replace("'", "\\'");

                string script = "<script type='text/javascript'>" +
                    "document.getElementById('modalDeptName').innerText = '" + name + "';" +
                    "document.getElementById('modalDeptType').innerText = '" + type + "';" +
                    "document.getElementById('modalDeptDesc').innerText = '" + desc + "';" +
                    "document.getElementById('modalDeptStatus').innerText = '" + status + "';" +
                    "document.getElementById('modalDeptAddress').innerText = '" + address + "';" +
                  
                    "document.getElementById('modalDeptEmail').innerText = '" + email + "';" +
                    "var modal = new bootstrap.Modal(document.getElementById('deptInfoModal'));" +
                    "modal.show();" +
                    "</script>";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowDeptModal", script, false);
            }
        }
    }
        protected void ddlDepartments_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlDepartments.SelectedIndex == 0) return;

        int deptID = Convert.ToInt32(ddlDepartments.SelectedValue);

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT DepartmentName, DepartmentType, Description, Status, 
                               FullAddress,  Email
                         FROM Department WHERE DepartmentID=@DeptID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@DeptID", deptID);
            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                // Encode values for JS
                string name = dr["DepartmentName"].ToString().Replace("'", "\\'");
                string type = dr["DepartmentType"].ToString().Replace("'", "\\'");
                string desc = dr["Description"].ToString().Replace("'", "\\'");
                string status = dr["Status"].ToString().Replace("'", "\\'");
                string address = dr["FullAddress"].ToString().Replace("'", "\\'");
               
               // string country = dr["Country"].ToString().Replace("'", "\\'");
                string email = dr["Email"].ToString().Replace("'", "\\'");

                string script = "<script type='text/javascript'>" +
                    "document.getElementById('modalDeptName').innerText = '" + name + "';" +
                    "document.getElementById('modalDeptType').innerText = '" + type + "';" +
                    "document.getElementById('modalDeptDesc').innerText = '" + desc + "';" +
                    "document.getElementById('modalDeptStatus').innerText = '" + status + "';" +
                    "document.getElementById('modalDeptAddress').innerText = '" + address + "';" +
                 
                    "document.getElementById('modalDeptEmail').innerText = '" + email + "';" +
                    "var modal = new bootstrap.Modal(document.getElementById('deptInfoModal'));" +
                    "modal.show();" +
                    "</script>";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowDeptModal", script, false);
            }
        }
    }
    private void ClearFields()
    {
        txtDescription.Text = "";
        ddlDepartments.SelectedIndex = 0;
        txtAddress.Text = "";
        fuPhoto.Dispose();
        hfPhoto.Value = "";
    }
}