<%@ Page Title="" Language="C#" MasterPageFile="~/Department/DepartmentMasterPage.master" AutoEventWireup="true" CodeFile="ViewFeedback.aspx.cs" Inherits="Department_ViewFeedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
    .feedback-header {
        background: linear-gradient(135deg, #4e73df, #1cc88a);
        color: white;
        padding: 15px;
        border-radius: 10px;
    }

    .rating-stars {
        color: #f6c23e;
        font-size: 18px;
    }

    .feedback-card {
        border-left: 5px solid #4e73df;
        transition: 0.3s;
    }

    .feedback-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    }

    .avg-rating-box {
        background: #f8f9fc;
        border-radius: 10px;
        padding: 15px;
        text-align: center;
    }
    .custom-select-mobile {
    width: 100%;
    height: 48px;
    padding: 10px 15px;
    border-radius: 12px;
    border: 1px solid #4e73df;
    background-color: #ffffff;
    font-size: 15px;
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    box-shadow: 0 3px 8px rgba(0,0,0,0.05);
}

/* Add custom dropdown arrow */


/* Fix mobile zoom issue */
@media (max-width: 576px) {
    .custom-select-mobile {
        font-size: 16px; /* prevents iOS zoom */
    }
}

    .avg-rating-box h2 {
        color: #1cc88a;
        font-weight: bold;
    }
    .form-control {
    height: 45px;
    font-size: 15px;
}

@media (max-width: 576px) {
    .feedback-header h4 {
        font-size: 18px;
    }

    .avg-rating-box h2 {
        font-size: 24px;
    }
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container py-4">

    <div class="card shadow border-0">
        <div class="card-body">

            <!-- Header -->
            <div class="feedback-header mb-4 text-center">
                <h4 class="mb-0">⭐ Department Feedback Overview</h4>
            </div>

            <!-- Dropdown -->
       <!-- Responsive Dropdown Section -->
<asp:DropDownList ID="ddlIssueType" runat="server"
    CssClass="form-control"
    AutoPostBack="true"
    OnSelectedIndexChanged="ddlIssueType_SelectedIndexChanged">
</asp:DropDownList>
            <!-- Average Rating -->
            <div class="avg-rating-box mb-4">
                <h6>Overall Average Rating</h6>
                <h2><asp:Label ID="lblAvgRating" runat="server" Text="0.0" /> ⭐</h2>
            </div>

            <!-- Feedback Repeater -->
            <asp:Repeater ID="rptFeedback" runat="server">
                <ItemTemplate>
                    <div class="card feedback-card mb-3 shadow-sm">
                        <div class="card-body">

                            <!-- Rating -->
                            <div class="rating-stars mb-2">
                                <%# GetStars(Convert.ToInt32(Eval("Rating"))) %>
                            </div>

                            <!-- Comment -->
                            <p class="mb-2 text-dark">
                                <%# Eval("Comments") %>
                            </p>

                            <!-- Date -->
                            <small class="text-muted">
                                🗓 <%# Eval("FeedbackDate", "{0:dd MMM yyyy, hh:mm tt}") %>
                            </small>

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>

</div>
    <script>
    $(document).ready(function () {
        $('#<%= ddlIssueType.ClientID %>').select2({
            width: '100%',
            placeholder: "Select Issue Type",
            allowClear: true
        });
    });
    </script>
    <!-- jQuery (if not already added) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Select2 CSS -->
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

<!-- Select2 JS -->
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
</asp:Content>

