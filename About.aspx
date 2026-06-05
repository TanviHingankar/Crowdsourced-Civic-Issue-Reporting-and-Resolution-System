<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="About.aspx.cs" Inherits="About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">

<style>
body {
    font-family: 'Segoe UI', sans-serif;
    background: linear-gradient(135deg, #e3f2fd, #f8f9fa);
}

/* Wrapper */
.about-wrapper {
    max-width: 1000px;
    margin: 40px auto;
    padding: 20px;
}

/* Hero Section */
.about-hero {
    background: linear-gradient(135deg, #18c1d6, #0072ff);
    color: white;
    padding: 50px 30px;
    border-radius: 25px;
    text-align: center;
    box-shadow: 0 20px 40px rgba(0,0,0,0.15);
}

.about-hero h2 {
    font-weight: 700;
}

/* Section Card */
.about-card {
    background: white;
    padding: 30px;
    border-radius: 20px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
    margin-top: 30px;
}

/* Mission Vision */
.mv-card {
    background: #f8f9fa;
    border-radius: 18px;
    padding: 25px;
    text-align: center;
    transition: 0.3s;
}

.mv-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 25px rgba(0,0,0,0.1);
}

/* Icons */
.mv-card i {
    font-size: 30px;
    color: #18c1d6;
    margin-bottom: 10px;
}

/* Features */
.feature-box {
    text-align: center;
    padding: 20px;
}

.feature-box i {
    font-size: 28px;
    color: #0072ff;
    margin-bottom: 10px;
}

/* Team */
.team-card {
    background: white;
    border-radius: 18px;
    padding: 20px;
    text-align: center;
    box-shadow: 0 8px 20px rgba(0,0,0,0.08);
    transition: 0.3s;
}

.team-card:hover {
    transform: translateY(-5px);
}

.team-img {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 10px;
}
</style>


<div class="about-wrapper">

    <!-- Hero -->
    <div class="about-hero">
        <h2>About CivicConnect</h2>
        <p>Empowering citizens to report and track civic issues seamlessly.</p>
    </div>

    <!-- About Description -->
    <div class="about-card text-center">
        <h4>Who We Are</h4>
        <p>
            CivicConnect is a digital civic issue reporting platform that allows citizens 
            to report local problems such as potholes, garbage, streetlight failures, 
            and water supply issues. Our system ensures transparency, faster resolution, 
            and better communication between citizens and authorities.
        </p>
    </div>

    <!-- Mission & Vision -->
    <div class="row mt-4">
        <div class="col-md-6">
            <div class="mv-card">
                <i class="fas fa-bullseye"></i>
                <h5>Our Mission</h5>
                <p>
                    To create a smart and connected city by enabling real-time 
                    reporting and efficient issue resolution.
                </p>
            </div>
        </div>

        <div class="col-md-6">
            <div class="mv-card">
                <i class="fas fa-eye"></i>
                <h5>Our Vision</h5>
                <p>
                    To build a transparent and technology-driven civic 
                    management system for a better tomorrow.
                </p>
            </div>
        </div>
    </div>

    <!-- Features -->
    <div class="about-card mt-4">
        <h4 class="text-center mb-4">Key Features</h4>

        <div class="row">
            <div class="col-md-4 feature-box">
                <i class="fas fa-map-marked-alt"></i>
                <h6>Location-Based Reporting</h6>
                <p>Report issues with accurate location tagging.</p>
            </div>

            <div class="col-md-4 feature-box">
                <i class="fas fa-bell"></i>
                <h6>Status Notifications</h6>
                <p>Receive real-time updates about issue progress.</p>
            </div>

            <div class="col-md-4 feature-box">
                <i class="fas fa-chart-line"></i>
                <h6>Transparent Tracking</h6>
                <p>Track issue resolution from start to finish.</p>
            </div>
        </div>
    </div>

    <!-- Team Section -->
    <div class="about-card mt-4">
        <h4 class="text-center mb-4">Our Team</h4>

        <div class="row text-center">
            <div class="col-md-4">
                <div class="team-card">
                    <img src="images/team1.jpg" class="team-img" />
                    <h6>Project Developer</h6>
                    <small>ASP.NET Developer</small>
                </div>
            </div>

            <div class="col-md-4">
                <div class="team-card">
                    <img src="images/team2.jpg" class="team-img" />
                    <h6>UI/UX Designer</h6>
                    <small>Frontend Specialist</small>
                </div>
            </div>

            <div class="col-md-4">
                <div class="team-card">
                    <img src="images/team3.jpg" class="team-img" />
                    <h6>Database Admin</h6>
                    <small>SQL Server Expert</small>
                </div>
            </div>
        </div>
    </div>

</div>

</asp:Content><asp:Content ID="Content4" ContentPlaceHolderID="Scripts" Runat="Server">
</asp:Content>

