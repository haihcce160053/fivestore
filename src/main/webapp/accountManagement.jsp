<%-- 
    Document   : accountManagement
    Created on : Mar 3, 2023, 7:14:03 PM
    Author     : QuangQui
--%>

<%@page import="com.daos.OrderDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.AccountDAO"%>
<%@page import="com.models.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Management</title>
        <!-- MDB -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
        <link href="${pageContext.request.contextPath}/Resources/css/footer.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/gototop.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <link href="${pageContext.request.contextPath}/Resources/css/cart.css" rel="stylesheet" />
        <style>
            .btn {
                text-align: center; /* canh giữa văn bản trong nút */
                justify-content: center; /* canh giữa nội dung trong nút */
                align-items: center; /* căn giữa nội dung theo chiều dọc trong nút */
                margin: 0 0 5px 0;
            }


            #page-header {
                transition: top 0.5s;
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 999;
            }

            mdb-search-box {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background-color: #f5f5f5;
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 10px;
            }

            mdb-search-input {
                flex-grow: 1;
            }

            select {
                max-width: 150px;
                margin-left: 10px;
            }

            .form-control {
                height: 38px;
                border-radius: 4px;
                border: none;
                background-color: #fff;
                padding: 8px 12px;
                box-shadow: none;
            }

            .select-container {
                display: inline-block;
                position: relative;
            }

            .select-container::after {
                content: "\f078";
                font-family: FontAwesome;
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                pointer-events: none;
            }


        </style>
    </head>
    <%
        String mess = (String) request.getAttribute("mess");
        String mess1 = null;
        Account ac = (Account) session.getAttribute("informationAccount");
    %>
    <body>
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
                                    <a class="nav-link" href="/Product/Management/<%=ac.getUsername()%>" style="color: #9FA6B2;">Product Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/Order/" style="color: #9FA6B2;">Order Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/Statistics" style="color: #9FA6B2;">Revenue statistics</a>
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
            </div>
        </header>
        <main>
            <div class="container" style="margin-top: 100px;">
                <!-- User -->
                <mdb-search-box>
                    <mdb-search-input>
                        <input type="text" id="search" class="form-control" mdbInput placeholder="Search by Username">
                    </mdb-search-input>
                    <mdb-search-buttons>
                        <div class="select-container">
                            <select class="form-control" id="AllSelect">
                                <option value="All">All</option>
                                <option value="Admin">Admin</option>
                                <option value="Customer">Customer</option>
                            </select>
                        </div>
                    </mdb-search-buttons>
                </mdb-search-box>

                <table class="table">
                    <thead class="bg-secondary text-white" style="margin-top:50px;">
                        <tr>
                            <th scope="col">Username</th>
                            <th scope="col">FullName</th>
                            <th scope="col">Email</th>
                            <th scope="col">TypeAccount</th>
                            <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <% AccountDAO dao = new AccountDAO();
                        ResultSet rs = dao.getAll(); %>
                    <tbody>
                        <% while (rs.next()) {%>
                        <tr class="table-row">
                            <td class="col-1"><%= rs.getString("Username")%></td>
                            <td><%= rs.getString("FullName")%></td>
                            <td><%= rs.getString("Email")%></td>
                            <% if (rs.getString("AccountTypeID").equals("AD")) { %>
                            <td data-label="Type">Admin</td>
                            <% } else { %>
                            <td data-label="Type">Customer</td>
                            <% }%>
                            <td>
                                <a href="/Account/Change/<%= rs.getString("Username")%>" class="edit btn btn-primary" title="Change Permisstion">Change</a>
                                <a href="/Account/Delete/<%= rs.getString("Username")%>" class="delete btn btn-success" title="Delete Account">Delete</a>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>

        </main>
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
                <span id="regError" data-my-attribute="<%= mess1%>"></span>
            </div>          
        </div>
        <%
            }
        %>
        <div  class="my-toast">
            <div id="toast">
            </div>
        </div>
        <div class="overlay" id="overlay"></div>

        <div class="confirm-box" id="confirm-box">
            <div class="box-header">
                <h2>Are you sure you want to change permission account?</h2>
            </div>
            <div class="box-content">
                <p>Account will be changed permission!</p>
            </div>
            <div class="button-container">
                <button id="yes-button">Yes</button>
                <button id="no-button">No</button>
            </div>
        </div>
        <div class="overlay" id="overlay1"></div>

        <div class="confirm-box" id="confirm-box1">
            <div class="box-header">
                <h2>Are you sure you want to delete this account?</h2>
            </div>
            <div class="box-content">
                <p>Account will be deleted!</p>
            </div>
            <div class="button-container">
                <button id="yes-button1">Yes</button>
                <button id="no-button1">No</button>
            </div>
        </div>
        <button onclick="topFunction()" id="myBtn" title="Go to top"></button>
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
        <!-- Footer -->            
        <%@ include file="/footer.jsp" %>      
        <script>
            const selectElement = document.getElementById("AllSelect");
            const tableRows = document.querySelectorAll(".table-row");
            selectElement.addEventListener("change", (event) => {
                const selectedValue = event.target.value;
                tableRows.forEach((row) => {
                    const statusElement = row.querySelector("[data-label='Type']");
                    const statusValue = statusElement.innerText.trim();
                    if (selectedValue == "All" || selectedValue == statusValue) {
                        row.style.display = "table-row";
                    } else {
                        row.style.display = "none";
                    }
                });
            });
        </script>
        
        <script src="${pageContext.request.contextPath}/Resources/js/gototop.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/cart.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/searchAc.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/comfirmboxAc.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/showmessageaccountmanagement.js"></script>
    </body>
</html>
