using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;

public partial class Default3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // ================= SEND OTP =================
    protected void btnSendOTP_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtUsername.Text))
        {
            lblmsg.Text = "Enter email first.";
            lblmsg.ForeColor = System.Drawing.Color.Red;
            return;
        }

        string otp = GenerateOTP();
        Session["UserOTP"] = otp;
        Session["OTPMode"] = true;

        try
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(txtUsername.Text.Trim());
            mail.Subject = "Your Login OTP";
            mail.Body = "Your OTP is: " + otp;

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);

            lblmsg.Text = "OTP Sent Successfully!";
            lblmsg.ForeColor = System.Drawing.Color.Green;

            btnLogin.Text = "Verify OTP";
        }
        catch
        {
            lblmsg.Text = "Failed to send OTP.";
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }
    }

    private string GenerateOTP()
    {
        Random rnd = new Random();
        return rnd.Next(100000, 999999).ToString();
    }

    // ================= LOGIN =================
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string userType = hfUserType.Value;
        string username = txtUsername.Text.Trim();
        string enteredValue = txtPassword.Text.Trim();

        string cs = ConfigurationManager.ConnectionStrings["PeopleComplaintConnectionString"].ConnectionString;

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            // ================= OTP MODE =================
            if (btnLogin.Text == "Verify OTP")
            {
                if (Session["UserOTP"] == null)
                {
                    lblmsg.Text = "Request OTP first.";
                    lblmsg.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                if (enteredValue == Session["UserOTP"].ToString())
                {
                    if (userType == "Citizen")
                    {
                        SqlCommand cmd = new SqlCommand(
                            "SELECT * FROM Registration WHERE emailid=@username OR username=@username",
                            con);

                        cmd.Parameters.AddWithValue("@username", username);

                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.Read())
                        {
                            Session["user_id"] = dr["user_id"].ToString();
                            Session["username"] = dr["username"].ToString();
                            Session["UserType"] = "Citizen";

                            Response.Redirect("User/Default.aspx");
                        }
                        else
                        {
                            lblmsg.Text = "User not found.";
                            lblmsg.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    else if (userType == "Admin")
                    {
                        Session["adminid"] = "1";
                        Session["UserType"] = "Admin";
                        Response.Redirect("Admin/Default.aspx");
                    }
                    else if (userType == "Department")
                    {
                        SqlCommand cmd = new SqlCommand(
                            "SELECT * FROM DepartmentAccount WHERE Email=@username AND Status='Active'",
                            con);

                        cmd.Parameters.AddWithValue("@username", username);

                        SqlDataReader dr = cmd.ExecuteReader();

                        if (dr.Read())
                        {
                            Session["dept_id"] = dr["dept_id"].ToString();
                            Session["username"] = dr["username"].ToString();
                            Session["UserType"] = "Department";

                            Response.Redirect("Department/Default.aspx");
                        }
                        else
                        {
                            lblmsg.Text = "Department not found or inactive.";
                            lblmsg.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
                else
                {
                    lblmsg.Text = "Invalid OTP!";
                    lblmsg.ForeColor = System.Drawing.Color.Red;
                }

                return;
            }

            // ================= PASSWORD MODE =================
            SqlCommand cmdLogin = new SqlCommand();
            cmdLogin.Connection = con;

            if (userType == "Citizen")
            {
                cmdLogin.CommandText = @"SELECT * FROM Registration 
                                         WHERE (emailid=@username OR username=@username) 
                                         AND pwd=@password";
            }
            else if (userType == "Admin")
            {
                cmdLogin.CommandText = @"SELECT * FROM Admin_Login 
                                         WHERE adminid=1 
                                         AND username=@username 
                                         AND password=@password";
            }
            else if (userType == "Department")
            {
                cmdLogin.CommandText = @"SELECT * FROM Department 
                                         WHERE Email=@username 
                                         AND Password=@password 
                                         AND Status='Active'";
            }

            cmdLogin.Parameters.AddWithValue("@username", username);
            cmdLogin.Parameters.AddWithValue("@password", enteredValue);

            SqlDataReader drLogin = cmdLogin.ExecuteReader();

            if (drLogin.Read())
            {
                if (userType == "Citizen")
                {
                    Session["user_id"] = drLogin["user_id"].ToString();
                    Session["username"] = drLogin["username"].ToString();
                    Session["UserType"] = "Citizen";

                    Response.Redirect("User/Default.aspx");
                }
                else if (userType == "Admin")
                {
                    Session["adminid"] = drLogin["adminid"].ToString();
                    Session["UserType"] = "Admin";

                    Response.Redirect("Admin/Default.aspx");
                }
                else if (userType == "Department")
                {
                    Session["dept_id"] = drLogin["DepartmentID"].ToString();
                    Session["username"] = drLogin["DepartmentName"].ToString();
                    Session["UserType"] = "Department";

                    Response.Redirect("Department/DepartmentDashboard.aspx");
                }
            }
            else
            {
                lblmsg.Text = "Invalid Username or Password!";
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}