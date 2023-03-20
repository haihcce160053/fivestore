<%-- 
    Document   : accountInf
    Created on : Feb 15, 2023, 7:03:52 AM
    Author     : QuangQui
--%>

<%@page import="com.daos.OrderDAO"%>
<%@page import="com.daos.AccountDAO"%>
<%@page import="com.models.Account"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/css/accountinformation.css">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet" />
        <!-- MDB -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css" rel="stylesheet" />
        <title>Account Information</title>
        <!-- Link ALL File CSS -->
        <link href="${pageContext.request.contextPath}/Resources/css/cart.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/gototop.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/footer.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />
    </head>
    <body>
        <%
            String username = (String) request.getAttribute("username");
            String mess = (String) request.getAttribute("mess");
            String mess1 = (String) request.getAttribute("mess1");
            AccountDAO dao = new AccountDAO();
            Account ac = dao.getAccount(username);
            if (ac != null) {
                int ordered = dao.getOrdered(ac.getUsername());
        %>
        <div class="main-content">
            <!-- Top navbar -->
            <header id="page-header">
                <div class="page-container">
                    <nav class="navbar navbar-expand-lg" style="background-color: #303C5F;">
                        <div class="container-fluid">
                            <div>
                                <a class="navbar-brand" href="/home"
                                   style="color: white; font-size: 25px;"><b>FIVESTORE.VN</b></a>
                            </div>
                            <div class="collapse navbar-collapse" id="navbarText">
                                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                    <%
                                        if (ac != null && (ac.getAccountTypeId()).equalsIgnoreCase("AD")) {
                                    %>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/Account/Management/<%=ac.getUsername()%>" style="color: white;">Account Management</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/Product/Management/<%=ac.getUsername()%>" style="color: white;">Product Management</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/Order/" style="color: white;">Order Management</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/Statistics" style="color: white;">Revenue statistics</a>
                                    </li>     
                                    <%
                                        }
                                    %>                             
                                </ul>
                            </div>
                            <div>
                                <%
                                    if (ac == null) {
                                %>
                                <button type="button" class="btn px-3 me-2"
                                        style="color: white; background-color: #20283F"
                                        onclick="location.href = '/login'">
                                    Login
                                </button>
                                <button type="button" class="btn me-3" 
                                        style="color: white; background-color: #20283F"
                                        onclick="location.href = '/signup'">
                                    Sign Up
                                </button>
                                <%
                                    }
                                    if (ac == null || (!ac.getAccountTypeId().equalsIgnoreCase("AD"))) {
                                %>
                                <button id="view-cart-btn" type="button" class="btn me-3" style="background-color: #20283F; color: white">
                                    MY CART <span id="cart-badge" class="badge badge-light" style="position: relative; top: -2px; right: -10px;">0</span>
                                </button>
                                <%
                                    }
                                    if ((ac != null) && (!ac.getAccountTypeId().equalsIgnoreCase("AD"))) {
                                        OrderDAO daoorder = new OrderDAO();
                                        int countOfOrder = daoorder.getNumberOrderByUsername(ac.getUsername());
                                %>
                                <button id="view-purchase-btn" type="button" class="btn me-3" style="background-color: #20283F; color: white" onclick="location.href = '/Account/Order/<%= ac.getUsername()%>'">
                                    MY Purchase<span id="cart-badge" class="badge badge-light" style="position: relative; top: -2px; right: -10px;"><%=countOfOrder%></span>
                                </button>
                                <% }%>


                            </div>
                            <form id="logout-form" action="/logout" method="post">
                                <input type="hidden" name="btnSignout" value="true">
                                <button class="btn btn-sm" style="background-color: red; color: white;width: 126px;height: 34px;" 
                                        type="submit" name="btnSignout">Logout</button>
                            </form>
                        </div>
                    </nav>
                </div>
            </header>
            <!-- Page content -->
            <div class="container-fluid mt-7">
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
                                            <img src="https://i.pinimg.com/564x/ad/91/05/ad910542c16da09af3662fc7e0ab2453.jpg"
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

                                            </div>
                                        </div>
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
                                            <span id="regError" style="color: red" data-my-attribute="<%= mess%>"></span>
                                        </div>          
                                    </div>
                                    <%
                                    } else {

                                    %>
                                    <div class="row" >
                                        <div class="col-lg-12" style="margin-left: 15px; margin-bottom: 15px;">
                                            <span id="regError" style="color: red" data-my-attribute=""></span>
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
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-8 order-xl-1">
                        <form id="form-1" action="/account" method="post">
                            <div class="card bg-secondary shadow">
                                <div class="card-header bg-white border-0">
                                    <div class="row align-items-center">
                                        <div class="col-8">
                                            <h4 class="mb-0">Account information</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body" style="background-color: #fff;">
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
                                                           placeholder="Phonenumber" value="0<%=ac.getPhoneNumber()%>">
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
                                        <div class="row">
                                            <div class="form-group">
                                                <button class="btn btn-sm btn-primary" type="button" id="edit-button">Edit Information</button> 
                                                <input type="hidden" name="btnUpdate" value="true">
                                                <button class="btn btn-sm btn-primary" type="submit" style="display: none" id="submit-button" name="btnUpdate" onclick="return update()">Update</button> 
                                            </div>
                                        </div>
                                        <%
                                            if (mess1 != null) {
                                        %>
                                        <div class="row" >
                                            <div class="col-lg-12" style="margin-left: 15px; margin-bottom: 15px;">
                                                <span id="regError1" data-my-attribute="<%= mess1%>"></span>
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
                                        <%  
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>
                        </form>        
                    </div>
                </div>
            </div>
        </div>
        <!-- Shopping Cart -->
        <form id="checkout-form" action="/checkout/<%if (ac != null) {%><%= ac.getUsername()%><%} else {%><%= String.valueOf(ac)%><%}%>" method="get">
            <div id="cart" style="display: none;">
                <h3>Cart</h3>
                <ul id="cart-items"></ul>
                <div id="cart-total">
                    <p>Total: <span id="cart-total-amount">0 VND</span></p>
                </div>
                <button id="checkout-button">Checkout</button>
            </div>
        </form>
        <!-- Toast Message  -->
        <div  class="my-toast">
            <div id="toast">
            </div>
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
        
        <div class="overlay" id="overlay2"></div>

        <div class="confirm-box" id="confirm-box2">
            <div class="box-header">
                <h2>Are you sure you want to log-out?</h2>
            </div>
            <div class="box-content">
                <p>Your account will be log-out!</p>
            </div>
            <div class="button-container">
                <button id="yes-button2">Yes</button>
                <button id="no-button2">No</button>
            </div>
        </div>
        <%@ include file="/footer.jsp" %>
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/accountInf.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/cart.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/gototop.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/tawk.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.js"></script>
        <script>
                                                    
        </script>
        <%
        } else {
        %>
        <%@ include file="/errorPage.jsp" %>
        <%
            }
        %>
    </body>
</html>