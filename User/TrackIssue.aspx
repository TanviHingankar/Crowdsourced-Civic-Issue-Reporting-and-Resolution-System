<%@ Page Title="Track Your Issues" Language="C#" MasterPageFile="~/User/UserMasterPage.master" AutoEventWireup="true" CodeFile="TrackIssue.aspx.cs" Inherits="User_TrackIssue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container py-4">

    <h3 class="mb-4 text-primary">Track Your Reported Issues</h3>

    <div class="card shadow-sm mb-4">
        <div class="card-body table-responsive">
            <asp:Repeater ID="rptTrack" runat="server">
                <HeaderTemplate>
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light">
                            <tr>
                              <%--  <th>Photo</th>--%>
                                <th>Issue / Description</th>
                                <th>Location</th>
                                <th>Status</th>
                                <th>Last Action</th>
                                <th>Action Date</th>
                                <td>After Completion Photo</td>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>

                <ItemTemplate>
                    <tr>
                        <%--<td>
                            <asp:Image ID="imgPhoto" runat="server" 
                                ImageUrl='<%# Eval("Photo") %>' 
                                CssClass="img-thumbnail img-fluid" 
                                Width="100px" />
                        </td>--%>
                        <td>
                            <b><%# Eval("Description") %></b><br />
                            <small>Issue ID: <%# Eval("IssueID") %></small>
                        </td>
                        <td><%# Eval("Address") %></td>
                        <td>
                            <span class='<%# GetStatusClass(Eval("Status").ToString()) %>'>
                                <%# Eval("Status") %>
                            </span>
                        </td>
                        <td><%# Eval("Remarks") %></td>
                        <td><%# Eval("ActionDate", "{0:dd-MM-yyyy HH:mm}") %></td>
                       <td>
    <!-- Original Photo -->
    <asp:Image ID="Image1" runat="server"
        ImageUrl='<%# Eval("Photo") %>'
        CssClass="img-thumbnail img-fluid mb-2 zoom-img"
        Width="100px"
        Style="cursor:pointer;" />

    <!-- Show Completion Photo Only If Status = Completed -->
    <asp:Panel runat="server"
        Visible='<%# Eval("Status") != null && Eval("Status").ToString() == "Completed" %>'>
        <br />
        <small class="text-success fw-bold">After Completion:</small><br />

        <asp:Image ID="imgCompletion" runat="server"
            ImageUrl='<%# Eval("CompletionPhoto") %>'
            CssClass="img-thumbnail img-fluid mt-1 zoom-img"
            Width="100px"
            Style="cursor:pointer;" />
    </asp:Panel>
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
    <!-- Image Zoom Modal -->
<div class="modal fade" id="imageModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content bg-transparent border-0">
      <div class="modal-body text-center">
        <img id="modalImage" class="img-fluid rounded shadow" />
      </div>
    </div>
  </div>
</div>
</div>
    <script>
    document.addEventListener("DOMContentLoaded", function () {

        document.querySelectorAll(".zoom-img").forEach(function (img) {

            img.addEventListener("click", function () {

                document.getElementById("modalImage").src = this.src;

                var modal = new bootstrap.Modal(
                    document.getElementById("imageModal")
                );
                modal.show();
            });

        });

    });
    </script>
</asp:Content>