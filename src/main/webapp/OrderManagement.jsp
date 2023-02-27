<%-- 
    Document   : OrderManagement
    Created on : Feb 19, 2023, 8:50:40 PM
    Author     : LEO
--%>
<%@page import="com.models.Order"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Management</title>
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/AccountInformation/style.css">
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/gototop.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/orderManagement.css" rel="stylesheet" />
    </head>
    <body>
        <%
            String mess = (String) request.getAttribute("mess");
        %>

        <header id="page-header">
            <div class="page-container">
                <nav class="navbar navbar-expand-lg" id="navbar-main" style="background-color: #303C5F;">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="/home" style="color: white; font-size: 25px;"><b>FIVESTORE.VN - Order management</b></a>
                    </div>
                </nav>
            </div>
        </header>

        <main>
            <div class="container" style="margin-top: 20px;">
                <!-- User -->
                <div class="search-box">
                    <div style="margin-top: 20px;">
                        <select class="form-control" id="exampleFormControlSelect1">
                            <option>Search By Status</option>
                            <option>Đã Liên Hệ</option>
                            <option>Không Liên Hệ Được</option>
                            <option>Đang Xác Nhận</option>                           
                            <option>Đang Vận Chuyển</option>
                            <option>Đã Nhận Hàng</option>
                            <option>Không Nhận Hàng</option>
                            <option>Ðã Hoàn Hàng</option>
                            <option>Đã Hủy Đơn</option>
                        </select>
                    </div>
                </div>

                <ul class="responsive-table">
                    <li class="table-header" style="color: white">
                        <div class="col col-1">OrderID</div>
                        <div class="col col-2">Username</div>
                        <div class="col col-3">DeliveryAddress</div>    
                        <div class="col col-4">OrderTime</div>
                        <div class="col col-5">Status</div>
                        <div class="col col-6">TotalBill</div>
                        <div class="col col-7">Actions</div>
                    </li>
                    <%
                        OrderDAO dao = new OrderDAO();
                        ResultSet rs = dao.getAll();
                        while (rs.next()) {
                    %>
                    <li class="table-row">
                        <div class="col col-1" data-label="OrderID"><%= rs.getString("OrderID")%></div>
                        <div class="col col-2" data-label="UserName"><%= rs.getString("Username")%></div>
                        <div class="col col-3" data-label="DeliveryAddress"><%= rs.getString("DeliveryAddress")%></div> 
                        <div class="col col-4" data-label="OrderTIme"><%= rs.getString("OrderTime")%></div> 
                        <div class="col col-5" data-label="Status"><%= rs.getString("OrderStatusID")%></div>
                        <div class="col col-6" data-label="TotalBill"><%= rs.getString("TotalBill")%></div>
                        <div class="col col-7" data-label="Action">
                            <a href="/Order/OrderDetails/<%= rs.getString("OrderID")%>" class="edit" title="View Details" data-toggle="tooltip"><i class="material-icons">&#xe417;</i></a>
                            <a href="/Order/Delete/<%= rs.getString("OrderID")%>" class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a>
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
                    <h2>Are you sure you want to delete this order?</h2>
                </div>
                <div class="box-content">
                    <p>Order will be deleted!</p>
                </div>
                <div class="button-container">
                    <button id="yes-button1">Yes</button>
                    <button id="no-button1">No</button>
                </div>
            </div>
        </main>

        <button onclick="topFunction()" id="myBtn" title="Go to top"></button>
        <script src="${pageContext.request.contextPath}/Resources/js/comfirmboxAc.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/gototop.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/showmessageordermanagement.js"></script>
    </body>
</html>
