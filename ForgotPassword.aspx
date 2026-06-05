<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">

<style>
    .forgot-wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 90vh;
        background: #e6e6e6;
    }

    .forgot-card {
        width: 360px;
        max-width: 95%;
        background: #ffffff;
        border-radius: 25px;
        padding: 30px;
        box-shadow: 0 15px 40px rgba(0,0,0,0.15);
        text-align: center;
    }

    .forgot-title {
        font-size: 22px;
        font-weight: 700;
        margin-bottom: 10px;
    }

    .forgot-subtitle {
        font-size: 13px;
        color: #6c757d;
        margin-bottom: 25px;
    }

    .form-control {
        border-radius: 12px;
        padding: 12px;
        font-size: 14px;
        margin-bottom: 15px;
        width: 100%;
        border: 1px solid #ccc;
    }

    .btn-send {
        width: 100%;
        background: #18c1d6;
        color: white;
        border: none;
        padding: 12px;
        border-radius: 12px;
        font-weight: 600;
        transition: 0.3s;
    }

    .btn-send:hover {
        background: #12a9bb;
    }

    .back-login {
        margin-top: 15px;
        font-size: 13px;
    }

    .back-login a {
        color: #18c1d6;
        text-decoration: none;
        font-weight: 600;
    }

    .msg-label {
        margin-bottom: 15px;
        font-size: 13px;
        font-weight: 600;
    }
</style>

<div class="forgot-wrapper">
    <div class="forgot-card">

        <div class="forgot-title">Forgot Password?</div>
        <div class="forgot-subtitle">
            Enter your registered email and we will send your password.
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="msg-label"></asp:Label>

        <asp:TextBox ID="txtEmail" runat="server"
            CssClass="form-control"
            placeholder="Enter Registered Email"></asp:TextBox>

        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
            ControlToValidate="txtEmail"
            ErrorMessage="Enter Email"
            ForeColor="Red"
            Display="Dynamic" />

        <asp:Button ID="btnSend" runat="server"
            Text="Send Password"
            CssClass="btn-send"
            OnClick="btnSend_Click" />

        <div class="back-login">
            <a href="Default3.aspx">Back to Login</a>
        </div>

    </div>
</div>

</asp:Content><asp:Content ID="Content4" ContentPlaceHolderID="Scripts" Runat="Server">
</asp:Content>

