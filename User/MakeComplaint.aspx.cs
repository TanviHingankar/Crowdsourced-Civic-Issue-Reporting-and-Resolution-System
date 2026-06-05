using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI;

public partial class User_MakeComplaint : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Optional session check
        if (Session["user_id"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        // Validation
        if (txtcomplaint.Text.Trim() == "" ||
            txtaddress.Text.Trim() == "" 
           )
        {
            lblmsg.ForeColor = System.Drawing.Color.Red;
            lblmsg.Text = "❌ Please fill all required fields.";
            return;
        }

        string fileName = "";

        // File upload
        if (FileUpload_complaint.HasFile)
        {
            string ext = Path.GetExtension(FileUpload_complaint.FileName).ToLower();

            if (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".pdf")
            {
                lblmsg.ForeColor = System.Drawing.Color.Red;
                lblmsg.Text = "❌ Only JPG, JPEG, PNG, PDF files allowed.";
                return;
            }

            fileName = Guid.NewGuid().ToString() + ext;
            string folderPath = Server.MapPath("~/photos/");

            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            FileUpload_complaint.SaveAs(folderPath + fileName);
        }

        // Database insert
        using (SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString))
        {
            string query = @"INSERT INTO ComplaintBox
                            (complaint, address, photo, status, user_id)
                            VALUES
                            (@complaint, @address, @photo, @status, @user_id)";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@complaint", txtcomplaint.Text);
            cmd.Parameters.AddWithValue("@address", txtaddress.Text);
            cmd.Parameters.AddWithValue("@photo", fileName);
            cmd.Parameters.AddWithValue("@status", "Pending");
            cmd.Parameters.AddWithValue("@user_id", Session["user_id"].ToString());
          //  cmd.Parameters.AddWithValue("@depart", ddldepartment.SelectedValue);

            con.Open();
            int result = cmd.ExecuteNonQuery();

            if (result > 0)
            {
                lblmsg.ForeColor = System.Drawing.Color.Green;
                lblmsg.Text = "✅ Complaint submitted successfully!";
            }
            else
            {
                lblmsg.ForeColor = System.Drawing.Color.Red;
                lblmsg.Text = "❌ Complaint submission failed.";
            }
        }

        // Clear form
        txtcomplaint.Text = "";
        txtaddress.Text = "";
        //ddldepartment.SelectedIndex = 0;
    }
}
