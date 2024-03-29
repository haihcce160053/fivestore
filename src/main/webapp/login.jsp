<%-- 
    Document   : login
    Created on : Feb 12, 2023, 9:09:40 AM
    Author     : Huynh Chi Hai
--%>

<%@page import="com.models.Account"%>
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

        <link href="${pageContext.request.contextPath}/Resources/css/login_signup.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />
    </head>

    <body>
        <%
            if (session.getAttribute("informationAccount") != null) {
                Account account = (Account) session.getAttribute("informationAccount");
                if (account != null) {
                    System.out.println(account.getAccountTypeId());
                    if (account.getAccountTypeId().equals("AD")) {
                        response.sendRedirect(request.getContextPath() + "/homeAdmin");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/home");
                    }
                }
            }
        %>
        <%
            String mess = (String) request.getAttribute("mess");
        %>
        <header id="page-header">
            <div class="page-container">
                <nav class="navbar navbar-expand-lg" style="background-color: #303C5F;">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="/home"
                           style="color: white; font-size: 25px;"><b>FIVESTORE.VN</b>
                        </a>
                    </div>
                </nav>
            </div>
        </header>
        <!-- Toast Message  -->
        <div  class="my-toast">
            <div id="toast">
            </div>
        </div>
        <!-- Modal -->
        <div class="modal fade" id="ForgotPasswordModal" tabindex="-1" aria-labelledby="ForgotPasswordLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modal-title">Forgot password</h5>
                        <button type="button" class="btn-close" data-mdb-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form method="post" action="/forgotpassword">
                        <div class="modal-body" id="modal-body">
                            <span>Username</span>
                            <input type="text" name="forgotUsername" placeholder="Input your username" style="background-color: #E7E7E7; margin-top: 10px"> 
                            <span>What's Your Primary School's Name?</span>
                            <input type="text" name="forgotAnswer" placeholder="Input your answer" style="background-color: #E7E7E7; margin-top: 10px"> 
                            <span>New password</span>
                            <input type="password" name="newPassword" placeholder="Input your new password" style="background-color: #E7E7E7; margin-top: 10px"> 
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn" name="btnForgotPassword" style="background-color: #303C5F; color: white">Submit</button> 
                        </div>
                    </form>

                    <!--data-mdb-dismiss="modal"-->
                </div>
            </div>
        </div>

        <main>
            <div class="container" style="margin-top: 100px">
                <div class="row justify-content-center">
                    <div class="col-md-5">
                        <a href="<%= getServletContext().getContextPath()%>/signup">
                            <img class="img-fluid" src="img/signupqc/banner_signup.png" alt="banner sign up"
                                 style="box-shadow: 10px 10px 10px rgba(48, 60, 95, 0.271);">
                        </a>
                    </div>

                    <div class="col-md-7">
                        <div class="login-wrap p-4 p-md-5">
                            <form id="login-form" method="post" action="/login">
                                <!-- Title login -->
                                <div class="form-group">
                                    <h3 class="text-left mb-1" style="color: #303C5F;">Login</h3>
                                    <span class="text-left" style="font-size: 15px; color: dimgray;">
                                        Welcome to the dietary supplemental shop</span>
                                    <hr>
                                </div>
                                <!-- Input username -->
                                <div class="form-group">
                                    <label for="" style="margin-bottom: 5px;">Username&nbsp;</label><label for=""
                                                                                                           style="color: red;">*</label>
                                    <input type="text" name="username" id="username" class="form-control rounded-left"
                                           placeholder="Please enter your username!">
                                </div>
                                <!-- Input password -->
                                <div class="form-group" style="margin-top: 20px;">
                                    <label for="" style="margin-bottom: 5px;">Password&nbsp;</label><label for=""
                                                                                                           style="color: red;">*</label>
                                    <input type="password" name="password" id="password" class="form-control rounded-left"
                                           placeholder="Please enter your password!">
                                </div>
                                <!-- Submit login -->
                                <div class="form-group" style="margin-top: 25px;">
                                    <button type="submit" id="btnSignIn" name="btnSignIn"
                                            class="form-control btn btn-primary rounded submit px-3"
                                            style="background-color: #303C5F;" onclick="return login()">Login</button>
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
                            <!-- Forgot password -->
                            <div class="form-group" style="margin-top: 20px;" align="center">
                                <a href="" data-mdb-toggle="modal" data-mdb-target="#ForgotPasswordModal">Forgot password?</a>
                            </div>
                            <!-- Sign in other way -->
                            <div class="orther-login" align="center" style="margin-top: 40px;">
                                <div class="login-orther-line"></div>
                                <span class="login-orther-text" style="color: gray;">Sign in another way</span>
                                <div class="login-orther-line"></div>
                            </div>
                            <!-- Sign in with google -->
                            <div class="orther-login" align="center">
                                <a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20openid&redirect_uri=http://localhost:8080/loginGoogle&response_type=code
                                   &client_id=931742517382-quh16iu9mem5r4gbo5r1kk1uos757t11.apps.googleusercontent.com&approval_prompt=force">                                    
                                    <button class="google-login" type="button">
                                        Login with Google
                                    </button></a>
                            </div>
                            <div class="form-group" style="margin-top: 20px;" align="center">
                                Do not have an account? <a href="/signup">Register here</a>
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
        <!-- Jquery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/loginAccount.js"></script>
        
    </body>

</html>
