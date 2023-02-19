<%-- 
    Document   : accountInf
    Created on : Feb 15, 2023, 7:03:52 AM
    Author     : QuangQui
--%>

<%@page import="com.models.Account"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Resources/AccountInformation/style.css">
        <title>Account Information</title>
        <style>
            #toast {
                position: fixed;
                top: 32px;
                right: 32px;
                z-index: 999999;
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
        </style>
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
    </head>
    <body>
        <%
            Account ac = (Account) session.getAttribute("Account");
            String mess = (String) request.getAttribute("mess");
            String mess1 = (String) request.getAttribute("mess1");
        %>
        <div class="main-content">
            <!-- Top navbar -->
            <nav class="navbar navbar-top navbar-expand-md navbar-dark" id="navbar-main">
                <div class="container-fluid">
                    <!-- Brand -->
                    <a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block"
                       href="/">FIVE STORE - ACCOUNT
                        INFORMATION</a>
                    <!-- User -->
                    <ul class="navbar-nav align-items-center d-none d-md-flex">
                        <li class="nav-item dropdown">
                            <a class="nav-link pr-0" href="#" click="false" role="button" data-toggle="dropdown"
                               aria-haspopup="true" aria-expanded="false">
                                <%
                                    if (ac != null) {
                                %>
                                <div class="media align-items-center">
                                    <div class="media-body ml-2 d-none d-lg-block">
                                        <span class="mb-0 text-sm  font-weight-bold"><%=ac.getFullname()%></span>
                                    </div>
                                </div>
                                <%
                                } else {
                                %>
                                <div class="media align-items-center">
                                    <div class="media-body ml-2 d-none d-lg-block">
                                        <span class="mb-0 text-sm  font-weight-bold">Null</span>
                                    </div>
                                </div>                              
                                <%
                                    }
                                %>
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>
            <!-- Header -->
            <div class="header pb-8 pt-5 pt-lg-8 d-flex align-items-center"
                 style="background-image: url(https://www.fda.gov/files/DS_Homepage_header%20graphic.jpg); background-size: cover; background-position: center;">
                <!-- Mask -->
                <span class="mask bg-gradient-default opacity-8"></span>
                <!-- Header container -->
                <div class="container-fluid d-flex align-items-center">
                    <div class="row">
                        <div class="col-lg-7 col-md-10">
                            <p class="text-white mt-0">This is your profile page. You can see all information about account and edit them.</p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Page content -->
            <div class="container-fluid mt--7">
                <div class="row">
                    <div class="col-xl-4 order-xl-2 mb-5 mb-xl-0">
                        <div class="card card-profile shadow">
                            <div class="row justify-content-center">
                                <div class="col-lg-3 order-lg-2">
                                    <div class="card-profile-image">
                                        <a href="#">
                                            <img src="https://cdn-icons-png.flaticon.com/512/149/149071.png"
                                                 class="rounded-circle">
                                        </a>
                                    </div>                         
                                </div>
                            </div>


                            <div class="card-body pt-0 pt-md-4">
                                <div class="row">
                                    <div class="col">
                                        <div class="card-profile-stats d-flex justify-content-center mt-md-5 m">
                                            <div>
                                                <span class="heading">0</span>
                                                <span class="description">Ordered</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-center">
                                    <h3>
                                        <%=ac.getFullname()%>
                                    </h3>
                                    <div class="h5 mt-4">
                                        <i class="ni business_briefcase-24 mr-2"></i><%=ac.getEmail()%>
                                    </div>
                                </div>
                                <form id="form-2" action="/account" method="post">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group focused">
                                                <label class="form-control-label" for="input-username">Current Password</label>
                                                <input type="password" id="input-oldpassword" 
                                                       name="oldpassword" 
                                                       readonly
                                                       class="form-control form-control-alternative editable" 
                                                       placeholder="Enter current password!"
                                                       >
                                                <input type="text"
                                                       name="username" 
                                                       hidden
                                                       value="<%=ac.getUsername()%>"
                                                       >
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="form-group focused">
                                                <label class="form-control-label" for="input-username">New Password</label>
                                                <input type="password" id="input-newpassword"
                                                       name="password" 
                                                       readonly
                                                       class="form-control form-control-alternative editable"
                                                       placeholder="Enter new password!"
                                                       >

                                            </div>
                                        </div>
                                        <div class="col-lg-6">
                                            <div class="form-group focused">
                                                <label class="form-control-label" for="input-username">Confirm Password</label>
                                                <input type="password" id="input-confirmpassword" 
                                                       name="confirmpassword" 
                                                       readonly
                                                       class="form-control form-control-alternative editable" 
                                                       placeholder="Enter again!"
                                                       >
                                            </div>
                                        </div>
                                    </div>
                                    <%
                                        if (mess != null) {
                                    %>
                                    <div class="row" >
                                        <div class="col-lg-12" style="margin-left: 15px; margin-bottom: 15px;">
                                            <span id="regError" data-my-attribute="<%= mess%>"></span>
                                        </div>          
                                    </div>
                                    <%
                                    } else {

                                    %>
                                    <div class="row" >
                                        <div class="col-lg-12" style="margin-left: 15px; margin-bottom: 15px;">
                                            <span id="regError" data-my-attribute=""></span>
                                        </div>          
                                    </div>
                                    <%                                        }

                                    %>
                                    <div class="row" >
                                        <div class="col-lg-6">
                                            <button class="btn btn-sm btn-info mr-4" 
                                                    type="button" id="edit-pass-button">Change Password</button> 
                                            <button class="btn btn-sm btn-info mr-4" 
                                                    type="submit" 
                                                    style="display: none" 
                                                    id="submit-pass-button" 
                                                    name="btnChangePassword">
                                                Change
                                            </button> 
                                        </div>       
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>
                    <div class="col-xl-8 order-xl-1">
                        <form id="form-1" action="/account" method="post">
                            <div class="card bg-secondary shadow">
                                <div class="card-header bg-white border-0">
                                    <div class="row align-items-center">
                                        <div class="col-8">
                                            <h3 class="mb-0">My account</h3>
                                        </div>
                                        <div class="col-4 text-right">
                                            <button class="btn btn-sm btn-primary" type="button" id="edit-button">Edit Information</button> 
                                            <button class="btn btn-sm btn-primary" type="submit" style="display: none" id="submit-button" name="btnUpdate" onclick="return update()">Submit Information</button> 
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <h6 class="heading-small text-muted mb-4">Account information</h6>
                                    <div class="pl-lg-4">
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group focused">
                                                    <label class="form-control-label" for="input-username">Username</label>
                                                    <input type="text" id="input-username" name="username" readonly
                                                           class="form-control form-control-alternative" placeholder="Username"
                                                           value="<%=ac.getUsername()%>">
                                                </div>
                                            </div>

                                            <div class="col-lg-6">
                                                <div class="form-group focused">
                                                    <label class="form-control-label" for="input-username">Email</label>
                                                    <input type="text" id="email" name="Email" readonly
                                                           class="form-control form-control-alternative editable" placeholder="Username"
                                                           value="<%=ac.getEmail()%>">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group focused"> 
                                                    <label class="form-control-label" for="input-first-name">Security Answer</label>
                                                    <input type="text" id="SecurityAnswer" name="SecurityAnswer" readonly
                                                           class="form-control form-control-alternative editable"
                                                           placeholder="SecurityAnswer" value="<%=ac.getSecurityAnswer()%>">
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="form-group focused">
                                                    <label class="form-control-label" for="input-last-name">Phone Number</label>
                                                    <input type="text" id="phone" name="phone" readonly
                                                           class="form-control form-control-alternative editable"
                                                           placeholder="Last name" value="0<%=ac.getPhoneNumber()%>">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-6">
                                                <div class="form-group focused">
                                                    <label class="form-control-label" for="input-first-name">Full Name</label>
                                                    <input type="text" id="fullname" name="fullname" readonly
                                                           class="form-control form-control-alternative editable"
                                                           placeholder="Full Name" value="<%=ac.getFullname()%>">
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <label class="form-control-label" for="input-first-name">Gender</label>
                                                <%
                                                    if (ac.getGender().equalsIgnoreCase("Male")) {
                                                %>
                                                <div class="form-group">
                                                    <div class="radio-group">
                                                        <input type="radio" name="gender" value="Male" readonly id="Gender" style="margin-left: 30px" checked>
                                                        <label for="genderMale">Male</label>
                                                    </div>
                                                    <div class="radio-group">
                                                        <input type="radio" name="gender" value="Female" readonly id="Gender" style="margin-left: 30px" >
                                                        <label for="genderFemale">Female</label>
                                                    </div>
                                                </div>
                                                <%
                                                } else {
                                                %>
                                                <div class="form-group">
                                                    <div class="radio-group">
                                                        <input type="radio" name="gender" value="Male" readonly id="Gender" style="margin-left: 30px" >
                                                        <label for="genderMale">Male</label>
                                                    </div>
                                                    <div class="radio-group">
                                                        <input type="radio" name="gender" value="Female" readonly id="Gender" style="margin-left: 30px"checked>
                                                        <label for="genderFemale">Female</label>
                                                    </div>
                                                </div>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <%                                                if (mess1 != null) {
                                        %>

                                        <span id="" data-my-attribute="my-value"></span>
                                        <div class="row" >
                                            <div class="col-lg-12" style="margin-left: 15px; margin-bottom: 15px;">
                                                <span id="regError1" data-my-attribute="<%= mess1%>"> </span>
                                            </div>          
                                        </div>
                                        <%
                                        } else {

                                        %>
                                        <div class="row" >
                                            <div class="col-lg-12" style="margin-left: 15px; margin-bottom: 15px;">
                                                <span id="regError1" data-my-attribute=""></span>
                                            </div>          
                                        </div>
                                        <%                                                }
                                        %>
                                    </div>
                                </div>
                        </form>        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="toast">


    </div>
    <footer class="footer">
        <div class="row align-items-center justify-content-xl-between">
            <div class="col-xl-6 m-auto text-center">
                <div class="copyright">
                    <p>Made </a> by FiveStore</p>
                </div>
            </div>
        </div>
    </footer>
    <script>
        const form = document.querySelector('#form-2');
        const currentPasswordInput = form.querySelector('#input-oldpassword');
        const newPasswordInput = form.querySelector('#input-newpassword');
        const confirmPasswordInput = form.querySelector('#input-confirmpassword');
        const errorSpan = document.querySelector('#regError');


        form.addEventListener('submit', (event) => {
            // Check if any of the password fields are empty
            if (currentPasswordInput.value === '' || newPasswordInput.value === '' || confirmPasswordInput.value === '') {
                event.preventDefault();
                errorSpan.innerText = 'Please fill out all password fields.';
                return;
            }

            // Check if the new password and confirm password fields match
            if (newPasswordInput.value !== confirmPasswordInput.value) {
                event.preventDefault();
                errorSpan.innerText = 'New password and confirm password do not match!';
                return;
            }

            // Check if the new password field meets the password criteria
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$/;
            if (!passwordRegex.test(currentPasswordInput.value)) {
                event.preventDefault();
                errorSpan.innerText = 'Current password must contain at least one uppercase letter, one lowercase letter, and one number.';
                return;
            } else if (!passwordRegex.test(newPasswordInput.value)) {
                event.preventDefault();
                errorSpan.innerText = 'New password must contain at least one uppercase letter, one lowercase letter, and one number.';
                return;
            } else
                // All password checks have passed
                errorSpan.innerText = '';
        });
    </script>

    <script>
        // Lấy các thẻ input và nút chỉnh sửa từ form 1
        const form1Inputs = document.querySelectorAll('#form-1 .editable');
        const form2Inputs = document.querySelectorAll('#form-2 .editable');
        const form1editButton = document.getElementById('edit-button');
        const form1submitButton = document.getElementById('submit-button');
        const form2editButton = document.getElementById('edit-pass-button');
        const form2submitButton = document.getElementById('submit-pass-button');

        // Thêm sự kiện click cho nút chỉnh sửa của form 1
        form1editButton.addEventListener('click', () => {
            for (const input of form1Inputs) {
                input.removeAttribute('readonly');
            }
            form1submitButton.style.display = '';
            form1editButton.style.display = 'none';
        });
        form2editButton.addEventListener('click', () => {
            for (const input of form2Inputs) {
                input.removeAttribute('readonly');
            }
            form2submitButton.style.display = '';
            form2editButton.style.display = 'none';
        });

        function update() {
            var fullname = document.getElementById("fullname").value;
            var email = document.getElementById("email").value;
            var phone = document.getElementById("phone").value;
            var answer = document.getElementById("SecurityAnswer").value;
            if (fullname != "" && email != "" && phone != "" && answer != "") {
                var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                if (re.test(String(email).toLowerCase()) == true) {
                    var phoneRegex = /^\d{10}$|^\d{3}-\d{3}-\d{4}$|^\d{3} \d{3} \d{4}$/;
                    if (phoneRegex.test(phone) == true) {
                        if (answer.length >= 5 && answer.length <= 30) {

                        } else {
                            document.getElementById("regError1").innerText =
                                    "Answer must be between 5 and 30 characters!";
                            return false;
                        }
                    } else {
                        document.getElementById("regError1").innerText =
                                "Phone number is not valid!";
                        return false;
                    }
                } else {
                    document.getElementById("regError1").innerText = "Email is not valid!";
                    return false;
                }
            } else {
                document.getElementById("regError1").innerText = "Please fill all information account to update!";
                return false;
            }
        }
    </script>

    <script>
        const mySpan = document.getElementById('regError1');
        const mySpan1 = document.getElementById('regError');
        const myAttribute = mySpan.getAttribute('data-my-attribute');
        const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
        console.log(myAttribute);
        console.log(myAttribute1);
        mainFunction();
        

        function mainFunction() {
            if (myAttribute == "Yes") {
                showSuccessInfToast();
            } else if (myAttribute == "No") {
                showErrorInfToast();
            } else if(myAttribute1 == "Noo"){
                showErrorsOldToast();
            } else if(myAttribute1 == "No"){
                showErrorPassToast();
            } else if(myAttribute1 == "Yes"){
                showSuccessPassToast();
            }else {
                return;
            }
        }

        function showSuccessInfToast() {
            toast({
                title: 'Successfully!',
                message: 'Update information successfully!',
                type: 'success',
                duration: 3000
            });
        }

        function showErrorInfToast() {
            toast({
                title: 'Failed!',
                message: 'Update information Unsuccessfully!',
                type: 'error',
                duration: 3000
            });
        }

        function showSuccessPassToast() {
            toast({
                title: 'Successfully!',
                message: 'Change Password Successfully!',
                type: 'success',
                duration: 3000
            });
        }
        function showErrorsOldToast() {
            toast({
                title: 'Failed!!',
                message: 'Your current password is not correct!',
                type: 'error',
                duration: 3000
            });
        }

        function showErrorPassToast() {
            toast({
                title: 'Failed!',
                message: 'Change Password Unsuccessfully!',
                type: 'error',
                duration: 3000
            });
        }
    </script>
</body>
</html>
