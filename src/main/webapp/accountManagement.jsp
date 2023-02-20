<%-- 
    Document   : accountManagement
    Created on : Feb 19, 2023, 1:06:54 PM
    Author     : QuangQui
--%>

<%@page import="com.models.Account"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Management</title>
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/AccountInformation/style.css">
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
                flex-basis: 15%;
            }

            .col-2 {
                flex-basis: 30%;
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

            /* Media query for tablet screens */
            @media all and (min-width: 768px) and (max-width: 1023px) {
                /* Adjust max-width and padding for container */
                .container {
                    max-width: 100%;
                    padding: 0 20px;
                }

                /* Adjust column widths */
                .col-1 {
                    flex-basis: 30%;
                }

                .col-2 {
                    flex-basis: 0%;
                }

                .col-3 {
                    flex-basis: 40%;
                }

                .col-4 {
                    flex-basis: 0%;
                    display: none;
                }

                .col-5 {
                    flex-basis: 30%;
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
                    flex-basis: 50%;
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
                    flex-basis: 50%;
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
                   href="/">FIVE STORE - ACCOUNT
                    Management</a>
                <!-- User -->
                <div class="search-box ">
                    <div class="input-group">								
                        <input type="text" id="search" class="form-control" placeholder="Search by Username" style="max-width: 237px; margin: 10px 0 -10px 0;">
                    </div>
                </div>
            </div>
        </nav>
        <div class="container" style="margin-top: 20px;">
            <ul class="responsive-table">
                <li class="table-header">
                    <div class="col col-1">Username</div>
                    <div class="col col-2">FullName</div>
                    <div class="col col-3">Email</div>
                    <div class="col col-4">TypeAccount</div>
                    <div class="col col-5">Actions</div>
                </li>
                <%
                    AccountDAO dao = new AccountDAO();
                    ResultSet rs = dao.getAll();
                    while (rs.next()) {
                %>

                <li class="table-row">
                    <div class="col col-1" data-label="Username"><%= rs.getString("Username")%></div>
                    <div class="col col-2" data-label="Fullname"><%= rs.getString("FullName")%></div>
                    <div class="col col-3" data-label="Email"><%= rs.getString("Email")%></div>
                    <%
                        if (rs.getString("AccountTypeID").equals("AD")) {
                    %>
                    <div class="col col-4" data-label="TypeAccount"><i class="material-icons haha" style="padding-left: 25px; ">&#xe853;</i></div>
                    <%
                    } else {
                    %>

                    <div class="col col-4" data-label="TypeAccount"> <i class="material-icons haha" style="padding-left: 25px; ">&#xe7fc;</i></div>
                    <%
                        }
                    %>
                    <div class="col col-5" data-label="Action">
                        <a href="/Account/Change/<%= rs.getString("Username")%>" class="edit" title="Change Permission" data-toggle="tooltip"><i class="material-icons">&#xe869;</i></a>
                        <a href="/Account/Delete/<%= rs.getString("Username")%>" class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a>
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
                <h2>Are you sure you want to change permission?</h2>
            </div>
            <div class="box-content">
                <p>Permission of Account will be changed!</p>
            </div>
            <div class="button-container">
                <button id="yes-button">Yes</button>
                <button id="no-button">No</button>
            </div>
        </div>

        <div class="overlay" id="overlay1"></div>

        <div class="confirm-box" id="confirm-box1">
            <div class="box-header">
                <h2>Are you sure you want to delete account?</h2>
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

            const overlay = document.querySelector(".overlay");
            overlay.addEventListener("click", function () {
                overlay.style.display = "none";
                const confirmBox = document.querySelector(".confirm-box");
                confirmBox.style.display = "none";
            });

        </script>

        <script>
            // Get all the a tags
            const aTags = document.querySelectorAll("a");
            const aTag = document.querySelector('a.edit');
            const aTag1 = document.querySelector('a.delete');

            // Add event listener to each a tag
            aTags.forEach((aTag) => {
                aTag.addEventListener("click", (event) => {
                    // Get the href of the link that was clicked
                    const href = aTag.getAttribute("href");
                    const href1 = aTag1.getAttribute("href");

                    // Check if the link is for changing permission or deleting account
                    if (href.includes("Change")) {
                        // Display the change permission confirm box
                        document.getElementById("overlay").style.display = "block";
                        document.getElementById("confirm-box").style.display = "block";
                        event.preventDefault();
                        document.getElementById("yes-button").addEventListener("click", () => {
                            document.getElementById("overlay").style.display = "none";
                            document.getElementById("confirm-box").style.display = "none";
                            window.location.href = href;
                        });
                    } else if (href.includes("Delete")) {
                        // Display the delete account confirm box
                        document.getElementById("overlay1").style.display = "block";
                        document.getElementById("confirm-box1").style.display = "block";
                        event.preventDefault();
                        document.getElementById("yes-button1").addEventListener("click", () => {


                            // Hide the confirmation box
                            document.getElementById("overlay1").style.display = "none";
                            document.getElementById("confirm-box1").style.display = "none";
                            window.location.href = href1;

                        });
                    }
                });
            });

            // Add event listener to the "No" buttons to hide the confirm boxes
            document.getElementById("no-button").addEventListener("click", () => {
                document.getElementById("overlay").style.display = "none";
                document.getElementById("confirm-box").style.display = "none";
            });

            document.getElementById("no-button1").addEventListener("click", () => {
                document.getElementById("overlay1").style.display = "none";
                document.getElementById("confirm-box1").style.display = "none";
            });

        </script>
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
            mainFunction();

            function mainFunction() {
                if (myAttribute1 == "Noo") {
                    showErrorDeleteAdToast();
                } else if (myAttribute1 == "YesD") {
                    showSuccessDeleteToast();
                } else if (myAttribute1 == "NoD") {
                    showErrorDeleteToast();
                } else if (myAttribute1 == "Nooo") {
                    showErrorChangeAdminToast();
                } else if (myAttribute1 == "YesC") {
                    showSuccessChangeCusToast();
                } else if (myAttribute1 == "NoC") {
                    showErrorChangeCusToast();
                } else if (myAttribute1 == "YesA") {
                    showSuccessChangeAdToast();
                } else if (myAttribute1 == "NoA") {
                    showErrorChangeAdToast();
                } else {
                    return;
                }
            }

            function showErrorDeleteAdToast() {
                toast({
                    title: 'Failed!',
                    message: 'You cannot delete account ADMIN!',
                    type: 'error',
                    duration: 3000
                });
            }

            function showSuccessDeleteToast() {
                toast({
                    title: 'Successfully!',
                    message: 'Delete Account Successfully!',
                    type: 'success',
                    duration: 3000
                });
            }
            function showErrorDeleteToast() {
                toast({
                    title: 'Failed!!',
                    message: 'Delete Account Unsuccessfully!',
                    type: 'error',
                    duration: 3000
                });
            }

            function showErrorChangeAdminToast() {
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
            }
        </script>
    </body>
</html>
