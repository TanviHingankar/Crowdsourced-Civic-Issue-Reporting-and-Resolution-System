using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI;

public partial class Department_EditProfile : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["dept_id"] == null)
            {
                Response.Redirect("~/Department/Default.aspx");
                return;
            }
            LoadDepartmentProfile();
        }
    }

    private void LoadDepartmentProfile()
    {
        int deptID = Convert.ToInt32(Session["dept_id"]);
        hfDepartmentID.Value = deptID.ToString();

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT DepartmentName, DepartmentType, Description, Status, Password, photo, Latitude, Longitude, FullAddress, Email, Mobile
                             FROM Department WHERE DepartmentID=@DeptID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@DeptID", deptID);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                txtDepartmentName.Text = dr["DepartmentName"].ToString();
                ddlDepartmentType.SelectedValue = dr["DepartmentType"].ToString();
                txtDescription.Text = dr["Description"].ToString();
                ddlStatus.SelectedValue = dr["Status"].ToString();
                txtPassword.Text = dr["Password"].ToString();
                txtEmail.Text = dr["Email"].ToString();
                txtMobile.Text = dr["Mobile"].ToString();
                txtAddress.Text = dr["FullAddress"].ToString();
                hfLatitude.Value = dr["Latitude"].ToString();
                hfLongitude.Value = dr["Longitude"].ToString();

                string photo = dr["photo"].ToString();
                if (!string.IsNullOrEmpty(photo))
                    imgPreview.ImageUrl = "~/DepartmentPhotos/" + photo;
            }
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        int deptID = Convert.ToInt32(hfDepartmentID.Value);

        string name = txtDepartmentName.Text.Trim();
        string type = ddlDepartmentType.SelectedValue;
        string desc = txtDescription.Text.Trim();
        string status = ddlStatus.SelectedValue;
        string password = txtPassword.Text.Trim();
        string email = txtEmail.Text.Trim();
        string mobile = txtMobile.Text.Trim();
        string address = txtAddress.Text.Trim();
        string latitude = hfLatitude.Value;
        string longitude = hfLongitude.Value;
        string photoName = null;

        string folderPath = Server.MapPath("~/DepartmentPhotos/");
        if (!Directory.Exists(folderPath)) Directory.CreateDirectory(folderPath);

        // Get old photo
        string oldPhoto = null;
        using (SqlConnection con = new SqlConnection(cs))
        {
            string q = "SELECT photo FROM Department WHERE DepartmentID=@DeptID";
            SqlCommand cmd = new SqlCommand(q, con);
            cmd.Parameters.AddWithValue("@DeptID", deptID);
            con.Open();
            oldPhoto = cmd.ExecuteScalar() as string;
            con.Close();
        }

        // Save new photo
        if (fuPhoto.HasFile)
        {
            string ext = Path.GetExtension(fuPhoto.FileName);
            photoName = "Dept_" + deptID + ext;
            string savePath = Path.Combine(folderPath, photoName);

            // Delete old photo
            if (!string.IsNullOrEmpty(oldPhoto))
            {
                string oldPath = Path.Combine(folderPath, oldPhoto);
                if (File.Exists(oldPath)) File.Delete(oldPath);
            }

            fuPhoto.SaveAs(savePath);
        }

        // Update DB
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"UPDATE Department
                             SET DepartmentName=@Name, DepartmentType=@Type, Description=@Desc,
                                 Status=@Status, Password=@Password, Email=@Email, Mobile=@Mobile,
                                 FullAddress=@Address, Latitude=@Lat, Longitude=@Long" +
                                 (photoName != null ? ", photo=@Photo" : "") +
                             " WHERE DepartmentID=@DeptID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Type", type);
            cmd.Parameters.AddWithValue("@Desc", desc);
            cmd.Parameters.AddWithValue("@Status", status);
            cmd.Parameters.AddWithValue("@Password", password);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Mobile", mobile);
            cmd.Parameters.AddWithValue("@Address", address);
            cmd.Parameters.AddWithValue("@Lat", latitude);
            cmd.Parameters.AddWithValue("@Long", longitude);
            if (photoName != null) cmd.Parameters.AddWithValue("@Photo", photoName);
            cmd.Parameters.AddWithValue("@DeptID", deptID);

            con.Open();
            cmd.ExecuteNonQuery();
        }

        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
            "alert('Department profile updated successfully!');", true);

        LoadDepartmentProfile();
    }
}