<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">

<style>
body {
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(135deg, #f1f5f9, #e3f2fd);
}

.contact-wrapper {
    max-width: 1000px;
    margin: 40px auto;
    padding: 20px;
}

/* Hero */
.contact-hero {
    background: linear-gradient(135deg, #18c1d6, #0072ff);
    color: white;
    padding: 50px 30px;
    border-radius: 25px;
    text-align: center;
    box-shadow: 0 20px 40px rgba(0,0,0,0.15);
}

/* Info Cards */
.contact-card {
    background: white;
    padding: 30px;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    text-align: center;
    transition: 0.3s;
}

.contact-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.12);
}

.contact-card i {
    font-size: 28px;
    color: #18c1d6;
    margin-bottom: 10px;
}

/* Map */
.map-box iframe {
    width: 100%;
    height: 300px;
    border-radius: 20px;
    border: none;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
}

/* Social */
.social-icons i {
    font-size: 20px;
    margin: 0 10px;
    color: #0072ff;
    transition: 0.3s;
}

.social-icons i:hover {
    color: #18c1d6;
    transform: scale(1.2);
}
</style>


<div class="contact-wrapper">

    <!-- Hero -->
    <div class="contact-hero">
        <h2>Contact Us</h2>
        <p>We’re here to help and answer any questions you might have.</p>
    </div>

    <!-- Contact Info -->
    <div class="row mt-4">

        <div class="col-md-4 mb-3">
            <div class="contact-card">
                <i class="fas fa-map-marker-alt"></i>
                <h5>Our Office</h5>
                <p>Nagpur, Maharashtra<br />India</p>
            </div>
        </div>

        <div class="col-md-4 mb-3">
            <div class="contact-card">
                <i class="fas fa-phone-alt"></i>
                <h5>Call Us</h5>
                <p>+91 98765 43210<br />Mon – Fri, 9AM – 6PM</p>
            </div>
        </div>

        <div class="col-md-4 mb-3">
            <div class="contact-card">
                <i class="fas fa-envelope"></i>
                <h5>Email</h5>
                <p>support@civicconnect.com<br />info@civicconnect.com</p>
            </div>
        </div>

    </div>

    <!-- Map Section -->
   <%-- <div class="mt-4">
        <h4 class="text-center mb-3">Find Us On Map</h4>
        <div class="map-box">
            <iframe 
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3721.493893!2d79.0882!3d21.1458"
                allowfullscreen="">
            </iframe>
        </div>
    </div>--%>

    <!-- Social Media -->
    <div class="text-center mt-4">
        <h5>Connect With Us</h5>
        <div class="social-icons mt-2">
            <i class="fab fa-facebook-f"></i>
            <i class="fab fa-twitter"></i>
            <i class="fab fa-instagram"></i>
            <i class="fab fa-linkedin-in"></i>
        </div>
    </div>

</div>

</asp:Content><asp:Content ID="Content4" ContentPlaceHolderID="Scripts" Runat="Server">
</asp:Content>

