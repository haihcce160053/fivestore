<%-- 
    Document   : OrderManagement
    Created on : Feb 19, 2023, 8:50:40 PM
    Author     : LEO
--%>
<%@page import="com.models.Order"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.OrderDAO"%>
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
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/AccountInformation/style.css">
                <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />
        <style>
            /* Use variables to store commonly used colors and font sizes */
            :root {
                --color-gray: #6C7A89;
                --color-light-gray: #95A5A6;
                --color-white: #ffffff;
                --color-shadow: rgba(0, 0, 0, 0.1);
                --font-body: 'lato', sans-serif;
            }

            /* Set font and default styles for body */
            body {
                font-family: var(--font-body);
            }

            /* Center and set max-width for container */
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 10px;
            }

            /* Style for list items */
            li {
                display: flex;
                justify-content: space-between;
                padding: 15px 20px; /* Decrease padding */
                margin-bottom: 10px; /* Decrease margin */
                border-radius: 3px;
                background-color: var(--color-white);
                box-shadow: 0 0 9px 0 var(--color-shadow);
            }

            /* Table header styles */
            .table-header {
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.03em;
                background-color: var(--color-light-gray);
            }

            /* Table row styles */
            .table-row {
                background-color: var(--color-white);
                box-shadow: 0 0 9px 0 var(--color-shadow);
            }

            /* Column styles */
            .col-1 {
                flex-basis: 10%;
            }

            .col-2 {
                flex-basis: 15%;
            }

            .col-3 {
                flex-basis: 30%;
            }

            .col-4 {
                flex-basis: 15%;
            }

            .col-5 {
                flex-basis: 10%;
            }

            .col-6 {
                flex-basis: 10%;
            }

            .col-7 {
                flex-basis: 10%;
            }
            /* Media query for tablet screens */
            @media all and (min-width: 768px) and (max-width: 1023px) {
                /* Adjust max-width and padding for container */
                .container {
                    max-width: 90%;
                    padding: 0 20px;
                }

                /* Adjust column widths */
                .col-1 {
                    flex-basis: 20%;
                }

                .col-2 {
                    flex-basis: 40%;
                }

                .col-3 {
                    flex-basis: 40%;
                }

                .col-4 {
                    flex-basis: 0%;
                    display: none;
                }

                .col-5 {
                    flex-basis: 0%;
                    display: none;
                }

                .col-6 {
                    flex-basis: 0%;
                    display: none;
                }

                .col-7 {
                    flex-basis: 0%;
                    display: none;
                }

                /* Adjust column label styles */
                .col:before {
                    display: none;
                }
            }

            /* Media query for mobile screens */
            @media all and (max-width: 767px) {
                /* Adjust max-width and padding for container */
                .container {
                    max-width: 100%;
                    padding: 0 15px;
                }

                /* Adjust column widths */
                .col-1 {
                    flex-basis: 100%;
                }

                .col-2 {
                    flex-basis: 0%;
                    display: none;
                }

                .col-3 {
                    flex-basis: 0%;
                    display: none;
                }

                .col-4 {
                    flex-basis: 0%;
                    display: none;
                }

                .col-5 {
                    flex-basis: 0%;
                    display: none;
                }

                .col-6 {
                    flex-basis: 0%;
                    display: none;
                }

                .col-7 {
                    flex-basis: 0%;
                    display: none;
                }
                /* Adjust column label styles */
                .col:before {
                    display: none;
                }

                /* Adjust list item padding */
                li {
                    padding: 10px 15px;
                }

                /* Adjust font size for search box */
                .search-box input[type="text"] {
                    font-size: 12px;
                }
            }


            /* Search box styles */
            .search-box {
                display: flex;
                justify-content: flex-end;
                margin-bottom: 20px;
            }

            .search-box .input-group {
                position: relative;
                display: flex;
            }

            .search-box input[type="text"] {
                font-size: 14px;
                padding: 10px 12px;
                border: 1px solid var(--color-gray);
                border-radius: 3px;
                background-color: var(--color-white);
                box-shadow: 0 0 9px 0 var(--color-shadow);
                outline: none;
            }

            .search-box input[type="text"]:focus {
                border-color: var(--color-light-gray);
            }




            #myBtn {
                display: none;
                position: fixed;
                bottom: 10px;
                right: 43px;
                z-index: 99;
                font-size: 18px;
                border: none;
                outline: none;
                background-color: red;
                color: white;
                cursor: pointer;
                padding: 15px;
                border-radius: 4px;
            }

            #myBtn:hover {
                background-color: #555;
            }

            #toast {
                position: fixed;
                top: 32px;
                right: 32px;
                z-index: 9;
            }

            .toast {
                display: flex;
                align-items: center;
                background-color: #fff;
                border-radius: 2px;
                padding: 20px 0;
                min-width: 400px;
                max-width: 450px;
                border-left: 4px solid;
                box-shadow: 0 5px 8px rgba(0, 0, 0, 0.08);
                transition: all linear 0.3s;
            }

            @keyframes slideInLeft {
                from {
                    opacity: 0;
                    transform: translateX(calc(100% + 32px));
                }
                to {
                    opacity: 1;
                    transform: translateX(0);
                }
            }

            @keyframes fadeOut {
                to {
                    opacity: 0;
                }
            }

            .toast--success {
                border-color: #47d864;
            }

            .toast--success .toast__icon {
                color: #47d864;
            }

            .toast--info {
                border-color: #2f86eb;
            }

            .toast--info .toast__icon {
                color: #2f86eb;
            }

            .toast--warning {
                border-color: #ffc021;
            }

            .toast--warning .toast__icon {
                color: #ffc021;
            }

            .toast--error {
                border-color: #ff623d;
            }

            .toast--error .toast__icon {
                color: #ff623d;
            }

            .toast + .toast {
                margin-top: 24px;
            }

            .toast__icon {
                font-size: 24px;
            }

            .toast__icon,
            .toast__close {
                padding: 0 16px;
            }

            .toast__body {
                flex-grow: 1;
            }

            .toast__title {
                font-size: 16px;
                font-weight: 600;
                color: #333;
            }

            .toast__msg {
                font-size: 14px;
                color: #888;
                margin-top: 6px;
                line-height: 1.5;
            }

            .toast__close {
                font-size: 20px;
                color: rgba(0, 0, 0, 0.3);
                cursor: pointer;
            }

            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 1;
            }

            .confirm-box {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.3);
                z-index: 2;
                max-width: 400px;
                text-align: center;
            }

            .box-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .box-header h2 {
                margin: 0;
                font-size: 18px;
                font-weight: bold;
            }

            .close-button {
                font-size: 24px;
                font-weight: bold;
                cursor: pointer;
            }

            .box-content {
                margin-bottom: 20px;
            }

            .button-container {
                display: flex;
                justify-content: center;
            }

            .button-container button {
                margin: 0 10px;
                padding: 10px 20px;
                border-radius: 5px;
                border: none;
                font-weight: bold;
                cursor: pointer;
            }

            #yes-button {
                background-color: #e74c3c;
                color: white;
            }

            #no-button {
                background-color: #2ecc71;
                color: white;
            }

            #yes-button1 {
                background-color: #e74c3c;
                color: white;
            }

            #no-button1 {
                background-color: #2ecc71;
                color: white;
            }
        </style>
    </head>
    <body>
        <%
            String mess = (String) request.getAttribute("mess");
        %>
        <nav class="navbar navbar-top navbar-expand-md navbar-dark" id="navbar-main" style="background-color: #303C5F;     padding: 0rem 1rem;">
            <div class="container-fluid">
                <!-- Brand -->
                <a class="h4 mb-0 text-uppercase text-white d-none d-lg-inline-block"
                   href="/">FIVE STORE - Order
                    Management</a>
                <!-- User -->
                <div class="search-box ">
                    <div class="col-lg-12 p-0" style="margin-top: 20px;">
                        <select class="form-control" id="exampleFormControlSelect1">
                            <option>Search By Status</option>
                            <option>Đã Liên Hệ</option>
                            <option>Không Liên Hệ Được</option>
                            <option>Đang Xác Nhận</option>                           
                            <option>Đang Vận Chuyển</option>
                            <option>Đã Nhận Hàng</option>
                            <option>Không Nhận Hàng</option>
                            <option>Ðã Hoàn Hàng</option>
                            <option>Đã Hủy Đơn</option>
                        </select>
                    </div>
                </div>
            </div>
        </nav>
        <div class="container" style="margin-top: 20px;">
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
                <%
                    OrderDAO dao = new OrderDAO();
                    ResultSet rs = dao.getAll();
                    while (rs.next()) {
                %>
                <li class="table-row">
                    <div class="col col-1" data-label="OrderID"><%= rs.getString("OrderID")%></div>
                    <div class="col col-2" data-label="UserName"><%= rs.getString("Username")%></div>
                    <div class="col col-3" data-label="DeliveryAddress"><%= rs.getString("DeliveryAddress")%></div> 
                    <div class="col col-4" data-label="OrderTIme"><%= rs.getString("OrderTime")%></div> 
                    <div class="col col-5" data-label="Status"><%= rs.getString("OrderStatusID")%></div>
                    <div class="col col-6" data-label="TotalBill"><%= rs.getString("TotalBill")%></div>
                    <div class="col col-7" data-label="Action">
                        <a href="/Order/OrderDetails/<%= rs.getString("OrderID")%>" class="edit" title="View Details" data-toggle="tooltip"><i class="material-icons">&#xe417;</i></a>
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
                <span id="regError" data-my-attribute=""></span>
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
                <h2>Are you sure you want to delete this order?</h2>
            </div>
            <div class="box-content">
                <p></p>
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

        <button onclick="topFunction()" id="myBtn" title="Go to top">TOP</button>
        <script>
            // Get the search input element
            var input = document.getElementById("search");

            // Add event listener to the search input
            input.addEventListener("keyup", function () {
                // Get the filter value from the search input
                var filter = input.value.toUpperCase();

                // Get the table rows
                var rows = document.getElementsByClassName("table-row");

                // Loop through the rows and hide/show based on filter value
                for (var i = 0; i < rows.length; i++) {
                    var username = rows[i].getElementsByClassName("col-1")[0].textContent.toUpperCase();
                    if (username.indexOf(filter) > -1) {
                        rows[i].style.display = "";
                    } else {
                        rows[i].style.display = "none";
                    }
                }
            });
        </script>
        <script>
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
        <script src="${pageContext.request.contextPath}/Resources/js/comfirmboxAc.js"></script>
      
        <script>
            $(document).ready(function () {

                // When the user scrolls down 20px from the top of the document, show the button
                window.onscroll = function () {
                    scrollFunction();
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

        <script>
            const mySpan1 = document.getElementById('regError');
            const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
            console.log(myAttribute1);
            mainFunction();

            function mainFunction() {
                if (myAttribute1 == "Noo") {
                    showErrorDeleteAdToast();
                } else if (myAttribute1 == "YesD") {
                    showSuccessDeleteToast();
                } else if (myAttribute1 == "NoD") {
                    showErrorDeleteToast();
            <%--      } else if (myAttribute1 == "Nooo") {
                      showErrorChangeAdminToast();
                  } else if (myAttribute1 == "YesC") {
                      showSuccessChangeCusToast();
                  } else if (myAttribute1 == "NoC") {
                      showErrorChangeCusToast();
                  } else if (myAttribute1 == "YesA") {
                      showSuccessChangeAdToast();
                  } else if (myAttribute1 == "NoA") {
                      showErrorChangeAdToast(); --%>
                } else {
                    return;
                }
            }

            function showErrorDeleteAdToast() {
                toast({
                    title: 'Failed!',
                    message: 'You cannot delete this order!',
                    type: 'error',
                    duration: 3000
                });
            }

            function showSuccessDeleteToast() {
                toast({
                    title: 'Successfully!',
                    message: 'Delete Order Successfully!',
                    type: 'success',
                    duration: 3000
                });
            }
            function showErrorDeleteToast() {
                toast({
                    title: 'Failed!!',
                    message: 'Delete Order Unsuccessfully!',
                    type: 'error',
                    duration: 3000
                });
            }

            <%--    function showErrorChangeAdminToast() {
                    toast({
                        title: 'Failed!',
                        message: 'You cannot change permission account ADMIN!',
                        type: 'error',
                        duration: 3000
                    });
                }

            function showSuccessChangeAdToast() {
                toast({
                    title: 'Successfully!',
                    message: 'Change Permission Account To Admin Successfully!',
                    type: 'success',
                    duration: 3000
                });
            }
            function showSuccessChangeCusToast() {
                toast({
                    title: 'Successfully!',
                    message: 'Change Permission Account To Customer Successfully!',
                    type: 'success',
                    duration: 3000
                });
            }



            function showErrorChangeAdToast() {
                toast({
                    title: 'Failed!',
                    message: 'Change Permission Account To Admin Unsuccessfully!',
                    type: 'error',
                    duration: 3000
                });
            }

            function showErrorChangeCusToast() {
                toast({
                    title: 'Failed!',
                    message: 'Change Permission Account To Customer Unsuccessfully!',
                    type: 'error',
                    duration: 3000
                });
            } --%>
        </script>
    </body>
</html>
