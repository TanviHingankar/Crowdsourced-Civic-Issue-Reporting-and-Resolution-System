using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI;

public partial class User_EditProfile : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["user_id"] == null)
            {
                Response.Redirect("~/Default3.aspx");
                return;
            }

            LoadUserProfile();
        }
    }

    private void LoadUserProfile()
    {
        int userID = Convert.ToInt32(Session["user_id"]);
        hfUserID.Value = userID.ToString();

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT uname, mobileno, address, emailid, pwd, photo FROM Registration WHERE user_id=@UserID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@UserID", userID);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                txtName.Text = dr["uname"].ToString();
                txtMobile.Text = dr["mobileno"].ToString();
                txtAddress.Text = dr["address"].ToString();
                txtEmail.Text = dr["emailid"].ToString();
                txtPassword.Text = dr["pwd"].ToString();

                string photo = dr["photo"].ToString();
                if (!string.IsNullOrEmpty(photo))
                {
                    imgPreview.ImageUrl = "~/UserPhotos/" + photo;
                }
            }
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        int userID = Convert.ToInt32(hfUserID.Value);

        string name = txtName.Text.Trim();
        string mobile = txtMobile.Text.Trim();
        string address = txtAddress.Text.Trim();
        string email = txtEmail.Text.Trim();
        string password = txtPassword.Text.Trim();
        string photoName = null;

        string folderPath = Server.MapPath("~/UserPhotos/");
        if (!Directory.Exists(folderPath))
            Directory.CreateDirectory(folderPath);

        // 🔹 Delete old photo(s) if they exist
        string searchPattern = "User_" + userID + ".*"; // matches any extension
        string[] oldFiles = Directory.GetFiles(folderPath, searchPattern);
        foreach (string file in oldFiles)
        {
            File.Delete(file);
        }

        // 🔹 Save new photo if uploaded
        if (fuPhoto.HasFile)
        {
            string extension = Path.GetExtension(fuPhoto.FileName);
            photoName = "User_" + userID + extension;
            string savePath = Path.Combine(folderPath, photoName);
            fuPhoto.SaveAs(savePath);
        }

        // 🔹 Update database
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"UPDATE Registration
                         SET uname=@Name, mobileno=@Mobile, address=@Address, 
                             emailid=@Email, pwd=@Password" +
                                 (photoName != null ? ", photo=@Photo" : "") +
                             " WHERE user_id=@UserID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Mobile", mobile);
            cmd.Parameters.AddWithValue("@Address", address);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Password", password);
            if (photoName != null)
                cmd.Parameters.AddWithValue("@Photo", photoName);
            cmd.Parameters.AddWithValue("@UserID", userID);

            con.Open();
            cmd.ExecuteNonQuery();
        }

        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
            "alert('Profile updated successfully!');", true);

        // 🔹 Refresh profile and force image reload
        LoadUserProfile();
        if (!string.IsNullOrEmpty(photoName))
        {
            imgPreview.ImageUrl = "~/UserPhotos/" + photoName + "?v=" + DateTime.Now.Ticks;
        }
    }
}