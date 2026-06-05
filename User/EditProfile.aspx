<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/User/UserMasterPage.master" AutoEventWireup="true" CodeFile="EditProfile.aspx.cs" Inherits="User_EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .card-custom {
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            padding: 30px;
        }
        .form-label {
            font-weight: 600;
        }
        .btn-custom {
            background: #3d5afe;
            color: #fff;
            border: none;
            padding: 8px 20px;
            border-radius: 8px;
        }
        .btn-custom:hover {
            background: #2c46d3;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-5">
        <div class="card card-custom mx-auto" style="max-width:600px;">
            <h3 class="mb-4 text-primary"><i class="fas fa-user-edit me-2"></i>Edit Profile</h3>

            <asp:HiddenField ID="hfUserID" runat="server" />

            <!-- User Name -->
            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <!-- Mobile -->
            <div class="mb-3">
                <label class="form-label">Mobile Number</label>
                <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <!-- Address -->
            <div class="mb-3">
                <label class="form-label">Address</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <!-- Password -->
            <div class="mb-3">
                <label class="form-label">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
            </div>

            <!-- Photo -->
            <div class="mb-3">
                <label class="form-label">Profile Photo</label>
                <asp:FileUpload ID="fuPhoto" runat="server" CssClass="form-control" />
                <br />
                <asp:Image ID="imgPreview" runat="server" Width="120px" Height="120px" CssClass="mt-2" />
            </div>

            <div class="text-center">
                <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-custom" OnClick="btnUpdate_Click" />
            </div>
        </div>
    </div>
</asp:Content>