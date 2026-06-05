<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master"
    CodeFile="AdminLogin.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Admin Login
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .admin-login-card {
            max-width: 460px;
            margin: 70px auto;
            padding: 35px;
            border-radius: 20px;
            background: #ffffff;
            box-shadow: 0 20px 45px rgba(0,0,0,0.2);
        }

        .admin-title {
            text-align: center;
            font-weight: 800;
            margin-bottom: 25px;
            color: #1e40af;
        }

        .btn-admin-login {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            font-weight: 600;
            background: linear-gradient(135deg, #2563eb, #1e40af);
            border: none;
            color: #fff;
        }

        .btn-admin-login:hover {
            opacity: 0.95;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <div class="admin-login-card">
        <h3 class="admin-title">
            <i class="fas fa-user-shield"></i> Admin Login
        </h3>

        <asp:Label ID="lblMsg" runat="server"
            CssClass="text-danger fw-bold"
            Visible="false"></asp:Label>

        <!-- Admin Username -->
        <div class="mb-3">
            <label class="form-label">Admin Username</label>
            <asp:TextBox ID="txtAdminUser" runat="server"
                CssClass="form-control"
                placeholder="Enter admin username"></asp:TextBox>

            <asp:RequiredFieldValidator ID="rfvAdminUser" runat="server"
                ControlToValidate="txtAdminUser"
                ErrorMessage="Admin username is required"
                Display="None"
                ValidationGroup="adminLogin" />
        </div>

        <!-- Admin Password -->
        <div class="mb-3">
            <label class="form-label">Password</label>
            <asp:TextBox ID="txtAdminPwd" runat="server"
                CssClass="form-control"
                TextMode="Password"
                placeholder="Enter password"></asp:TextBox>

            <asp:RequiredFieldValidator ID="rfvAdminPwd" runat="server"
                ControlToValidate="txtAdminPwd"
                ErrorMessage="Password is required"
                Display="None"
                ValidationGroup="adminLogin" />
        </div>

        <!-- ONE popup for all fields -->
        <asp:ValidationSummary ID="ValidationSummary1" runat="server"
            ValidationGroup="adminLogin"
            ShowMessageBox="true"
            ShowSummary="false"
            HeaderText="Please fill all fields" />

        <asp:Button ID="btnAdminLogin" runat="server"
            Text="Login"
            CssClass="btn-admin-login"
            ValidationGroup="adminLogin"
            OnClick="btnAdminLogin_Click" />

        <div class="text-center mt-3">
            <a href="Default.aspx" class="text-decoration-none fw-bold">
                Back to Home
            </a>
        </div>
    </div>

</asp:Content>
