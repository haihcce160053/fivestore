<%-- 
    Document   : OderInfomation
    Created on : Feb 17, 2023, 9:03:28 AM
    Author     : ASUS
--%>

<%@page import="com.models.Account"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.ProductDAO"%>
<!--THIS PAGE USING FOR TESTING !!!-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FIVESTORE - Order Information</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>FIVESTORE - Dietary supplemental shop</title>
        <link rel="icon" type="image/x-icon" href="HCDATAFILE/img/logo-only.png">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet" />
        <!-- MDB -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css" rel="stylesheet" />
        <!-- Jquery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
    </head>
    <body>
        <%
            Account ac = (Account) session.getAttribute("informationAccount");
        %>
        <header id="page-header">
            <div class="page-container">
                <nav class="navbar navbar-expand-lg" style="background-color: #303C5F;">
                    <div class="container-fluid">
                        <div>
                            <a class="navbar-brand" href="/home"
                               style="color: white; font-size: 25px;"><b>FIVESTORE.VN</b></a>
                            <button class="navbar-toggler" type="button" data-mdb-toggle="collapse"
                                    data-mdb-target="#navbarText" aria-controls="navbarText" aria-expanded="false"
                                    aria-label="Toggle navigation">
                                <i class="fas fa-bars"></i>
                            </button>
                        </div>                 
                        <div class="collapse navbar-collapse" id="navbarText">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <%
                                    if (ac != null && (ac.getAccountTypeId()).equalsIgnoreCase("AD")) {
                                %>
                                <li class="nav-item">
                                    <a class="nav-link" href="/Account/Management/<%=ac.getUsername()%>" style="color: #566787;">Account Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/product" style="color: #566787;">Product Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/product" style="color: #566787;">Order Management</a>
                                </li>

                                <%
                                } else {
                                %>
                                <li class="nav-item">
                                    <a class="nav-link" href="/home" aria-current="page" style="color: white;">Home</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/product" style="color: white;">Product</a>
                                </li>
                                <%
                                    }
                                %>
                            </ul>
                        </div>
                    </div>
            </div>
        </header>
        <div class="Container justify-center">
            <div class="row justify-content-center" style="margin-top: 100px;">
                <div class="col-md-4 col-sm-6 card">
                    <h2 style="margin-top: 10px" class="row justify-content-end">Order Information</h2>
                    <form style="margin-top: 10px;" method="post" action="/order/checkout/">
                        <div class="form-group row">
                            <label for="txtOrderID" class="col-4 col-form-label">Order ID</label> 
                            <div class="col-8">
                                <input id="txtOrderID" name="txtOrderID" type="text" class="form-control" value="test" readonly>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="txtUsername" class="col-4 col-form-label">Username</label> 
                            <div class="col-8">
                                <input id="txtUsername" name="txtUsername" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="txtEmail" class="col-4 col-form-label">Email</label> 
                            <div class="col-8">
                                <input id="txtEmail" name="txtEmail" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="txtPhone" class="col-4 col-form-label">Phone</label> 
                            <div class="col-8">
                                <input id="txtPhone" name="txtPhone" type="text" class="form-control">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="txtTotalBill" class="col-4 col-form-label">Total Bill</label> 
                            <div class="col-8">
                                <input id="txtTotalBill" name="txtTotalBill" type="text" class="form-control">
                            </div>
                        </div>
                        <h2 class="shipping-info-text row justify-content-end">Shipping address</h2>
                        <div class="form-group row">
                            <label for="txtFullname" class="col-4 col-form-label">Full Name</label> 
                            <div class="col-8">
                                <input id="txtFullname" name="txtFullname" type="text" class="form-control">
                            </div>
                        </div> 
                        <div class="form-group row">
                            <label for="select" class="col-4 col-form-label">City</label>
                            <div class="col-8">
                                <select class="form-select form-select-sm mb-3 " id="city" name="city" aria-label=".form-select-sm">
                                    <option value="" selected>Chọn tỉnh thành</option>           
                                </select>
                            </div> 
                        </div> 
                        <div class="form-group row">
                            <label for="select" class="col-4 col-form-label">District</label>
                            <div class="col-8">
                                <select class="form-select form-select-sm mb-3" id="district" name="district" aria-label=".form-select-sm">
                                    <option value="" selected>Chọn quận huyện</option>
                                </select>
                            </div> 
                        </div> 
                        <div class="form-group row">
                            <label for="select" class="col-4 col-form-label">Ward</label>
                            <div class="col-8">
                                <select class="form-select form-select-sm" id="ward" name="ward" aria-label=".form-select-sm">
                                    <option value="" selected>Chọn phường xã</option>
                                </select>
                            </div> 
                        </div>
                        <div class="form-group row">
                            <label for="txtDetailAddress" class="col-4 col-form-label">Street name, building, house number,...</label> 
                            <div class="col-8">
                                <input id="txtDetailAddress" name="txtDetailAddress" type="text" class="form-control">
                            </div>
                        </div> 
                        <div class="form-group row" style="margin-bottom: 20px">
                            <div class="offset-4 col-8">
                                <button name="submit" type="submit" class="btn btn-primary" onclick="return checkInfo()">Submit Order</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
    <script>
                                    var citis = document.getElementById("city");
                                    var districts = document.getElementById("district");
                                    var wards = document.getElementById("ward");
                                    var Parameter = {
                                        url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
                                        method: "GET",
                                        responseType: "application/json",
                                    };
                                    var promise = axios(Parameter);
                                    promise.then(function (result) {
                                        renderCity(result.data);
                                    });
                                    function renderCity(data) {
                                        for (const x of data) {
                                            citis.options[citis.options.length] = new Option(x.Name, x.Id);
                                        }
                                        citis.onchange = function () {
                                            district.length = 1;
                                            ward.length = 1;
                                            if (this.value != "") {
                                                const result = data.filter(n => n.Id === this.value);
                                                for (const k of result[0].Districts) {
                                                    district.options[district.options.length] = new Option(k.Name, k.Id);
                                                }
                                            }
                                        };
                                        district.onchange = function () {
                                            ward.length = 1;
                                            const dataCity = data.filter((n) => n.Id === citis.value);
                                            if (this.value != "") {
                                                const dataWards = dataCity[0].Districts.filter(n => n.Id === this.value)[0].Wards;
                                                for (const w of dataWards) {
                                                    wards.options[wards.options.length] = new Option(w.Name, w.Id);
                                                }
                                            }
                                        };
                                    }
    </script>
</html>
