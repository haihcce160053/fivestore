<%-- 
    Document   : accountManagement
    Created on : Feb 17, 2023, 2:24:40 PM
    Author     : QuangQui
--%>

<%@page import="com.models.Account"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Account Management</title>

        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <style>
            body {
                color: #566787;
                background: #303C5F;
                font-family: 'Varela Round', sans-serif;
                font-size: 13px;
            }
            .table-responsive {
                margin: 30px 0;
            }
            .table-wrapper {
                min-width: 1000px;
                background: #fff;
                padding: 20px 25px;
                border-radius: 5px;
                box-shadow: 0 1px 1px rgba(0,0,0,.05);
            }
            .table-title {
                padding-bottom: 15px;
                background: #fff;
                color: #000;
                padding: 16px 30px;
                margin: -20px -25px 10px;
                border-radius: 5px;
            }
            .table-title h2 {
                margin: 5px 0 0;
                font-size: 24px;
            }
            .table-title .btn {
                color: #fff;
                float: right;
                font-size: 13px;
                background: #303C5F;
                border: none;
                min-width: 50px;
                border-radius: 2px;
                border: none;
                outline: none !important;
                margin-left: 10px;
            }
            .table-title .btn:hover, .table-title .btn:focus {
                color: #566787;
                background: #f2f2f2;
            }
            .table-title .btn i {
                float: left;
                font-size: 21px;
                margin-right: 5px;
            }
            .table-title .btn span {
                float: left;
                margin-top: 2px;
            }
            table.table tr th, table.table tr td {
                border-color: #e9e9e9;
                padding: 12px 15px;
                vertical-align: middle;
            }
            table.table tr th:first-child {
                width: 60px;
            }
            table.table tr th:last-child {
                width: 100px;
            }
            table.table-striped tbody tr:nth-of-type(odd) {
                background-color: #fcfcfc;
            }
            table.table-striped.table-hover tbody tr:hover {
                background: #f5f5f5;
            }
            table.table th i {
                font-size: 13px;
                margin: 0 5px;
                cursor: pointer;
            }
            table.table td:last-child i {
                opacity: 0.9;
                font-size: 22px;
                margin: 0 5px;
            }
            table.table td a {
                font-weight: bold;
                color: #566787;
                display: inline-block;
                text-decoration: none;
            }
            table.table td a:hover {
                color: #2196F3;
            }
            table.table td a.settings {
                color: #2196F3;
            }
            table.table td a.delete {
                color: #F44336;
            }
            table.table td i {
                font-size: 19px;
            }
            table.table .avatar {
                border-radius: 50%;
                vertical-align: middle;
                margin-right: 10px;
            }
            .status {
                font-size: 30px;
                margin: 2px 2px 0 0;
                display: inline-block;
                vertical-align: middle;
                line-height: 10px;
            }
            .search-box {
                position: relative;
                float: right;
            }
            .search-box .input-group {
                min-width: 300px;
                position: absolute;
                right: 0;
            }
            .search-box .input-group-addon, .search-box input {
                border-color: #ddd;
                border-radius: 0;
            }
            .search-box input {
                height: 34px;
                padding-right: 35px;
                background: #f4fcfd;
                border-color: #303C5F;
                border-radius: 5px !important;
            }
            .search-box input:focus {
                background: #fff;
            }
            .search-box .input-group-addon {
                min-width: 35px;
                border: none;
                background: transparent;
                position: absolute;
                right: 0;
                z-index: 9;
                padding: 6px 0;
            }
            .search-box i {
                color: #a0a5b1;
                font-size: 19px;
                position: relative;
                top: 2px;
            }
            .text-success {
                color: #10c469;
            }
            .text-info {
                color: #62c9e8;
            }
            .text-warning {
                color: #FFC107;
            }
            .text-danger {
                color: #ff5b5b;
            }
            .pagination {
                float: right;
                margin: 0 0 5px;
            }
            .pagination li a {
                border: none;
                font-size: 13px;
                min-width: 30px;
                min-height: 30px;
                color: #999;
                margin: 0 2px;
                line-height: 30px;
                border-radius: 2px !important;
                text-align: center;
                padding: 0 6px;
            }
            .pagination li a:hover {
                color: #666;
            }
            .pagination li.active a, .pagination li.active a.page-link {
                background: #03A9F4;
            }
            .pagination li.active a:hover {
                background: #0397d6;
            }
            .pagination li.disabled i {
                color: #ccc;
            }
            .pagination li i {
                font-size: 16px;
                padding-top: 6px
            }
            .hint-text {
                float: left;
                margin-top: 10px;
                font-size: 13px;
            }
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

            #toast {
                position: fixed;
                top: 32px;
                right: 32px;
                z-index: 999999999;
            }

            .toast {
                display: flex;
                align-items: center;
                background-color: #fff;
                border-radius: 2px;
                padding: 20px 0;
                min-width: 400px;
                max-width: 450px;
                border-left: 4px solid;
                box-shadow: 0 5px 8px rgba(0, 0, 0, 0.08);
                transition: all linear 0.3s;
            }

            @keyframes slideInLeft {
                from {
                    opacity: 0;
                    transform: translateX(calc(100% + 32px));
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            @keyframes fadeOut {
                to {
                    opacity: 0;
                }
            }

            .toast--success {
                border-color: #47d864;
            }

            .toast--success .toast__icon {
                color: #47d864;
            }

            .toast--info {
                border-color: #2f86eb;
            }

            .toast--info .toast__icon {
                color: #2f86eb;
            }

            .toast--warning {
                border-color: #ffc021;
            }

            .toast--warning .toast__icon {
                color: #ffc021;
            }

            .toast--error {
                border-color: #ff623d;
            }

            .toast--error .toast__icon {
                color: #ff623d;
            }

            .toast + .toast {
                margin-top: 24px;
            }

            .toast__icon {
                font-size: 24px;
            }

            .toast__icon,
            .toast__close {
                padding: 0 16px;
            }

            .toast__body {
                flex-grow: 1;
            }

            .toast__title {
                font-size: 16px;
                font-weight: 600;
                color: #333;
            }

            .toast__msg {
                font-size: 14px;
                color: #888;
                margin-top: 6px;
                line-height: 1.5;
            }

            .toast__close {
                font-size: 20px;
                color: rgba(0, 0, 0, 0.3);
                cursor: pointer;
            }
        </style>

    </head>
    <body>
        <div id="toast" class="my-toast">
            <div class="toast">
                <!-- Toast content here -->
            </div>        </div>
            <%
                Account ac = (Account) session.getAttribute("Account");
                String mess = (String) request.getAttribute("mess");
            %>
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
                        <li class="nav-item">
                            <a class="nav-link" href="/home" aria-current="page" style="color: white; font-weight: bold">Account Management</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/product" style="color: #566787;">Product Management</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="/product" style="color: #566787;">Order Management</a>
                        </li>
                    </ul>
                </div>
                <div>
                    <%if (ac == null) {%>
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
                    } else {
                    %>
                    <button type="button" class="btn px-3 me-2"
                            style="color: white; background-color: #20283F"
                            onclick="location.href = '/Account/information/<%= ac.getUsername()%>'">
                        <%=ac.getFullname()%>
                    </button>
                    <%
                        }
                    %>
                </div>
            </div>
        </nav>
        <div class="container-xl" style="max-width: 1200px">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-5">
                                <h2>Account <b>Management</b></h2>
                            </div>
                            <div class="col-sm-7">
                                <div class="search-box">
                                    <div class="input-group">								
                                        <input type="text" id="search" class="form-control" style="font-size: 13px;" placeholder="Search by Username">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th style="width: 15%">Username</th>                     
                                <th style="width: 30%">FullName</th>
                                <th style="width: 30%">Email</th>
                                <th style="width: 15%">TypeAccount</th>
                                <th style="width: 10%">Actions</th>
                            </tr>
                        </thead>
                        <%
                            AccountDAO dao = new AccountDAO();
                            ResultSet rs = dao.getAll();
                            while (rs.next()) {
                        %>
                        <tbody>
                            <tr>
                                <td><%= rs.getString("Username")%></td>
                                <td><%= rs.getString("FullName")%></td>
                                <td><%= rs.getString("Email")%></td>
                                <%
                                    if (rs.getString("AccountTypeID").equals("AD")) {
                                %>
                                <td><i class="material-icons haha" style="padding-left: 25px; ">&#xe853;</i></td>
                                <%
                                } else {
                                %>
                                <td><i class="material-icons haha" style="padding-left: 25px; ">&#xe7fc;</i></td>

                                <%
                                    }
                                %>
                                <td>
                                    <a href="/Account/Change/<%= rs.getString("Username")%>" class="edit" title="Change Permission" data-toggle="tooltip"><i class="material-icons">&#xe869;</i></a>
                                    <a href="/Account/Delete/<%= rs.getString("Username")%>" class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a>
                                </td>
                            </tr>

                        </tbody>
                        <%
                            }
                        %>
                    </table>
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

        <button onclick="topFunction()" id="myBtn" title="Go to top">TOP</button>
        <script>
            $(document).ready(function () {
                // Filter table rows based on searched term
                $("#search").on("keyup", function () {
                    var term = $(this).val().toLowerCase();
                    $("table tbody tr").each(function () {
                        $row = $(this);
                        var name = $row.find("td:nth-child(1)").text().toLowerCase();
                        console.log(name);
                        if (name.search(term) < 0) {
                            $row.hide();
                        } else {
                            $row.show();
                        }
                    });
                });
                // When the user scrolls down 20px from the top of the document, show the button
                window.onscroll = function () {
                    scrollFunction()
                };

            });
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

        <script>
            const mySpan1 = document.getElementById('regError');
            const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
            mainFunction();

            function mainFunction() {
                if (myAttribute1 == "Noo") {
                    showErrorDeleteAdToast();
                } else if (myAttribute1 == "YesD") {
                    showSuccessDeleteToast();
                } else if (myAttribute1 == "NoD") {
                    showErrorDeleteToast();
                } else if (myAttribute1 == "Nooo") {
                    showErrorChangeAdminToast();
                } else if (myAttribute1 == "YesC") {
                    showSuccessChangeCusToast();
                } else if (myAttribute1 == "NoC") {
                    showErrorChangeCusToast();
                } else if (myAttribute1 == "YesA") {
                    showSuccessChangeAdToast();
                } else if (myAttribute1 == "NoA") {
                    showErrorChangeAdToast();
                } else {
                    return;
                }
            }

            function showErrorDeleteAdToast() {
                toast({
                    title: 'Failed!',
                    message: 'You cannot delete account ADMIN!',
                    type: 'success',
                    duration: 3000
                });
            }

            function showSuccessDeleteToast() {
                toast({
                    title: 'Successfully!',
                    message: 'Delete Account Successfully!',
                    type: 'success',
                    duration: 3000
                });
            }
            function showErrorDeleteToast() {
                toast({
                    title: 'Failed!!',
                    message: 'Delete Account Unsuccessfully!',
                    type: 'error',
                    duration: 3000
                });
            }

            function showErrorChangeAdminToast() {
                toast({
                    title: 'Failed!',
                    message: 'You cannot change permission account ADMIN!',
                    type: 'error',
                    duration: 3000
                });
            }

            function showSuccessChangeAdToast() {
                toast({
                    title: 'Successfully!',
                    message: 'Change Permission Account To Admin Successfully!',
                    type: 'success',
                    duration: 3000
                });
            }
            function showSuccessChangeCusToast() {
                toast({
                    title: 'Successfully!',
                    message: 'Change Permission Account To Customer Successfully!',
                    type: 'success',
                    duration: 3000
                });
            }



            function showErrorChangeAdToast() {
                toast({
                    title: 'Failed!',
                    message: 'Change Permission Account To Admin Unsuccessfully!',
                    type: 'error',
                    duration: 3000
                });
            }

            function showErrorChangeCusToast() {
                toast({
                    title: 'Failed!',
                    message: 'Change Permission Account To Customer Unsuccessfully!',
                    type: 'error',
                    duration: 3000
                });
            }
        </script>
    </body>
</html>
