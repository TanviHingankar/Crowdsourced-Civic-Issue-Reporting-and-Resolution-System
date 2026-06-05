using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;

public partial class Registration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnVerifyOTP_Click(object sender, EventArgs e)
    {
        if (Session["UserOTP"] == null)
        {
            lblmsg.Text = "Please request OTP first.";
            return;
        }

        if (txtOTP.Text.Trim() == Session["UserOTP"].ToString())
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "otpVerified",
            "Swal.fire({icon:'success',title:'OTP Verified!',text:'OTP Verified Successfully!',confirmButtonColor:'#18c1d6'});", true); Session["OTPVerified"] = true;
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "otpInvalid",
            "Swal.fire({icon:'error',title:'Invalid OTP!',text:'Please enter correct OTP.',confirmButtonColor:'#d33'});", true);
        }
    }
    protected void btnSendOTP_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtemail.Text))
        {
            lblmsg.Text = "Please enter email first.";
            return;
        }

        string otp = GenerateOTP();
        Session["UserOTP"] = otp;   // Store OTP in session

        try
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(txtemail.Text.Trim());
            mail.Subject = "Your Registration OTP";
            mail.Body = "Your OTP is: " + otp;
            mail.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);

            ScriptManager.RegisterStartupScript(this, GetType(), "otpSuccess",
 "Swal.fire({icon:'success',title:'OTP Sent!',text:'OTP sent to your email successfully.',confirmButtonColor:'#18c1d6'});", true);
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "otpError",
            "Swal.fire({icon:'error',title:'Error!',text:'Failed to send OTP. Please try again.',confirmButtonColor:'#d33'});", true);
        }
    }
    // Generate Random 6 Digit OTP
    private string GenerateOTP()
    {
        Random rnd = new Random();
        return rnd.Next(100000, 999999).ToString();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtname.Text) ||
            string.IsNullOrWhiteSpace(txtemail.Text) ||
            string.IsNullOrWhiteSpace(txtaddress.Text) ||
            string.IsNullOrWhiteSpace(txtcontact.Text) ||
            string.IsNullOrWhiteSpace(txtusername.Text) ||
            string.IsNullOrWhiteSpace(txtpwd.Text))
        {
            Response.Write("<script>alert('Please fill all fields');</script>");
            return;
        }

        SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["LISS"]);
        con.Open();
        SqlCommand checkCmd = new SqlCommand( @"select emailid from Registration where emailid=@email", con);
        checkCmd.Parameters.AddWithValue("@Email", txtemail.Text.Trim());

      int emailCount = Convert.ToInt32(checkCmd.ExecuteScalar());
        if (emailCount > 0)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "emailExists",
            "Swal.fire({icon:'warning',title:'Email Exists!',text:'This email is already registered.',confirmButtonColor:'#d33'});", true);

            con.Close();
            return;  // ❌ STOP INSERTION
        }
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;

        // FIRST INSERT WITHOUT PHOTO (to get user_id)
        cmd.CommandText = @"INSERT INTO Registration
                        (uname, mobileno, address, emailid, username, pwd)
                        VALUES
                        (@sname, @contact, @address, @emailid, @userid, @pwd);
                        SELECT SCOPE_IDENTITY();";

        cmd.Parameters.AddWithValue("@sname", txtname.Text);
        cmd.Parameters.AddWithValue("@contact", txtcontact.Text);
        cmd.Parameters.AddWithValue("@address", txtaddress.Text);
        cmd.Parameters.AddWithValue("@emailid", txtemail.Text);
        cmd.Parameters.AddWithValue("@userid", txtusername.Text);
        cmd.Parameters.AddWithValue("@pwd", txtpwd.Text);

        // Get inserted user_id
        int newUserId = Convert.ToInt32(cmd.ExecuteScalar());

        string photoFileName = "";

        if (fuphoto.HasFile)
        {
            string extension = System.IO.Path.GetExtension(fuphoto.FileName);

            // Rename photo using user_id
            photoFileName = "User_" + newUserId + extension;

            string folderPath = Server.MapPath("~/UserPhotos/");
            string fullPath = folderPath + photoFileName;

            // Save photo in folder
            fuphoto.SaveAs(fullPath);

            // Update photo name in database
            SqlCommand cmdUpdate = new SqlCommand(
                "UPDATE Registration SET photo=@photo WHERE user_id=@uid", con);

            cmdUpdate.Parameters.AddWithValue("@photo", photoFileName);
            cmdUpdate.Parameters.AddWithValue("@uid", newUserId);
            cmdUpdate.ExecuteNonQuery();
        }

        con.Close();

        ScriptManager.RegisterStartupScript(this, GetType(), "regSuccess",
 "Swal.fire({icon:'success',title:'Registered!',text:'Registration Successful',confirmButtonColor:'#18c1d6'}).then(()=>{window.location='Registration.aspx';});", true);
    }
}