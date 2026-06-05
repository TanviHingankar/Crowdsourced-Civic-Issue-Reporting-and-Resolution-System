<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/User/UserMasterPage.master" CodeFile="~/User/My_complaints.aspx.cs" Inherits="TopMess" %>

    


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<%--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet" />--%>

<style>
    body {
        background: #f4f6fb;
    }
    .page-title {
        font-weight: 700;
        color: #1b266d;
    }
    .complaint-card {
        border: none;
        border-radius: 18px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        transition: 0.3s;
    }
    .complaint-card:hover {
        transform: translateY(-5px);
    }
    .complaint-img {
        height: 120px;
        object-fit: cover;
        border-radius: 12px;
    }
    .badge-status {
        font-size: 0.8rem;
        padding: 6px 12px;
        border-radius: 20px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container py-5">

    <!-- PAGE HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="page-title">
            <i class="fas fa-list-check text-primary"></i> My Complaints
        </h2>
        <a href="MakeComplaint.aspx" class="btn btn-primary rounded-pill">
            <i class="fas fa-plus"></i> New Complaint
        </a>
    </div>

    <!-- COMPLAINT LIST -->
    <div class="row g-4">

        <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>

                <div class="col-lg-6">
                    <div class="card complaint-card p-3">

                        <div class="row g-3 align-items-center">
                            
                            <!-- IMAGE -->
                            <div class="col-md-4">
                                <img src="../photos/<%# Eval("photo") %>" 
                                     class="img-fluid complaint-img"
                                     onerror="this.src='../images/no-image.png';" />
                            </div>

                            <!-- DETAILS -->
                            <div class="col-md-8">
                                <h5 class="fw-bold mb-1">
                                    <%# Eval("complaint") %>
                                </h5>

                                <p class="text-muted mb-2">
                                    <i class="fas fa-location-dot text-danger"></i>
                                    <%# Eval("address") %>
                                </p>

                                <span class="badge bg-warning text-dark badge-status">
                                    <%# Eval("status") %>
                                </span>

                                <div class="mt-3">
                                    <a href="Details.aspx?cid=<%# Eval("cid") %>" 
                                       class="btn btn-outline-primary btn-sm rounded-pill">
                                        View Details
                                    </a>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>

            </ItemTemplate>
        </asp:Repeater>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:PeopleComplaintConnectionString %>"
            SelectCommand="SELECT * FROM ComplaintBox WHERE user_id=@user_id">
            <SelectParameters>
                <asp:SessionParameter Name="user_id" SessionField="user_id" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

    </div>
</div>

</asp:Content>

