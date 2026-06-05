using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.IO;

public partial class Registration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

    }
    protected void sendMail(string userid, string pwd)
    {
        // string userid = GetSecureKey();

        string to = "";
        StreamReader reader = new StreamReader(Server.MapPath("~/MailBody1.htm"));
        string readFile = reader.ReadToEnd();
        string myString = "";
        myString = readFile;
        myString = myString.Replace("$$Username$$", userid);
        myString = myString.Replace("$$Password$$", pwd);

        myString = myString.Replace("$$Website$$", "http://localhost:3530/Default.aspx");
        MailMessage Msg = new MailMessage();
        //MailAddress fromMail = new MailAddress("administrator@aspdotnet-suresh.com");
        MailAddress fromMail = new MailAddress("elocker403@gmail.com");
        // Sender e-mail address.
        Msg.From = fromMail;
        // Recipient e-mail address.
        Msg.To.Add(new MailAddress(to));
        // Subject of e-mail
        Msg.Subject = "Login Creadential From Question Generation";
        Msg.Body = myString.ToString();
        Msg.IsBodyHtml = true;

        SmtpClient smtp = new SmtpClient();
        smtp.Host = "smtp.gmail.com";
        smtp.EnableSsl = true;
        NetworkCredential NetworkCred = new NetworkCredential("elocker403@gmail.com", "7770056136");
        //  NetworkCredential NetworkCred = new NetworkCredential("videostegnography12@gmail.com", "Stegnography12@");
        smtp.UseDefaultCredentials = true;
        smtp.Credentials = NetworkCred;
        smtp.Port = 587;
        smtp.Send(Msg);

        reader.Dispose();    //ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Email sent.');", true);
        lblMsg.Text = "You are Successfully Registered....Check Your mail for UserId and Password";

    }

}