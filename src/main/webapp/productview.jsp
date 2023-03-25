<%-- 
    Document   : productview
    Created on : Mar 3, 2023, 10:32:22 AM
    Author     : huynh
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="com.models.Product"%>
<%@page import="com.daos.ProductDAO"%>
<%@page import="com.models.Account"%>
<%@page import="com.daos.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>FIVESTORE - Dietary supplemental shop</title>

        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet" />
        <!-- MDB -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css" rel="stylesheet" />

        <!-- Link ALL File CSS -->
        <link href="${pageContext.request.contextPath}/Resources/css/cart.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/gototop.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/footer.css" rel="stylesheet" />

        <!-- CSS Navigation bar -->
        <style>
            #page-header {
                transition: top 0.5s;
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 999;
            }
        </style>
    </head>
    <body>
        <%
            Account ac = (Account) session.getAttribute("informationAccount");
        %>

        <!-- Navigation bar -->
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
                            } else {
                            %>
                            <button type="button" class="btn px-3 me-2"
                                    style="color: white; background-color: #20283F"
                                    onclick="location.href = '/Account/information/<%= ac.getUsername()%>'">
                                <%=ac.getFullname()%>
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
                                    OrderDAO dao = new OrderDAO();
                                    int countOfOrder = dao.getNumberOrderByUsername(ac.getUsername());
                            %>
                            <button id="view-purchase-btn" type="button" class="btn me-3" style="background-color: #20283F; color: white" onclick="location.href = '/Account/Order/<%= ac.getUsername()%>'">
                                MY Purchase<span id="cart-badge" class="badge badge-light" style="position: relative; top: -2px; right: -10px;"><%=countOfOrder%></span>
                            </button>
                            <% }%>
                        </div>
                    </div>
                </nav>
            </div>
        </header>

        <main>
            <div style="padding: 100px">
                <div style="margin-bottom: 40px">
                    <%
                        ProductDAO dao = new ProductDAO();
                        String ProductID = (String) request.getAttribute("viewproductid");
                        Product product = new Product();
                        product = dao.getProduct(ProductID);
                        if (product != null) {
                    %>
                    <div class="row">
                        <div class="card col-md-5">
                            <div class="card-body">
                                <div>
                                    <h5 class="card-title"><%= product.getProductName()%></h5>
                                    <p class="card-text">Product ID: <%= product.getProductID()%></p>
                                </div>
                                <div class="row justify-content-center align-items-center" align="center" style="margin-top: 50px">
                                    <img src="<%= product.getPictureLink()%>" style="width: 500px; height: 500px" algin="center" alt="<%= product.getProductName()%>"/>
                                </div>
                                <div style="margin-top: 50px">
                                    <%
                                        NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                        String formattedPrice = format.format(product.getPrice()).replace("₫", "VND").replaceAll("\\s", "");
                                    %>
                                    <span class="card-text text-muted" hidden id="price-<%= product.getProductID()%>"><b>Price: </b><%= formattedPrice%></span>
                                    <span class="card-text text-muted" hidden id="quantity-<%= product.getProductID()%>"><b>Quantity: </b><%= product.getQuantity()%></span>
                                    <h6>EXP: <%= product.getEXP()%></h6>
                                    <h6>Quantity: <%= product.getQuantity()%></h6>
                                    <h6>Price: <%= formattedPrice%></h6>
                                </div>
                                <div style="margin-top: 20px">
                                    <input id="title-<%= product.getProductID()%>" type="text" value="<%= product.getProductName()%>" hidden>
                                    <%
                                        String dateString = product.getEXP();
                                        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                        Date expDate = formatter.parse(dateString);

                                        Date currentDate = new Date();
                                        String currentDateString = formatter.format(currentDate);
                                        Date currentDay = formatter.parse(currentDateString);

                                        if (product.getQuantity() > 0 && expDate.after(currentDay)) {

                                    %>
                                    <div style="margin-top: 20px">
                                        <button id="cart-<%= product.getProductID()%>" type="button" class="btn btn-primary" style="width: 100%; background-color: #303C5F; color: white">Add to cart</button>
                                    </div>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                        <div class="card col-md-7">
                            <div class="card-body">
                                <p class="card-text"><%= product.getDescription()%></p>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </main>

        <!-- Shopping Cart -->
        <% if (ac != null) {
                String username = ac.getUsername();
            } else {
                String username = "null";
            }
        %>
        <form id="checkout-form" action="/checkout/<%if (ac != null) {%><%= ac.getUsername()%><%} else {%><%= String.valueOf(ac)%><%}%>" method="get">
            <div id="cart" style="display: none;">
                <h3>Cart</h3>
                <ul id="cart-items">

                </ul>

                <div id="cart-total">
                    <p>Total: <span id="cart-total-amount">0 VND</span></p>
                </div>
                <button id="checkout-button">Checkout</button>
            </div>
        </form>
        <!--Start of Tawk.to Script-->
        <script src="${pageContext.request.contextPath}/Resources/js/tawk.js"></script>
        <!--End of Tawk.to Script-->
        <!-- Footer -->            
        <%@ include file="/footer.jsp" %>

        <!-- Button GO TO TOP -->
        <button onclick="topFunction()" id="myBtn" title="Go to top"></button>

        <!-- Link ALL JS From URL -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.1.js"></script>

        <!-- Link All File JS -->
        <script src="${pageContext.request.contextPath}/Resources/js/cart.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/gototop.js"></script>
    </body>
</html>
