<%-- 
    Document   : OrderManagement
    Created on : Feb 19, 2023, 8:50:40 PM
    Author     : LEO
--%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.models.Account"%>
<%@page import="com.models.Order"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.OrderDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Management</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <!-- MDB -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css" rel="stylesheet" />
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/css/accountinformation.css">
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/gototop.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/ordermanagement.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/footer.css" rel="stylesheet" />
    </head>
    <body>
        <%
            Account ac = (Account) session.getAttribute("informationAccount");
            if (ac.getAccountTypeId().equalsIgnoreCase("AD")) {
                String mess = (String) request.getAttribute("mess");
                String mess1 = null;
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
                                    <a class="nav-link" href="/Account/Management/<%=ac.getUsername()%>" style="color:#9FA6B2;">Account Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/Product/Management/<%=ac.getUsername()%>" style="color:#9FA6B2;">Product Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/Order/" style="color: white;">Order Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/Statistics" style="color:#9FA6B2;">Revenue statistics</a>
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
            <div class="container" style="margin-top: 20px;">
                <!-- User -->
                <div class="search-box">
                    <div style="margin-top: 20px;">
                        <select class="form-control" id="AllSelect">
                            <option value="All">All</option>
                            <option value="DXN">Đang Xác Nhận</option>
                            <option value="DCK">Đã chuyển khoản / Đang Xác Nhận</option>    
                            <option value="DLH">Đã Liên Hệ</option>
                            <option value="KLHD">Không Liên Hệ Được</option>                             
                            <option value="DVC">Đang Vận Chuyển</option>
                            <option value="DNH">Đã Nhận Hàng</option>
                            <option value="KNH">Không Nhận Hàng</option>
                            <option value="DHD">Đã Hủy Đơn</option>
                        </select>
                    </div>
                </div>

                <ul class="responsive-table">
                    <li class="table-header" style="display: flex !important; justify-content: space-between !important; padding: 15px 20px !important; margin-bottom: 10px !important; border-radius: 3px !important; background-color: #138496 !important; box-shadow: 0 0 9px 0 var(--color-shadow) !important;">
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
                    <li class="table-row" style="display: flex !important; justify-content: space-between !important; padding: 15px 20px !important; margin-bottom: 10px !important; border-radius: 3px !important; background-color: var(--color-white) !important; box-shadow: 0 0 9px 0 var(--color-shadow) !important;">
                        <div class="col col-1" data-label="OrderID"><%= rs.getString("OrderID")%></div>
                        <div class="col col-2" data-label="UserName"><%= rs.getString("Username")%></div>
                        <div class="col col-3" data-label="DeliveryAddress"><%= rs.getString("DeliveryAddress")%></div> 
                        <div class="col col-4" data-label="OrderTIme"><%= rs.getDate("OrderTime")%></div> 
                        <div class="col col-5">
                            <div class="Change-box">  
                                <select id="selectStatus">
                                    <option class="change" value="DXN" href="/Order/Change/<%= rs.getString("OrderID")%>/DXN" <%= rs.getString("OrderStatusID").equals("DXN") ? "selected" : ""%>>Đang Xác Nhận</option>
                                    <option class="change" value="DCK" href="/Order/Change/<%= rs.getString("OrderID")%>/DCK" <%= rs.getString("OrderStatusID").equals("DCK") ? "selected" : ""%>>Đã chuyển khoản</option>
                                    <option class="change" value="DLH" href="/Order/Change/<%= rs.getString("OrderID")%>/DLH" <%= rs.getString("OrderStatusID").equals("DLH") ? "selected" : ""%>>Đã Liên Hệ</option>
                                    <option class="change" value="KLHD" href="/Order/Change/<%= rs.getString("OrderID")%>/KLHD" <%= rs.getString("OrderStatusID").equals("KLHD") ? "selected" : ""%>>Không Liên Hệ Được</option>
                                    <option class="change" value="DVC" href="/Order/Change/<%= rs.getString("OrderID")%>/DVC" <%= rs.getString("OrderStatusID").equals("DVC") ? "selected" : ""%>>Đang Vận Chuyển</option>
                                    <option class="change" value="DNH" href="/Order/Change/<%= rs.getString("OrderID")%>/DNH" <%= rs.getString("OrderStatusID").equals("DNH") ? "selected" : ""%>>Đã Nhận Hàng</option>
                                    <option class="change" value="KNH" href="/Order/Change/<%= rs.getString("OrderID")%>/KNH" <%= rs.getString("OrderStatusID").equals("KNH") ? "selected" : ""%>>Không Nhận Hàng</option>
                                    <option class="change" value="DHD" href="/Order/Change/<%= rs.getString("OrderID")%>/DHD" <%= rs.getString("OrderStatusID").equals("DHD") ? "selected" : ""%>>Đã Hủy Đơn</option>
                                </select>              
                            </div>
                        </div>                    
                        <%
                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                            String formattedPrice = format.format(rs.getInt("TotalBill")).replace("₫", "VND").replaceAll("\\s", "");
                        %>
                        <div class="col col-6" data-label="TotalBill"><%= formattedPrice%></div>
                        <div class="col col-7" data-label="Action">
                            <a href="/Order/Detail/<%= rs.getString("OrderID")%>" class="edit" title="View Details" data-toggle="tooltip"><i class="material-icons">&#xe417;</i></a>
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
                     margin-bottom: 15px ;">
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

            <div class="overlay" id="overlay"> </div>

            <<div class="confirm-box" id="confirm-box">
                <div class="box-header">
                    <h2>Are you sure you want change order Status?</h2>
                </div>
                <div class="box-content">
                    <p>Your order status will be change!</p>
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
            <%
                }
            %>

        </main>
            
        <!-- Footer -->            
        <%@ include file="/footer.jsp" %>
        <button onclick="topFunction()" id="myBtn" title="Go to top"></button>

        <!-- Link ALL FIle JS --> 

        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/selectbox.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/confirmchangebox.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/gototop.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/showmessageordermanagement.js"></script>
    </body>
</html>
