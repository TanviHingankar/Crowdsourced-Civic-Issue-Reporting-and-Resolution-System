<%@ Page Title="Report Issue" Language="C#" MasterPageFile="~/User/UserMasterPage.master" AutoEventWireup="true" CodeFile="ReportIssue.aspx.cs" Inherits="User_ReportIssue" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <style>
/*        body {
            background: linear-gradient(to right, #e0f7fa, #e1bee7);
            font-family: 'Segoe UI', sans-serif;
        }*/

        .card-custom {
            border-radius: 20px;
            box-shadow: 0 12px 25px rgba(0,0,0,0.15);
            padding: 30px;
            background: #fff;
            transition: all 0.3s ease;
        }
        .card-custom:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }

        .form-label {
            font-weight: 600;
            color: #333;
        }

        .btn-custom {
            background: linear-gradient(135deg,#6a11cb,#2575fc);
            border: none;
            padding: 10px 25px;
            border-radius: 12px;
            color: #fff;
            font-weight: 600;
            transition: 0.3s ease;
        }

        .btn-custom:hover {
            background: linear-gradient(135deg,#2575fc,#6a11cb);
            color: #fff;
        }

        .btn-info {
            background: linear-gradient(135deg,#00c6ff,#0072ff);
            border: none;
            color: #fff;
            font-weight: 600;
            transition: 0.3s ease;
        }
        .btn-info:hover {
            background: linear-gradient(135deg,#0072ff,#00c6ff);
        }

        #video {
            width: 100%;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .modal-content {
            border-radius: 15px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.25);
        }

        .table th {
            background: #6a11cb;
            color: #fff;
            font-weight: 600;
        }
        .table td {
            vertical-align: middle;
        }
        .content-padding-bottom {
    padding-bottom: 120px; /* Height of your fixed bottom navbar + some space */
}
        /* Responsive modal on small devices */
@media (max-width: 576px) {
    .modal-dialog {
        max-width: 95%;
        margin: 1.75rem auto;
    }
    .modal-content {
        font-size: 14px; /* Smaller font for small screens */
    }
    .table th, .table td {
        white-space: nowrap; /* Prevent text wrapping too aggressively */
    }
}
    </style>
<script>
    document.addEventListener("DOMContentLoaded", function () {

        var map = L.map('map').setView([20.5937, 78.9629], 5);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        var marker = L.marker([20.5937, 78.9629], { draggable: true }).addTo(map);

        // When clicking on map
        map.on('click', function (e) {
            marker.setLatLng(e.latlng);
            updateLocation(e.latlng);
        });

        // When dragging marker
        marker.on('dragend', function () {
            updateLocation(marker.getLatLng());
        });

        function updateLocation(latlng) {

            // Save Lat Long in HiddenFields
            document.getElementById('<%= hfLatitude.ClientID %>').value = latlng.lat;
        document.getElementById('<%= hfLongitude.ClientID %>').value = latlng.lng;

        // Reverse Geocoding (Get Address)
        fetch(`https://nominatim.openstreetmap.org/reverse?format=json&lat=${latlng.lat}&lon=${latlng.lng}`)
            .then(response => response.json())
            .then(data => {
                if (data.display_name) {
                    document.getElementById('<%= txtAddress.ClientID %>').value = data.display_name;
                }
            })
            .catch(error => {
                console.log("Error fetching address:", error);
            });
    }

    setTimeout(function () {
        map.invalidateSize();
    }, 500);

});
</script>    
    
    <script type="text/javascript">
    let video, canvas, hfPhoto;

    window.onload = function () {
        video = document.getElementById('video');
        canvas = document.getElementById('canvas');
        hfPhoto = document.getElementById('<%= hfPhoto.ClientID %>');
    };

    function startCamera() {
        navigator.mediaDevices.getUserMedia({ video: true })
            .then(stream => {
                video.srcObject = stream;
                video.play();
            })
            .catch(err => alert("Camera access denied or not available"));
    }

    function capturePhoto() {
        if (!video.srcObject) {
            alert("Please start the camera first!");
            return;
        }
        canvas.width = video.videoWidth;
        canvas.height = video.videoHeight;
        canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);
        let dataURL = canvas.toDataURL("image/png");
        hfPhoto.value = dataURL; // Save Base64 in hidden field

        // Optional: show a preview
        if (!document.getElementById('photoPreview')) {
            let img = document.createElement('img');
            img.id = 'photoPreview';
            img.style.width = '100%';
            img.style.marginTop = '10px';
            document.getElementById('canvas').parentNode.appendChild(img);
        }
        document.getElementById('photoPreview').src = dataURL;
    }
</script></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <div class="container py-5" style="padding-bottom: 120px;">
    <div class="card card-custom mx-auto" style="max-width: 900px;">
            <h3 class="mb-4 text-primary"><i class="fas fa-exclamation-circle me-2"></i> Report Issue</h3>

            <div class="row g-3">
              
<div class="col-md-6">
    <label class="form-label">Enter Address of Issue</label>
    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" 
        placeholder="Type the address of the issue here..."></asp:TextBox>
</div>
                <div class="col-12 mt-3">
    <label class="form-label">Select Location on Map</label>
    <div id="map" style="height:400px; border-radius:15px;"></div>
</div>

<asp:HiddenField ID="hfLatitude" runat="server" />
<asp:HiddenField ID="hfLongitude" runat="server" />
                </div>

                <!-- Department -->
                <div class="col-md-6">
                    <label class="form-label">Select Department</label>
                    <div class="input-group">
                        <asp:DropDownList ID="ddlDepartments" runat="server" CssClass="form-select" AutoPostBack="true" 
                            OnSelectedIndexChanged="ddlDepartments_SelectedIndexChanged">
                            <asp:ListItem Text="-- Select Department --" Value=""></asp:ListItem>
                        </asp:DropDownList>
 <asp:Button ID="btnViewDeptInfo" runat="server" Text="View Info" CssClass="btn btn-info" OnClick="btnViewDeptInfo_Click" />
                     </div>
                </div>

                <!-- Description -->
                <div class="col-12">
                    <label class="form-label">Issue Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"
                        placeholder="Describe the issue here..."></asp:TextBox>
                </div>
         <div class="col-12">
                    <label class="form-label">Issue Type</label>
                    <asp:TextBox ID="txttype" runat="server" CssClass="form-control" TextMode="SingleLine" Rows="4"
                        placeholder="Enter the issue type here..."></asp:TextBox>
                </div>
                <!-- Upload Photo -->
                <div class="col-md-6">
                    <label class="form-label">Upload Photo</label>
                    <asp:FileUpload ID="fuPhoto" runat="server" CssClass="form-control" />
                </div>

                <!-- Capture Live Photo -->
                <div class="col-md-6">
                    <label class="form-label">Capture Live Photo</label>
                    <video id="video" autoplay></video>
                    <canvas id="canvas" style="display:none;"></canvas>
                    <asp:HiddenField ID="hfPhoto" runat="server" />
                    <div class="mt-2 d-flex gap-2">
                        <button type="button" class="btn btn-secondary flex-fill" onclick="startCamera()">Start Camera</button>
                        <button type="button" class="btn btn-primary flex-fill" onclick="capturePhoto()">Capture Photo</button>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="col-12 text-center mt-3">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-custom btn-lg" Text="Report Issue" OnClick="btnSubmit_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Department Info Modal -->
    <div class="modal fade" id="deptInfoModal" tabindex="-1" aria-labelledby="deptInfoModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header bg-primary text-white">
            <h5 class="modal-title" id="deptInfoModalLabel">Department Information</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
<div class="modal-body">
    <!-- Make table responsive -->
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <tr><th>Department Name</th><td id="modalDeptName"></td></tr>
            <tr><th>Type</th><td id="modalDeptType"></td></tr>
            <tr><th>Description</th><td id="modalDeptDesc"></td></tr>
            <tr><th>Status</th><td id="modalDeptStatus"></td></tr>
            <tr><th>Address</th><td id="modalDeptAddress"></td></tr>
            
            <tr><th>Email</th><td id="modalDeptEmail"></td></tr>
        </table>
    </div>
</div>          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
</asp:Content>