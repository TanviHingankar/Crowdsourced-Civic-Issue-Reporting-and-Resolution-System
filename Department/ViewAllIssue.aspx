<%@ Page Title="" Language="C#" MasterPageFile="~/Department/DepartmentMasterPage.master" 
    AutoEventWireup="true" CodeFile="ViewAllIssue.aspx.cs" Inherits="Department_ViewAllIssue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        @media (max-width:768px){
            .table thead { display:none; }
            .table tbody tr { display:block; margin-bottom:1rem; border:1px solid #dee2e6; border-radius:8px; padding:0.5rem;}
            .table tbody td { display:flex; justify-content:space-between; align-items:center; padding:0.25rem 0.5rem; border:none;}
            .table tbody td:before { content: attr(data-label); font-weight:bold; flex-basis:40%; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <h3 class="mb-4 text-primary">All Department Issues</h3>

        <div class="card shadow-sm mb-4">
            <div class="card-body table-responsive">
                <asp:Repeater ID="rptDepartmentIssues" runat="server">
                    <HeaderTemplate>
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Issue ID</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>

                    <ItemTemplate>
                        <tr>
                            <td data-label="Issue ID"><%# Eval("IssueID") %></td>
                            <td data-label="Description"><%# Eval("Description") %></td>
                            <td data-label="Status">
                                <span class='<%# GetStatusClass(Eval("Status").ToString()) %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </td>
                            <td data-label="Actions">
                                <a href='IssueManagement.aspx?DepartmentID=<%# Eval("DepartmentID") %>' 
                                   class='btn btn-sm btn-primary w-100'>View / Manage</a>
                            </td>
                        </tr>
                    </ItemTemplate>

                    <FooterTemplate>
                            </tbody>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>