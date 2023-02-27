<%-- 
    Document   : accountManagement
    Created on : Feb 19, 2023, 1:06:54 PM
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
        <title>Account Management</title>
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/css/accountinformation.css">
        <link href="${pageContext.request.contextPath}/Resources/css/gototop.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/accManagement.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />

    </head>
    <body>
        <%
            Account ac = (Account) session.getAttribute("informationAccount");
            if (ac.getAccountTypeId().equalsIgnoreCase("AD")) {
                String mess = (String) request.getAttribute("mess");
        %>
        <header id="page-header">
            <div class="page-container">
                <nav class="navbar navbar-expand-lg" id="navbar-main" style="background-color: #303C5F;">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="/home" style="color: white; font-size: 25px;"><b>FIVESTORE.VN - Account management</b></a>
                    </div>
                </nav>
            </div>
        </header>

        <main>
            <div class="container" style="margin-top: 20px;">
                <!-- User -->
                <div class="search-box">
                   <input type="text" id="search" class="form-control" placeholder="Search by Username" style="max-width: 237px; margin: 10px 0 -10px 0;">
                </div>

                <ul class="responsive-table">
                    <li class="table-header" style="color: white">
                        <div class="col col-1">Username</div>
                        <div class="col col-2">FullName</div>
                        <div class="col col-3">Email</div>
                        <div class="col col-4">TypeAccount</div>
                        <div class="col col-5">Actions</div>
                    </li>
                    <%
                        AccountDAO dao = new AccountDAO();
                        ResultSet rs = dao.getAll();
                        while (rs.next()) {
                    %>

                    <li class="table-row">
                        <div class="col col-1" data-label="Username"><%= rs.getString("Username")%></div>
                        <div class="col col-2" data-label="Fullname"><%= rs.getString("FullName")%></div>
                        <div class="col col-3" data-label="Email"><%= rs.getString("Email")%></div>
                        <%
                            if (rs.getString("AccountTypeID").equals("AD")) {
                        %>
                        <div class="col col-4" data-label="TypeAccount"><i class="material-icons haha" style="padding-left: 25px; ">&#xe853;</i></div>
                        <%
                        } else {
                        %>

                        <div class="col col-4" data-label="TypeAccount"> <i class="material-icons haha" style="padding-left: 25px; ">&#xe7fc;</i></div>
                        <%
                            }
                        %>
                        <div class="col col-5" data-label="Action">
                            <a href="/Account/Change/<%= rs.getString("Username")%>" class="edit" title="Change Permission" data-toggle="tooltip"><i class="material-icons">&#xe869;</i></a>
                            <a href="/Account/Delete/<%= rs.getString("Username")%>" class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a>
                        </div>
                    </li>

                    <%
                        }
                    %>
                </ul>
            </div>
            <%
                if (mess != null) {
            %>
            <div class="row" >
                <div class="col-lg-12" style="margin-left: 15px;
                     margin-bottom: 15px;">
                    <span id="regError" data-my-attribute="<%= mess%>"></span>
                </div>          
            </div>
            <%
            } else {
            %>
            <div class="row" >
                <div class="col-lg-12" style="margin-left: 15px;
                     margin-bottom: 15px;">
                    <span id="regError" data-my-attribute=""></span>
                </div>          
            </div>
            <%
                }
            %>
            <div id="toast">


            </div>
            <div class="overlay" id="overlay">
                
            </div>

            <div class="confirm-box" id="confirm-box">
                <div class="box-header">
                    <h2>Are you sure you want to change permission?</h2>
                </div>
                <div class="box-content">
                    <p>Permission of Account will be changed!</p>
                </div>
                <div class="button-container">
                    <button id="yes-button">Yes</button>
                    <button id="no-button">No</button>
                </div>
            </div>

            <div class="overlay" id="overlay1"></div>

            <div class="confirm-box" id="confirm-box1">
                <div class="box-header">
                    <h2>Are you sure you want to delete account?</h2>
                </div>
                <div class="box-content">
                    <p>Account will be deleted!</p>
                </div>
                <div class="button-container">
                    <button id="yes-button1">Yes</button>
                    <button id="no-button1">No</button>
                </div>
            </div>
        </main>


        <%
            }

        %>

        <button onclick="topFunction()" id="myBtn" title="Go to top"></button>
        <script src="${pageContext.request.contextPath}/Resources/js/gototop.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/searchAc.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/comfirmboxAc.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/showmessageaccountmanagement.js"></script>
    </body>
</html>
