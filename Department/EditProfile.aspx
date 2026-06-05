<%@ Page Title="" Language="C#" MasterPageFile="~/Department/DepartmentMasterPage.master" AutoEventWireup="true" CodeFile="EditProfile.aspx.cs" Inherits="Department_EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <style>
        .form-label { font-weight:600; }
        #map { height:400px; border-radius:10px; }
        .btn-custom { background:#3d5afe; color:white; border-radius:8px; padding:8px 20px; }
        .btn-custom:hover { background:#2c46d3; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid p-4">
        <h4>Edit Department Profile</h4>
        <asp:HiddenField ID="hfDepartmentID" runat="server" />
        <asp:HiddenField ID="hfLatitude" runat="server" />
        <asp:HiddenField ID="hfLongitude" runat="server" />

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Department Name</label>
                <asp:TextBox ID="txtDepartmentName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Department Type</label>
                <asp:DropDownList ID="ddlDepartmentType" runat="server" CssClass="form-select">
                    <asp:ListItem Text="-- Select Type --" Value=""></asp:ListItem>
                    <asp:ListItem>Public Works</asp:ListItem>
                    <asp:ListItem>Electricity</asp:ListItem>
                    <asp:ListItem>Water Supply</asp:ListItem>
                    <asp:ListItem>Sanitation</asp:ListItem>
                    <asp:ListItem>Transport</asp:ListItem>
                    <asp:ListItem>Health</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="col-md-12 mb-3">
                <label class="form-label">Description</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                    <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Department Photo</label>
                <asp:FileUpload ID="fuPhoto" runat="server" CssClass="form-control" />
                <asp:Image ID="imgPreview" runat="server" Height="100px" Margin="5px" />
            </div>

            <div class="col-md-12 mb-3">
                <label class="form-label">Select Location on Map</label>
                <div id="map"></div>
            </div>

            <div class="col-md-12 mb-3">
                <label class="form-label">Full Address</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Contact Number</label>
                <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-12">
                <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-custom" OnClick="btnUpdate_Click" />
            </div>
        </div>
    </div>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var lat = parseFloat('<%= hfLatitude.Value %>') || 20.5937;
            var lng = parseFloat('<%= hfLongitude.Value %>') || 78.9629;

            var map = L.map('map').setView([lat, lng], 5);
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '© OpenStreetMap contributors'
            }).addTo(map);

            var marker = L.marker([lat, lng], { draggable: true }).addTo(map);

            marker.on('dragend', function () {
                updateLocation(marker.getLatLng());
            });

            map.on('click', function (e) {
                marker.setLatLng(e.latlng);
                updateLocation(e.latlng);
            });

            function updateLocation(latlng) {
                document.getElementById('<%= hfLatitude.ClientID %>').value = latlng.lat;
                document.getElementById('<%= hfLongitude.ClientID %>').value = latlng.lng;

                fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lat=${latlng.lat}&lon=${latlng.lng}`)
                    .then(response => response.json())
                    .then(data => {
                        if (data.display_name) {
                            document.getElementById('<%= txtAddress.ClientID %>').value = data.display_name;
                        }
                    });
            }
        });
    </script>
</asp:Content>