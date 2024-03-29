<%-- 
    Document   : hometest
    Created on : Feb 15, 2023, 7:22:51 AM
    Author     : Huynh Chi Hai
--%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.models.Product"%>
<%@page import="java.text.Normalizer"%>
<!-- Import -->
<%@page import="com.daos.OrderDAO"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="com.models.Account"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.ProductDAO"%>

<!-- JSP Page -->
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
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />

        <!-- CSS Navigation bar -->
        <style>
            #page-header {
                transition: top 0.5s;
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 999;
            }
            .sold-label {
                position: absolute;
                top: 10px;
                right: 10px;
                font-weight: bold;
                font-size: 14px;
                color: #fff;
                background-color: #c62828;
                text-align: center;
            }
            .order-label {
                position: absolute;
                top: 10px;
                right: 10px;
                border-radius: 20px;
                font-weight: bold;
                font-size: 14px;
                color: #fff;
                background-color: #4CAF50;
                text-align: center;
                box-shadow: 0px 2px 5px rgba(0,0,0,0.2);
                animation: pulse 2.5s ease-in-out infinite;
            }
            @keyframes pulse {
                0% {
                    transform: scale(1);
                    opacity: 1;
                }
                50% {
                    transform: scale(1.2);
                    opacity: 0.8;
                }
                100% {
                    transform: scale(1);
                    opacity: 1;
                }
            }
        </style>
    </head>

    <body>
        <div id="page-container"
             class="sidebar-o side-scroll page-header-glass page-header-inverse page-header-fixed main-content-narrow sidebar-inverse side-trans-enabled page-header-scroll">
            <%
                Account ac = (Account) session.getAttribute("informationAccount");
                String mess = (String) request.getAttribute("mess");
            %>
            <!-- Navigation bar -->
            <header id="page-header">
                <div class="page-container">
                    <nav class="navbar navbar-expand-lg" style="background-color: #303C5F;">
                        <div class="container-fluid">
                            <!-- Toggle button -->
                            <button
                                class="navbar-toggler"
                                type="button"
                                data-mdb-toggle="collapse"
                                data-mdb-target="#navbarSupportedContent"
                                aria-controls="navbarSupportedContent"
                                aria-expanded="false"
                                aria-label="Toggle navigation"
                                >
                                <i class="fas fa-bars"></i>
                            </button>

                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <div>
                                    <a class="navbar-brand" href="/home"
                                       style="color: white; font-size: 25px;"><b>FIVESTORE.VN</b></a>
                                </div>
                                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                    <%
                                        if (ac != null && (ac.getAccountTypeId()).equalsIgnoreCase("AD")) {
                                    %>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/Account/Management/" style="color: white;">Account Management</a>
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
            <%
                if (mess != null) {
            %>
            <div class="form-group" style="margin-top: 10px;">
                <span id="regError" data-my-attribute="<%= mess%>"></span>
            </div>
            <%
            } else {
            %>
            <div class="form-group" style="margin-top: 10px;">
                <span id="regError" data-my-attribute=""></span>
            </div>
            <%
                }
            %>
            <!-- Toast Message  -->
            <div  class="my-toast">
                <div id="toast">
                </div>
            </div>
            <!-- All Product -->
            <main>
                <!-- Banner And Search Bar -->
                <div class="container" style="margin-top: 100px;">
                    <div class="row justify-content-center align-items-center" style="margin-bottom: 50px;">
                        <img src="../img/sale/sale.png" alt="alt" class="img-fluid">
                    </div>
                    <div>
                        <form class="d-flex input-group w-auto" action="/Product/Search=" onsubmit="submitSearchForm(event)">
                            <%
                                if (request.getAttribute("searchkeyword") != null) {
                            %>
                            <input
                                type="text"
                                class="form-control rounded"
                                placeholder="Search"
                                id="search-input" value="<%= request.getAttribute("searchkeyword")%>"
                                />
                            <%
                            } else {
                            %>
                            <input
                                type="text"
                                class="form-control rounded"
                                placeholder="Search"
                                id="search-input"
                                />
                            <%
                                }
                            %>
                            <button type="submit" class="input-group-text border-0" id="search-addon">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
                    </div>                
                </div>

                <div>
                    <!-- Shopping Cart -->
                    <% if (ac != null) {
                            String username = ac.getUsername();
                        }
                    %>
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
                    <%
                        if (request.getAttribute(
                                "searchkeyword") != null) {
                            String keyword = (String) request.getAttribute("searchkeyword");
                            ProductDAO dao = new ProductDAO();
                            ResultSet rs = dao.getAll();
                    %>            
                    <div style="padding: 50px">
                        <div style="margin-bottom: 40px">
                            <div class="row">
                                <%
                                    while (rs.next()) {
                                        String ProductName = Normalizer.normalize(rs.getString("ProductName"), Normalizer.Form.NFD).replaceAll("[^\\p{ASCII}]", "");
                                        if (ProductName.toLowerCase().contains(keyword.toLowerCase())) {
                                %>
                                <div class="col-md-3">
                                    <div class="card">
                                        <div align="center" style="margin-bottom: 20px">
                                            <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs.getString("PictureLink")%>" alt="alt"/>
                                        </div>
                                        <div class="card-body d-flex flex-column justify-content-between">
                                            <h6 class="card-title text-truncate"><%= rs.getString("ProductName")%></h6>
                                            <%
                                                NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                                String formattedPrice = format.format(rs.getInt("Price")).replaceAll("\\s", "");
                                            %>   
                                            <div>
                                                <span class="card-text text-muted" id="exp-<%= rs.getString("ProductID")%>"><b>EXP: </b><%= rs.getString("EXP")%></span>
                                            </div>
                                            <div>
                                                <span class="card-text text-muted" id="quantity-<%= rs.getString("ProductID")%>"><b>Quantity: </b><%= rs.getString("Quantity")%></span>
                                            </div>
                                            <div>
                                                <span class="card-text text-muted" id="price-<%= rs.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                            </div>
                                            <div style="margin-top: 20px">
                                                <input id="title-<%= rs.getString("ProductID")%>" type="text" value="<%= rs.getString("ProductName")%>" hidden>
                                                <button id="view-<%= rs.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%" onclick="location.href = '/Product/View/<%= rs.getString("ProductID")%>'">View</button>
                                            </div>
                                            <%
                                                String dateString = rs.getString("EXP");
                                                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                                Date expDate = formatter.parse(dateString);

                                                Date currentDate = new Date();
                                                String currentDateString = formatter.format(currentDate);
                                                Date currentDay = formatter.parse(currentDateString);

                                                if (Integer.parseInt(rs.getString("Quantity")) > 0 && expDate.after(currentDay)) {

                                            %>
                                            <div style="margin-top: 20px">
                                                <button id="cart-<%= rs.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%">Add to Cart</button>
                                            </div>
                                            <%
                                                }
                                            %>
                                            <div style="margin-top: 20px">
                                                <span class="badge badge-secondary sold-label"><%= rs.getString("SoldAmount")%> sold</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                        }
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                    <%
                    } else {
                    %>
                    <!-- BEST SELLING OR BEST ORDER -->
                    <%
                        ProductDAO dao_product = new ProductDAO();
                        ResultSet rs_product_order = dao_product.getAllProductBestOrder();
                        if (rs_product_order != null) {
                            boolean hasData = rs_product_order.next();
                            if (hasData) {
                    %>
                    <div style="padding: 50px">
                        <div>
                            <h5>BEST ORDER</h5>
                            <div class="row">
                                <%
                                    do {
                                        Product pd = dao_product.getProduct(rs_product_order.getString("ProductID"));
                                %> 
                                <div class="col-md-3">
                                    <div class="card">
                                        <div align="center" style="margin-bottom: 20px">
                                            <img class="card-img-top" style="width: 150px; height: 150px" src="<%= pd.getPictureLink()%>" alt="alt"/>
                                        </div>
                                        <div class="card-body d-flex flex-column justify-content-between">
                                            <h6 class="card-title text-truncate"><%= pd.getProductName()%></h6>
                                            <%
                                                NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                                String formattedPrice = format.format(pd.getPrice()).replaceAll("\\s", "");
                                            %>   
                                            <div>
                                                <span class="card-text text-muted" id="exp-<%= pd.getProductID()%>"><b>EXP: </b><%= pd.getEXP()%></span>
                                            </div>
                                            <div>
                                                <span class="card-text text-muted" id="quantity-<%=pd.getProductID()%>"><b>Quantity: </b><%= pd.getQuantity()%></span>
                                            </div>
                                            <div>
                                                <span class="card-text text-muted" id="price-<%= pd.getProductID()%>"><b>Price: </b><%= formattedPrice%></span>
                                            </div>
                                            <div style="margin-top: 20px">
                                                <input id="title-<%= pd.getProductID()%>" type="text" value="<%= pd.getProductName()%>" hidden>
                                                <button id="view-<%= pd.getProductID()%>" class="btn" style="background-color: #303C5F; color: white; width: 100%" onclick="location.href = '/Product/View/<%= pd.getProductID()%>'">View</button>
                                            </div>
                                            <%
                                                String dateString = pd.getEXP();
                                                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                                Date expDate = formatter.parse(dateString);

                                                Date currentDate = new Date();
                                                String currentDateString = formatter.format(currentDate);
                                                Date currentDay = formatter.parse(currentDateString);

                                                if (pd.getQuantity() > 0 && expDate.after(currentDay)) {

                                            %>
                                            <div style="margin-top: 20px">
                                                <button id="cart-<%= pd.getProductID()%>" class="btn" style="background-color: #303C5F; color: white; width: 100%">Add to Cart</button>
                                            </div>
                                            <%
                                                }
                                            %>
                                            <div style="margin-top: 20px">
                                                <span class="badge badge-secondary order-label"><%= rs_product_order.getString("TotalOrders")%> order</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    } while (rs_product_order.next());
                                %>
                            </div>
                        </div>
                    </div>
                    <%
                            }
                        }
                        ResultSet rs_product_selling = dao_product.getAllProductBestSelling();
                        if (rs_product_selling != null) {
                            boolean hasData1 = rs_product_selling.next();
                            if (hasData1) {
                    %>
                    <div style="padding: 50px">
                        <div>
                            <h5>BEST SELLING</h5>
                            <div class="row">
                                <%
                                    do {
                                %> 
                                <div class="col-md-3">
                                    <div class="card">
                                        <div align="center" style="margin-bottom: 20px">
                                            <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_product_selling.getString("PictureLink")%>" alt="alt"/>
                                        </div>
                                        <div class="card-body d-flex flex-column justify-content-between">
                                            <h6 class="card-title text-truncate"><%= rs_product_selling.getString("ProductName")%></h6>
                                            <% NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                                String formattedPrice = format.format(rs_product_selling.getInt("Price")).replaceAll("\\s", "");
                                            %>   
                                            <div>
                                                <span class="card-text text-muted" id="exp-<%= rs_product_selling.getString("ProductID")%>"><b>EXP: </b><%= rs_product_selling.getString("EXP")%></span>
                                            </div>
                                            <div>
                                                <span class="card-text text-muted" id="quantity-<%=rs_product_selling.getString("ProductID")%>"><b>Quantity: </b><%= rs_product_selling.getString("Quantity")%></span>
                                            </div>
                                            <div>
                                                <span class="card-text text-muted" id="price-<%= rs_product_selling.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                            </div>
                                            <div style="margin-top: 20px">
                                                <input id="title-<%= rs_product_selling.getString("ProductID")%>" type="text" value="<%= rs_product_selling.getString("ProductName")%>" hidden>
                                                <button id="view-<%= rs_product_selling.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%" onclick="location.href = '/Product/View/<%= rs_product_selling.getString("ProductID")%>'">View</button>
                                            </div>
                                            <%
                                                String dateString = rs_product_selling.getString("EXP");
                                                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                                Date expDate = formatter.parse(dateString);

                                                Date currentDate = new Date();
                                                String currentDateString = formatter.format(currentDate);
                                                Date currentDay = formatter.parse(currentDateString);

                                                if (Integer.parseInt(rs_product_selling.getString("Quantity")) > 0 && expDate.after(currentDay)) {
                                            %>
                                            <div style="margin-top: 20px">
                                                <button id="cart-<%= rs_product_selling.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%">Add to Cart</button>
                                            </div>
                                            <%
                                                }
                                            %>
                                            <div style="margin-top: 20px">
                                                <span class="badge badge-secondary order-label"><%= rs_product_selling.getString("SoldAmount")%> sold</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    } while (rs_product_selling.next());
                                %>
                            </div>
                        </div>
                    </div>
                    <%
                            }
                        }
                    %>
                </div>

                <div style="padding: 50px">
                    <div style="margin-bottom: 40px">
                        <h5>DIGESTION</h5>
                        <div class="row">
                            <%
                                ProductDAO dao_dig = new ProductDAO();
                                ResultSet rs_dig = dao_dig.getAll();
                                while (rs_dig.next()) {
                                    if (rs_dig.getString("ProductTypeID").equals("Dig")) {
                            %>
                            <div class="col-md-3">
                                <div class="card">
                                    <div align="center" style="margin-bottom: 20px">
                                        <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_dig.getString("PictureLink")%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h6 class="card-title text-truncate"><%= rs_dig.getString("ProductName")%></h6>
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_dig.getInt("Price")).replaceAll("\\s", "");
                                        %>   
                                        <div>
                                            <span class="card-text text-muted" id="exp-<%= rs_dig.getString("EXP")%>"><b>EXP: </b><%= rs_dig.getString("EXP")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="quantity-<%= rs_dig.getString("ProductID")%>"><b>Quantity: </b><%= rs_dig.getString("Quantity")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="price-<%= rs_dig.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                        </div>
                                        <div style="margin-top: 20px">
                                            <input id="title-<%= rs_dig.getString("ProductID")%>" type="text" value="<%= rs_dig.getString("ProductName")%>" hidden>
                                            <button id="view-<%= rs_dig.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%" onclick="location.href = '/Product/View/<%= rs_dig.getString("ProductID")%>'">View</button>
                                        </div>

                                        <%
                                            String dateString = rs_dig.getString("EXP");
                                            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                            Date expDate = formatter.parse(dateString);

                                            Date currentDate = new Date();
                                            String currentDateString = formatter.format(currentDate);
                                            Date currentDay = formatter.parse(currentDateString);

                                            if (Integer.parseInt(rs_dig.getString("Quantity")) > 0 && expDate.after(currentDay)) {

                                        %>
                                        <div style="margin-top: 20px">
                                            <button id="cart-<%= rs_dig.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%">Add to Cart</button>
                                        </div>
                                        <%
                                            }
                                        %>

                                        <div style="margin-top: 20px">
                                            <span class="badge badge-secondary sold-label"><%= rs_dig.getString("SoldAmount")%> sold</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>

                    <div style="margin-bottom: 30px">
                        <h5>EYES</h5>
                        <div class="row">
                            <%
                                ProductDAO dao_eyes = new ProductDAO();
                                ResultSet rs_eyes = dao_eyes.getAll();
                                while (rs_eyes.next()) {
                                    if (rs_eyes.getString("ProductTypeID").equals("Ey")) {
                            %>
                            <div class="col-md-3">
                                <div class="card">
                                    <div align="center" style="margin-bottom: 20px">
                                        <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_eyes.getString("PictureLink")%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h6 class="card-title text-truncate"><%= rs_eyes.getString("ProductName")%></h6>
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_eyes.getInt("Price")).replaceAll("\\s", "");
                                        %>   
                                        <div>
                                            <span class="card-text text-muted" id="exp-<%= rs_eyes.getString("ProductID")%>"><b>EXP: </b><%= rs_eyes.getString("EXP")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="quantity-<%= rs_eyes.getString("ProductID")%>"><b>Quantity: </b><%= rs_eyes.getString("Quantity")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="price-<%= rs_eyes.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                        </div>
                                        <div style="margin-top: 20px">
                                            <input id="title-<%= rs_eyes.getString("ProductID")%>" type="text" value="<%= rs_eyes.getString("ProductName")%>" hidden>
                                            <button id="view-<%= rs_eyes.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%" onclick="location.href = '/Product/View/<%= rs_eyes.getString("ProductID")%>'">View</button>
                                        </div>
                                        <%
                                            String dateString = rs_eyes.getString("EXP");
                                            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                            Date expDate = formatter.parse(dateString);

                                            Date currentDate = new Date();
                                            String currentDateString = formatter.format(currentDate);
                                            Date currentDay = formatter.parse(currentDateString);

                                            if (Integer.parseInt(rs_eyes.getString("Quantity")) > 0 && expDate.after(currentDay)) {

                                        %>
                                        <div style="margin-top: 20px">
                                            <button id="cart-<%= rs_eyes.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%">Add to Cart</button>
                                        </div>
                                        <%
                                            }
                                        %>
                                        <div style="margin-top: 20px">
                                            <span class="badge badge-secondary sold-label"><%= rs_eyes.getString("SoldAmount")%> sold</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>

                    <div style="margin-bottom: 30px">
                        <h5>HIGHBLOOD</h5>
                        <div class="row">
                            <%
                                ProductDAO dao_blood = new ProductDAO();
                                ResultSet rs_blood = dao_blood.getAll();
                                while (rs_blood.next()) {
                                    if (rs_blood.getString("ProductTypeID").equals("Hi")) {
                            %>
                            <div class="col-md-3">
                                <div class="card">
                                    <div align="center" style="margin-bottom: 20px">
                                        <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_blood.getString("PictureLink")%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h6 class="card-title text-truncate"><%= rs_blood.getString("ProductName")%></h6>
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_blood.getInt("Price")).replaceAll("\\s", "");
                                        %>   
                                        <div>
                                            <span class="card-text text-muted" id="exp-<%= rs_blood.getString("ProductID")%>"><b>EXP: </b><%= rs_blood.getString("EXP")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="quantity-<%= rs_blood.getString("ProductID")%>"><b>Quantity: </b><%= rs_blood.getString("Quantity")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="price-<%= rs_blood.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                        </div>
                                        <div style="margin-top: 20px">
                                            <input id="title-<%= rs_blood.getString("ProductID")%>" type="text" value="<%= rs_blood.getString("ProductName")%>" hidden>
                                            <button id="view-<%= rs_blood.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%" onclick="location.href = '/Product/View/<%= rs_blood.getString("ProductID")%>'">View</button>
                                        </div>
                                        <%
                                            String dateString = rs_blood.getString("EXP");
                                            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                            Date expDate = formatter.parse(dateString);

                                            Date currentDate = new Date();
                                            String currentDateString = formatter.format(currentDate);
                                            Date currentDay = formatter.parse(currentDateString);

                                            if (Integer.parseInt(rs_blood.getString("Quantity")) > 0 && expDate.after(currentDay)) {

                                        %>
                                        <div style="margin-top: 20px">
                                            <button id="cart-<%= rs_blood.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%">Add to Cart</button>
                                        </div>
                                        <%
                                            }
                                        %>
                                        <div style="margin-top: 20px">
                                            <span class="badge badge-secondary sold-label"><%= rs_blood.getString("SoldAmount")%> sold</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>

                    <div style="margin-bottom: 30px">
                        <h5>LIVER</h5>
                        <div class="row">
                            <%
                                ProductDAO dao_liver = new ProductDAO();
                                ResultSet rs_liver = dao_liver.getAll();
                                while (rs_liver.next()) {
                                    if (rs_liver.getString("ProductTypeID").equals("Li")) {
                            %>
                            <div class="col-md-3">
                                <div class="card">
                                    <div align="center" style="margin-bottom: 20px">
                                        <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_liver.getString("PictureLink")%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h6 class="card-title text-truncate"><%= rs_liver.getString("ProductName")%></h6>
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_liver.getInt("Price")).replaceAll("\\s", "");
                                        %>   
                                        <div>
                                            <span class="card-text text-muted" id="exp-<%= rs_liver.getString("ProductID")%>"><b>EXP: </b><%= rs_liver.getString("EXP")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="quantity-<%= rs_liver.getString("ProductID")%>"><b>Quantity: </b><%= rs_liver.getString("Quantity")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="price-<%= rs_liver.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                        </div>
                                        <div style="margin-top: 20px">
                                            <input id="title-<%= rs_liver.getString("ProductID")%>" type="text" value="<%= rs_liver.getString("ProductName")%>" hidden>
                                            <button id="view-<%= rs_liver.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%" onclick="location.href = '/Product/View/<%= rs_liver.getString("ProductID")%>'">View</button>
                                        </div>
                                        <%
                                            String dateString = rs_liver.getString("EXP");
                                            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                            Date expDate = formatter.parse(dateString);

                                            Date currentDate = new Date();
                                            String currentDateString = formatter.format(currentDate);
                                            Date currentDay = formatter.parse(currentDateString);

                                            if (Integer.parseInt(rs_liver.getString("Quantity")) > 0 && expDate.after(currentDay)) {

                                        %>
                                        <div style="margin-top: 20px">
                                            <button id="cart-<%= rs_liver.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%">Add to Cart</button>
                                        </div>
                                        <%
                                            }
                                        %>
                                        <div style="margin-top: 20px">
                                            <span class="badge badge-secondary sold-label"><%= rs_liver.getString("SoldAmount")%> sold</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>

                    <div style="margin-bottom: 30px">
                        <h5>RESISTANCE</h5>
                        <div class="row">
                            <%
                                ProductDAO dao_resistance = new ProductDAO();
                                ResultSet rs_resistance = dao_resistance.getAll();
                                while (rs_resistance.next()) {
                                    if (rs_resistance.getString("ProductTypeID").equals("Re")) {
                            %>
                            <div class="col-md-3">
                                <div class="card">
                                    <div align="center" style="margin-bottom: 20px">
                                        <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_resistance.getString("PictureLink")%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h6 class="card-title text-truncate"><%= rs_resistance.getString("ProductName")%></h6>
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_resistance.getInt("Price")).replaceAll("\\s", "");
                                        %>   
                                        <div>
                                            <span class="card-text text-muted" id="exp-<%= rs_resistance.getString("ProductID")%>"><b>EXP: </b><%= rs_resistance.getString("EXP")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="quantity-<%= rs_resistance.getString("ProductID")%>"><b>Quantity: </b><%= rs_resistance.getString("Quantity")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="price-<%= rs_resistance.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                        </div>
                                        <div style="margin-top: 20px">
                                            <input id="title-<%= rs_resistance.getString("ProductID")%>" type="text" value="<%= rs_resistance.getString("ProductName")%>" hidden>
                                            <button id="view-<%= rs_resistance.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%" onclick="location.href = '/Product/View/<%= rs_resistance.getString("ProductID")%>'">View</button>
                                        </div>
                                        <%
                                            String dateString = rs_resistance.getString("EXP");
                                            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                            Date expDate = formatter.parse(dateString);

                                            Date currentDate = new Date();
                                            String currentDateString = formatter.format(currentDate);
                                            Date currentDay = formatter.parse(currentDateString);

                                            if (Integer.parseInt(rs_resistance.getString("Quantity")) > 0 && expDate.after(currentDay)) {

                                        %>
                                        <div style="margin-top: 20px">
                                            <button id="cart-<%= rs_resistance.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%">Add to Cart</button>
                                        </div>
                                        <%
                                            }
                                        %>
                                        <div style="margin-top: 20px">
                                            <span class="badge badge-secondary sold-label"><%= rs_resistance.getString("SoldAmount")%> sold</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>

                    <div style="margin-bottom: 30px">
                        <h5>SKIN</h5>
                        <div class="row">
                            <%
                                ProductDAO dao_skin = new ProductDAO();
                                ResultSet rs_skin = dao_skin.getAll();
                                while (rs_skin.next()) {
                                    if (rs_skin.getString("ProductTypeID").equals("Sk")) {
                            %>
                            <div class="col-md-3">
                                <div class="card">
                                    <div align="center" style="margin-bottom: 20px">
                                        <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_skin.getString("PictureLink")%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h6 class="card-title text-truncate"><%= rs_skin.getString("ProductName")%></h6>
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_skin.getInt("Price")).replaceAll("\\s", "");
                                        %>   
                                        <div>
                                            <span class="card-text text-muted" id="exp-<%= rs_skin.getString("ProductID")%>"><b>EXP: </b><%= rs_skin.getString("EXP")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="quantity-<%= rs_skin.getString("ProductID")%>"><b>Quantity: </b><%= rs_skin.getString("Quantity")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="price-<%= rs_skin.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                        </div>
                                        <div style="margin-top: 20px">
                                            <input id="title-<%= rs_skin.getString("ProductID")%>" type="text" value="<%= rs_skin.getString("ProductName")%>" hidden>
                                            <input id="des-<%= rs_skin.getString("ProductID")%>" type="text" value="<%= rs_skin.getString("Description")%>" hidden>
                                            <button id="view-<%= rs_skin.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%" onclick="location.href = '/Product/View/<%= rs_skin.getString("ProductID")%>'">View</button>
                                        </div>
                                        <%
                                            String dateString = rs_skin.getString("EXP");
                                            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                            Date expDate = formatter.parse(dateString);

                                            Date currentDate = new Date();
                                            String currentDateString = formatter.format(currentDate);
                                            Date currentDay = formatter.parse(currentDateString);

                                            if (Integer.parseInt(rs_skin.getString("Quantity")) > 0 && expDate.after(currentDay)) {

                                        %>
                                        <div style="margin-top: 20px">
                                            <button id="cart-<%= rs_skin.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%">Add to Cart</button>
                                        </div>
                                        <%
                                            }
                                        %>
                                        <div style="margin-top: 20px">
                                            <span class="badge badge-secondary sold-label"><%= rs_skin.getString("SoldAmount")%> sold</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>

                    <div style="margin-bottom: 30px">
                        <h5>SLEEP DEPRIVATION</h5>
                        <div class="row">
                            <%
                                ProductDAO dao_sleep = new ProductDAO();
                                ResultSet rs_sleep = dao_sleep.getAll();
                                while (rs_sleep.next()) {
                                    if (rs_sleep.getString("ProductTypeID").equals("Sleep")) {
                            %>
                            <div class="col-md-3">
                                <div class="card">
                                    <div align="center" style="margin-bottom: 20px">
                                        <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_sleep.getString("PictureLink")%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h6 class="card-title text-truncate"><%= rs_sleep.getString("ProductName")%></h6>
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_sleep.getInt("Price")).replaceAll("\\s", "");
                                        %>   
                                        <div>
                                            <span class="card-text text-muted" id="exp-<%= rs_sleep.getString("EXP")%>"><b>EXP: </b><%= rs_sleep.getString("EXP")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="quantity-<%= rs_sleep.getString("ProductID")%>"><b>Quantity: </b><%= rs_sleep.getString("Quantity")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="price-<%= rs_sleep.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                        </div>
                                        <div style="margin-top: 20px">
                                            <input id="title-<%= rs_sleep.getString("ProductID")%>" type="text" value="<%= rs_sleep.getString("ProductName")%>" hidden>
                                            <input id="des-<%= rs_sleep.getString("ProductID")%>" type="text" value="<%= rs_sleep.getString("Description")%>" hidden>
                                            <button id="view-<%= rs_sleep.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%" onclick="location.href = '/Product/View/<%= rs_sleep.getString("ProductID")%>'">View</button>
                                        </div>
                                        <%
                                            String dateString = rs_sleep.getString("EXP");
                                            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                            Date expDate = formatter.parse(dateString);

                                            Date currentDate = new Date();
                                            String currentDateString = formatter.format(currentDate);
                                            Date currentDay = formatter.parse(currentDateString);

                                            if (Integer.parseInt(rs_sleep.getString("Quantity")) > 0 && expDate.after(currentDay)) {

                                        %>
                                        <div style="margin-top: 20px">
                                            <button id="cart-<%= rs_sleep.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%">Add to Cart</button>
                                        </div>
                                        <%
                                            }
                                        %>
                                        <div style="margin-top: 20px">
                                            <span class="badge badge-secondary sold-label"><%= rs_sleep.getString("SoldAmount")%> sold</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>

                    <div style="margin-bottom: 30px">
                        <h5>WEIGHT</h5>
                        <div class="row">
                            <%
                                ProductDAO dao_weight = new ProductDAO();
                                ResultSet rs_weight = dao_weight.getAll();
                                while (rs_weight.next()) {
                                    if (rs_weight.getString("ProductTypeID").equals("We")) {
                            %>
                            <div class="col-md-3">
                                <div class="card">
                                    <div align="center" style="margin-bottom: 20px">
                                        <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_weight.getString("PictureLink")%>" alt="alt"/>
                                    </div>
                                    <div class="card-body d-flex flex-column justify-content-between">
                                        <h6 class="card-title text-truncate"><%= rs_weight.getString("ProductName")%></h6>
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_weight.getInt("Price")).replaceAll("\\s", "");
                                        %>   
                                        <div>
                                            <span class="card-text text-muted" id="exp-<%= rs_weight.getString("ProductID")%>"><b>EXP: </b><%= rs_weight.getString("EXP")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="quantity-<%= rs_weight.getString("ProductID")%>"><b>Quantity: </b><%= rs_weight.getString("Quantity")%></span>
                                        </div>
                                        <div>
                                            <span class="card-text text-muted" id="price-<%= rs_weight.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                        </div>
                                        <div style="margin-top: 20px">
                                            <input id="title-<%= rs_weight.getString("ProductID")%>" type="text" value="<%= rs_weight.getString("ProductName")%>" hidden>
                                            <input id="des-<%= rs_weight.getString("ProductID")%>" type="text" value="<%= rs_weight.getString("Description")%>" hidden>
                                            <button id="view-<%= rs_weight.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%" onclick="location.href = '/Product/View/<%= rs_weight.getString("ProductID")%>'">View</button>
                                        </div>
                                        <%
                                            String dateString = rs_weight.getString("EXP");
                                            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                            Date expDate = formatter.parse(dateString);

                                            Date currentDate = new Date();
                                            String currentDateString = formatter.format(currentDate);
                                            Date currentDay = formatter.parse(currentDateString);

                                            if (Integer.parseInt(rs_weight.getString("Quantity")) > 0 && expDate.after(currentDay)) {

                                        %>
                                        <div style="margin-top: 20px">
                                            <button id="cart-<%= rs_weight.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white; width: 100%">Add to Cart</button>
                                        </div>
                                        <%
                                            }
                                        %>
                                        <div style="margin-top: 20px">
                                            <span class="badge badge-secondary sold-label"><%= rs_weight.getString("SoldAmount")%> sold</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </main>
            <!-- Footer -->            
            <%@ include file="/footer.jsp" %>

            <!-- Button GO TO TOP -->
            <button onclick="topFunction()" id="myBtn" title="Go to top"></button>
        </div>
        <!--Search function-->
        <script>
            function submitSearchForm(event) {
                event.preventDefault();
                const searchInput = removeUnicode(document.getElementById('search-input').value);
                window.location.href = '/Product/Search=' + searchInput;
            }
            function removeUnicode(str) {
                str = str.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
                return str.normalize("NFC");
            }
        </script>

        <!-- Link ALL JS From URL -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.1.js"></script>


        <!-- Link All File JS -->
        <script src="${pageContext.request.contextPath}/Resources/js/cart.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/gototop.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/tawk.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <script>
            const mySpan1 = document.getElementById('regError');

            function mainFunction() {
                const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
                if (myAttribute1 !== "") {
                    showSuccessInfToast(myAttribute1);
                }
            }

            window.addEventListener("load", function () {
                const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
                if (myAttribute1 !== "") {
                    showSuccessInfToast(myAttribute1);
                }
            });

            function showSuccessInfToast(myAttribute1) {
                toast({
                    title: 'Welcome!',
                    message: myAttribute1,
                    type: 'success',
                    duration: 4000
                });
            }
        </script>

    </body>
</html>