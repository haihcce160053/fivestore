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
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
        <link href="${pageContext.request.contextPath}/Resources/css/footer.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/gototop.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/myorder.css" rel="stylesheet" />

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
                        <a class="navbar-brand" href="/home" style="color: white; font-size: 25px;"><b>FIVESTORE.VN - My purchase</b></a>
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
            <div class="container" style="margin-top: 20px;">
                <!-- User -->
                <div class="search-box">
                    <div class="search-input">
                        <input type="text" id="search" class="form-control" placeholder="Search by Order ID">
                    </div>
                    <div class="search-buttons">
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
                    </div>
                </div>

                <ul class="responsive-table">
                    <li class="table-header">
                        <div class="col col-1">OrderID</div>
                        <div class="col col-2">Username</div>
                        <div class="col col-3">DeliveryAddress</div>    
                        <div class="col col-4">OrderTime</div>
                        <div class="col col-5">Status</div>
                        <div class="col col-6">TotalBill</div>
                        <div class="col col-7">Actions</div>
                    </li>
                    <%                    while (rs.next()) {
                    %>
                    <li class="table-row">
                        <div class="col col-1" data-label="OrderID"><%= rs.getString("OrderID")%></div>
                        <div class="col col-2" data-label="UserName"><%= rs.getString("Username")%></div>
                        <div class="col col-3" data-label="DeliveryAddress"><%= rs.getString("DeliveryAddress")%></div> 
                        <div class="col col-4" data-label="OrderTIme"><%= rs.getDate("OrderTime")%></div> 
                        <div class="col col-5" data-label="Status"><%String nameOfStatusOrder = dao.getNameOfStatusOrder(rs.getString("OrderStatusID"));%><%=nameOfStatusOrder%></div>
                        <%
                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                            String formattedPrice = format.format(rs.getInt("TotalBill")).replace("₫", "VND").replaceAll("\\s", "");
                        %>
                        <div class="col col-6" data-label="TotalBill"><%=formattedPrice%></div>
                        <div class="col col-7" data-label="Action">
                            <a href="/Order/Detail/<%= rs.getString("OrderID")%>" class="edit" title="View Details" data-toggle="tooltip"><i class="material-icons">&#xe417;</i></a>
                            <%
                                if (rs.getString("OrderStatusID").equalsIgnoreCase("DHD")) {
                            %>
                            <a href="/Order/Change/Reorder/<%= rs.getString("OrderID")%>" class="edit" title="Re-order" data-toggle="tooltip"><span class="material-icons">update</span></a>


                            <%
                            } else {
                            %>
                            <a href="/Order/Cancel/Delete/<%= rs.getString("OrderID")%>" class="delete" title="Cancel" data-toggle="tooltip"><span class="material-icons">cancel</span></a>
                            <%
                                }
                            %>
                        </div>
                    </li>
                    <%
                        }
                    %>
                </ul>
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
            <div id="toast">


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
            <!-- Footer -->            
            <%@ include file="/footer.jsp" %>
        </main>



        <script src="${pageContext.request.contextPath}/Resources/js/gototop.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/searchAc.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/comfirmboxAc.js"></script>
        <script>
                const selectElement = document.getElementById("AllSelect");
                const tableRows = document.querySelectorAll(".table-row");

                selectElement.addEventListener("change", (event) => {
                    const selectedValue = event.target.value;
                    tableRows.forEach((row) => {
                        const statusElement = row.querySelector("[data-label='Status']");
                        const statusValue = statusElement.textContent.trim();
                        if (selectedValue === "All" || selectedValue === statusValue) {
                            row.style.display = "flex";
                        } else {
                            row.style.display = "none";
                        }
                    });
                });

        </script>
        <script>
            const mySpan1 = document.getElementById('regError');
            const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
            console.log(myAttribute1);
            mainFunction();

            function mainFunction() {
                if (myAttribute1 == "Noo") {
                    ShowErrorNotCancel();
                } else if (myAttribute1 == "YesD") {
                    showSuccessCancel();
                } else if (myAttribute1 == "NoD") {
                    showErrorCancel();
                } else if (myAttribute1 == "Not") {
                    showOrderToast();
                } else if (myAttribute1 == "YesR") {
                    showSuccessReorder();
                } else if (myAttribute1 == "NoR") {
                    showErrorReorder();
                } else if (myAttribute1 == "NooR") {
                    showErrorReorder();
                } else {
                    return;
                }
            }

            function ShowErrorNotCancel() {
                toast({
                    title: 'You cannot cancel this order!',
                    message: 'You can only cancel if the order is in the status of confirmation!',
                    type: 'error',
                    duration: 5000
                });
            }

            function showSuccessCancel() {
                toast({
                    title: 'Successfully!',
                    message: 'Cancel Order Successfully!',
                    type: 'success',
                    duration: 3000
                });
            }
            function showErrorCancel() {
                toast({
                    title: 'Failed!!',
                    message: 'Cancel Order Unsuccessfully!',
                    type: 'error',
                    duration: 3000
                });
            }

            function showOrderToast() {
                toast({
                    title: 'Notice!',
                    message: 'You do not have any orders!',
                    type: 'error',
                    duration: 3000
                });
            }
            function showSuccessReorder() {
                toast({
                    title: 'Successfully!',
                    message: 'Re-Order Successfully!',
                    type: 'success',
                    duration: 3000
                });
            }
            function showErrorReorder() {
                toast({
                    title: 'Failed!!',
                    message: 'Re-Order Unsuccessfully!',
                    type: 'error',
                    duration: 3000
                });
            }
        </script>
    </body>
</html>
