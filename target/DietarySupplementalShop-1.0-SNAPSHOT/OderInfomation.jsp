<%-- 
    Document   : OderInfomation
    Created on : Feb 17, 2023, 9:03:28 AM
    Author     : ASUS
--%>

<%@page import="com.models.Account"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.ProductDAO"%>
<!--THIS PAGE USING FOR TESTING !!!-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FIVESTORE - Home page</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>FIVESTORE - Dietary supplemental shop</title>
        <link rel="icon" type="image/x-icon" href="HCDATAFILE/img/logo-only.png">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet" />
        <!-- MDB -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css" rel="stylesheet" />
        <!-- Jquery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
    </head>
    <body>
        <%
            Account ac = (Account) session.getAttribute("informationAccount");
        %>
        <header id="page-header">
            <div class="page-container">
                <nav class="navbar navbar-expand-lg" style="background-color: #303C5F;">
                    <div class="container-fluid">
                        <div>
                            <a class="navbar-brand" href="/home"
                               style="color: white; font-size: 25px;"><b>FIVESTORE.VN</b></a>
                            <button class="navbar-toggler" type="button" data-mdb-toggle="collapse"
                                    data-mdb-target="#navbarText" aria-controls="navbarText" aria-expanded="false"
                                    aria-label="Toggle navigation">
                                <i class="fas fa-bars"></i>
                            </button>
                        </div>                 
                        <div class="collapse navbar-collapse" id="navbarText">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <%
                                    if (ac != null && (ac.getAccountTypeId()).equalsIgnoreCase("AD")) {
                                %>
                                <li class="nav-item">
                                    <a class="nav-link" href="/Account/Management/<%=ac.getUsername()%>" style="color: #566787;">Account Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/product" style="color: #566787;">Product Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/product" style="color: #566787;">Order Management</a>
                                </li>

                                <%
                                } else {
                                %>
                                <li class="nav-item">
                                    <a class="nav-link" href="/home" aria-current="page" style="color: white;">Home</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/product" style="color: white;">Product</a>
                                </li>
                                <%
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
            </div>
        </header>
        <div class="col-md-6">

        </div>     
        <div class="col-md-6">
            <form>
                <div class="form-group row">
                    <label for="txtOrderID" class="col-4 col-form-label">Order ID</label> 
                    <div class="col-8">
                        <input id="txtOrderID" name="txtOrderID" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="txtUsername" class="col-4 col-form-label">Username</label> 
                    <div class="col-8">
                        <input id="txtUsername" name="txtUsername" type="text" class="form-control">
                    </div>
                </div>
                <div class="form-group row">
                    <label for="txtTotalBill" class="col-4 col-form-label">Total Bill</label> 
                    <div class="col-8">
                        <input id="txtTotalBill" name="txtTotalBill" type="text" class="form-control">
                    </div>
                </div> 
                <div class="form-group row">
                    <div class="offset-4 col-8">
                        <button name="submit" type="submit" class="btn btn-primary">Submit Order</button>
                    </div>
                </div>
            </form>
        </div>     
    </body>

</html>
