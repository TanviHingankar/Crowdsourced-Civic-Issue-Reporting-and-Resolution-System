<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserDefault.aspx.cs" Inherits="_Default" %>

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
    <script type="text/javascript" >
        function preventBack() { window.history.forward(); }
        setTimeout("preventBack()", 0);
        window.onunload = function () { null };
</script>

</style>


    <link href="../css/bootstrap.css" rel='stylesheet' type='text/css' />
    <link href="../css/zoomslider.css" rel='stylesheet' type='text/css' />
    <link href="../css/style6.css" rel='stylesheet' type='text/css' />
    <link href="../css/style.css" rel='stylesheet' type='text/css' />
    <link href="../css/fontawesome-all.css" rel="stylesheet">
    <link href="//fonts.googleapis.com/css?family=Dosis:200,300,400,500,600,700" rel="stylesheet">
    <link href="//fonts.googleapis.com/css?family=Quicksand:300,400,500,700" rel="stylesheet">
</head>

<body>
    <div id="demo-1" data-zs-src='["../images/1.jpg", "../images/2.jpg","../images/3.jpg", "../images/4.jpg"]' data-zs-overlay="dots">
        
        
        
        <div class="demo-inner-content">
            <div class="header-top" >
                <header>
                    <div class="top-head ml-lg-auto text-center">
                        <div class="row">

                            <div class="col-md-4">
                               
                            </div>
                          
                          
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <nav class="navbar navbar-expand-lg navbar-light">
                        <div class="logo">
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
                                    <a class="nav-link" href="UserDefault.aspx" style="font-weight: bolder">Home
                                    
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="MakeComplaint.aspx" style="font-weight: bolder">Make Complaint</a>
                                </li>
                          <li class="nav-item">
                                    <a class="nav-link" href="My_complaints.aspx" style="font-weight: bolder">My Complaint</a>
                                </li>
                                 <li class="nav-item">
                                    <a class="nav-link" href="All_complaints.aspx" style="font-weight: bolder">All Complaint</a>
                                </li>
                                 <li class="nav-item">
                                    <a class="nav-link" href="Feedback.aspx" style="font-weight: bolder">Feedback</a>
                                </li>
                          <li class="nav-item">
                                    <a class="nav-link" href="logout.aspx" style="font-weight: bolder">LogOut</a>
                                </li>
                               
                               
                            </ul>

                        </div>
                    </nav>
                </header>
            </div>
            
            
            <div class="banner-info-w3layouts text-center">
          
                <h3>
                    <span>College Complaints Box..</span>
               
                </h3>
                <p>Online complaint system.</p>
                 
                 
                 
                
                    </div>
                
            </div>
        </div>
   
    <div>
   
    </div>
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
                                <input type="text" class="form-control" name="txtname" required=""  />
                                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                            </div>
                            <div class="form-group">
                                <label class="mb-2">Password</label>
                                <input type="password" class="form-control" name="txtpwd" required="" />
                            </div>
                            <input type="submit" class="btn btn-primary" value="SignIn" />
                            <p class="text-center pb-4">
                                <a href="Registration.aspx"> Don't have an account?</a>
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
                        <form action="SellerLogin.aspx" method="get">
                            <div class="form-group">
                                <label class="mb-2">User Name</label>
                                <input type="text" class="form-control" name="txtname" required=""  />
                                <small id="Small1" class="form-text text-muted">We'll never share your email with anyone else.</small>
                            </div>
                            <div class="form-group">
                                <label class="mb-2">Password</label>
                                <input type="password" class="form-control" name="txtpwd" required="" />
                            </div>
                            <input type="submit" class="btn btn-primary" value="SignIn" />
                            <p class="text-center pb-4">
                                <a href="Registration.aspx"> Don't have an account?</a>
                            </p>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <script src="../js/jquery-1.11.1.min.js"></script>
    <script src="../js/modernizr-2.6.2.min.js"></script>
    <script src="../js/jquery.zoomslider.min.js"></script>
    <!--//slider-->
    <!--search jQuery-->
    <script src="../js/classie-search.js"></script>
    <script src="../js/demo1-search.js"></script>
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
    <script src="../js/jquery.waypoints.min.js"></script>
    <script src="../js/jquery.countup.js"></script>
    <script>
        $('.counter').countUp();
    </script>
    <!-- //stats -->

    <!-- //js -->
    <script src="../js/bootstrap.js"></script>
    <!--/ start-smoth-scrolling -->
    <script src="../js/move-top.js"></script>
    <script src="../js/easing.js"></script>
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
    <%--</form>--%>
    </body>

</html>
