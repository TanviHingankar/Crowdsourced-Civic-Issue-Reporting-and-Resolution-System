using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Net;
using System.Net.Mail;

public partial class ForgotPassword : System.Web.UI.Page
{
    protected void btnSend_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand("SELECT pwd FROM Registration WHERE emailid=@email", con);
            cmd.Parameters.AddWithValue("@email", email);

            object result = cmd.ExecuteScalar();

            if (result != null)
            {
                string password = result.ToString();

                // Send Email
                MailMessage mail = new MailMessage();
                mail.To.Add(email);
                mail.From = new MailAddress("mycollegeproject02@gmail.com");
                mail.Subject = "Your Password";
                mail.Body = "Your password is: " + password;

                SmtpClient smtp = new SmtpClient("smtp.gmail.com");
                smtp.Port = 587;
                smtp.Credentials = new NetworkCredential("mycollegeproject02@gmail.com", "khbn zjfy nwie aigk");
                smtp.EnableSsl = true;

                smtp.Send(mail);

                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Password sent to your email successfully!";
            }
            else
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Email not found!";
            }
        }
    }
}