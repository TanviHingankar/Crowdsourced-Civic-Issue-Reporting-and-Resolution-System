<%@ Page Title="Home - College Complaints Box" Language="C#" MasterPageFile="~/User/UserMasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="User_Default"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style>
/* Profile Section */
.profile-section {
    text-align: center;
    padding: 20px 10px;
}

.profile-img {
    width: 110px;
    height: 110px;
    border-radius: 50%;
    border: 5px solid #3d5afe;
    object-fit: cover;
}

.profile-name {
    font-size: 20px;
    font-weight: 600;
    margin-top: 10px;
}

.profile-role {
    font-size: 13px;
    color: #777;
}

/* Stats Cards */
.stats-card {
    background: #f8f9fa;
    border-radius: 15px;
    padding: 15px;
    text-align: center;
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
}

.stats-card h4 {
    font-weight: 700;
    color: #3d5afe;
}

.stats-card span {
    font-size: 12px;
    color: #666;
}

/* Badge Cards */
.badge-card {
    background: #ffffff;
    border-radius: 15px;
    padding: 15px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    text-align: center;
}

.badge-icon {
    font-size: 30px;
    color: #00bcd4;
    margin-bottom: 10px;
}

/* Report Item */
.report-item {
    background: #ffffff;
    border-radius: 15px;
    padding: 10px;
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
}

.report-item img {
    width: 55px;
    height: 55px;
    border-radius: 10px;
    object-fit: cover;
    margin-right: 10px;
}

.report-title {
    font-weight: 600;
    font-size: 14px;
}

.report-status {
    font-size: 11px;
    padding: 3px 8px;
    border-radius: 10px;
    color: white;
}

.status-resolved {
    background: #28a745;
}

.status-progress {
    background: #ffc107;
    color: black;
}
</style>
<!-- Profile Section -->
<div class="profile-section">
    
    <asp:Image ID="imgProfile" runat="server" 
        CssClass="profile-img" 
        ImageUrl="~/images/user.jpg" />

    <div class="profile-name">
        <asp:Label ID="lblUsername" runat="server"></asp:Label>
    </div>

    <div class="profile-role">
      Memeber Since  <asp:Label ForeColor="YellowGreen" ID="lblMemberSince" runat="server"></asp:Label>
    </div>

</div>

<!-- Stats Row -->
<div class="row text-center mb-4">
    <div class="col-4">
        <div class="stats-card">
            <h4>42</h4>
            <span>Reports</span>
        </div>
    </div>
    <div class="col-4">
        <div class="stats-card">
            <h4>38</h4>
            <span>Resolved</span>
        </div>
    </div>
    <div class="col-4">
        <div class="stats-card">
            <h4>1.2k</h4>
            <span>Impact</span>
        </div>
    </div>
</div>

<!-- Badges Section -->
<h6 class="mb-3">Badges Earned</h6>

<div class="row mb-4">
    <div class="col-6">
        <div class="badge-card">
            <div class="badge-icon">
                <i class="fas fa-bullhorn"></i>
            </div>
            <div><strong>Active Reporter</strong></div>
            <small class="text-muted">10+ issues reported</small>
        </div>
    </div>

    <div class="col-6">
        <div class="badge-card">
            <div class="badge-icon">
                <i class="fas fa-hands-helping"></i>
            </div>
            <div><strong>Top Helper</strong></div>
            <small class="text-muted">Helped 5 neighbors</small>
        </div>
    </div>
</div>

<!-- My Past Reports -->
<h6 class="mb-3">My Past Reports</h6>

<asp:Repeater ID="rptReports" runat="server">
    <ItemTemplate>
        <div class="report-item">
            <img src='<%# Eval("Photo", "../IssuePhotos/{0}") %>' />

            <div>
                <div class="report-title">
                    <%# Eval("IssueType") %>
                </div>

                <span class='report-status <%# GetStatusClass(Eval("Status").ToString()) %>'>
                    <%# Eval("Status") %>
                </span>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater></asp:Content>