<%-- 
    Document   : orderSuccessfull
    Created on : Feb 25, 2023, 9:48:44 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order process</title>
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <style>
            body {
                background-color: #f2f2f2;
                font-family: 'Arial', sans-serif;
                font-size: 18px;
                line-height: 1.5;
            }

            .wrap {
                width: 600px;
                margin: 250px auto;
                padding: 50px;
                border-radius: 10px;
                border: 1px solid #ddd;
                text-align: center;
            }

            #timer {
                margin-bottom: 20px;
            }
        </style>

    </head>
    <body>
        <%
            if (request.getAttribute("mess") != null) {
        %>
        <div class="row" >
            <div class="col-lg-12" style="margin-left: 15px;
                 margin-bottom: 15px;">
                <span id="regError" data-my-attribute="<%= request.getAttribute("mess")%>"></span>
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

        <script>
            var count = 8;
            var redirect = "<%= request.getAttribute("link")%>";
            function countDown() {
                var timer = document.getElementById("timer");
                if (count > 0) {
                    count--;
                    timer.innerHTML = "You have received the order status toast message. We will redirect the website in <b>" + count + "</b> s.";
                    setTimeout("countDown()", 1000);
                } else {
                    window.location.href = redirect;
                }
            }
        </script>
        <div class="wrap">
            <p id="timer"><script type="text/javascript">countDown();</script></p>
        </div>

        <script>
            const mySpan1 = document.getElementById('regError');
            const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
            mainFunction();
           
            function mainFunction() {
                if (myAttribute1 == "Noo") {
                    showErrorOrderList();
                } else if (myAttribute1 == "Yes") {
                    showSuccessOrder();
                    deleteCartItemsCookie();
                } else if (myAttribute1 == "No") {
                    showErrorOrder();
                } else {
                    return;
                }
            }
            
            function deleteCartItemsCookie() {
                // Set the expiration date to a date in the past
                const pastDate = new Date(0);
                document.cookie = "cartItems=; expires=" + pastDate.toUTCString() + "; path=/";
            }

            function showErrorOrderList() {
                toast({
                    title: 'Sorry!',
                    message: 'There was a problem creating your order, Please try again later! ',
                    type: 'error',
                    duration: 3000
                });
            }

            function showSuccessOrder() {
                toast({
                    title: 'Successfully!',
                    message: 'Your order has been ordered and is awaiting confirmation!',
                    type: 'success',
                    duration: 3000
                });
            }
            function showErrorOrder() {
                toast({
                    title: 'Sorry!!',
                    message: 'There was a problem creating your order, Please try again later! ',
                    type: 'error',
                    duration: 3000
                });
            }
        </script>
    </body>
</html>
