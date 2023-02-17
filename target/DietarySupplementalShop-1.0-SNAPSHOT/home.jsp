<%-- 
    Document   : home
    Created on : Feb 12, 2023, 11:03:04 AM
    Author     : Tran Trung Kien
--%>

<%@page import="com.models.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FIVESTORE - Home page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/styles/bootstrap4/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/styles/main_styles.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/styles/responsive.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/assets/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/Shopping-Cart/fonts.googleapis.com/css?family=Duru+Sans|Istok+Web">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/Shopping-Cart/css/font-awesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/Shopping-Cart/css/main.css">
        <style>
            #myBtn {
                display: none;
                position: fixed;
                bottom: 10px;
                right: 43px;
                z-index: 99;
                font-size: 18px;
                border: none;
                outline: none;
                background-color: red;
                color: white;
                cursor: pointer;
                padding: 15px;
                border-radius: 4px;
            }
            #myBtn:hover {
                background-color: #555;
            }
        </style>
    </head>
    <body>
        <%
            Account ac = (Account) session.getAttribute("informationAccount");
        %>

        <div class="super_container">
            <!-- Header -->
            <header class="header trans_300">
                <!-- Top Navigation -->
                <div class="top_nav">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="top_nav_left">FIVESTORE - Dietary supplemental shop</div>
                            </div>
                            <div class="col-md-6 text-right">
                                <div class="top_nav_right">
                                    <!--  My Account -->
                                    <li class="account">
                                        <% if (ac != null) {
                                        %>
                                        <a href="#">Hello,<b><%=ac.getFullname()%></b> <i class="fa fa-angle-down"></i></a>
                                        <ul class="account_selection">
                                            <form action="/logout" method="post">
                                                <li>
                                                    <div class="form-group">
                                                        <button type="submit" id="btnSignIn" name="btnSignout"
                                                                class="form-control btn btn-primary rounded submit px-3"
                                                                style="background-color: #9c27b0; color: white"><i class="fa fa-sign-in" aria-hidden="true"></i> Logout</button> </div>
                                                </li>
                                            </form>
                                            <form action="/account" method="post">
                                                <li>
                                                    <div class="form-group">
                                                        <button type="submit" id="btnSignIn" name="btnEditInformation"
                                                                class="form-control btn btn-primary rounded submit px-3"
                                                                style="background-color: #9c27b0; color: white"><i class="fa fa-user-plus" aria-hidden="true"></i> Edit Info</button> </div>
                                                </li>
                                            </form>
                                        </ul>
                                        <%
                                        } else {
                                        %>
                                        <a href="<%= getServletContext().getContextPath()%>/login"><b>LOGIN NOW</b></a>
                                        <%
                                            }
                                        %>
                                    </li>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Navigation -->
                <div class="main_nav_container">
                    <div class="container">
                        <div class="row">
                            <div class="col-lg-12 text-right">
                                <div class="logo_container">
                                    <a href="<%= getServletContext().getContextPath()%>/">FIVESTORE.VN</a>
                                </div>
                                <nav class="navbar">
                                    <ul class="navbar_menu">
                                        <li><a href="<%= getServletContext().getContextPath()%>/">home</a></li>
                                        <li><a href="https://forms.gle/UBkjxzXC4anXkwNC7">contact</a></li>
                                    </ul>
                                    <div class="hamburger_container">
                                        <i class="fa fa-bars" aria-hidden="true"></i>
                                    </div>
                                    <form method="post" action="/Payment"id="f">
                                        <div class="simplecart_area">
                                            <div class="simplecart_cart" style="
                                                 margin-bottom: 10px;">
                                                <span class="showCart">
                                                    <span class="fa fa-shopping-cart"></span>
                                                    <span class="simpleCart_quantity"></span> items - <span class="simpleCart_total"></span>
                                                    <span class="dropdown fa fa-chevron-circle-down"></span>
                                                </span>
                                                <input class="simpleCart_checkout" type="submit" value="Check out" name="btnP" onclick="hihi()"/>
                                                <div id="cartPopover" style="display:none">
                                                    <div class="simpleCart_items"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="text" id="blind" name="blind" value="" hidden="true" />
                                        <input type="text" id="username" name="username" value="" hidden="true" />
                                    </form>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </header

            <!--For mobile-->
            <div class="fs_menu_overlay"></div>
            <div class="hamburger_menu">
                <div class="hamburger_close"><i class="fa fa-times" aria-hidden="true"></i></div>
                <div class="hamburger_menu_content text-right">
                    <ul class="menu_top_nav">
                        <li class="menu_item has-children">
                            <% if (ac != null) {
                            %>

                            <a href="<%= getServletContext().getContextPath()%>/">Hello,<b><%=ac.getFullname()%></b> <i class="fa fa-angle-down"></i></a>
                            <ul class="menu_selection">
                                <li><a href="<%= getServletContext().getContextPath()%>/Login"><i class="fa fa-sign-in" aria-hidden="true"></i>Sign out</a></li>
                                <li><a href="<%= getServletContext().getContextPath()%>/Login/Edit/"><i class="fa fa-user-plus" aria-hidden="true"></i>Edit Info</a></li>
                            </ul>
                            <%
                            } else {
                            %>
                            <a href="<%= getServletContext().getContextPath()%>/login"><b>LOGIN NOW</b></a>
                            <%
                                }%>

                        </li>
                    </ul>
                </div>
            </div>

            <!-- Main Navigation for mobile -->
            <div class="main_nav_container">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12 text-right">
                            <div class="logo_container">
                                <a href="<%= getServletContext().getContextPath()%>/">Group 5 <span>shop</span></a>
                            </div>
                            <nav class="navbar">
                                <ul class="navbar_menu">
                                    <li><a href="<%= getServletContext().getContextPath()%>/">home</a></li>

                                    <li><a href="https://forms.gle/UBkjxzXC4anXkwNC7">contact</a></li>
                                </ul>
                                <ul class="navbar_user">
                                    <li><a href="#"><i class="fa fa-search" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-user" aria-hidden="true"></i></a></li>
                                </ul>
                                <div class="hamburger_container">
                                    <i class="fa fa-bars" aria-hidden="true"></i>
                                </div>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- New Arrivals -->

        <div class="new_arrivals">
            <div class="container">            
                <div class="row align-items-center">
                    <div class="col text-center">
                        <div class="new_arrivals_sorting">
                            <ul class="arrivals_grid_sorting clearfix button-group filters-button-group">
                                <li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center active is-checked" data-filter="*">all</li>
                                <li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".Resistance">Resistance</li>
                                <li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".Sleep">Sleep deprivation</li>
                                <li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".Digestion">Digestion</li>
                                <li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".Liver">Liver</li><!-- comment -->
                                <li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".HighBlood">High Blood Sugar</li><!-- comment -->
                                <li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".Weight">Weight</li><!-- comment -->
                                <li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".Skin">For Skin</li><!-- comment -->
                                <li class="grid_sorting_button button d-flex flex-column justify-content-center align-items-center" data-filter=".Eyes">Eyes</li><!-- comment -->
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="product-grid" data-isotope='{ "itemSelector": ".product-item", "layoutMode": "fitRows" }'>
                            <!-- Product -->

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Deal of the week -->
        <div class="deal_ofthe_week">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <div class="deal_ofthe_week_img">
                            <img src="${pageContext.request.contextPath}/resources/images/favpng_doctors-day-medical-background.png" alt="">
                        </div>
                    </div>
                    <div class="col-lg-6 text-right deal_ofthe_week_col">
                        <div class="deal_ofthe_week_content d-flex flex-column align-items-center float-right">
                            <div class="section_title">
                                <h2>Deal Of The Week</h2>
                            </div>
                            <ul class="timer">
                                <li class="d-inline-flex flex-column justify-content-center align-items-center">
                                    <div id="day" class="timer_num">03</div>
                                    <div class="timer_unit">Day</div>
                                </li>
                                <li class="d-inline-flex flex-column justify-content-center align-items-center">
                                    <div id="hour" class="timer_num">15</div>
                                    <div class="timer_unit">Hours</div>
                                </li>
                                <li class="d-inline-flex flex-column justify-content-center align-items-center">
                                    <div id="minute" class="timer_num">45</div>
                                    <div class="timer_unit">Mins</div>
                                </li>
                                <li class="d-inline-flex flex-column justify-content-center align-items-center">
                                    <div id="second" class="timer_num">23</div>
                                    <div class="timer_unit">Sec</div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>                    
        <!-- Best Sellers -->

        <div class="best_sellers">
            <div class="container">
                <div class="row">
                    <div class="col text-center">
                        <div class="section_title new_arrivals_title">
                            <h2>Best Sellers</h2>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <div class="product_slider_container">
                            <div class="owl-carousel owl-theme product_slider">


                            </div>

                            <!-- Slider Navigation -->

                            <div class="product_slider_nav_left product_slider_nav d-flex align-items-center justify-content-center flex-column">
                                <i class="fa fa-chevron-left" aria-hidden="true"></i>
                            </div>
                            <div class="product_slider_nav_right product_slider_nav d-flex align-items-center justify-content-center flex-column">
                                <i class="fa fa-chevron-right" aria-hidden="true"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>    
        <button onclick="topFunction()" id="myBtn" title="Go to top">TOP</button>
        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="footer_nav_container d-flex flex-sm-row flex-column align-items-center justify-content-lg-start justify-content-center text-center">
                            <ul class="footer_nav">
                                <li><a href="#">Blog</a></li>
                                <li><a href="#">FAQs</a></li>
                                <li><a href="contact.jsp">Contact us</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="footer_social d-flex flex-row align-items-center justify-content-lg-end justify-content-center">
                            <ul>
                                <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-skype" aria-hidden="true"></i></a></li>
                                <li><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="footer_nav_container">
                            <div class="cr"> Template by <a href="#">©Group 1</a></div>                                
                        </div>
                    </div>
                </div>
            </div>
        </footer>
        <!--button on top-->
        <script>
//            $('#f').submit(function (e) {
//                
//            });
        </script>

        <!--Link Java Script-->
        <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/styles/bootstrap4/popper.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/styles/bootstrap4/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/custom.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/Shopping-Cart/js/jquery-1.11.3.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/Shopping-Cart/js/simpleCart.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/Shopping-Cart/js/handlebars.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/Shopping-Cart/js/sheetrock.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/Shopping-Cart/js/main.js"></script>
        <script>
            // When the user scrolls down 20px from the top of the document, show the button
            window.onscroll = function () {
                scrollFunction()
            };
            function scrollFunction() {
                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                    document.getElementById("myBtn").style.display = "block";
                } else {
                    document.getElementById("myBtn").style.display = "none";
                }
            }
            // When the user clicks on the button, scroll to the top of the document
            function topFunction() {
                document.body.scrollTop = 0;
                document.documentElement.scrollTop = 0;
            }
        </script>
    </body>
</html>
