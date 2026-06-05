<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AboutUs.aspx.cs" Inherits="AboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
     <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1e40af;
            --accent-color: #3b82f6;
            --dark-bg: #0f172a;
            --light-bg: #f8fafc;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
              background: 
        linear-gradient(rgba(0,0,0,0.55), rgba(0,0,0,0.55)),
        url('images/city.png');
            overflow-x: hidden;
        }

        /* Navigation */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color) !important;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .navbar-brand i {
            font-size: 2rem;
        }

        .nav-link {
            color: white !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            transition: all 0.3s ease;
            position: relative;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            width: 0;
            height: 2px;
            background: var(--primary-color);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .nav-link:hover::after,
        .nav-link.active::after {
            width: 80%;
        }

        .nav-link:hover,
        .nav-link.active {
            color: var(--primary-color) !important;
        }

        .btn-nav {
            padding: 0.5rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-signin {
            background: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
        }

        .btn-signin:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(37, 99, 235, 0.3);
        }

        /* Hero Header */
        .about-hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 5rem 0 3rem;
            color: white;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .about-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 20% 50%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            animation: pulse 15s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .about-hero h1 {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 1rem;
            position: relative;
            z-index: 10;
        }

        .about-hero p {
            font-size: 1.3rem;
            opacity: 0.95;
            position: relative;
            z-index: 10;
        }

        /* Content Section */
        .content-section {
            padding: 4rem 0;
        }

        .content-card {
            background: white;
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
        }

        .section-heading {
            font-size: 2rem;
            font-weight: 700;
            color: var(--dark-bg);
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .section-heading i {
            color: var(--primary-color);
            font-size: 2.5rem;
        }

        .content-text {
            font-size: 1.1rem;
            line-height: 1.8;
            color: #475569;
            margin-bottom: 1.5rem;
            text-align: justify;
        }

        /* Steps Section */
        .steps-section {
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            padding: 3rem;
            border-radius: 20px;
            margin: 2rem 0;
        }

        .step-item {
            display: flex;
            align-items: start;
            gap: 1.5rem;
            padding: 1.5rem;
            background: white;
            border-radius: 15px;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .step-item:hover {
            transform: translateX(10px);
            box-shadow: 0 10px 30px rgba(37, 99, 235, 0.15);
        }

        .step-icon {
            min-width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            font-weight: 700;
        }

        .step-content {
            flex: 1;
        }

        .step-content h4 {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-bg);
            margin-bottom: 0.5rem;
        }

        .step-content p {
            color: #64748b;
            margin: 0;
        }

        /* Why Use Section */
        .why-use-section {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 3rem;
            border-radius: 20px;
            margin: 2rem 0;
        }

        .why-use-section h3 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .why-use-section p {
            font-size: 1.1rem;
            line-height: 1.8;
        }

        /* Notice Section */
        .notice-section {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            padding: 3rem;
            border-radius: 20px;
            border: 3px solid #ef4444;
        }

        .notice-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .notice-header i {
            font-size: 3rem;
            color: #dc2626;
        }

        .notice-header h3 {
            font-size: 2rem;
            font-weight: 700;
            color: #991b1b;
            margin: 0;
        }

        .notice-item {
            display: flex;
            align-items: start;
            gap: 1rem;
            padding: 1rem;
            background: white;
            border-radius: 10px;
            margin-bottom: 0.75rem;
            border-left: 4px solid #dc2626;
        }

        .notice-item i {
            color: #dc2626;
            font-size: 1.2rem;
            margin-top: 0.2rem;
        }

        .notice-item p {
            color: #1f2937;
            font-weight: 600;
            margin: 0;
        }

        /* Features Grid */
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin: 3rem 0;
        }

        .feature-box {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
        }

        .feature-box:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(37, 99, 235, 0.15);
        }

        .feature-box i {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .feature-box h4 {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--dark-bg);
            margin-bottom: 0.75rem;
        }

        .feature-box p {
            color: #64748b;
            margin: 0;
        }

        /* Modal Styling */
        .modal-content {
            border-radius: 20px;
            border: none;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
        }

        .modal-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 20px 20px 0 0;
            padding: 1.5rem 2rem;
        }

        .modal-title {
            font-weight: 700;
            font-size: 1.5rem;
        }

        .btn-close {
            filter: brightness(0) invert(1);
        }

        .modal-body {
            padding: 2.5rem;
        }

        .form-label {
            font-weight: 600;
            color: var(--dark-bg);
            margin-bottom: 0.5rem;
        }

        .form-control {
            border-radius: 12px;
            border: 2px solid #e2e8f0;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(37, 99, 235, 0.1);
        }

        .btn-submit {
            width: 100%;
            padding: 0.875rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            font-weight: 600;
            margin-top: 1rem;
            transition: all 0.3s ease;
            color: white;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .about-hero h1 {
                font-size: 2rem;
            }

            .content-card {
                padding: 2rem 1.5rem;
            }

            .step-item {
                flex-direction: column;
                text-align: center;
            }

            .step-icon {
                margin: 0 auto;
            }
        }
    </style>
        <!-- Navigation -->
      
        <!-- Hero Section -->
        <div class="about-hero">
            <div class="container">
                <h1><i class="fas fa-info-circle"></i> About Our System</h1>
                <p>Learn how we're revolutionizing complaint management in educational institutions</p>
            </div>
        </div>

        <!-- Main Content -->
        <div class="content-section">
            <div class="container">
                <!-- Introduction -->
                <div class="content-card">
                    <h2 class="section-heading">
                        <i class="fas fa-bullseye"></i>
                        Our Mission
                    </h2>
                    <p class="content-text">
                        Handling too many complaints can be irritating. And, if 'some' complaints are not handled properly, they become 'many'. 
                        Our 'Complaint Management System' is one such tool and a perfect solution for managing all the queries and complaints 
                        regarding the organization/institute. One can implement the same concept in any company, offices, area or society.
                    </p>
                    <p class="content-text">
                        It is quite a simple system which anyone can easily use without any difficulties - only a few steps you have to follow. 
                        So, here we are providing some steps one will have to follow when using this complaint management system for the first time.
                    </p>
                </div>

                <!-- How It Works -->
                <div class="content-card">
                    <h2 class="section-heading">
                        <i class="fas fa-cogs"></i>
                        How It Works
                    </h2>
                    
                    <div class="steps-section">
                        <div class="step-item">
                            <div class="step-icon">1</div>
                            <div class="step-content">
                                <h4>Register Your Account</h4>
                                <p>If you are a new user, first register yourself with your valid credentials.</p>
                            </div>
                        </div>

                        <div class="step-item">
                            <div class="step-icon">2</div>
                            <div class="step-content">
                                <h4>Remember Your Credentials</h4>
                                <p>Keep your User ID and password safe. You'll need them for login access.</p>
                            </div>
                        </div>

                        <div class="step-item">
                            <div class="step-icon">3</div>
                            <div class="step-content">
                                <h4>Submit Your Complaint</h4>
                                <p>Use the complaint option to submit your request with supporting photographs if needed.</p>
                            </div>
                        </div>

                        <div class="step-item">
                            <div class="step-icon">4</div>
                            <div class="step-content">
                                <h4>Track Status</h4>
                                <p>Monitor your complaint status in real-time and receive updates on resolution progress.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Features -->
                <div class="content-card">
                    <h2 class="section-heading">
                        <i class="fas fa-star"></i>
                        Key Features
                    </h2>
                    
                    <div class="features-grid">
                        <div class="feature-box">
                            <i class="fas fa-mobile-alt"></i>
                            <h4>Mobile Accessible</h4>
                            <p>Lodge complaints from anywhere using your mobile phone or PC/laptop.</p>
                        </div>

                        <div class="feature-box">
                            <i class="fas fa-clock"></i>
                            <h4>Real-Time Tracking</h4>
                            <p>Track complaint status and receive instant updates on resolution progress.</p>
                        </div>

                        <div class="feature-box">
                            <i class="fas fa-shield-alt"></i>
                            <h4>Secure Process</h4>
                            <p>Industry-standard security ensures your data and complaints remain protected.</p>
                        </div>

                        <div class="feature-box">
                            <i class="fas fa-chart-line"></i>
                            <h4>Performance Analytics</h4>
                            <p>Help organizations track and improve their complaint resolution efficiency.</p>
                        </div>

                        <div class="feature-box">
                            <i class="fas fa-comments"></i>
                            <h4>Feedback System</h4>
                            <p>Provide valuable feedback to help improve institutional services and environment.</p>
                        </div>

                        <div class="feature-box">
                            <i class="fas fa-users"></i>
                            <h4>User-Friendly</h4>
                            <p>Simple, intuitive interface that anyone can use without technical knowledge.</p>
                        </div>
                    </div>
                </div>

                <!-- Why Use This -->
                <div class="why-use-section">
                    <h3><i class="fas fa-question-circle"></i> Why Use Our System?</h3>
                    <p>
                        The better you handle your employees'/students'/customer's complaints and queries, the more they'll be satisfied, 
                        and hence your institute's atmosphere will undoubtedly enhance multiple times. This system provides a secure and 
                        flawless process for managing all types of institutional concerns.
                    </p>
                    <p class="mb-0">
                        Complaint management system helps any organization increase performance and create an efficient environment. 
                        It helps you handle questions raised by employees, users, or students effectively, boosting the chances of 
                        meeting their expectations and building a stronger community.
                    </p>
                </div>

                <!-- Notice Section -->
                <div class="notice-section">
                    <div class="notice-header">
                        <i class="fas fa-exclamation-triangle"></i>
                        <h3>Important Notice</h3>
                    </div>

                    <div class="notice-item">
                        <i class="fas fa-user-check"></i>
                        <p>Only authorized users can access the system</p>
                    </div>

                    <div class="notice-item">
                        <i class="fas fa-ban"></i>
                        <p>Repeated complaints will not be accepted</p>
                    </div>

                    <div class="notice-item">
                        <i class="fas fa-list"></i>
                        <p>Always check the complaint list before posting your complaint</p>
                    </div>

                    <div class="notice-item">
                        <i class="fas fa-camera"></i>
                        <p>Proper and clear photographs should be uploaded for better resolution</p>
                    </div>

                    <div class="notice-item">
                        <i class="fas fa-gavel"></i>
                        <p>If any improper content is noticed, strict action will be taken by authorities</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Student Login Modal -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>

