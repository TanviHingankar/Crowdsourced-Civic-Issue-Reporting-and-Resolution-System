<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeFile="PwdForget.aspx.cs" Inherits="Registration" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="zxx">

<head>
  <title>College Complaints Box</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="utf-8">
    <meta name="keywords" content="Replenish a Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
    <script>
        addEventListener("load", function () {
            setTimeout(hideURLbar, 0);
        }, false);

        function hideURLbar() {
            window.scrollTo(0, 1);
        }
    </script>
   <%-- <script type="text/javascript" >
        function preventBack() { window.history.forward(); }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
</script>--%>
    <link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
    <link href="css/zoomslider.css" rel='stylesheet' type='text/css' />
    <link href="css/style6.css" rel='stylesheet' type='text/css' />
    <link href="css/style.css" rel='stylesheet' type='text/css' />
    <link href="css/fontawesome-all.css" rel="stylesheet">
    <link href="//fonts.googleapis.com/css?family=Dosis:200,300,400,500,600,700" rel="stylesheet">
    <link href="//fonts.googleapis.com/css?family=Quicksand:300,400,500,700" rel="stylesheet">

    


    <%--<style>
      
      
        h5:hover 
        {
            
            border-bottom: 5px solid blue;
     
     }
      a:hover {
    background-color: Blue;
    color: #FFFFF;
}
 .header {
  padding: 10px 16px;
  background: #555;
  color: #f1f1f1;
}
.sticky {
  position: fixed;
  top: 0;
  width: 100%;
}
.content {
  padding: 16px;
}
.sticky + .content {
  padding-top: 102px;
}
    </style>--%>


</head>

<body>
    <form id="form1" action="" method="post" runat="server">
    <!-- banner-inner -->
    <div>
    
    
        <div style="background-image: none; background-repeat: no-repeat; position: relative; background-color: #1b266d;">
        
        <div class="demo-inner-content">
    <%--<div style="background-image: url('images/1(h).jpg'); background-repeat: no-repeat; position: relative;">--%>
     <nav class="navbar navbar-expand-lg navbar-light">
                        <div class="logo"><%--<img src="images/messnewlogo.png"  />--%>
                           <h1>
                                <a class="navbar-brand" href="#">
                                    College Complaints Box</a>
                            </h1>
                        </div>
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon">
                                    <i class="fas fa-bars"></i>
                                </span>
            
                        </button>

                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav ml-lg-auto text-center">
                                <li class="nav-item active">
                                    <a class="nav-link" href="Default.aspx" style="font-weight: bolder">Home
                                       
                                    </a>
                                </li>
                                 <li class="nav-item">
                                    <a class="nav-link" href="About_us.aspx" style="font-weight: bolder">About Us</a>
                                </li>
                                  <li class="nav-item">
                                    <a class="nav-link" href="Registration.aspx" style="font-weight: bolder">Register</a>
                                </li>
                                <li class="nav-item">
                                
                                     <a href="#" data-toggle="modal" data-target="#exampleModalCenter" class="nav-link" style="font-weight: bolder">
                                    <i class="fas fa-lock"></i>Sign In</a>
                                </li>
                               
                                <li class="nav-item">
                                    
                                     <a href="#" data-toggle="modal" data-target="#Div1" class="nav-link" style="font-weight: bolder">
                                    <i class="fas fa-lock"></i>Admin In</a>
                                </li>
                              
                            </ul>
                            
                        </div>
                    </nav>
                    </div>
                   </div>
          
 
 
                      
    <!-- banner-text -->
    <!-- banner-bottom-wthree -->
    
    <!-- //banner-bottom-wthree -->
    <!--/process-->
    <section class="banner-bottom-wthree pb-lg-5 pb-md-4 pb-3">
        <div class="container">
     
      <div class="inner-sec-w3ls py-lg-5  py-3">
			<!---728x90--->
                
					<!---728x90--->
                <div class="tabs mt-5">
                    <%--<ul class="nav nav-pills my-4" id="pills-tab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">Featured Jobs</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">Recent Jobs</a>
                        </li>

                    </ul>--%>
                    <div class="tab-content" id="pills-tabContent">
                        <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                            <div class="menu-grids mt-4">
                                <div class="row t-in">
                                    <div class="col-lg-8 text-info-sec">
                                        <!--/job1-->
                                         <div align="center"><h5 ><strong style="font-weight: bolder; color: Blue; font-size: 1.5em">Forgot Password </strong></h5></div>
                                          
                                       <div class="main_grid_contact emp-single-page mt-5">
                    <div class="wrapper">
    <div class="contact agileits">
				<div class="contact-agileinfo">
					<div class="contact-form wthree">
						<form id="Form2" action="#" method="post" >
							<div class="">
                                <asp:TextBox ID="txtemail" placeholder=" Enter your email-id" runat="server" required="" class="form-control"></asp:TextBox>
							</div>
                            <br />
							
                          
                      <div >
                           <asp:Button ID="btnSubmit" runat="server" Text="Submit" class="btn btn-primary" 
                               style="width: 200px" onclick="btnSubmit_Click"/>
                           </div>
                           <br />
                           <asp:Label ID="lblmsg" runat="server" ForeColor="#FF3300" Font-Size="Medium" 
                                Font-Bold="True"></asp:Label>
                        
						</form>
					</div>
				
				</div>
			</div>
            </div>
                </div>

                                        <!--//job1-->
                                        <!--/job2-->

                                        <%--<div class="job-post-main row my-3">
                                            <div class="col-md-9 job-post-info text-left">
                                                <div class="job-post-icon">
                                                    <i class="fas fa-briefcase"></i>
                                                </div>
                                                <div class="job-single-sec">
                                                    <h4>
                                                        <a href="#">
                                                            Regional Sales Manager</a>
                                                    </h4>
                                                    <p class="my-2">Company Name goes here</p>
                                                    <ul class="job-list-info d-flex">
                                                        <li>
                                                            <i class="fas fa-briefcase"></i> Comera</li>
                                                        <li>
                                                            <i class="fas fa-map-marker-alt"></i> California</li>
                                                        <li>
                                                            <i class="fas fa-dollar-sign"></i> 300000 - 500000 / Annum</li>
                                                    </ul>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="col-md-3 job-single-time text-right">
                                                <span class="job-time">
                                                    <i class="far fa-heart"></i> Part Time</span>
                                                <a href="#" class="aply-btn ">Appy Now</a>
                                            </div>
                                        </div>--%>
                                        <!--//job2-->
                                        <!--/job3-->

                                        <%--<div class="job-post-main row">
                                            <div class="col-md-9 job-post-info text-left">
                                                <div class="job-post-icon">
                                                    <i class="fas fa-briefcase"></i>
                                                </div>
                                                <div class="job-single-sec">
                                                    <h4>
                                                        <a href="#">
                                                            Web Designer / Developer</a>
                                                    </h4>
                                                    <p class="my-2">Company Name goes here</p>
                                                    <ul class="job-list-info d-flex">
                                                        <li>
                                                            <i class="fas fa-briefcase"></i> Chicago</li>
                                                        <li>
                                                            <i class="fas fa-map-marker-alt"></i> California</li>
                                                        <li>
                                                            <i class="fas fa-dollar-sign"></i> 300000 - 500000 / Annum</li>
                                                    </ul>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="col-md-3 job-single-time text-right">
                                                <span class="job-time">
                                                    <i class="far fa-heart"></i> Full Time</span>
                                                <a href="#" class="aply-btn ">Appy Now</a>
                                            </div>
                                        </div>--%>
                                        <!--//job3-->
                                        <!--/job4-->

                                        <%--<div class="job-post-main row mt-3">
                                            <div class="col-md-9 job-post-info text-left">
                                                <div class="job-post-icon">
                                                    <i class="fas fa-briefcase"></i>
                                                </div>
                                                <div class="job-single-sec">
                                                    <h4>
                                                        <a href="#">
                                                            Marketing Director</a>
                                                    </h4>
                                                    <p class="my-2">Technology Management Consulting</p>
                                                    <ul class="job-list-info d-flex">
                                                        <li>
                                                            <i class="fas fa-briefcase"></i> Rennes</li>
                                                        <li>
                                                            <i class="fas fa-map-marker-alt"></i> France</li>
                                                        <li>
                                                            <i class="fas fa-dollar-sign"></i> 300000 - 500000 / Annum</li>
                                                    </ul>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="col-md-3 job-single-time text-right">
                                                <span class="job-time">
                                                    <i class="far fa-heart"></i> Full Time</span>
                                                <a href="#" class="aply-btn ">Appy Now</a>
                                            </div>
                                        </div>--%>
                                        <!--//job4-->
                                        <!--/job1-->

                                        <%--<div class="job-post-main row mt-3">
                                            <div class="col-md-9 job-post-info text-left">
                                                <div class="job-post-icon">
                                                    <i class="fas fa-briefcase"></i>
                                                </div>
                                                <div class="job-single-sec">
                                                    <h4>
                                                        <a href="#">Developer for Site Maintenance </a>
                                                    </h4>
                                                    <p class="my-2">Company nName gose here</p>
                                                    <ul class="job-list-info d-flex">
                                                        <li>
                                                            <i class="fas fa-briefcase"></i> Comera</li>
                                                        <li>
                                                            <i class="fas fa-map-marker-alt"></i> California</li>
                                                        <li>
                                                            <i class="fas fa-dollar-sign"></i> 300000 - 500000 / Annum</li>
                                                    </ul>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="col-md-3 job-single-time text-right">
                                                <span class="job-time">
                                                    <i class="far fa-heart"></i> Part Time</span>
                                                <a href="#" class="aply-btn ">Appy Now</a>
                                            </div>
                                        </div>--%>
                                        <!--//job1-->
                                        <!--/job2-->

                                        <%--<div class="job-post-main row my-3">
                                            <div class="col-md-9 job-post-info text-left">
                                                <div class="job-post-icon">
                                                    <i class="fas fa-briefcase"></i>
                                                </div>
                                                <div class="job-single-sec">
                                                    <h4>
                                                        <a href="#">
                                                            Content Writer and Speaker</a>
                                                    </h4>
                                                    <p class="my-2">Company Name goes here</p>
                                                    <ul class="job-list-info d-flex">
                                                        <li>
                                                            <i class="fas fa-briefcase"></i> Comera</li>
                                                        <li>
                                                            <i class="fas fa-map-marker-alt"></i> California</li>
                                                        <li>
                                                            <i class="fas fa-dollar-sign"></i> 200000 - 100000 / Annum</li>
                                                    </ul>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="col-md-3 job-single-time text-right">
                                                <span class="job-time">
                                                    <i class="far fa-heart"></i> Part Time</span>
                                                <a href="#" class="aply-btn ">Appy Now</a>
                                            </div>
                                        </div>--%>
                                        <!--//job2-->
                                        <!--/job3-->

                                        <%--<div class="job-post-main row">
                                            <div class="col-md-9 job-post-info text-left">
                                                <div class="job-post-icon">
                                                    <i class="fas fa-briefcase"></i>
                                                </div>
                                                <div class="job-single-sec">
                                                    <h4>
                                                        <a href="#">
                                                            Web Designer / Developer</a>
                                                    </h4>
                                                    <p class="my-2">Company Name goes here</p>
                                                    <ul class="job-list-info d-flex">
                                                        <li>
                                                            <i class="fas fa-briefcase"></i> Chicago</li>
                                                        <li>
                                                            <i class="fas fa-map-marker-alt"></i> California</li>
                                                        <li>
                                                            <i class="fas fa-dollar-sign"></i> 300000 - 500000 / Annum</li>
                                                    </ul>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="col-md-3 job-single-time text-right">
                                                <span class="job-time">
                                                    <i class="far fa-heart"></i> Full Time</span>
                                                <a href="#" class="aply-btn ">Appy Now</a>
                                            </div>
                                        </div>--%>
                                        <!--//job3-->
                                        <!--/job4-->

                                        <%--<div class="job-post-main row mt-3">
                                            <div class="col-md-9 job-post-info text-left">
                                                <div class="job-post-icon">
                                                    <i class="fas fa-briefcase"></i>
                                                </div>
                                                <div class="job-single-sec">
                                                    <h4>
                                                        <a href="#">
                                                            Marketing Director</a>
                                                    </h4>
                                                    <p class="my-2">Technology Management Consulting</p>
                                                    <ul class="job-list-info d-flex">
                                                        <li>
                                                            <i class="fas fa-briefcase"></i> Rennes</li>
                                                        <li>
                                                            <i class="fas fa-map-marker-alt"></i> France</li>
                                                        <li>
                                                            <i class="fas fa-dollar-sign"></i> 300000 - 500000 / Annum</li>
                                                    </ul>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="col-md-3 job-single-time text-right">
                                                <span class="job-time">
                                                    <i class="far fa-heart"></i> Full Time</span>
                                                <a href="#" class="aply-btn ">Appy Now</a>
                                            </div>
                                        </div>--%>
                                        <!--//job4-->
                                    </div>
                                    <div class="col-lg-4 text-info-sec">
                                     <img src="images/1.jpg" alt=" " class="img-fluid" />
                                     <hr />
                                        <img src="images/3.jpg" alt=" " class="img-fluid" />
                                        <hr />
                                        <img src="images/img1.png" alt=" " class="img-fluid" />
                                        <hr />
                                        <img src="images/img2.png" alt=" " class="img-fluid" />
                                        <hr />
                                       
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                            <div class="menu-grids mt-4">
                                <div class="row t-in">
                                    <div class="col-lg-8 text-info-sec">
                                        <!--/job1-->

                                        <!--//job1-->
                                        <!--/job2-->

                                        <!--//job2-->
                                        <!--/job3-->

                                        <!--//job3-->
                                        <!--/job4-->

                                        <!--//job4-->
                                        <!--/job1-->

                                        <!--//job1-->
                                        <!--/job2-->

                                        <!--//job2-->
                                        <!--/job3-->

                                        <!--//job3-->
                                        <!--/job4-->

                                        <!--//job4-->
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--//preocess-->

    <!--job -->

    <!--//job -->
    <!--job -->
   
    <!--//job -->
    <!--/candidates -->
   
    <!--/candidates -->
    <!--/stats-->
   
    <!--//stats-->

    <!--job -->
   
    <!--//job -->
    <!--/mobile-app -->
    
    <!--clients-->
  
    <!--//clients-->
    <!--footer -->
  
    <!-- //footer -->

    <!--model-forms-->
    <!--/Login-->
      <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <div class="login px-4 mx-auto mw-100">
                        <h5 class="text-center mb-4">Login Now</h5>
                        <form action="Login.aspx" method="get">
                            <div class="form-group">
                                <label class="mb-2">User Name</label>
                                <input type="text"  name="txtname" required=""  style="margin-right: 10px; width: 100%" />
                                <%--<input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="" required="">--%>
                               <%-- <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>--%>
                            </div>
                            <div class="form-group">
                                <label class="mb-2">Password</label>
                                <input type="password"  name="txtpwd" required="" style="margin-right: 10px; width: 100%" />
                                <%--<input type="password" class="form-control" id="exampleInputPassword1" placeholder="" required="">--%>
                            </div>
                            <%--<div class="form-check mb-2">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">Check me out</label>
                            </div>--%>
                            <%--<button type="submit" class="btn btn-primary submit mb-4">Sign In</button>--%>
                            <input type="submit" class="btn btn-primary" value="SignIn" />
                            <p class="text-center pb-4">
                                <a href="Registration.aspx"> Don't have an account?</a>
                                <a href="#" data-toggle="modal" data-target="#Div2" class="nav-link" style="font-weight: bolder">Forget Password</a>
                            </p>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!--//Login-->

    <div class="modal fade" id="Div1" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <div class="login px-4 mx-auto mw-100">
                        <h5 class="text-center mb-4">Login Now</h5>
                        <form action="AdminLogin.aspx" method="get">
                            <div class="form-group">
                                <label class="mb-2">User Name</label>
                                <input type="text"  name="txtname" required="" style="margin-right: 10px; width: 100%" />
                                <%--<input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="" required="">--%>
                               <%-- <small id="Small1" class="form-text text-muted">We'll never share your email with anyone else.</small>--%>
                            </div>
                            <div class="form-group">
                                <label class="mb-2">Password</label>
                                <input type="password"  name="txtpwd" required="" style="margin-right: 10px; width: 100%" />
                                <%--<input type="password" class="form-control" id="exampleInputPassword1" placeholder="" required="">--%>
                            </div>
                            <%--<div class="form-check mb-2">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">Check me out</label>
                            </div>--%>
                            <%--<button type="submit" class="btn btn-primary submit mb-4">Sign In</button>--%>
                            <input type="submit" class="btn btn-primary" value="SignIn" />
                           <%-- <p class="text-center pb-4">
                                <a href="Registration.aspx"> Don't have an account?</a>
                            </p>--%>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
    </div>
    <!--//Login-->
    <!--/Forget Password-->
    <div class="modal fade" id="Div2" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header text-center">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <div class="login px-4 mx-auto mw-100">
                        <h5 class="text-center mb-4">Forget Password</h5>
                        <form action="ForgetPassword.aspx" method="get">
                            <div class="form-group">
                                <label class="mb-2">Enter your Email-id</label>
                                <input type="text"  name="txtemail" required="" style="margin-right: 10px; width: 100%" />
                                <%--<input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="" required="">--%>
                               <%-- <small id="Small1" class="form-text text-muted">We'll never share your email with anyone else.</small>--%>
                            </div>
                          <%--  <div class="form-group">
                                <label class="mb-2">Password</label>
                                <input type="password"  name="txtpwd" required="" style="margin-right: 10px; width: 100%" />
                                
                            </div>--%>
                            <%--<div class="form-check mb-2">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">Check me out</label>
                            </div>--%>
                            <%--<button type="submit" class="btn btn-primary submit mb-4">Sign In</button>--%>
                            <input type="submit" class="btn btn-primary" value="Submit" />
                           <%-- <p class="text-center pb-4">
                                <a href="Registration.aspx"> Don't have an account?</a>
                            </p>--%>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!--//Register-->

    <!--//model-form-->
    <!-- js -->
    <!--/slider-->
    <script src="js/jquery-1.11.1.min.js"></script>
    <script src="js/modernizr-2.6.2.min.js"></script>
    <script src="js/jquery.zoomslider.min.js"></script>
    <!--//slider-->
    <!--search jQuery-->
    <script src="js/classie-search.js"></script>
    <script src="js/demo1-search.js"></script>
    <!--//search jQuery-->

    <script>
        $(document).ready(function () {
            $(".dropdown").hover(
                function () {
                    $('.dropdown-menu', this).stop(true, true).slideDown("fast");
                    $(this).toggleClass('open');
                },
                function () {
                    $('.dropdown-menu', this).stop(true, true).slideUp("fast");
                    $(this).toggleClass('open');
                }
            );
        });
    </script>
    <!-- //dropdown nav -->
    <!-- password-script -->
    <script>
        window.onload = function () {
            document.getElementById("password1").onchange = validatePassword;
            document.getElementById("password2").onchange = validatePassword;
        }

        function validatePassword() {
            var pass2 = document.getElementById("password2").value;
            var pass1 = document.getElementById("password1").value;
            if (pass1 != pass2)
                document.getElementById("password2").setCustomValidity("Passwords Don't Match");
            else
                document.getElementById("password2").setCustomValidity('');
            //empty string means no validation error
        }
    </script>
    <!-- //password-script -->

    <!-- stats -->
    <script src="js/jquery.waypoints.min.js"></script>
    <script src="js/jquery.countup.js"></script>
    <script>
        $('.counter').countUp();
    </script>
    <!-- //stats -->

    <!-- //js -->
    <script src="js/bootstrap.js"></script>
    <!--/ start-smoth-scrolling -->
    <script src="js/move-top.js"></script>
    <script src="js/easing.js"></script>
    <script>
        jQuery(document).ready(function ($) {
            $(".scroll").click(function (event) {
                event.preventDefault();
                $('html,body').animate({
                    scrollTop: $(this.hash).offset().top
                }, 900);
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            /*
            var defaults = {
            containerID: 'toTop', // fading element id
            containerHoverID: 'toTopHover', // fading element hover id
            scrollSpeed: 1200,
            easingType: 'linear' 
            };
            */

            $().UItoTop({
                easingType: 'easeOutQuart'
            });

        });
    </script>
    <!--// end-smoth-scrolling -->
    </form>
      <script>
          window.onscroll = function () { myFunction() };

          var header = document.getElementById("myHeader");
          var sticky = header.offsetTop;

          function myFunction() {
              if (window.pageYOffset > sticky) {
                  header.classList.add("sticky");
              } else {
                  header.classList.remove("sticky");
              }
          }
</script>
</body>

</html>
