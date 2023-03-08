<%-- 
    Document   : addProduct
    Created on : Mar 2, 2023, 6:11:52 PM
    Author     : Hoang Liem
--%>

<%@page import="com.models.Product"%>
<%@page import="com.models.Account"%>
<%@page import="com.daos.AccountDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Product</title>
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
        <!-- MDB -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css" rel="stylesheet" />
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <link href="${pageContext.request.contextPath}/Resources/css/gototop.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/addProduct.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />

        <link href="${pageContext.request.contextPath}/Resources/css/footer.css" rel="stylesheet" />
    </head>
    <body>
        <%
            String username = (String) request.getAttribute("username");
            //Get message from controller
            String mess = (String) request.getAttribute("mess");
        %>
        <!-- PAGE ADD NEW PRODUCT -->

        <header id="page-header">
            <div class="page-container">
                <nav class="navbar navbar-expand-lg" id="navbar-main" style="background-color: #303C5F;">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="/" style="color: white; font-size: 25px;"><b>FIVESTORE.VN - Add Product</b></a>

                    </div>
                </nav>
            </div>
        </header>
        <form action="/product" method="POST">
            <label for="pictureLink">Picture Link:</label>
            <input type="text" id="pictureLink" name="pictureLink" value =""><br>

            <label for="productID">Product ID:</label>
            <input type="text" id="productID" name="productID" value =""><br>

            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName" value =""><br>

            <label for="description">Description:</label>
            <textarea id="description" name="description" value =""></textarea><br>


            <label for="type">Type:</label>
            <select id="type" name="type">
                <%
                    ProductDAO dao = new ProductDAO();
                    ResultSet rs = dao.getAllTypeOfProduct();
                    while (rs.next()) {
                %>
                <option value="<%=rs.getString("ProductTypeID")%>"><%=rs.getString("ProductTypeName")%></option>
                <%
                    }
                %>
            </select><br>

            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" value =""><br>

            <label for="price">Price:</label>
            <input type="number" id="price" name="price" value =""><br>

            <label for="exp">EXP:</label>
            <input type="date" id="exp" name="exp" value =""><br>

            <label for="origin">Origin:</label>
            <input type="text" id="origin" name="origin" value =""><br>

            <label for="soldAmount">Sold Amount:</label>
            <input type="number" id="soldAmount" name="soldAmount" value =""><br>

            <input type="hidden" name="btnInsert" value="insert">

            <input type="submit" name="btnInsert" value="insert">
            <!-- Get message from Controller  -->
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
        </form>


        <!-- Toast Message  -->
        <div  class="my-toast">
            <div id="toast">
            </div>
        </div>

        <div class="overlay" id="overlay1"></div>
        <div class="confirm-box" id="confirm-box1">
            <div class="box-header">
                <h2>Are you sure you want to add this product?</h2>
            </div>
            <div class="box-content">
                <p>Product will be added!</p>
            </div>
            <div class="button-container">
                <button id="yes-button1">Yes</button>
                <button id="no-button1">No</button>
            </div>
        </div>

        <!-- Footer -->            
        <%@ include file="/footer.jsp" %>

        <!-- button go to top -->
        <button onclick="topFunction()" id="myBtn" title="Go to top"></button>
        <script>

            const mySpan1 = document.getElementById('regError');
            const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
            mainFunction();

            function mainFunction() {
                if (myAttribute1 == "Noo") {
                    showErrorAddIdToast();
                } else if (myAttribute1 == "NoA") {
                    showErrorAddToast();
                } else {
                    return;
                }
            }

            function showErrorAddIdToast() {
                toast({
                    title: 'Failed!',
                    message: 'ID of Product is already exists!',
                    type: 'error',
                    duration: 3000
                });
            }
            function showErrorAddToast() {
                toast({
                    title: 'Failed!!',
                    message: 'Add Product Unsuccessfully!',
                    type: 'error',
                    duration: 3000
                });
            }
        </script>
        <!-- JS -->
        <script src="${pageContext.request.contextPath}/Resources/js/gototop.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/addproduct.js"></script>
        <!-- Link ALL JS From URL -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>

    </body>
</html>

