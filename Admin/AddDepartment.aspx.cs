using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Web.UI;

public partial class Admin_AddDepartment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(),
                "GetLocation",
                "getLocation();",
                true);
        }
        // Optional: Admin session check
        if (Session["UserType"] == null || Session["UserType"].ToString() != "Admin")
        {
            Response.Redirect("~/Default3.aspx");
        }
    }

    // ================= SAVE BUTTON =================
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (txtDepartmentName.Text.Trim() == "" ||
            ddlDepartmentType.SelectedIndex == 0 ||
            txtPassword.Text.Trim() == "")
        {
            return;
        }
        string address = txtAddress.Text.Trim();
        string latitude = hfLatitude.Value;
        string longitude = hfLongitude.Value;
        string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();
            string checkQuery = "SELECT COUNT(*) FROM Department WHERE DepartmentName=@Name";
            SqlCommand cmdCheck = new SqlCommand(checkQuery, con);
            cmdCheck.Parameters.AddWithValue("@Name", txtDepartmentName.Text.Trim());

            int count = (int)cmdCheck.ExecuteScalar();
            if (count > 0)
            {
                // Duplicate found, show popup and return
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "alert('Department with this name already exists!');", true);
                return;
            }
            string insertQuery = @"INSERT INTO Department
    (DepartmentName, DepartmentType, Description, Status,
     CreatedDate, Password, Latitude, Longitude,
     FullAddress, Email,Mobile)
    OUTPUT INSERTED.DepartmentID
    VALUES
    (@Name, @Type, @Desc, @Status,
     @Date, @Password, @Lat, @Long,
     @Address,  @email,@mobile)";

            SqlCommand cmd = new SqlCommand(insertQuery, con);

            // 🔹 ADD ALL PARAMETERS (THIS WAS MISSING)

            cmd.Parameters.AddWithValue("@Name", txtDepartmentName.Text.Trim());
            cmd.Parameters.AddWithValue("@Type", ddlDepartmentType.SelectedValue);
            cmd.Parameters.AddWithValue("@Desc", txtDescription.Text.Trim());
            cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@Date", DateTime.Now);
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
            cmd.Parameters.AddWithValue("@Lat", string.IsNullOrEmpty(hfLatitude.Value) ? (object)DBNull.Value : Convert.ToDecimal(hfLatitude.Value));
            cmd.Parameters.AddWithValue("@Long", string.IsNullOrEmpty(hfLongitude.Value) ? (object)DBNull.Value : Convert.ToDecimal(hfLongitude.Value));
            //cmd.Parameters.AddWithValue("@City", string.IsNullOrEmpty(Request.Form["txtCity"]) ? "" : Request.Form["txtCity"]);
            //cmd.Parameters.AddWithValue("@State", string.IsNullOrEmpty(Request.Form["txtState"]) ? "" : Request.Form["txtState"]);
            cmd.Parameters.AddWithValue("@Address", address);

            cmd.Parameters.AddWithValue("@email", txtemail.Text.Trim());
            cmd.Parameters.AddWithValue("@mobile", txtmobile.Text.Trim());

            int departmentID = (int)cmd.ExecuteScalar();
            if (fuPhoto.HasFile)
            {
                string folderPath = Server.MapPath("~/DepartmentPhotos/");
                if (!Directory.Exists(folderPath))
                    Directory.CreateDirectory(folderPath);

                string extension = Path.GetExtension(fuPhoto.FileName);
                string photoName = "Dept_" + departmentID + extension; // unique name
                string savePath = Path.Combine(folderPath, photoName);

                fuPhoto.SaveAs(savePath);

                // 3️⃣ Update Department table with photo name (assuming you have a Photo column)
                string updateQuery = "UPDATE Department SET photo=@Photo WHERE DepartmentID=@ID";
                SqlCommand cmdUpdate = new SqlCommand(updateQuery, con);
                cmdUpdate.Parameters.AddWithValue("@Photo", photoName);
                cmdUpdate.Parameters.AddWithValue("@ID", departmentID);
                cmdUpdate.ExecuteNonQuery();
            }
            // Now departmentID contains inserted ID
        }
        ClearFields();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
        "alert('Department Added Successfully!');", true);
    }
    // ================= RESET BUTTON =================
    protected void btnReset_Click(object sender, EventArgs e)
    {
        ClearFields();
    }

    // ================= CLEAR METHOD =================
    private void ClearFields()
    {
        txtDepartmentName.Text = "";
        ddlDepartmentType.SelectedIndex = 0;
        txtDescription.Text = "";
        ddlStatus.SelectedIndex = 0;
        txtPassword.Text = "";
        txtemail.Text = "";
        txtAddress.Text = "";
        txtmobile.Text = "";
    }
}