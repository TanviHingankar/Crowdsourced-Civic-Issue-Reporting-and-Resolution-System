using System;
using System.Web.UI;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Do nothing here
    }

    protected void btnAdminLogin_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid)
            return;

        string uname = txtAdminUser.Text.Trim();
        string pwd = txtAdminPwd.Text.Trim();

        // Simple admin credentials
        if (uname == "admin" && pwd == "admin")
        {
            Session["Admin"] = "admin";
            Response.Redirect("~/Admin/ViewComplaints.aspx");
        }
        else
        {
            lblMsg.Visible = true;
            lblMsg.Text = "Invalid admin username or password";
        }
    }
}
