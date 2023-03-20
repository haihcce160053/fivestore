<%-- 
    Document   : signup
    Created on : Feb 12, 2023, 9:14:07 AM
    Author     : huynh chi hai
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
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
        <link href="${pageContext.request.contextPath}/Resources/css/login_signup.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />
    </head>

    <body>
        <%
            String mess = (String) request.getAttribute("mess");
            String fullname = null;
            String username = null;
            String email = null;
            String loginwithgg = null;
            boolean googleLogin = (boolean) request.getAttribute("googleLogin");
            if (googleLogin) {
                fullname = (String) request.getAttribute("fullname");
                username = (String) request.getAttribute("username");
                email = (String) request.getAttribute("email");
                loginwithgg = (String) request.getAttribute("loginwithgg");
            }
        %>
        <header id="page-header">
            <div class="page-container">
                <nav class="navbar navbar-expand-lg" style="background-color: #303C5F;">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="home.jsp"
                           style="color: white; font-size: 25px;"><b>FIVESTORE.VN</b></a>
                    </div>
                </nav>
            </div>
        </header>

        <main>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-5"> 
                        <img class="img-fluid" src="img/signupqc/banner_signup.png" alt="banner sign up" class="image"
                             style="box-shadow: 10px 10px 10px rgba(48, 60, 95, 0.271);margin-top: 80px;">
                    </div>
                    <div class="col-md-7">
                        <div class="login-wrap p-4 p-md-5">
                            <form id="login-form" method="post" action="/signup">
                                <!-- Title login -->
                                <div class="form-group">
                                    <h3 class="text-left mb-1" style="color: #303C5F;">Register</h3>
                                    <span class="text-left" style="font-size: 15px; color: dimgray">
                                        Welcome to the dietary supplemental shop</span>
                                    <hr>
                                </div>

                                <!-- Input Fullname -->
                                <div class="form-group">
                                    <label for="" style="margin-bottom: 5px;">Full name&nbsp;</label>
                                    <label for="" style="color: red;">*</label>

                                    <input type="text" name="fullname" id="fullname" class="form-control rounded-left" placeholder="Ex: Casey Williams" 
                                           <% if (fullname != null) {%> value="<%= fullname%>" <% } %>>
                                </div>
                                <!-- Choose gender -->
                                <div class="form-group">
                                    <label for="" style="margin-top: 20px;">Gender&nbsp;</label><label for="" style="color: red;">*</label>
                                </div>
                                <div class="form-group">
                                    <div class="radio-group">
                                        <input type="radio" name="gender" value="Male" id="genderMale" style="margin-left: 30px" checked>
                                        <label for="genderMale">Male</label>
                                    </div>
                                    <div class="radio-group">
                                        <input type="radio" name="gender" value="Female" id="genderFemale" style="margin-left: 30px">
                                        <label for="genderFemale">Female</label>
                                    </div>
                                </div>

                                <!-- Input username -->
                                <div class="form-group">
                                    <label for="" style="margin-top: 20px;">Username&nbsp;</label><label for=""
                                                                                                         style="color: red;">*</label>
                                    <input type="text" name="username" id="username" class="form-control rounded-left"
                                           placeholder="Ex: abc123"
                                           <% if (username != null) {%> value="<%= username%>" readonly <% } %>>
                                </div> 
                                <!-- Input password -->
                                <div class="form-group" style="margin-top: 20px;">
                                    <label for="" style="margin-bottom: 5px;">Password&nbsp;</label><label for=""
                                                                                                           style="color: red;">*</label>
                                    <input type="password" name="password" id="password" class="form-control rounded-left"
                                           placeholder="Between 5 and 30 characters">
                                </div>
                                <!-- Confirm password -->
                                <div class="form-group" style="margin-top: 20px;">
                                    <label for="" style="margin-bottom: 5px;">Confirm Password&nbsp;</label><label for=""
                                                                                                                   style="color: red;">*</label>
                                    <input type="password" name="confirmPassword" id="confirmPassword" class="form-control rounded-left"
                                           placeholder="Please enter again password!">
                                </div>
                                <!-- Input security question -->
                                <div class="form-group">
                                    <label for="" style="margin-top: 20px;">Security&nbsp;</label><label for=""
                                                                                                         style="color: red;">*</label>
                                    <input type="text" name="securityques" id="securityques" class="form-control rounded-left"
                                           value="What's Your Primary School's Name?" style="margin-bottom: 10px" readonly>
                                    <input type="text" name="securityAnswer" id="securityAnswer" class="form-control rounded-left"
                                           placeholder="Security answer">
                                </div>    
                                <!-- Input Phone Number -->
                                <div class="form-group">
                                    <label for="" style="margin-top: 20px;">Phone Number&nbsp;</label><label for=""
                                                                                                             style="color: red;">*</label>
                                    <input type="text" name="phoneNumber" id="phoneNumber" class="form-control rounded-left"
                                           placeholder="Please enter your phone number!">
                                    <%
                                        if (loginwithgg != null) {
                                    %>
                                    <input type="text" name="btnGG" hidden value="<%=loginwithgg%>">
                                    <%
                                        }
                                    %>
                                </div>
                                <!-- Input email -->
                                <div class="form-group">
                                    <label for="" style="margin-top: 20px;">Email&nbsp;</label><label for=""
                                                                                                      style="color: red;">*</label>
                                    <input type="text" name="email" id="email" class="form-control rounded-left"
                                           placeholder="example@gmail.com"
                                           <% if (email != null) {%> value="<%= email%>" readonly <% } %>>
                                </div>                                                             

                                <!-- Submit login -->
                                <div class="form-group" style="margin-top: 25px;">
                                    <button type="submit" id="btnSignUp" name="btnSignUp"
                                            class="form-control btn btn-primary rounded submit px-3"
                                            style="background-color: #303C5F;" onclick="return register()">Register</button>
                                </div>
                            </form>
                            <%
                                if (mess != null) {
                            %>
                            <div class="form-group" style="margin-top: 10px;">
                                <span id="regError" data-my-attribute="<%= mess%>"></span>
                            </div>
                            <%
                            } else {
                            %>
                            <div class="form-group" style="margin-top: 10px;">
                                <span id="regError" data-my-attribute=""></span>
                            </div>
                            <%
                                }
                            %>
                            <div class="form-group" style="margin-top: 20px;" align="center">
                                Do you already have an account? <a href="<%= getServletContext().getContextPath()%>/login">Login here</a>
                            </div>
                            <!-- Toast Message  -->
                            <div  class="my-toast">
                                <div id="toast">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </main>
        <!-- MDB -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.js"></script>
        <!-- Jquery -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script>
                                                function showWarning(myAttribute1) {
                                                    toast({
                                                        title: 'Note!',
                                                        message: myAttribute1,
                                                        type: 'warning',
                                                        duration: 5000
                                                    });
                                                }
                                                window.addEventListener("load", function () {
                                                    const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
                                                    if (myAttribute1 !== "") {
                                                        showWarning(myAttribute1);
                                                    }
                                                });
        </script>
        <script src="${pageContext.request.contextPath}/Resources/js/signUp.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
    </body>

</html>
