<%@ Page Title="My Feedbacks" Language="C#" MasterPageFile="~/User/UserMasterPage.master" 
    AutoEventWireup="true" CodeFile="ViewMyFeedbacks.aspx.cs" Inherits="User_ViewMyFeedbacks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Card Style */
        .card-custom {
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            padding: 25px;
            margin-top: 20px;
            background: linear-gradient(145deg, #ffffff, #f0f4ff);
        }

        /* Filter Bar */
        .filter-bar {
            margin-bottom: 20px;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            align-items: center;
        }

        .filter-bar .form-control, .filter-bar .form-select {
            min-width: 180px;
        }

        .btn-reset {
            background: #ff4d6d;
            color: #fff;
            border-radius: 10px;
            padding: 5px 15px;
            border: none;
        }

        .btn-reset:hover {
            background: #ff1a3c;
            color: #fff;
        }

        /* GridView Header */
        .table thead th {
            background: linear-gradient(to right, #3d5afe, #00bcd4);
            color: #fff;
            border-radius: 8px;
        }

        /* Star Rating */
        .star-rating {
            color: #FFD700;
            font-size: 16px;
        }

        /* Row hover effect */
        .table-hover tbody tr:hover {
            background: rgba(61, 90, 254, 0.1);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="card card-custom">
            <h3 class="mb-4 text-primary">Your Feedbacks</h3>

            <!-- Filter bar -->
            <div class="filter-bar">
                <input type="text" id="txtSearch" class="form-control" placeholder="Search Comments..." onkeyup="filterTable()" />
                <asp:DropDownList ID="ddlDepartmentFilter" runat="server" CssClass="form-select" AutoPostBack="true" 
                    OnSelectedIndexChanged="ddlDepartmentFilter_SelectedIndexChanged">
                    <asp:ListItem Text="All Departments" Value=""></asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="ddlRatingFilter" runat="server" CssClass="form-select" AutoPostBack="true" 
                    OnSelectedIndexChanged="ddlRatingFilter_SelectedIndexChanged">
                    <asp:ListItem Text="All Ratings" Value=""></asp:ListItem>
                    <asp:ListItem Text="1 Star" Value="1"></asp:ListItem>
                    <asp:ListItem Text="2 Stars" Value="2"></asp:ListItem>
                    <asp:ListItem Text="3 Stars" Value="3"></asp:ListItem>
                    <asp:ListItem Text="4 Stars" Value="4"></asp:ListItem>
                    <asp:ListItem Text="5 Stars" Value="5"></asp:ListItem>
                </asp:DropDownList>
                <button type="button" class="btn-reset" onclick="resetFilters()">Reset Filters</button>
            </div>

            <!-- Desktop Table -->
            <div class="table-responsive d-none d-md-block">
                <asp:GridView ID="gvFeedback" runat="server" CssClass="table table-striped table-hover table-bordered"
                    AutoGenerateColumns="False" EmptyDataText="No feedback submitted yet." GridLines="None">
                    <Columns>
                        <asp:BoundField HeaderText="Feedback ID" DataField="FeedbackID" />
                        <asp:BoundField HeaderText="Issue ID" DataField="IssueID" />
                        <asp:BoundField HeaderText="Department" DataField="DepartmentName" />
                        <asp:TemplateField HeaderText="Rating">
                            <ItemTemplate>
                                <span class="star-rating">
                                    <%# new string('★', Convert.ToInt32(Eval("Rating"))) + new string('☆', 5 - Convert.ToInt32(Eval("Rating"))) %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Comments" DataField="Comments" />
                        <asp:BoundField HeaderText="Feedback Date" DataField="FeedbackDate" DataFormatString="{0:dd/MM/yyyy}" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Mobile Card Layout -->
            <div id="mobileFeedbackCards" class="d-block d-md-none"></div>
        </div>
    </div>

    <script>
        function filterTable() {
            var search = document.getElementById("txtSearch").value.toLowerCase();
            var dept = document.getElementById("<%= ddlDepartmentFilter.ClientID %>").value;
            var rating = document.getElementById("<%= ddlRatingFilter.ClientID %>").value;

            // Render mobile cards dynamically
            var table = document.getElementById("<%= gvFeedback.ClientID %>");
            var cardsContainer = document.getElementById("mobileFeedbackCards");
            cardsContainer.innerHTML = ""; // Clear previous

            for (var i = 1; i < table.rows.length; i++) {
                var row = table.rows[i];
                if (row.style.display === "none") continue;

                var feedbackID = row.cells[0].innerText;
                var issueID = row.cells[1].innerText;
                var department = row.cells[2].innerText;
                var stars = row.cells[3].innerText;
                var comments = row.cells[4].innerText;
                var date = row.cells[5].innerText;

                if ((dept && dept !== department) || (rating && rating !== stars.replace(/★/g,""))) continue;

                var card = document.createElement("div");
                card.className = "card mb-3 p-3";
                card.style.border = "1px solid #ddd";
                card.innerHTML = `
                    <div><strong>Feedback ID:</strong> ${feedbackID}</div>
                    <div><strong>Issue ID:</strong> ${issueID}</div>
                    <div><strong>Department:</strong> ${department}</div>
                    <div><strong>Rating:</strong> <span class="star-rating">${stars}</span></div>
                    <div><strong>Comments:</strong> ${comments}</div>
                    <div><strong>Date:</strong> ${date}</div>
                `;
                cardsContainer.appendChild(card);
            }
        }

        function resetFilters() {
            document.getElementById("txtSearch").value = "";
            document.getElementById("<%= ddlDepartmentFilter.ClientID %>").selectedIndex = 0;
            document.getElementById("<%= ddlRatingFilter.ClientID %>").selectedIndex = 0;
            filterTable();
        }

        // Initial render on page load
        window.onload = filterTable;
    </script>
</asp:Content>