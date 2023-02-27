<%-- 
    Document   : accountInf
    Created on : Feb 15, 2023, 7:03:52 AM
    Author     : QuangQui
--%>

<%@page import="com.daos.AccountDAO"%>
<%@page import="com.models.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/css/accountinformation.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
        <title>Account Information</title>
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />
    </head>
    <body>
        <%
            Account ac = (Account) session.getAttribute("informationAccount");
            String mess = (String) request.getAttribute("mess");
            String mess1 = (String) request.getAttribute("mess1");
            AccountDAO dao = new AccountDAO();
            int ordered = dao.getOrdered(ac.getUsername());
        %>
        <div class="main-content">
            <!-- Top navbar -->
            <nav class="navbar navbar-top navbar-expand-md navbar-dark" id="navbar-main">
                <div class="container-fluid">
                    <!-- Brand -->
                    <a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block"
                       href="/">FIVE STORE - ACCOUNT
                        INFORMATION</a>
                    <!-- User -->
                    <ul class="navbar-nav align-items-center d-none d-md-flex">
                        <li class="nav-item dropdown">
                            <a class="nav-link pr-0" href="#" click="false" role="button" data-toggle="dropdown"
                               aria-haspopup="true" aria-expanded="false">
                                <%
                                    if (ac != null) {
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
                 style="background-image: url(https://www.fda.gov/files/DS_Homepage_header%20graphic.jpg); background-size: cover; background-position: center;">
                <!-- Mask -->
                <span class="mask bg-gradient-default opacity-8"></span>
                <!-- Header container -->
                <div class="container-fluid d-flex align-items-center">
                    <div class="row">
                        <div class="col-lg-7 col-md-10">
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
                                        <%
                                            if (ac.getGender().equalsIgnoreCase("Male")) {
                                        %>
                                        <a href="#">
                                            <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png"
                                                 class="rounded-circle">
                                        </a>
                                        <%
                                        } else {
                                        %>
                                        <a href="#">
                                            <img src="https://i.pinimg.com/564x/a6/58/32/a65832155622ac173337874f02b218fb--people-icon-avatar.jpg"
                                                 class="rounded-circle">
                                        </a>
                                        <%
                                            }
                                        %>
                                    </div>                         
                                </div>
                            </div>


                            <div class="card-body pt-0 pt-md-4">
                                <div class="row">
                                    <div class="col">
                                        <div class="card-profile-stats d-flex justify-content-center mt-md-5 m">
                                            <div>
                                                <%
                                                    if (ordered != 0) {
                                                %>
                                                <span class="heading"><%=ordered%></span>
                                                <%
                                                } else {
                                                %>
                                                <span class="heading">0</span>
                                                <%
                                                    }
                                                %>
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
                                <form id="form-2" action="/account" method="post">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group focused">
                                                <label class="form-control-label" for="input-username">Current Password</label>
                                                <input type="password" id="input-oldpassword" 
                                                       name="oldpassword" 
                                                       readonly
                                                       class="form-control form-control-alternative editable" 
                                                       placeholder="Enter current password!"
                                                       >
                                                <input type="text"
                                                       name="username" 
                                                       hidden
                                                       value="<%=ac.getUsername()%>"
                                                       >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group focused">
                                                <label class="form-control-label" for="input-username">New Password</label>
                                                <input type="password" id="input-newpassword"
                                                       name="password" 
                                                       readonly
                                                       class="form-control form-control-alternative editable"
                                                       placeholder="Enter new password!"
                                                       >

                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group focused">
                                                <label class="form-control-label" for="input-username">Confirm Password</label>
                                                <input type="password" id="input-confirmpassword" 
                                                       name="confirmpassword" 
                                                       readonly
                                                       class="form-control form-control-alternative editable" 
                                                       placeholder="Enter again!"
                                                       >
                                            </div>
                                        </div>
                                    </div>
                                    <%
                                        if (mess != null) {
                                    %>
                                    <div class="row" >
                                        <div class="col-lg-12" style="margin-left: 15px; margin-bottom: 15px;">
                                            <span id="regError" data-my-attribute="<%= mess%>"></span>
                                        </div>          
                                    </div>
                                    <%
                                    } else {

                                    %>
                                    <div class="row" >
                                        <div class="col-lg-12" style="margin-left: 15px; margin-bottom: 15px;">
                                            <span id="regError" data-my-attribute=""></span>
                                        </div>          
                                    </div>
                                    <%                                        }

                                    %>
                                    <div style="display: flex">
                                        <div>
                                            <button class="btn btn-sm btn-info mr-4" 
                                                    type="button" id="edit-pass-button">Change Password</button> 
                                        </div>
                                        <button class="btn btn-sm btn-info mr-4" 
                                                type="submit" 
                                                style="display: none" 
                                                id="submit-pass-button" 
                                                name="btnChangePassword">
                                            Change
                                        </button>
                                        <input type="hidden" name="btnChangePassword" value="true">
                                    </div>
                                </form>

                                <form action="/logout" method="post">
                                    <button class="btn btn-sm" style="background-color: red; color: white; margin-top: 20px" 
                                            type="submit" name="btnSignout">Logout</button>
                                </form>
                            </div>
                        </div>

                    </div>
                    <div class="col-xl-8 order-xl-1">
                        <form id="form-1" action="/account" method="post">
                            <div class="card bg-secondary shadow">
                                <div class="card-header bg-white border-0">
                                    <div class="row align-items-center">
                                        <div class="col-8">
                                            <h3 class="mb-0">My account</h3>
                                        </div>
                                        <div class="col-4 text-right">
                                            <button class="btn btn-sm btn-primary" type="button" id="edit-button">Edit Information</button> 
                                            <input type="hidden" name="btnUpdate" value="true">
                                            <button class="btn btn-sm btn-primary" type="submit" style="display: none" id="submit-button" name="btnUpdate" onclick="return update()">Submit Information</button> 
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <h6 class="heading-small text-muted mb-4">Account information</h6>
                                    <div class="pl-lg-4">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group focused">
                                                    <label class="form-control-label" for="input-username">Username</label>
                                                    <input type="text" id="input-username" name="username" readonly
                                                           class="form-control form-control-alternative" placeholder="Username"
                                                           value="<%=ac.getUsername()%>">
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="form-group focused">
                                                    <label class="form-control-label" for="input-username">Email</label>
                                                    <input type="text" id="email" name="Email" readonly
                                                           class="form-control form-control-alternative editable" placeholder="Username"
                                                           value="<%=ac.getEmail()%>">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group focused"> 
                                                    <label class="form-control-label" for="input-first-name">Security Answer</label>
                                                    <input type="text" id="SecurityAnswer" name="SecurityAnswer" readonly
                                                           class="form-control form-control-alternative editable"
                                                           placeholder="SecurityAnswer" value="<%=ac.getSecurityAnswer()%>">
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="form-group focused">
                                                    <label class="form-control-label" for="input-last-name">Phone Number</label>
                                                    <input type="text" id="phone" name="phone" readonly
                                                           class="form-control form-control-alternative editable"
                                                           placeholder="Last name" value="0<%=ac.getPhoneNumber()%>">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group focused">
                                                    <label class="form-control-label" for="input-first-name">Full Name</label>
                                                    <input type="text" id="fullname" name="fullname" readonly
                                                           class="form-control form-control-alternative editable"
                                                           placeholder="Full Name" value="<%=ac.getFullname()%>">
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <label class="form-control-label" for="input-first-name">Gender</label>
                                                <%
                                                    if (ac.getGender().equalsIgnoreCase("Male")) {
                                                %>
                                                <div class="form-group">
                                                    <div class="radio-group">
                                                        <input type="radio" name="gender" value="Male" readonly id="Gender" style="margin-left: 30px" checked>
                                                        <label for="genderMale">Male</label>
                                                    </div>
                                                    <div class="radio-group">
                                                        <input type="radio" name="gender" value="Female" readonly id="Gender" style="margin-left: 30px" >
                                                        <label for="genderFemale">Female</label>
                                                    </div>
                                                </div>
                                                <%
                                                } else {
                                                %>
                                                <div class="form-group">
                                                    <div class="radio-group">
                                                        <input type="radio" name="gender" value="Male" readonly id="Gender" style="margin-left: 30px" >
                                                        <label for="genderMale">Male</label>
                                                    </div>
                                                    <div class="radio-group">
                                                        <input type="radio" name="gender" value="Female" readonly id="Gender" style="margin-left: 30px"checked>
                                                        <label for="genderFemale">Female</label>
                                                    </div>
                                                </div>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <%                                                if (mess1 != null) {
                                        %>

                                        <span id="" data-my-attribute="my-value"></span>
                                        <div class="row" >
                                            <div class="col-lg-12" style="margin-left: 15px; margin-bottom: 15px;">
                                                <span id="regError1" data-my-attribute="<%= mess1%>"> </span>
                                            </div>          
                                        </div>
                                        <%
                                        } else {

                                        %>
                                        <div class="row" >
                                            <div class="col-lg-12" style="margin-left: 15px; margin-bottom: 15px;">
                                                <span id="regError1" data-my-attribute=""></span>
                                            </div>          
                                        </div>
                                        <%                                                }
                                        %>
                                    </div>
                                </div>
                        </form>        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="toast">


    </div>

    <div class="overlay" id="overlay"></div>

    <div class="confirm-box" id="confirm-box">
        <div class="box-header">
            <h2>Are you sure you want to update?</h2>
        </div>
        <div class="box-content">
            <p>The information entered will be updated!</p>
        </div>
        <div class="button-container">
            <button id="yes-button">Yes</button>
            <button id="no-button">No</button>
        </div>
    </div>

    <div class="overlay" id="overlay1"></div>

    <div class="confirm-box" id="confirm-box1">
        <div class="box-header">
            <h2>Are you sure you want to change password?</h2>
        </div>
        <div class="box-content">
            <p>New password will be change!</p>
        </div>
        <div class="button-container">
            <button id="yes-button1">Yes</button>
            <button id="no-button1">No</button>
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

    <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
    <script src="${pageContext.request.contextPath}/Resources/js/showmessageaccountinf.js"></script>
    <script src="${pageContext.request.contextPath}/Resources/js/validationaccountinf.js"></script>
    <script>
    overlay.addEventListener("click", function () {
        overlay.style.display = "none";
        const confirmBox = document.getElementById("confirm-box");
        confirmBox.style.display = "none";
    });

    overlay1.addEventListener("click", function () {
        overlay1.style.display = "none";
        const confirmBox1 = document.getElementById("confirm-box1");
        confirmBox1.style.display = "none";
    });
    </script>
</body>
</html>
