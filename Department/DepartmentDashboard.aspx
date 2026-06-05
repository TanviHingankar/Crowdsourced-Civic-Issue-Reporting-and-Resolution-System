<%@ Page Title="" Language="C#" MasterPageFile="~/Department/DepartmentMasterPage.master" AutoEventWireup="true" CodeFile="DepartmentDashboard.aspx.cs" Inherits="Department_DepartmentDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<style>
.dashboard-title {
    font-size: 28px;
    font-weight: 600;
    margin-bottom: 25px;
}

.card-box {
    border-radius: 20px;
    padding: 25px;
    color: white;
    transition: 0.3s;
    backdrop-filter: blur(10px);
}

.card-box:hover {
    transform: translateY(-8px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.4);
}

.card-icon {
    font-size: 35px;
    margin-bottom: 10px;
}

.bg-total {
    background: linear-gradient(135deg, #667eea, #764ba2);
}

.bg-pending {
    background: linear-gradient(135deg, #ff9966, #ff5e62);
}

.bg-progress {
    background: linear-gradient(135deg, #36d1dc, #5b86e5);
}

.bg-resolved {
    background: linear-gradient(135deg, #11998e, #38ef7d);
}

.count-number {
    font-size: 30px;
    font-weight: bold;
}

</style>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="container-fluid">

    <div class="dashboard-title">
        <i class="fas fa-chart-line"></i> Department Dashboard
    </div>

    <div class="row g-4">

        <!-- TOTAL -->
        <div class="col-md-3">
            <div class="card-box bg-total text-center">
                <div class="card-icon">
                    <i class="fas fa-file-alt"></i>
                </div>
                <div>Total Complaints</div>
                <div class="count-number">
                    <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>

        <!-- PENDING -->
        <div class="col-md-3">
            <div class="card-box bg-pending text-center">
                <div class="card-icon">
                    <i class="fas fa-hourglass-half"></i>
                </div>
                <div>Pending Issues</div>
                <div class="count-number">
                    <asp:Label ID="lblPending" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>

        <!-- IN PROGRESS -->
        <div class="col-md-3">
            <div class="card-box bg-progress text-center">
                <div class="card-icon">
                    <i class="fas fa-spinner"></i>
                </div>
                <div>In Progress</div>
                <div class="count-number">
                    <asp:Label ID="lblProgress" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>

        <!-- RESOLVED -->
        <div class="col-md-3">
            <div class="card-box bg-resolved text-center">
                <div class="card-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div>Resolved Issues</div>
                <div class="count-number">
                    <asp:Label ID="lblResolved" runat="server" Text="0"></asp:Label>
                </div>
            </div>
        </div>

    </div>

</div>

</asp:Content>