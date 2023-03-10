<%-- 
    Document   : OrderDetails
    Created on : Feb 22, 2023, 7:56:57 AM
    Author     : LEO
--%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.models.OrderDetails"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.OrderDetailsDAO"%>
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/css/accountinformation.css">
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/gototop.css" rel="stylesheet" />
         <link href="${pageContext.request.contextPath}/Resources/css/orderManagement.css" rel="stylesheet" />
    </head>
    <body>
        <nav class="navbar navbar-top navbar-expand-md navbar-dark" id="navbar-main" style="background-color: #303C5F;     padding: 0rem 1rem;">
            <div class="container-fluid">
                <!-- Brand -->
                <a class="h4 mb-0 text-uppercase text-white d-none d-lg-inline-block"
                   href="/">FIVE STORE - Order
                    Details</a>
                 <!-- User -->
            </div>
        </nav>
        <div class="container" style="margin-top: 20px;">
            <ul class="responsive-table">
                <li class="table-header">
                    <div class="col col-1">OrderID</div>
                    <div class="col col-2">ProductID</div>
                    <div class="col col-3">Quantity</div>    
                    <div class="col col-4">TotalPrice</div>
                </li>
                <%
                    String OrderID = (String) request.getAttribute("Order");
                    OrderDetailsDAO daos = new OrderDetailsDAO();
                    ResultSet rs = daos.getOrderDetails(OrderID);
                    while (rs.next()) {
                %> 
                <li class="table-row">
                    <div class="col col-1" data-label="OrderID"><%= rs.getString("OrderID")%></div>
                    <div class="col col-2" data-label="ProductID"><%= rs.getString("ProductID")%></div>
                    <div class="col col-3" data-label="Quantity"><%= rs.getString("Quantity")%></div> 
                    <%
                        NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                        String formattedPrice = format.format(rs.getInt("TotalPrice")).replace("₫", "VND").replaceAll("\\s", "");
                    %>
                    <div class="col col-4" data-label="TotalPrice"><%= formattedPrice%></div>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
        <button onclick="topFunction()" id="myBtn" title="Go to top"></button>
        <script src="${pageContext.request.contextPath}/Resources/js/comfirmboxAc.js"></script>
         <script src="${pageContext.request.contextPath}/Resources/js/gototop.js"></script>
         <script src="${pageContext.request.contextPath}/Resources/js/tawk.js"></script>
         <script src="${pageContext.request.contextPath}/Resources/js/showmessageordermanagement.js"></script>
    </body>
</html>
