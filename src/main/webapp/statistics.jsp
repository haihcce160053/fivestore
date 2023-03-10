<%-- 
    Document   : statistics
    Created on : Feb 27, 2023, 6:35:49 PM
    Author     : Huynh Chi Hai
--%>

<%@page import="com.models.Account"%>
<%@page import="com.daos.OrderDetailsDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.models.Order"%>
<%@page import="com.daos.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Revenue statistics</title>
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet" />
        <!-- MDB -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css" rel="stylesheet" />

        <!-- Jquery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
        <!--Table data-->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.css">

        <link href="${pageContext.request.contextPath}/Resources/css/footer.css" rel="stylesheet" />

        <style>
            table.dataTable thead .sorting:after,
            table.dataTable thead .sorting:before,
            table.dataTable thead .sorting_asc:after,
            table.dataTable thead .sorting_asc:before,
            table.dataTable thead .sorting_asc_disabled:after,
            table.dataTable thead .sorting_asc_disabled:before,
            table.dataTable thead .sorting_desc:after,
            table.dataTable thead .sorting_desc:before,
            table.dataTable thead .sorting_desc_disabled:after,
            table.dataTable thead .sorting_desc_disabled:before {
                bottom: .5em;
            }
        </style>
    </head>
    <%
        Account ac = (Account) session.getAttribute("informationAccount");
    %>
    <body>
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
                                    <a class="nav-link" href="/Account/Management/<%=ac.getUsername()%>" style="color:#9FA6B2;">Account Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/Product/Management/<%=ac.getUsername()%>" style="color: #9FA6B2;">Product Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/Order/" style="color: #9FA6B2;">Order Management</a>
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
                                    OrderDAO daoorder = new OrderDAO();
                                    int countOfOrder = daoorder.getNumberOrderByUsername(ac.getUsername());
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
            <div class="container" style="margin-top: 20px; margin-bottom: 120px">
                <div class="card" style="width: 100%;">
                    <div class="card-body">
                        <h5 class="card-title">Choose a statistical time</h5>
                        <div class="row">
                            <div style="margin-top: 20px" class="col-md-6 col-sm-6">
                                <div style="margin-top: 10px">
                                    <form action="/Statistics" method="post">
                                        <span style="margin-right: 20px">Statistics of the number of products sold by day: </span>
                                        <input type="date" name="choose-day">
                                        <button type="submit" class="btn" name="statistics-by-day" style="background-color: #303C5F; color: white; width: 100%; margin-top: 20px">
                                            Statistics</button>
                                    </form>
                                </div>
                            </div>
                            <div style="margin-top: 20px" class="col-md-6 col-sm-6">
                                <div style="margin-top: 10px">
                                    <form action="/Statistics" method="post">
                                        <span style="margin-right: 14px">
                                            Statistics of the number of products sold by month:</span>
                                        <input type="month" name="choose-month">
                                        <button type="submit" class="btn" name="statistics-by-month" style="background-color: #303C5F; color: white; width: 100%; margin-top: 20px">Statistics</button>
                                    </form> 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div style="margin-top: 20px; overflow: auto; height: 500px;">
                    <table id="tableAccount" class="table table-striped table-bordered table-sm" cellspacing="0" width="100%">
                        <thead>
                            <tr>
                                <th class="th-sm">Product ID</th>
                                <th class="th-sm">Quantity</th>
                                <th class="th-sm">Total Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if ((ResultSet) request.getAttribute("statistics-by-day-attribute") != null) {
                                    long TotalDayPrice = 0;
                                    ResultSet rs_day = (ResultSet) request.getAttribute("statistics-by-day-attribute");
                                    while (rs_day.next()) {
                                        TotalDayPrice = TotalDayPrice + Long.parseLong(rs_day.getString("TotalPrice"));
                            %>
                            <tr>                               
                                <td><%= rs_day.getString("ProductID")%></td>
                                <td><%= rs_day.getString("TotalQuantity")%></td>
                                <td><%= rs_day.getString("TotalPrice")%></td>
                            </tr>
                            <%
                                }
                                request.setAttribute("TotalDayPrice", TotalDayPrice);
                            } else if ((ResultSet) request.getAttribute("statistics-by-month-attribute") != null) {
                                long TotalMonthPrice = 0;
                                ResultSet rs_month = (ResultSet) request.getAttribute("statistics-by-month-attribute");
                                while (rs_month.next()) {
                                    TotalMonthPrice = TotalMonthPrice + Long.parseLong(rs_month.getString("TotalPrice"));
                            %>
                            <tr>                               
                                <td><%= rs_month.getString("ProductID")%></td>
                                <td><%= rs_month.getString("TotalQuantity")%></td>
                                <td><%= rs_month.getString("TotalPrice")%></td>
                            </tr>
                            <%
                                    }
                                    request.setAttribute("TotalMonthPrice", TotalMonthPrice);
                                }
                            %>
                        </tbody>

                    </table>
                </div>

                <%
                    if (request.getAttribute("TotalDayPrice") != null) {
                %>
                <div class="card" style="background-color: #303C5F; color:white; margin-top: 30px; margin-bottom: 30px">
                    <div class="card-body">
                        <h5 class="card-title">Total price</h5>
                        <p class="card-text"><%= request.getAttribute("TotalDayPrice")%>đ</p>
                    </div>
                </div>
                <%
                } else if (request.getAttribute("TotalMonthPrice") != null) {
                %>
                <div class="card" style="background-color: #303C5F; color:white; margin-top: 30px; margin-bottom: 30px">
                    <div class="card-body">
                        <h5 class="card-title">Total price</h5>
                        <p class="card-text"><%= request.getAttribute("TotalMonthPrice")%>đ</p>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </main>
        <!-- Footer -->            
        <%@ include file="/footer.jsp" %>
        <script>
            $(document).ready(function () {
                $('#tableAccount').DataTable({
                    lengthMenu: [
                        [-1],
                        ['All'],
                    ],
                    "searching": true // false to disable search (or any other option)
                });
                $('.dataTables_length').addClass('bs-select');
            });

            var datepicker = document.getElementById("statistics-by-day");

            datepicker.onchange = function () {
                var dateValue = datepicker.value;

                var dateParts = dateValue.split("-");
                var day = dateParts[2];
                var month = dateParts[1];
                var year = dateParts[0];

                var formattedDate = year + "-" + month + "-" + day;

                datepicker.value = formattedDate;
            }
        </script>

        <!-- MDB -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.js"></script>

        <!-- Jquery -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

        <!--Table data-->
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.js"></script>

    </body>
</html>
