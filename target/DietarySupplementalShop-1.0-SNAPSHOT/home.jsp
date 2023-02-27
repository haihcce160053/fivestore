<%-- 
    Document   : hometest
    Created on : Feb 15, 2023, 7:22:51 AM
    Author     : Huynh Chi Hai
--%>

<%@page import="com.daos.OrderDAO"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
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
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet" />
        <!-- MDB -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css" rel="stylesheet" />
        <!-- Cart -->
        <link href="${pageContext.request.contextPath}/Resources/css/cart.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/gototop.css" rel="stylesheet" />
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
                                    <a class="nav-link" href="/Account/Management/<%=ac.getUsername()%>" style="color: white;">Account Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="" style="color: white;">Product Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/Order/" style="color: white;">Order Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/Statistics" style="color: white;">Revenue statistics</a>
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
                            %>
                            <%
                                if (ac != null && ac.getUsername().equalsIgnoreCase("Admin")) {
                            %>

                            <%
                            } else if (ac == null || (!ac.getUsername().equalsIgnoreCase("Admin"))) {
                            %>
                            <button id="view-cart-btn" type="button" class="btn me-3" style="background-color: #20283F; color: white">
                                MY CART <span id="cart-badge" class="badge badge-light" style="position: relative; top: -2px; right: -10px;">0</span>
                            </button>
                            <%
                                }
                            %>
                            <%
                                if (ac != null) {
                                    OrderDAO dao = new OrderDAO();
                                    int countOfOrder = dao.getNumberOrderByUsername(ac.getUsername());
                            %>
                            <button id="view-purchase-btn" type="button" class="btn me-3" style="background-color: #20283F; color: white" 
                                    onclick="location.href = '/Account/Order/<%= ac.getUsername()%>'">
                                MY Purchase<span id="cart-badge" class="badge badge-light" style="position: relative; top: -2px; right: -10px;"><%=countOfOrder%></span>

                            </button>
                            <%
                            } else {
                            %>
                            <button id="view-purchase-btn" type="button" class="btn me-3" style="background-color: #20283F; color: white"
                                    >
                                MY Purchase<span id="cart-badge" class="badge badge-light" style="position: relative; top: -2px; right: -10px;">0</span>
                            </button>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </nav>
                <div style="container">
                    <div class="row justify-content-center" style="margin-top: 50px;">
                        <div class="col-md-7 col-lg-5">
                            <div style="margin-bottom: 50px">
                                <h2 style="text-align: center">
                                    FIVESTORE.VN - DIETARY SUPPLEMENTS SHOP
                                </h2>
                            </div>
                            <div class="row justify-content-center" style="margin-bottom: 50px">
                                <div class="col-md-7 col-lg-5 d-flex align-items-center justify-content-center">
                                    <img src="../img/sale/sale.png" alt="alt" />
                                </div>
                            </div>
                            <div>
                                <form class="d-flex input-group w-auto">
                                    <input
                                        type="search"
                                        class="form-control rounded"
                                        placeholder="Search"
                                        aria-label="Search"
                                        />
                                    <span class="input-group-text border-0" id="search-addon">
                                        <i class="fas fa-search"></i>
                                    </span>
                                </form>
                            </div>                         
                        </div>
                    </div>
                </div>
            </div>
        </header>
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

        <!-- Modal -->
        <div class="modal fade" id="ProductDetailModal" tabindex="-1" aria-labelledby="ProductDetailModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modal-title">Modal title</h5>
                        <button type="button" class="btn-close" data-mdb-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body">...</div>
                    <div class="modal-footer">
                        <button type="button" class="btn" style="background-color: #303C5F; color: white" data-mdb-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <main>
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
                        <div class="col-md-2 my-3">
                            <div class="card">
                                <div align="center" style="margin-bottom: 20px">
                                    <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_dig.getString("PictureLink")%>" alt="alt"/>
                                </div>
                                <div class="card-body d-flex flex-column justify-content-between">
                                    <h6 class="card-title text-truncate"><%= rs_dig.getString("ProductName")%></h6>
                                    <div class="d-flex justify-content-between">
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_dig.getInt("Price")).replace("₫", "VND").replaceAll("\\s", "");
                                        %>
                                        <span class="card-text text-muted" id="price-<%= rs_dig.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                    </div>
                                    <div style="margin-top: 20px">
                                        <input id="title-<%= rs_dig.getString("ProductID")%>" type="text" value="<%= rs_dig.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_dig.getString("ProductID")%>" type="text" value="<%= rs_dig.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_dig.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_dig.getString("ProductID")%>').value, document.getElementById('des-<%= rs_dig.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_dig.getString("ProductID")%>"class="btn"  style="background-color: #303C5F; color: white">Add to Cart</button>
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
                        <div class="col-md-2 my-3">
                            <div class="card">
                                <div align="center" style="margin-bottom: 20px">
                                    <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_eyes.getString("PictureLink")%>" alt="alt"/>
                                </div>
                                <div class="card-body d-flex flex-column justify-content-between">
                                    <h6 class="card-title text-truncate"><%= rs_eyes.getString("ProductName")%></h6>
                                    <div class="d-flex justify-content-between">
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_eyes.getInt("Price")).replace("₫", "VND").replaceAll("\\s", "");
                                        %>
                                        <span class="card-text text-muted" id="price-<%= rs_eyes.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                    </div>
                                    <div style="margin-top: 20px">
                                        <input id="title-<%= rs_eyes.getString("ProductID")%>" type="text" value="<%= rs_eyes.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_eyes.getString("ProductID")%>" type="text" value="<%= rs_eyes.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_eyes.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_eyes.getString("ProductID")%>').value, document.getElementById('des-<%= rs_eyes.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_eyes.getString("ProductID")%>"class="btn"  style="background-color: #303C5F; color: white">Add to Cart</button>
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
                        <div class="col-md-2 my-3">
                            <div class="card">
                                <div align="center" style="margin-bottom: 20px">
                                    <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_blood.getString("PictureLink")%>" alt="alt"/>
                                </div>
                                <div class="card-body d-flex flex-column justify-content-between">
                                    <h6 class="card-title text-truncate"><%= rs_blood.getString("ProductName")%></h6>
                                    <div class="d-flex justify-content-between">
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_blood.getInt("Price")).replace("₫", "VND").replaceAll("\\s", "");
                                        %>
                                        <span class="card-text text-muted" id="price-<%= rs_blood.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                    </div>
                                    <div style="margin-top: 20px">
                                        <input id="title-<%= rs_blood.getString("ProductID")%>" type="text" value="<%= rs_blood.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_blood.getString("ProductID")%>" type="text" value="<%= rs_blood.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_blood.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_blood.getString("ProductID")%>').value, document.getElementById('des-<%= rs_blood.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_blood.getString("ProductID")%>"class="btn"  style="background-color: #303C5F; color: white">Add to Cart</button>
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
                        <div class="col-md-2 my-3">
                            <div class="card">
                                <div align="center" style="margin-bottom: 20px">
                                    <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_liver.getString("PictureLink")%>" alt="alt"/>
                                </div>
                                <div class="card-body d-flex flex-column justify-content-between">
                                    <h6 class="card-title text-truncate"><%= rs_liver.getString("ProductName")%></h6>
                                    <div class="d-flex justify-content-between">
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_liver.getInt("Price")).replace("₫", "VND").replaceAll("\\s", "");
                                        %>
                                        <span class="card-text text-muted" id="price-<%= rs_liver.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                    </div>
                                    <div style="margin-top: 20px">
                                        <input id="title-<%= rs_liver.getString("ProductID")%>" type="text" value="<%= rs_liver.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_liver.getString("ProductID")%>" type="text" value="<%= rs_liver.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_liver.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_liver.getString("ProductID")%>').value, document.getElementById('des-<%= rs_liver.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_liver.getString("ProductID")%>"class="btn"  style="background-color: #303C5F; color: white">Add to Cart</button>
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
                        <div class="col-md-2 my-3">
                            <div class="card">
                                <div align="center" style="margin-bottom: 20px">
                                    <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_resistance.getString("PictureLink")%>" alt="alt"/>
                                </div>
                                <div class="card-body d-flex flex-column justify-content-between">
                                    <h6 class="card-title text-truncate"><%= rs_resistance.getString("ProductName")%></h6>
                                    <div class="d-flex justify-content-between">
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_resistance.getInt("Price")).replace("₫", "VND").replaceAll("\\s", "");
                                        %>
                                        <span class="card-text text-muted" id="price-<%= rs_resistance.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                    </div>
                                    <div style="margin-top: 20px">
                                        <input id="title-<%= rs_resistance.getString("ProductID")%>" type="text" value="<%= rs_resistance.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_resistance.getString("ProductID")%>" type="text" value="<%= rs_resistance.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_resistance.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_resistance.getString("ProductID")%>').value, document.getElementById('des-<%= rs_resistance.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_resistance.getString("ProductID")%>"class="btn"  style="background-color: #303C5F; color: white">Add to Cart</button>
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
                        <div class="col-md-2 my-3">
                            <div class="card">
                                <div align="center" style="margin-bottom: 20px">
                                    <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_skin.getString("PictureLink")%>" alt="alt"/>
                                </div>
                                <div class="card-body d-flex flex-column justify-content-between">
                                    <h6 class="card-title text-truncate"><%= rs_skin.getString("ProductName")%></h6>
                                    <div class="d-flex justify-content-between">
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_skin.getInt("Price")).replace("₫", "VND").replaceAll("\\s", "");
                                        %>
                                        <span class="card-text text-muted" id="price-<%= rs_skin.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                    </div>
                                    <div style="margin-top: 20px">
                                        <input id="title-<%= rs_skin.getString("ProductID")%>" type="text" value="<%= rs_skin.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_skin.getString("ProductID")%>" type="text" value="<%= rs_skin.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_skin.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_skin.getString("ProductID")%>').value, document.getElementById('des-<%= rs_skin.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_skin.getString("ProductID")%>"class="btn"  style="background-color: #303C5F; color: white">Add to Cart</button>
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
                        <div class="col-md-2 my-3">
                            <div class="card">
                                <div align="center" style="margin-bottom: 20px">
                                    <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_sleep.getString("PictureLink")%>" alt="alt"/>
                                </div>
                                <div class="card-body d-flex flex-column justify-content-between">
                                    <h6 class="card-title text-truncate"><%= rs_sleep.getString("ProductName")%></h6>
                                    <div class="d-flex justify-content-between">
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_sleep.getInt("Price")).replace("₫", "VND").replaceAll("\\s", "");
                                        %>
                                        <span class="card-text text-muted" id="price-<%= rs_sleep.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                    </div>
                                    <div style="margin-top: 20px">
                                        <input id="title-<%= rs_sleep.getString("ProductID")%>" type="text" value="<%= rs_sleep.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_sleep.getString("ProductID")%>" type="text" value="<%= rs_sleep.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_sleep.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_sleep.getString("ProductID")%>').value, document.getElementById('des-<%= rs_sleep.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_sleep.getString("ProductID")%>"class="btn"  style="background-color: #303C5F; color: white">Add to Cart</button>
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
                        <div class="col-md-2 my-3">
                            <div class="card">
                                <div align="center" style="margin-bottom: 20px">
                                    <img class="card-img-top" style="width: 150px; height: 150px" src="<%= rs_weight.getString("PictureLink")%>" alt="alt"/>
                                </div>
                                <div class="card-body d-flex flex-column justify-content-between">
                                    <h6 class="card-title text-truncate"><%= rs_weight.getString("ProductName")%></h6>
                                    <div class="d-flex justify-content-between">
                                        <%
                                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                            String formattedPrice = format.format(rs_weight.getInt("Price")).replace("₫", "VND").replaceAll("\\s", "");
                                        %>
                                        <span class="card-text text-muted" id="price-<%= rs_weight.getString("ProductID")%>"><b>Price: </b><%= formattedPrice%></span>
                                    </div>
                                    <div style="margin-top: 20px">
                                        <input id="title-<%= rs_weight.getString("ProductID")%>" type="text" value="<%= rs_weight.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_weight.getString("ProductID")%>" type="text" value="<%= rs_weight.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_weight.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_weight.getString("ProductID")%>').value, document.getElementById('des-<%= rs_weight.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_weight.getString("ProductID")%>"class="btn"  style="background-color: #303C5F; color: white">Add to Cart</button>
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
        </main>

        <button onclick="topFunction()" id="myBtn" title="Go to top"></button>
        <script>
            function ShowProductDetail(title, description) {
                document.getElementById("modal-title").innerHTML = title;
                const productInfo = description.split(":");
                console.log(productInfo);
                document.getElementById("modal-body").innerHTML = description;
            }
        </script>
        <!-- MDB -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.js"></script>
        <!-- Jquery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
        <!--Link Java Script-->
        <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/cart.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/gototop.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/searchhome.js"></script>
    </body>
</html>