<%-- 
    Document   : accountInf
    Created on : Feb 15, 2023, 7:03:52 AM
    Author     : QuangQui
--%>

<%@page import="com.models.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/AccountInformation/style.css">
        <title>Account Information</title>
    </head>
    <body>
        <%
            Account ac = (Account) session.getAttribute("Account");
        %>
        <div class="main-content">
            <!-- Top navbar -->
            <nav class="navbar navbar-top navbar-expand-md navbar-dark" id="navbar-main">
                <div class="container-fluid">
                    <!-- Brand -->
                    <a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block"
                       href="https://www.creative-tim.com/product/argon-dashboard" target="_blank">FIVE STORE - ACCOUNT
                        INFORMATION</a>
                    <!-- User -->
                    <ul class="navbar-nav align-items-center d-none d-md-flex">
                        <li class="nav-item dropdown">
                            <a class="nav-link pr-0" href="#" click="false" role="button" data-toggle="dropdown"
                               aria-haspopup="true" aria-expanded="false">
                                <%
                                    if(ac != null) {
                                %>
                                <div class="media align-items-center">
                                    <div class="media-body ml-2 d-none d-lg-block">
                                        <span class="mb-0 text-sm  font-weight-bold"><%=ac.getFullname()%></span>
                                    </div>
                                </div>
                                 <%
                                     } else {
                                %>
                                <div class="media align-items-center">
                                    <div class="media-body ml-2 d-none d-lg-block">
                                        <span class="mb-0 text-sm  font-weight-bold">Null</span>
                                    </div>
                                </div>                              
                                 <%
                                     }
                                %>
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
            <!-- Header -->
            <div class="header pb-8 pt-5 pt-lg-8 d-flex align-items-center"
                 style="background-image: url(https://www.fda.gov/files/DS_Homepage_header%20graphic.jpg); background-size: cover; background-position: center top;">
                <!-- Mask -->
                <span class="mask bg-gradient-default opacity-8"></span>
                <!-- Header container -->
                <div class="container-fluid d-flex align-items-center">
                    <div class="row">
                        <div class="col-lg-7 col-md-10">
<!--                            <h2 class="display-2 text-white">Hello <%=ac.getFullname()%></h2>-->
                            <p class="text-white mt-0">This is your profile page. You can see all information about account and edit them.</p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Page content -->
            <div class="container-fluid mt--7">
                <div class="row">
                    <div class="col-xl-4 order-xl-2 mb-5 mb-xl-0">
                        <div class="card card-profile shadow">
                            <div class="row justify-content-center">
                                <div class="col-lg-3 order-lg-2">
                                    <div class="card-profile-image">
                                        <a href="#">
                                            <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png"
                                                 class="rounded-circle">
                                        </a>
                                    </div>                         
                                </div>
                            </div>
                            <div class="col-lg-3 order-lg-2" style="margin-bottom: 10px; margin-top: 10px;">
                                <div class="d-flex justify-content-between">
                                    <a href="#" class="btn btn-sm btn-info mr-4">ChangePassword</a>
                                </div>
                            </div>
                            <div class="card-body pt-0 pt-md-4">
                                <div class="row">
                                    <div class="col">
                                        <div class="card-profile-stats d-flex justify-content-center mt-md-5 m">
                                            <div>
                                                <span class="heading">0</span>
                                                <span class="description">Ordered</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-center">
                                    <h3>
                                        <%=ac.getFullname()%>
                                    </h3>
                                    <div class="h5 mt-4">
                                        <i class="ni business_briefcase-24 mr-2"></i><%=ac.getEmail()%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-8 order-xl-1">
                        <div class="card bg-secondary shadow">
                            <div class="card-header bg-white border-0">
                                <div class="row align-items-center">
                                    <div class="col-8">
                                        <h3 class="mb-0">My account</h3>
                                    </div>
                                    <div class="col-4 text-right">
                                        <a href="#!" class="btn btn-sm btn-primary">Edit Information</a>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <form>
                                    <h6 class="heading-small text-muted mb-4">Account information</h6>
                                    <div class="pl-lg-4">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group focused">
                                                    <label class="form-control-label" for="input-username">Username</label>
                                                    <input type="text" id="input-username" readonly=""
                                                           class="form-control form-control-alternative" placeholder="Username"
                                                           value="<%=ac.getUsername()%>">
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label class="form-control-label" for="input-email">Email
                                                    </label>
                                                    <input type="email" id="input-email" readonly=""
                                                           class="form-control form-control-alternative"
                                                           placeholder="<%=ac.getEmail()%>">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group focused"> 
                                                    <label class="form-control-label" for="input-first-name">Security Answer</label>
                                                    <input type="text" id="input-first-name" readonly=""
                                                           class="form-control form-control-alternative"
                                                           placeholder="SecurityAnswer" value="<%=ac.getSecurityAnswer()%>">
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="form-group focused">
                                                    <label class="form-control-label" for="input-last-name">Phone Number</label>
                                                    <input type="text" id="input-last-name" readonly
                                                           class="form-control form-control-alternative"
                                                           placeholder="Last name" value="Jesse<%=ac.getPhoneNumber()%>">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group focused">
                                                    <label class="form-control-label" for="input-first-name">Full Name</label>
                                                    <input type="text" id="input-first-name" readonly
                                                           class="form-control form-control-alternative"
                                                           placeholder="Full Name" value="<%=ac.getFullname()%>">
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="form-group focused">
                                                    <label class="form-control-label" for="input-last-name">Gender</label>
                                                    <input type="text" id="input-last-name" readonly=""
                                                           class="form-control form-control-alternative"
                                                           placeholder="Gender" value="<%=ac.getGender()%>">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <footer class="footer">
            <div class="row align-items-center justify-content-xl-between">
                <div class="col-xl-6 m-auto text-center">
                    <div class="copyright">
                        <p>Made </a> by FiveStore</p>
                    </div>
                </div>
            </div>
        </footer>
    </body>
</html>
