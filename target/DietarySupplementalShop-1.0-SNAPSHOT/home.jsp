<%-- 
    Document   : hometest
    Created on : Feb 15, 2023, 7:22:51 AM
    Author     : Huynh Chi Hai
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
        <style>

            #myBtn {
                display: none;
                position: fixed;
                bottom: 10px;
                right: 43px;
                z-index: 99;
                font-size: 18px;
                border: none;
                outline: none;
                background: linear-gradient(to bottom, #FF6B6B, #FF8E8E);
                color: white;
                cursor: pointer;
                padding: 15px;
                border-radius: 4px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }

            #myBtn:hover {
                background-color: #333;
                transition: background-color 0.2s ease-in-out;
            }

            #myBtn:before {
                content: "\2191";
            }

            #cart {
                position: fixed;
                top: 0;
                right: 0;
                width: auto;
                margin-top: 80px;
                background-color: white;
                border: 1px solid #ddd;
                border-radius: 10px 0 0 0;
                box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);
                padding: 20px;
                display: none;
                z-index: 99999;
            }

            #cart h3 {
                font-size: 24px;
                margin-bottom: 20px;
                color: #20283F;
            }

            #cart ul {
                list-style: none;
                padding: 0;
                margin: 0;
                margin-bottom: 20px;
            }

            #cart li {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 10px;
            }

            #cart li span {
                font-size: 16px;
                color: #20283F;
            }

            #cart-total {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            #cart-total p {
                font-size: 18px;
                color: #20283F;
            }

            #cart-total-amount {
                font-weight: bold;
            }

            #checkout-button {
                display: block;
                width: 100%;
                background-color: #20283F;
                color: white;
                border: none;
                border-radius: 5px;
                font-size: 18px;
                padding: 10px 0;
                cursor: pointer;
                transition: background-color 0.2s ease;
            }

            #checkout-button:hover {
                background-color: #28364B;
            }

        </style>
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
                                Giỏ hàng <span id="cart-badge" class="badge badge-light">0</span>
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
                                    FIVESOTRE.VN - DIETARY SUPPLEMENTAL SHOP
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
        <div id="cart" style="display: none;">
            <h3>Cart</h3>
            <ul id="cart-items">

            </ul>
            <div id="cart-total">
                <p>Total: <span id="cart-total-amount">$0.00</span></p>
            </div>
            <button id="checkout-button">Checkout</button>
        </div>
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
                        <%                            ProductDAO dao_dig = new ProductDAO();
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
                                        <span class="card-text text-muted" id="price-<%= rs_dig.getString("ProductID")%>"><%= rs_dig.getInt("Price")%>VND</span>

                                    </div>
                                    <div>
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
                                        <span class="card-text text-muted" id="price-">$<%= rs_eyes.getFloat("Price")%></span>
                                    </div>
                                    <div>
                                        <input id="title-<%= rs_eyes.getString("ProductID")%>" type="text" value="<%= rs_eyes.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_eyes.getString("ProductID")%>" type="text" value="<%= rs_eyes.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_eyes.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_eyes.getString("ProductID")%>').value, document.getElementById('des-<%= rs_eyes.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_eyes.getString("ProductID")%>"class="btn" style="background-color: #303C5F; color: white">Add to Cart</button>
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
                                        <span class="card-text text-muted" id="price-">$<%= rs_blood.getFloat("Price")%></span>
                                    </div>
                                    <div>
                                        <input id="title-<%= rs_blood.getString("ProductID")%>" type="text" value="<%= rs_blood.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_blood.getString("ProductID")%>" type="text" value="<%= rs_blood.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_blood.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_blood.getString("ProductID")%>').value, document.getElementById('des-<%= rs_blood.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_blood.getString("ProductID")%>"class="btn" style="background-color: #303C5F; color: white">Add to Cart</button>
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
                                        <span class="card-text text-muted" id="price-">$<%= rs_liver.getFloat("Price")%></span>
                                    </div>
                                    <div>
                                        <input id="title-<%= rs_liver.getString("ProductID")%>" type="text" value="<%= rs_liver.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_liver.getString("ProductID")%>" type="text" value="<%= rs_liver.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_liver.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_liver.getString("ProductID")%>').value, document.getElementById('des-<%= rs_liver.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_liver.getString("ProductID")%>"class="btn" style="background-color: #303C5F; color: white">Add to Cart</button>
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
                                        <span class="card-text text-muted" id="price-">$<%= rs_resistance.getFloat("Price")%></span>
                                    </div>
                                    <div>
                                        <input id="title-<%= rs_resistance.getString("ProductID")%>" type="text" value="<%= rs_resistance.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_resistance.getString("ProductID")%>" type="text" value="<%= rs_resistance.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_resistance.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_resistance.getString("ProductID")%>').value, document.getElementById('des-<%= rs_resistance.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_resistance.getString("ProductID")%>"class="btn" style="background-color: #303C5F; color: white">Add to Cart</button>
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
                                        <span class="card-text text-muted" id="price-">$<%= rs_skin.getFloat("Price")%></span>
                                    </div>
                                    <div>
                                        <input id="title-<%= rs_skin.getString("ProductID")%>" type="text" value="<%= rs_skin.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_skin.getString("ProductID")%>" type="text" value="<%= rs_skin.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_skin.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_skin.getString("ProductID")%>').value, document.getElementById('des-<%= rs_skin.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_skin.getString("ProductID")%>"class="btn" style="background-color: #303C5F; color: white">Add to Cart</button>
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
                                        <span class="card-text text-muted" id="price-">$<%= rs_sleep.getFloat("Price")%></span>
                                    </div>
                                    <div>
                                        <input id="title-<%= rs_sleep.getString("ProductID")%>" type="text" value="<%= rs_sleep.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_sleep.getString("ProductID")%>" type="text" value="<%= rs_sleep.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_sleep.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_sleep.getString("ProductID")%>').value, document.getElementById('des-<%= rs_sleep.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_sleep.getString("ProductID")%>"class="btn" style="background-color: #303C5F; color: white">Add to Cart</button>
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
                                        <span class="card-text text-muted" id="price-<%= rs_weight.getString("ProductID")%>">$<%= rs_weight.getFloat("Price")%></span>
                                    </div>
                                    <div>
                                        <input id="title-<%= rs_weight.getString("ProductID")%>" type="text" value="<%= rs_weight.getString("ProductName")%>" hidden>
                                        <input id="des-<%= rs_weight.getString("ProductID")%>" type="text" value="<%= rs_weight.getString("Description")%>" hidden>
                                        <button id="view-<%= rs_weight.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs_weight.getString("ProductID")%>').value, document.getElementById('des-<%= rs_weight.getString("ProductID")%>').value)">View</button>
                                        <button id="cart-<%= rs_weight.getString("ProductID")%>"class="btn" style="background-color: #303C5F; color: white">Add to Cart</button>
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
        <!-- MDB -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.js"></script>
        <!-- Jquery -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

        <!--Link Java Script-->
        <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/styles/bootstrap4/popper.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/styles/bootstrap4/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/custom.js"></script>
        <script>//Quang Qui
            // Get the view cart button
            const viewCartBtn = document.querySelector("#view-cart-btn");

            // Add a click event listener to the view cart button
            viewCartBtn.addEventListener("click", toggleCart);

            // Get the cart element
            const cart = document.querySelector("#cart");

            // Get the cart items element
            const cartItems = document.querySelector("#cart-items");

            // Get the cart total amount element
            const cartTotalAmount = document.querySelector("#cart-total-amount");

            // Get the checkout button
            const checkoutBtn = document.querySelector("#checkout-button");

            // Initialize the cart items array
            let cartItemsArray = [];

            // Add a click event listener to the checkout button
            checkoutBtn.addEventListener("click", checkout);

            // Define the toggleCart function
            function toggleCart() {
                // Toggle the display property of the cart element
                cart.style.display = cart.style.display === "none" ? "block" : "none";
            }

            document.addEventListener('DOMContentLoaded', function () {
                // Lặp qua tất cả các nút "Add to Cart" và gán sự kiện click cho từng nút
                var addToCartButtons = document.querySelectorAll('button[id^="cart-"]');
                for (var i = 0; i < addToCartButtons.length; i++) {
                    addToCartButtons[i].addEventListener('click', function () {
                        // Lấy id của sản phẩm từ id của nút "Add to Cart"
                        var productId = this.id.split('-')[1];
                        var productName = document.getElementById("title-" + productId).value;
                        var price = document.getElementById("price-" + productId).innerHTML.replace("VND", "");

                        // Gọi hàm addToCart với các tham số tương ứng
                        addToCart(productId, productName, price);
                    });
                }
            });

            // Define the addToCart function
            function addToCart(productId, productName, price) {
                // Find the item in the cart items array with the same product id
                const cartItem = cartItemsArray.find((item) => item.productId === productId);

                if (cartItem) {
                    // If the item already exists in the cart, increase its quantity by 1
                    cartItem.quantity++;
                } else {
                    // If the item does not exist in the cart, add it to the cart items array
                    cartItemsArray.push({productId, productName, price, quantity: 1});
                }

                // Update the cart badge
                updateCartBadge();

                // Update the cart items list
                updateCartItems();
            }

            // Define the updateCartBadge function
            function updateCartBadge() {
                // Get the cart badge element
                const cartBadge = document.querySelector("#cart-badge");

                // Get the total quantity of items in the cart items array
                const totalQuantity = cartItemsArray.reduce((total, item) => total + item.quantity, 0);

                // Set the text content of the cart badge element to the total quantity
                cartBadge.textContent = totalQuantity;
            }

            // Define the updateCartItems function
            function updateCartItems() {

                // Clear the cart items element
                cartItems.innerHTML = "";

                // Initialize the total price variable
                let totalPrice = 0;

                // Loop through the cart items array
                cartItemsArray.forEach((item) => {


                    //
                    totalofProduct = item.price * item.quantity;
                    // Create a list item element
                    const listItem = document.createElement("li");

                    // Set the text content of the list item element to the product name and quantity
                    listItem.textContent = "" + item.productName + " " + "x" + " " + item.quantity + " = " + totalofProduct;

                    // Append the list item element to the cart items element
                    cartItems.appendChild(listItem);

                    // Add the price of the item to the total price
                    totalPrice += item.price * item.quantity;


                });

                // Set the text content of the cart total amount element to the total price
                cartTotalAmount.textContent = "" + totalPrice + " VND";
            }

            // Define the checkout function
            function checkout() {
                // Display an alert with the total price
                const totalPrice = parseFloat(cartTotalAmount.textContent.slice(1));
                alert(`Total: $${totalPrice.toFixed(2)}`);

                // Reset the cart items array and update the cart badge and cart items list
                cartItemsArray = [];
                updateCartBadge();
                updateCartItems();
            }


        </script>
        <script>
            function ShowProductDetail(title, description) {
                document.getElementById("modal-title").innerHTML = title;
                document.getElementById("modal-body").innerHTML = description;
            }
        </script>
        <script>//Quang Qui
            const inputSearch = document.querySelector('input[aria-label="Search"]');

            inputSearch.addEventListener('input', () => {
                const searchText = inputSearch.value.toLowerCase();
                const productTitles = document.querySelectorAll('.card-title');

                productTitles.forEach(title => {
                    const titleText = title.textContent.toLowerCase();
                    const card = title.closest('.card');

                    if (titleText.includes(searchText)) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                });
            });

        </script>
        <script>//Quang Qui
            $(document).ready(function () {

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
    </body>
</html>