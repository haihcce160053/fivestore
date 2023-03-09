<%-- 
    Document   : OderInfomation
    Created on : Feb 17, 2023, 9:03:28 AM
    Author     : ASUS
--%>

<%@page import="com.daos.OrderDAO"%>
<%@page import="com.models.Account"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.ProductDAO"%>
<!--THIS PAGE USING FOR TESTING !!!-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>FIVESTORE - Dietary supplemental shop</title>
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet" />
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet" />
        <!-- MDB -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css" rel="stylesheet" />
        
                <link href="${pageContext.request.contextPath}/Resources/css/footer.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/cart.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/gototop.css" rel="stylesheet" />
        <style>
            .form-select{
                margin-bottom: 5px;
            }
            form button{

            }
            .card{
                color: #303C5F;
                background-color: #303C5F;
            }
            .card label{
                color: #ffffff;
            }
            .card h2{
                color: #ffffff;
            }
            .error-container {
                display: none;
                margin-bottom: 10px;
                padding: 10px;
                border-radius: 5px;
                background-color: #f8d7da;
                color: #721c24;
            }

            .error-container.show {
                display: block;
            }

            .error-message {
                margin: 0;
            }
            .popup {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
                z-index: 999;
                padding: 20px;
            }

            .popup.show {
                display: block;
            }

            .popup h2 {
                font-size: 24px;
                font-weight: bold;
                margin-top: 0;
                margin-bottom: 10px;
            }

            .popup p {
                font-size: 18px;
                line-height: 1.5;
                margin-bottom: 20px;
            }

            .popup img {
                display: block;
                max-width: 100%;
                height: auto;
                margin-bottom: 20px;
            }

            .popup span {
                background-color: #007bff;
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 18px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .popup span:hover {
                background-color: #0069d9;
            }

            .popup-backdrop {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                backdrop-filter: blur(5px);
                z-index: 998;
                display: none;
            }

            .popup-backdrop.show {
                display: block;
            }

            .hidden {
                display: none;
            }


        </style>
    </head>

    <body>        
        <%
            Account ac = (Account) session.getAttribute("informationAccount");
            String linkQRcode = "https://img.vietqr.io/image/970418-74110000929461-s0Kd2aq.jpg?accountName=TRAN%20TRUNG%20KIEN&";
        %>
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
                                    <a class="nav-link" href="/Account/Management/<%=ac.getUsername()%>" style="color: white;">Account Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="" style="color: white;">Product Management</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/Order/" style="color: white;">Order Management</a>
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
                                    style="color: white; background-color: #20283F;"
                                    onclick="location.href = '/Account/information/<%= ac.getUsername()%>'">
                                <%=ac.getFullname()%>
                            </button>
                            <%
                                }
                                if (ac != null && ac.getUsername().equalsIgnoreCase("Admin")) {
                            %>

                            <%
                            } else if (ac == null || (!ac.getUsername().equalsIgnoreCase("Admin"))) {
                            %>
                            <button id="view-cart-btn" id="mycart" type="button" class="btn me-3" style="background-color: #20283F; color: white">
                                MY CART <span id="cart-badge" class="badge badge-light" style="position: relative; top: -2px; right: -10px;">0</span>
                            </button>
                            <%
                                }
                            %>
                            <%
                                if (ac != null) {
                                    OrderDAO dao = new OrderDAO();
                                    int countOfOrder = dao.getNumberOrderByUsername(ac.getUsername());
                            %>
                            <button id="view-purchase-btn" type="button" class="btn me-3" style="background-color: #20283F; color: white" 
                                    onclick="location.href = '/Account/Order/<%= ac.getUsername()%>'">
                                MY Purchase<span id="cart-badge" class="badge badge-light" style="position: relative; top: -2px; right: -10px;"><%=countOfOrder%></span>

                            </button>
                            <%
                            } else {
                            %>
                            <button id="view-purchase-btn" type="button" class="btn me-3" style="background-color: #20283F; color: white"
                                    >
                                MY Purchase<span id="cart-badge" class="badge badge-light" style="position: relative; top: -2px; right: -10px;">0</span>

                            </button>
                            <%
                                }
                            %>
                        </div>
                </nav>
            </div>
        </header>
        <div class="Container justify-center">
            <div class="row justify-content-center" style="margin-top: 50px; margin-bottom: 50px">
                <div class="col-md-5 col-sm-9 col-11 card">
                    <h2 style="margin-top: 10px; margin-bottom: 10px; margin-right: 10px" class="row justify-content-end">Order Information</h2>
                    <form id="newOrderForm" style="margin-top: 10px;" method="post" action="/Order/new">
                        <div class="form-group row">
                            <label for="txtOrderID" class="col-4 col-form-label">Order ID</label> 
                            <div class="col-8">
                                <% if (request.getAttribute("OrderID") != null) {%>
                                <input id="txtOrderID" name="txtOrderID" type="text" class="form-control" value="<%= request.getAttribute("OrderID")%>" readonly>
                                <%  }%>
                            </div>
                        </div>
                        <% if (ac != null) {%>
                        <div class="form-group row">
                            <label for="txtUsername" class="col-4 col-form-label">Username</label> 
                            <div class="col-8">
                                <input id="txtUsername" name="txtUsername" type="text" class="form-control" value="<%=ac.getUsername()%>" readonly>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="txtEmail" class="col-4 col-form-label">Email</label> 
                            <div class="col-8">
                                <input id="txtEmail" name="txtEmail" type="text" class="form-control" value="<%=ac.getEmail()%>" readonly>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="txtPhone" class="col-4 col-form-label">Phone</label> 
                            <div class="col-8">
                                <input id="txtPhone" name="txtPhone" type="text" class="form-control" value="<%="0" + ac.getPhoneNumber()%>">
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="txtTotalBill" class="col-4 col-form-label">Total Payment</label> 
                            <div class="col-8">
                                <input id="txtTotalBill" name="txtTotalBill" type="text" class="form-control" value="" readonly>
                            </div>
                        </div>
                        <h2 class="shipping-info-text row justify-content-end" 
                            style="margin-top: 10px; margin-bottom: 10px; margin-right: 10px">
                            Shipping address
                        </h2>
                        <div class="form-group row">
                            <label for="txtFullname" class="col-4 col-form-label">Full Name</label> 
                            <div class="col-8">
                                <input id="txtFullname" name="txtFullname" type="text" class="form-control" value="<%=ac.getFullname()%>">
                            </div>
                        </div> 
                        <% }%>
                        <div class="form-group row">
                            <label for="select" for="input" class="col-4 col-form-label"">City</label>
                            <div class="col-8">
                                <select class="form-select " id="ls_province" name="ls_province" aria-label=".form-select-sm">
                                    <option value="" selected>Chọn tỉnh thành</option>           
                                </select>
                            </div>
                        </div> 
                        <div class="form-group row">
                            <label for="select" for="input"  class="col-4 col-form-label">District</label>
                            <div class="col-8">
                                <select class="form-select " id="ls_district" name="ls_district" aria-label=".form-select-sm">
                                    <option value="" selected>Chọn quận huyện</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="select" for="input" class="col-4 col-form-label">Ward</label>
                            <div class="col-8">
                                <select class="form-select " id="ls_ward" name="ls_ward"  aria-label=".form-select-sm" >
                                    <option value="" selected>Chọn phường xã</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="txtDetailAddress" class="col-12 col-md-4 col-form-label">Street name, building, house number,...</label> 
                            <div class="col-12 col-md-8">
                                <input id="txtDetailAddress" name="txtDetailAddress" type="text" class="form-control" placeholder="Street Name, Building, House No.">
                            </div>
                        </div>
                        <div class="form-group" style="margin-top: 10px;">
                            <span id="regError" style="color:red"></span>
                        </div>
                        <h2 class="shipping-info-text row justify-content-end" 
                            style="margin-top: 10px; margin-bottom: 10px; margin-right: 10px">
                            Payment
                        </h2>
                        <div class="form-group row">
                            <label for="select" class="col-12 col-sm-6 col-form-label">Payment Option</label>
                            <div class="col-12 col-sm-6">
                                <select class="form-select " id="paymentMethod" name="paymentMethod" aria-label=".form-select-sm">
                                    <option value="" selected> Chọn phương thức thanh toán</option>
                                    <option value="COD">Payment on delivery(COD)</option>
                                    <option value="VietQR" >VietQR</option>
                                </select>
                            </div> 
                        </div>
                        <!-- shopping cart -->
                        <div id="cart" style="display: none;">
                            <h3>Cart</h3>
                            <ul id="cart-items">

                            </ul>
                            <div id="cart-total">
                                <p>Total: <span id="cart-total-amount"></span></p>
                            </div>
                            <input type="text" id="blind" name="blind" value="" hidden="true" />
                            <input type="text" id="linkQR" name="" value="<%=linkQRcode%>amount=" hidden="true" />
                        </div>
                        <div class="form-group row" style="margin-bottom: 20px">
                            <div class="offset-5">
                                <button name="submit" type="submit" class="btn btn-primary " value="submit" onclick="getValue()">Place Order</button>
                            </div>
                        </div>
                        <div id="error-messages"></div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Pop-up QR code -->       
        <div class="popup-backdrop"></div>
        <div id="vietqr-popup" class="popup">

            <img id="txtQRCode" alt="VietQR code">
            <label>
                <input type="checkbox" id="confirm-checkbox"> Tôi đã chuyển khoản và đồng ý đặt hàng với các sản phẩm trong giỏ hàng!
            </label>
            <span class="popup-close" >✔</span>
        </div>
        
                <%@ include file="/footer.jsp" %>

        <script src="${pageContext.request.contextPath}/Resources/js/vietnameselocation/vietnamlocalselector.js"></script> 
        <script>
                                    var localpicker = new LocalPicker({
                                        province: "ls_province",
                                        district: "ls_district",
                                        ward: "ls_ward"
                                    });
        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <!-- Jquery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>

        <script> // Quang Qui: Xử lý lấy số tiền trong giỏ hàng vào ô input

                                    // Lấy thẻ span trong div chứa tổng tiền
                                    var cartTotalSpan = document.getElementById("cart-total-amount");

                                    // Lấy thẻ input
                                    var totalBillInput = document.getElementById("txtTotalBill");

                                    // 
                                    var linkQRCode = document.getElementById("linkQR");
                                    var linkQRCodeOrgirin = linkQRCode.value;

                                    // Thiết lập giá trị ban đầu cho thẻ input
                                    var totalBill = cartTotalSpan.innerText;
                                    totalBill = totalBill.replaceAll(".", "").replace(" đ", "");
                                    totalBillInput.value = totalBill;

                                    linkQRCode.value += totalBill;


                                    // Lắng nghe sự kiện thay đổi trên thẻ span
                                    cartTotalSpan.addEventListener('DOMSubtreeModified', function () {
                                        // Cập nhật giá trị của thẻ input tại đây
                                        var he = cartTotalSpan.innerText;
                                        he = he.replaceAll(".", "").replace(" đ", "");
                                        totalBillInput.value = he;
                                        linkQRCode.value = "";
                                        linkQRCode.value = linkQRCodeOrgirin;
                                        linkQRCode.value += he;
                                        linkQRCode.value += "&addInfo=Payment%20OrderID%20";
                                        //Sau khi ghép thành công số tiền cần chuyển thì tiếp tục nối chuỗi gồm mã đơn hàng 
                                        var orderID = document.getElementById("txtOrderID");
                                        linkQRCode.value += orderID.value + "%20";
                                        //Sau khi ghép thành công mã đơn hàng thì tiếp tục nối chuỗi username
                                        var username = document.getElementById("txtUsername");
                                        linkQRCode.value += username.value;
                                        //Sau khi ghép thành công username thì set src cho the img
                                        var imgQR = document.getElementById("txtQRCode");
                                        imgQR.setAttribute('src', linkQRCode.value);
                                    });

                                    linkQRCode.value += "&addInfo=Payment%20OrderID%20";
                                    //Sau khi ghép thành công số tiền cần chuyển thì tiếp tục nối chuỗi gồm mã đơn hàng 
                                    var orderID = document.getElementById("txtOrderID");
                                    linkQRCode.value += orderID.value + "%20";
                                    //Sau khi ghép thành công mã đơn hàng thì tiếp tục nối chuỗi username
                                    var username = document.getElementById("txtUsername");
                                    linkQRCode.value += username.value;
                                    //Sau khi ghép thành công username thì set src cho the img
                                    var imgQR = document.getElementById("txtQRCode");
                                    imgQR.setAttribute('src', linkQRCode.value);


        </script> 

        <script>
            //Quang Qui
            //Khi bấm vào nút submit order thì sẽ xử lý giỏ hàng thành chuỗi gửi lên servlet
            function getValue() {
//                event.preventDefault(); // Tạm thời ngưng cái sự kiện submit gửi lên servlet để nhìn cái chuỗi sau khi xử lý
                //Ô input ẩn trong form có id là blind
                const inputElement = document.getElementById("blind");

                const ulElement = document.getElementById('cart-items');
                const liElements = ulElement.querySelectorAll('li');

                let items = "";
                for (let i = 0; i < liElements.length; i++) {
                    const divElement = liElements[i].querySelector('div');
                    const spanElements = liElements[i].querySelectorAll('span');
                    const itemString = divElement.textContent.trim() + ":" + spanElements[1].textContent.trim();
                    items += itemString + "/";
                }

                // Loại bỏ các ký tự đặc biệt khỏi chuỗi bằng phương thức replace()
                items = items.replaceAll("- ", "<<").replaceAll("+", ">>").replaceAll("Remove", "").replaceAll(".", "").replaceAll("x", "").replaceAll("đ", "").replaceAll("   ", "|");

                //Chuỗi sau khi xử lý sẽ gán vào ô input ẩn để tiện trên Servlet lấy data
                inputElement.value = items;
                console.log(items);

            }
        </script>
        <script>
            // get form elements
            const form = document.getElementById("newOrderForm");
            const fullNameInput = document.getElementById("txtFullname");
            const detailAddressInput = document.getElementById("txtDetailAddress");
            const provinceSelect = document.getElementById("ls_province");
            const districtSelect = document.getElementById("ls_district");
            const wardSelect = document.getElementById("ls_ward");
            const paymentMethodSelect = document.getElementById("paymentMethod");
            const errorElement = document.getElementById("regError");

            // add event listener to form
            form.addEventListener("submit", (event) => {
                let messages = [];

                // validate Full Name field
                if (fullNameInput.value === "" || fullNameInput.value == null) {
                    messages.push("Full Name is required");
                }

                // validate Detail Address field
                if (detailAddressInput.value === "" || detailAddressInput.value == null) {
                    messages.push("Detail Address is required");
                }

                // validate Province select
                if (provinceSelect.value === "" || provinceSelect.value == null) {
                    messages.push("Province is required");
                }

                // validate District select
                if (districtSelect.value === "" || districtSelect.value == null) {
                    messages.push("District is required");
                }

                // validate Ward select
                if (wardSelect.value === "" || wardSelect.value == null) {
                    messages.push("Ward is required");
                }

                // validate Payment Method select
                if (paymentMethodSelect.value === "" || paymentMethodSelect.value == null) {
                    messages.push("Payment Method is required");
                }

                // display error messages
                if (messages.length > 0) {
                    event.preventDefault();
                    errorElement.innerText = messages.join(", ");
                }
            });
        </script>
        <script src="${pageContext.request.contextPath}/Resources/js/cart.js"></script>
        <script>
            const checkbox = document.getElementById('confirm-checkbox');
            const closeBtn = document.querySelector('.popup-close');
            const backdrop = document.querySelector('.popup-backdrop');
            var popup = document.getElementById("vietqr-popup");
            // Lắng nghe sự kiện onchange của thẻ <select>
            paymentMethodSelect.addEventListener("change", function () {
                // Lấy giá trị được chọn
                var selectedValue = paymentMethodSelect.value;

                // Nếu giá trị được chọn là "VietQR"
                if (selectedValue === "VietQR") {
                    // Hiển thị pop-up
                    popup.style.display = "block";
                    backdrop.classList.add('show');
                } else {
                    // Ẩn pop-up nếu không chọn "VietQR"
                    popup.style.display = "none";
                    backdrop.sclassList.remove('show');
                }
            });

            closeBtn.addEventListener('click', function () {
                popup.style.display = "none";
                backdrop.classList.remove('show');
            });

            backdrop.addEventListener('click', function () {
                popup.style.display = "none";
                backdrop.classList.remove('show');
            });

            checkbox.addEventListener('change', (event) => {
                if (event.target.checked) {
                    const viewCartBtn = document.querySelector("#view-cart-btn");
                    viewCartBtn.removeEventListener("click", toggleCart);
                }
            });


        </script>

    </body>
</html>
