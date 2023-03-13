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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css" rel="stylesheet" />
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/css/accountinformation.css">
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/gototop.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/orderdetails.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/footer.css" rel="stylesheet" />
    </head>
    <body>
        <header id="page-header">
            <div class="page-container">
                <nav class="navbar navbar-expand-lg" id="navbar-main" style="background-color: #303C5F;">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="/" style="color: white; font-size: 25px;"><b>FIVESTORE.VN - Order Details</b></a>
                    </div>
                </nav>
            </div>
        </header>
        <div style="width: 100%">
            <ul class="responsive-table">
                <li class="table-header" style="margin-top: 25px;display: flex !important; justify-content: space-between !important; padding: 15px 20px !important; margin-bottom: 10px !important; border-radius: 3px !important; background-color: #138496 !important; box-shadow: 0 0 9px 0 var(--color-shadow) !important; color:white">
                    <div class="col col-1">ProductID</div>
                    <div class="col col-2">ProductName</div>
                    <div class="col col-3">Quantity</div>    
                    <div class="col col-4">TotalPrice</div>
                </li>
                <%
                    String OrderID = (String) request.getAttribute("Order");
                    OrderDetailsDAO daos = new OrderDetailsDAO();
                    ResultSet rs = daos.getOrderDetails(OrderID);
                    while (rs.next()) {
                %> 
                <li class="table-row" style="display: flex !important; justify-content: space-between !important; padding: 15px 20px !important; margin-bottom: 10px !important; border-radius: 3px !important; background-color: var(--color-white) !important; box-shadow: 0 0 9px 0 var(--color-shadow) !important;">
                    <div class="col col-1" data-label="OrderID"><%= rs.getString("ProductID")%></div>
                    <div class="col col-2" data-label="ProductID"><% String ProductName = daos.getProductName(rs.getString("ProductID"));%> <%= ProductName%></div>
                    <div class="col col-3" data-label="Quantity"><%= rs.getString("Quantity")%></div> 
                    <%
                        NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                        String formattedPrice = format.format(rs.getInt("TotalPrice")).replace("₫", "VND").replaceAll("\\s", "");
                    %>
                    <div class="col col-4" data-label="TotalPrice"><%= formattedPrice%></div>
                </li>
                </li>
                <%
                    }
                %>
            </ul>
        </div> 
        <!-- Footer -->            
        <%@ include file="/footer.jsp" %>
        
        <button onclick="topFunction()" id="myBtn" title="Go to top"></button>
        <button onclick="topFunction()" id="myBtn" title="Go to top"></button>
        <script src="${pageContext.request.contextPath}/Resources/js/comfirmboxAc.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/gototop.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/tawk.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/showmessageordermanagement.js"></script>
    </body>
</html>
