using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.IO;

public partial class Department_TakeAction : System.Web.UI.Page
{
    // Connection string from Web.config
    string connectionString = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["dept_id"] == null)
        {
            Response.Redirect("~/Login.aspx");
            return;
        }
        if (!IsPostBack)
        {
            // Get IssueID from query string
            if (Request.QueryString["issueID"] != null)
            {
                int issueID = Convert.ToInt32(Request.QueryString["issueID"]);
                ViewState["IssueID"] = issueID; // store for postback

                LoadIssueDetails(issueID);
                LoadPreviousActions(issueID);
            }
            else
            {
                // Redirect back if no IssueID
                Response.Redirect("IssueManagement.aspx");
            }
        }
    }

    private void LoadIssueDetails(int issueID)
    {
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"SELECT IssueID, UserID, DepartmentID, Address, Description, Photo, Status, CreatedDate,IssueType 
                             FROM UserIssue 
                             WHERE IssueID = @IssueID";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@IssueID", issueID);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblType.Text = dr["IssueType"].ToString(); // Assuming description as type placeholder
                    lblDescription.Text = dr["Description"].ToString();
                    lblAddress.Text = dr["Address"].ToString();
                    lblStatus.Text = dr["Status"].ToString();
                    //lblUserID.Text = dr["UserID"].ToString();
                    lblCreatedDate.Text = Convert.ToDateTime(dr["CreatedDate"]).ToString("dd-MMM-yyyy HH:mm");

                    // Handle photo
                    string photo = dr["Photo"] != DBNull.Value ? dr["Photo"].ToString() : "no-image.png";
                    imgIssuePhoto.ImageUrl = ResolveUrl("~/IssuePhotos/" + photo);
                }
                dr.Close();
            }
        }
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlStatus.SelectedValue == "Completed")
        {
            divCompletionPhoto.Style["display"] = "block";
        }
        else
        {
            divCompletionPhoto.Style["display"] = "none";
        }
    }
    private void LoadPreviousActions(int issueID)
    {
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            string query = @"SELECT ActionID, Status, Remarks, ActionDate, UserID 
                             FROM IssueActions 
                             WHERE IssueID = @IssueID 
                             ORDER BY ActionDate DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@IssueID", issueID);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Optional: bind to a GridView or Repeater if you have one
                // Example: rptActions.DataSource = dt; rptActions.DataBind();
            }
        }
    }
    protected void btnSaveAction_Click(object sender, EventArgs e)
    {
        if (ViewState["IssueID"] == null)
            return;

        if (Session["dept_id"] == null)
        {
            Response.Redirect("~/Default3.aspx");
            return;
        }

        int issueID = Convert.ToInt32(ViewState["IssueID"]);
        string status = ddlStatus.SelectedValue;
        string remarks = txtRemarks.Text.Trim();
        int departmentID = Convert.ToInt32(Session["dept_id"]); // department ID
        string completionPhotoName = null;
        string userEmail = "";
        string issueDesc = "";
        int userID = 0; // initialize

        // Handle completion photo
     

        if (status == "Completed")
        {
            // First, check if the user uploaded a file
            if (fileCompletionPhoto.HasFile)
            {
                string folderPath = Server.MapPath("~/CompletionPhotos/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                completionPhotoName = "Issue_" + departmentID + "_" + issueID + "_AfterCompletion" +
                                      Path.GetExtension(fileCompletionPhoto.FileName);

                string savePath = Path.Combine(folderPath, completionPhotoName);
                fileCompletionPhoto.SaveAs(savePath);
            }
            // Else, use camera captured photo
            else if (!string.IsNullOrEmpty(hfCompletionPhoto.Value))
            {
                string folderPath = Server.MapPath("~/CompletionPhotos/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                completionPhotoName = "Issue_" + departmentID + "_" + issueID + "_AfterCompletion.png";
                string base64 = hfCompletionPhoto.Value.Replace("data:image/png;base64,", "");
                byte[] bytes = Convert.FromBase64String(base64);
                File.WriteAllBytes(Path.Combine(folderPath, completionPhotoName), bytes);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Please capture or upload a completion photo before marking as Completed.');", true);
                return;
            }
        }
        using (SqlConnection con = new SqlConnection(connectionString))
        {
            con.Open();

            // Get user email, description, and UserID
            string getUserQuery = @"SELECT U.user_id, U.emailid, UI.Description
                                FROM UserIssue UI
                                INNER JOIN Registration U ON UI.UserID = U.user_id
                                WHERE UI.IssueID=@IssueID";

            using (SqlCommand cmdUser = new SqlCommand(getUserQuery, con))
            {
                cmdUser.Parameters.AddWithValue("@IssueID", issueID);
                SqlDataReader dr = cmdUser.ExecuteReader();
                if (dr.Read())
                {
                    userID = Convert.ToInt32(dr["user_id"]);  // <-- store UserID
                    userEmail = dr["emailid"].ToString();
                    issueDesc = dr["Description"].ToString();
                }
                dr.Close();
            }

            // Insert action + update issue
            string query = @"
            INSERT INTO IssueActions 
            (IssueID, DepartmentID, Status, Remarks, ActionDate, UserID)
            VALUES (@IssueID, @DepartmentID, @Status, @Remarks, GETDATE(), @UserID);

            UPDATE UserIssue 
            SET Status=@Status,
                CompletionPhoto=@CompletionPhoto
            WHERE IssueID=@IssueID;";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@IssueID", issueID);
                cmd.Parameters.AddWithValue("@DepartmentID", departmentID);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@Remarks", remarks);
                cmd.Parameters.AddWithValue("@UserID", userID); // insert UserID
                cmd.Parameters.AddWithValue("@CompletionPhoto",
                    (object)completionPhotoName ?? DBNull.Value);

                cmd.ExecuteNonQuery();
            }
        }

        // Send email to the user
        if (!string.IsNullOrEmpty(userEmail))
        {
            try
            {
                MailMessage mail = new MailMessage();
                mail.From = new MailAddress("mycollegeproject02@gmail.com", "CivicConnect");
                mail.To.Add(userEmail);
                mail.Subject = "Update on Your Reported Issue";
                mail.IsBodyHtml = true;

                string emailBody =
          "<h3>Your Issue Has Been Updated</h3>" +
          "<p><b>Description:</b> " + issueDesc + "</p>" +
          "<p><b>Status:</b> " + status + "</p>" +
          "<p><b>Remarks:</b> " + remarks + "</p>" +
          "<p><b>Date:</b> " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm") + "</p>";

                mail.Body = emailBody;

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                smtp.Credentials = new NetworkCredential("mycollegeproject02@gmail.com", "khbn zjfy nwie aigk");
                smtp.EnableSsl = true;
                smtp.Send(mail);
            }
            catch { }
        }

        LoadIssueDetails(issueID);

        ClientScript.RegisterStartupScript(this.GetType(), "alert",
            "alert('Action saved successfully with completion photo!');", true);
    }

    //protected void btnSaveAction_Click(object sender, EventArgs e)
    //{
    //    if (ViewState["IssueID"] == null)
    //        return;

    //    int issueID = Convert.ToInt32(ViewState["IssueID"]);
    //    string status = ddlStatus.SelectedValue;
    //    string remarks = txtRemarks.Text.Trim();
    //    int departmentID = 1;
    //    string userID = Session["user_id"].ToString();

    //    string completionPhotoName = null;
    //    string userEmail = "";
    //    string issueDesc = "";

    //    // ✅ HANDLE COMPLETION PHOTO
    //    if (status == "Completed")
    //    {
    //        // Option 1: Normal Upload
    //        if (fileCompletionPhoto.HasFile)
    //        {
    //            completionPhotoName = Guid.NewGuid().ToString() +
    //                Path.GetExtension(fileCompletionPhoto.FileName);

    //            string savePath = Server.MapPath("~/CompletionPhotos/") + completionPhotoName;
    //            fileCompletionPhoto.SaveAs(savePath);
    //        }
    //        // Option 2: Camera Capture
    //        else if (Request.Files["cameraInput"] != null &&
    //                 Request.Files["cameraInput"].ContentLength > 0)
    //        {
    //            HttpPostedFile cameraFile = Request.Files["cameraInput"];

    //            completionPhotoName = Guid.NewGuid().ToString() +
    //                Path.GetExtension(cameraFile.FileName);

    //            string savePath = Server.MapPath("~/CompletionPhotos/") + completionPhotoName;
    //            cameraFile.SaveAs(savePath);
    //        }
    //        else
    //        {
    //            ClientScript.RegisterStartupScript(this.GetType(), "alert",
    //                "alert('Please upload or capture completion photo before marking as Completed.');", true);
    //            return;
    //        }
    //    }

    //    using (SqlConnection con = new SqlConnection(connectionString))
    //    {
    //        con.Open();

    //        // Get user email
    //        string getUserQuery = @"SELECT U.emailid, UI.Description
    //                            FROM UserIssue UI
    //                            INNER JOIN Registration U ON UI.UserID = U.user_id
    //                            WHERE UI.IssueID=@IssueID";

    //        using (SqlCommand cmdUser = new SqlCommand(getUserQuery, con))
    //        {
    //            cmdUser.Parameters.AddWithValue("@IssueID", issueID);
    //            SqlDataReader dr = cmdUser.ExecuteReader();
    //            if (dr.Read())
    //            {
    //                userEmail = dr["emailid"].ToString();
    //                issueDesc = dr["Description"].ToString();
    //            }
    //            dr.Close();
    //        }

    //        // Insert action + update issue
    //        string query = @"
    //    INSERT INTO IssueActions 
    //    (IssueID, DepartmentID, Status, Remarks, ActionDate, UserID)
    //    VALUES (@IssueID, @DepartmentID, @Status, @Remarks, GETDATE(), @UserID);

    //    UPDATE UserIssue 
    //    SET Status=@Status,
    //        CompletionPhoto=@CompletionPhoto
    //    WHERE IssueID=@IssueID;";

    //        using (SqlCommand cmd = new SqlCommand(query, con))
    //        {
    //            cmd.Parameters.AddWithValue("@IssueID", issueID);
    //            cmd.Parameters.AddWithValue("@DepartmentID", departmentID);
    //            cmd.Parameters.AddWithValue("@Status", status);
    //            cmd.Parameters.AddWithValue("@Remarks", remarks);
    //            cmd.Parameters.AddWithValue("@UserID", userID);
    //            cmd.Parameters.AddWithValue("@CompletionPhoto",
    //                (object)completionPhotoName ?? DBNull.Value);

    //            cmd.ExecuteNonQuery();
    //        }
    //    }

    //    // ✅ SEND EMAIL
    //    if (!string.IsNullOrEmpty(userEmail))
    //    {
    //        try
    //        {
    //            MailMessage mail = new MailMessage();
    //            mail.From = new MailAddress("mycollegeproject02@gmail.com", "CivicConnect");
    //            mail.To.Add(userEmail);
    //            mail.Subject = "Update on Your Reported Issue";
    //            mail.IsBodyHtml = true;

    //            string emailBody = @"
    //        <h3>Your Issue Has Been Updated</h3>
    //        <p><b>Description:</b> " + issueDesc + @"</p>
    //        <p><b>Status:</b> " + status + @"</p>
    //        <p><b>Remarks:</b> " + remarks + @"</p>
    //        <p><b>Date:</b> " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm") + @"</p>";

    //            mail.Body = emailBody;

    //            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
    //            smtp.Credentials = new NetworkCredential("mycollegeproject02@gmail.com", "khbn zjfy nwie aigk");
    //            smtp.EnableSsl = true;
    //            smtp.Send(mail);
    //        }
    //        catch { }
    //    }

    //    LoadIssueDetails(issueID);
    //    ClientScript.RegisterStartupScript(this.GetType(), "alert",
    //        "alert('Action saved successfully!');", true);
    //}
}
