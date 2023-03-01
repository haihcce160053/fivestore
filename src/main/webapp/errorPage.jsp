<%-- 
    Document   : errorPage
    Created on : Mar 1, 2023, 4:12:50 PM
    Author     : QuangQui
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Error Page - Dietary Supplements Shop</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <<link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/css/errorPage.css"/>
    </head>
    <body>

        <div class="container">
            <h1>Have A Problem!</h1>
            <p>We're sorry, but there was an error processing your request.</p>
            <p>Please try again later or contact us for assistance.</p>
            <a href="/" class="btn btn-primary">Return to Home</a>
        </div>

    </body>
</html>

