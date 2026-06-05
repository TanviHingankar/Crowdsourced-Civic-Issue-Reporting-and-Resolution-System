<%@ Page Language="C#" AutoEventWireup="true"
    MasterPageFile="~/User/UserMasterPage.master"
    CodeFile="Feedback.aspx.cs"
    Inherits="Admin_NewMess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .view
        {
            background-color:chartreuse;
        }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
    <div class="card shadow-sm">
        <div class="card-body">

            <h4 class="text-primary mb-4">Give Feedback</h4>

            <!-- Issue Dropdown -->
            <div class="mb-3">
                <label class="form-label">Select Completed Issue</label>
                <asp:DropDownList ID="ddlIssue" runat="server"
                    CssClass="form-select">
                </asp:DropDownList>
            </div>

            <!-- Rating -->
            <div class="mb-3">
                <label class="form-label">Rating</label>
                <asp:DropDownList ID="ddlRating" runat="server"
                    CssClass="form-select">
                    <asp:ListItem Text="⭐ 1 - Very Bad" Value="1" />
                    <asp:ListItem Text="⭐ 2 - Bad" Value="2" />
                    <asp:ListItem Text="⭐ 3 - Average" Value="3" />
                    <asp:ListItem Text="⭐ 4 - Good" Value="4" />
                    <asp:ListItem Text="⭐ 5 - Excellent" Value="5" />
                </asp:DropDownList>
            </div>

            <!-- Comments -->
            <div class="mb-3">
                <label class="form-label">Comments</label>
                <asp:TextBox ID="txtComments" runat="server"
                    CssClass="form-control"
                    TextMode="MultiLine"
                    Rows="4"></asp:TextBox>
            </div>

            <div class="text-end">
                <asp:Button ID="btnSubmit" runat="server"
                    CssClass="btn btn-success"
                    Text="Submit Feedback"
                    OnClick="btnSubmit_Click" />
            </div>
            <br />
             <div class="text-end">
            <asp:Button ID="btnview" runat="server" Text="View Feeback" class="view" OnClick="btnview_Click"/>
                 </div>
        </div>
    </div>
</div>
</asp:Content>

