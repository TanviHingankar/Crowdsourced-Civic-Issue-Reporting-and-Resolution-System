<%@ Page Title="" Language="C#" MasterPageFile="~/Department/DepartmentMasterPage.master" 
    AutoEventWireup="true" CodeFile="IssueManagement.aspx.cs" Inherits="Department_IssueManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <style>
        /* Mobile-friendly table -> card layout */
        @media (max-width: 768px){
            table.table thead { display:none; }
            table.table tbody tr { display:block; margin-bottom:1rem; border:1px solid #dee2e6; border-radius:8px; padding:0.5rem; }
            table.table tbody td { display:block; border:none; padding:0.25rem 0; }
            table.table tbody td[data-label]::before { content: attr(data-label) ": "; font-weight:bold; }
        }

        .issue-map { width: 100%; height: 200px; min-height: 150px; margin-top:5px; }
        .zoomable-img { max-width:150px; cursor:pointer; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container py-4">
        <h3 class="mb-4 text-primary">Department Issues Dashboard</h3>

        <div class="card shadow-sm mb-4">
            <div class="card-body table-responsive">
                <asp:Repeater ID="rptIssues" runat="server">
                    <HeaderTemplate>
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th>Photo</th>
                                    <th>Description</th>
                                    <th>Location</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                    </HeaderTemplate>

                    <ItemTemplate>
                        <tr>
                            <!-- Photo -->
                            <td data-label="Photo">
                                <img runat="server"
                                     src='<%# ResolveUrl(Eval("Photo").ToString()) %>' 
                                     class="img-thumbnail img-fluid zoomable-img"
                                     data-bs-toggle="modal" 
                                     data-bs-target="#imageModal"
                                     data-bs-src='<%# ResolveUrl(Eval("Photo").ToString()) %>' />
                            </td>

                            <!-- Description -->
                            <td data-label="Description">
                                <b><%# Eval("Description") %></b>
                            </td>

                            <!-- Location -->
                            <td data-label="Location">
                                <div class="issue-location" 
                                     data-lat='<%# Eval("Latitude") %>' 
                                     data-lng='<%# Eval("Longitude") %>'>
                                     <%# Eval("Address") %>
                                </div>
                                <div id="map-<%# Eval("IssueID") %>" class="issue-map"></div>
                            </td>

                            <!-- Status -->
                            <td data-label="Status">
                                <span class='<%# GetStatusClass(Eval("Status").ToString()) %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </td>

                            <!-- Actions -->
                            <td data-label="Actions">
                                <a href='TakeAction.aspx?issueID=<%# Eval("IssueID") %>' 
                                   class='btn btn-sm btn-info mb-1 w-100'>Take Action</a>
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

    <!-- Image Zoom Modal -->
    <div class="modal fade" id="imageModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content bg-transparent border-0">
                <div class="modal-body p-0 text-center">
                    <img id="modalImage" src="" class="img-fluid" style="max-height:80vh;" />
                </div>
            </div>
        </div>
    </div>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelectorAll('.issue-location').forEach(function (elem) {
                var lat = parseFloat(elem.getAttribute('data-lat'));
                var lng = parseFloat(elem.getAttribute('data-lng'));
                var mapDiv = elem.nextElementSibling; // the div after span

                if (lat && lng && mapDiv) {
                    var map = L.map(mapDiv, { scrollWheelZoom: false }).setView([lat, lng], 15);
                    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                        maxZoom: 19,
                        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
                    }).addTo(map);
                    L.marker([lat, lng]).addTo(map)
                        .bindPopup(elem.textContent)
                        .openPopup();

                    // Force Leaflet to recalc size after render (fix mobile issue)
                    setTimeout(function () { map.invalidateSize(); }, 200);
                }
            });

            // Image modal
            var imageModal = document.getElementById('imageModal');
            imageModal.addEventListener('show.bs.modal', function (event) {
                var button = event.relatedTarget;
                var src = button.getAttribute('data-bs-src');
                document.getElementById('modalImage').src = src;
            });
        });
    </script>
</asp:Content>