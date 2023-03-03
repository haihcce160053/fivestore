<%-- 
    Document   : myOrder
    Created on : Feb 22, 2023, 3:38:47 PM
    Author     : QuangQui
--%>

<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.OrderDAO"%>
<%@page import="com.models.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Purchase</title>
        <!-- MDB -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
        <link href="${pageContext.request.contextPath}/Resources/css/footer.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/gototop.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <style>
            .btn {
                width: 100px; 
                height: 40px;
                margin: 5px 5px 5px 5px;
                text-align: center; 
                display: inline-flex; 
                justify-content: center; 
                align-items: center;
            }
            
            #page-header {
                transition: top 0.5s;
                position: fixed;
                top: 0;
                width: 100%;
                z-index: 999;
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
                <nav class="navbar navbar-expand-lg" id="navbar-main" style="background-color: #303C5F;">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="/home" style="color: white; font-size: 25px;"><b>FIVESTORE.VN -  MY PURCHASE</b></a>
                    </div>
                </nav>
            </div>
        </header>

        <main>
            <%
                if (ac != null) {
                    OrderDAO dao = new OrderDAO();
                    ResultSet rs = dao.getOrderByUsername(ac.getUsername());
                    int orderbyusername = dao.getNumberOrderByUsername(ac.getUsername());
                    if (orderbyusername != 0) {

            %>
            <div class="container" style="margin-top: 100px;">
                <!-- User -->
                <mdb-search-box>
                    <mdb-search-input>
                        <input type="text" id="search" class="form-control" placeholder="Search by Order ID">
                    </mdb-search-input>
                    <mdb-search-buttons>
                        <div class="select-container">
                            <select class="form-control" id="AllSelect">
                                <option value="All">All</option>
                                <option value="Đang Xác Nhận">Đang Xác Nhận</option>
                                <option value="Đã Chuyển Khoản">Đã chuyển khoản / Đang Xác Nhận</option>    
                                <option value="Đã Liên Hệ">Đã Liên Hệ</option>
                                <option value="Không Liên Hệ Được">Không Liên Hệ Được</option>                             
                                <option value="Đang Vận Chuyển">Đang Vận Chuyển</option>
                                <option value="Đã Nhận Hàng">Đã Nhận Hàng</option>
                                <option value="Không Nhận Hàng">Không Nhận Hàng</option>
                                <option value="Đã Hủy Đơn">Đã Hủy Đơn</option>
                            </select>
                        </div>
                    </mdb-search-buttons>
                </mdb-search-box>

                <table class="table">
                    <thead class="bg-secondary text-white" style="margin-top:50px;">
                        <tr>
                            <th scope="col">OrderID</th>
                            <th scope="col">Username</th>
                            <th scope="col">DeliveryAddress</th>
                            <th scope="col">OrderTime</th>
                            <th scope="col">Status</th>
                            <th scope="col">TotalBill</th>
                            <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <tbody >
                        <% while (rs.next()) {%>
                        <tr class="table-row">
                            <td><%= rs.getString("OrderID")%></td>
                            <td><%= rs.getString("Username")%></td>
                            <td><%= rs.getString("DeliveryAddress")%></td>
                            <td><%= rs.getDate("OrderTime")%></td>
                            <td data-label="Status">
                                <% String nameOfStatusOrder = dao.getNameOfStatusOrder(rs.getString("OrderStatusID"));%>
                                <%= nameOfStatusOrder%>
                            </td>
                            <td >
                                <%
                                    NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                                    String formattedPrice = format.format(rs.getInt("TotalBill")).replace("₫", "VND").replaceAll("\\s", "");
                                %>
                                <%= formattedPrice%>
                            </td>
                            <td>
                                <a href="/Order/Detail/<%= rs.getString("OrderID")%>" class="btn btn-primary" title="View Details">View Details</a>
                                <%
                                    if (rs.getString("OrderStatusID").equalsIgnoreCase("DHD")) {
                                %>
                                <a href="/Order/Change/Reorder/<%= rs.getString("OrderID")%>" class="btn btn-success" title="Re-order">Re-order</a>
                                <%
                                } else {
                                %>
                                <a href="/Order/Cancel/Delete/<%= rs.getString("OrderID")%>" class="btn btn-danger" title="Cancel">Cancel</a>
                                <%
                                    }
                                %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>

            </div>
            <%
            } else {
                mess1 = "Not";
            %>
            <a href="/"><img src="https://thumbs.dreamstime.com/b/order-now-premium-red-tag-sign-order-now-isolated-premium-red-tag-sign-abstract-illustration-124737434.jpg" alt="alt" style="width: auto"/></a>
                <%
                        }
                    }
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
                    <h2>Are you sure you want to re-order?</h2>
                </div>
                <div class="box-content">
                    <p>Your order will be ordered again!</p>
                </div>
                <div class="button-container">
                    <button id="yes-button">Yes</button>
                    <button id="no-button">No</button>
                </div>
            </div>
            <div class="overlay" id="overlay1"></div>

            <div class="confirm-box" id="confirm-box1">
                <div class="box-header">
                    <h2>Are you sure you want to cancel this order?</h2>
                </div>
                <div class="box-content">
                    <p>Order will be canceled!</p>
                </div>
                <div class="button-container">
                    <button id="yes-button1">Yes</button>
                    <button id="no-button1">No</button>
                </div>
            </div>
            <button onclick="topFunction()" id="myBtn" title="Go to top"></button>

        </main>

        <!-- Footer -->            
        <%@ include file="/footer.jsp" %>

        <!-- Link All File JS --> 
        <script>
            const selectElement = document.getElementById("AllSelect");
            const tableRows = document.querySelectorAll(".table-row");
            console.log(tableRows);
            selectElement.addEventListener("change", (event) => {
                const selectedValue = event.target.value;
                console.log(selectedValue);
                tableRows.forEach((row) => {
                    const statusElement = row.querySelector("[data-label='Status']");

                    const statusValue = statusElement.innerText.trim();
                    console.log(statusValue);
                    if (selectedValue == "All" || selectedValue == statusValue) {
                        row.style.display = "table-row";
                    } else {
                        row.style.display = "none";
                    }
                });
            });
        </script>
        <script src="${pageContext.request.contextPath}/Resources/js/gototop.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/searchAc.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/comfirmboxAc.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/showmessagemyorder.js"></script>
    </body>
</html>
