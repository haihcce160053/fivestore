<%-- 
    Document   : homeAdmin
    Created on : Feb 13, 2023, 9:50:51 AM
    Author     : QuangQui
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FIVESTORE - Home page admin</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/styles/bootstrap4/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/styles/main_styles.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/styles/responsive.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/assets/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/Shopping-Cart/fonts.googleapis.com/css?family=Duru+Sans|Istok+Web">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/Shopping-Cart/css/font-awesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/Shopping-Cart/css/main.css">
    </head>
    <body>
        <h1 align="center">Chào mừng đến với trang của quản trị viên</h1>
        <div>
            <form action="/logout" method="post">
                <div class="form-group">
                    <button type="submit" id="btnSignIn" name="btnSignout"
                            class="form-control btn btn-primary rounded submit px-3"
                            style="background-color: #9c27b0; color: white"><i class="fa fa-sign-in" aria-hidden="true"></i> Logout</button> </div>
            </form>
        </div>

        <!--Link Java Script-->
        <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/styles/bootstrap4/popper.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/styles/bootstrap4/bootstrap.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/custom.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/Shopping-Cart/js/jquery-1.11.3.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/Shopping-Cart/js/simpleCart.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/Shopping-Cart/js/handlebars.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/Shopping-Cart/js/sheetrock.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/Shopping-Cart/js/main.js"></script>
        <script>
            // When the user scrolls down 20px from the top of the document, show the button
            window.onscroll = function () {
                scrollFunction()
            };
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
