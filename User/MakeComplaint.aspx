<%@ Page Language="C#"
    AutoEventWireup="true"
    MasterPageFile="~/User/UserMasterPage.master"
    CodeFile="MakeComplaint.aspx.cs"
    Inherits="User_MakeComplaint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>
    :root {
        --primary-color: #4f46e5;
        --primary-dark: #4338ca;
    }

    .main-container {
        margin-top: 2rem;
        margin-bottom: 2rem;
    }

    .complaint-card {
        background: white;
        border-radius: 20px;
        box-shadow: 0 20px 25px rgba(0,0,0,0.1);
    }

    .card-header-custom {
        background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
        color: white;
        padding: 2rem;
        text-align: center;
        border-radius: 20px 20px 0 0;
    }

    .card-body-custom {
        padding: 2rem;
    }

    .form-control {
        border-radius: 10px;
        margin-bottom: 1rem;
    }

    .btn-submit {
        background: linear-gradient(135deg, var(--primary-color), var(--primary-dark));
        color: white;
        border-radius: 12px;
        padding: 12px;
        width: 100%;
        font-weight: 600;
    }

    .alert-custom {
        margin-top: 1rem;
        font-weight: bold;
    }
</style>

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

</asp:Content>

<asp:Content ID="Content2"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

<div class="container main-container">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <div class="complaint-card">
                <div class="card-header-custom">
                    <h2><i class="fas fa-edit"></i> Submit Complaint</h2>
                    <p>Help us improve by sharing your issue</p>
                </div>

                <div class="card-body-custom">

                    <label>Complaint Details *</label>
                    <asp:TextBox ID="txtcomplaint"
                        runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine"
                        Rows="4" />

                    <label>Address / Location *</label>
                    <asp:TextBox ID="txtaddress"
                        runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine"
                        Rows="3" />

                  <%--  <label>Department *</label>
                    <asp:DropDownList ID="ddldepartment"
                        runat="server"
                        CssClass="form-control">
                        <asp:ListItem>Select Department</asp:ListItem>
                        <asp:ListItem>CSE</asp:ListItem>
                        <asp:ListItem>IT</asp:ListItem>
                        <asp:ListItem>EXTC</asp:ListItem>
                        <asp:ListItem>Mechanical</asp:ListItem>
                        <asp:ListItem>Civil</asp:ListItem>
                        <asp:ListItem>Administration</asp:ListItem>
                    </asp:DropDownList>--%>

                    <label>Upload Evidence</label>
                    <asp:FileUpload ID="FileUpload_complaint"
                        runat="server"
                        CssClass="form-control" />

                    <asp:Button ID="btnSubmit"
                        runat="server"
                        Text="Submit Complaint"
                        CssClass="btn btn-submit"
                        OnClick="btnSubmit_Click" />

                    <asp:Label ID="lblmsg"
                        runat="server"
                        CssClass="alert-custom"
                        ForeColor="Red" />

                </div>
            </div>

        </div>
    </div>
</div>

</asp:Content>
