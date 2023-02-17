<%-- 
    Document   : OderInfomation
    Created on : Feb 17, 2023, 9:03:28 AM
    Author     : ASUS
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

        <!-- Jquery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>

        <!-- Style of google button -->
        <style>
            body {
                background-color: #f2f2f2;
                border-radius: 10px;
            }

            .icon {
                background-color: #9c27b0;
                border-radius: 50%;
                width: 70px;
                height: 70px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 0 auto;
            }

            .icon span {
                color: white;
                font-size: 40px;
            }

            h3 {
                margin-bottom: 30px;
            }

            label {
                font-weight: bold;
            }

            input[type="text"],
            input[type="password"] {
                border: none;
                border-radius: 25px;
                padding: 10px;
                margin-bottom: 20px;
                width: 100%;
                box-sizing: border-box;
                font-size: 16px;
                background-color: #fff;
            }

            input[type="text"]:focus,
            input[type="password"]:focus {
                outline: none;
            }

            .submit {
                background-color: #9c27b0;
                color: white;
                font-weight: bold;
                border-radius: 25px;
                padding: 10px 20px;
                margin-top: 20px;
                width: 100%;
                box-sizing: border-box;
                font-size: 16px;
            }

            .submit:hover {
                background-color: #7b1fa2;
            }

            .orther-login {
                margin-top: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .orther-login .login-orther-line {
                height: 1px;
                width: 100px;
                background-color: gray;
                margin: 0 10px;
            }

            .orther-login .login-orther-text {
                font-size: 14px;
                color: gray;
                margin: 0 20px;
            }

            .google-login {
                background-color: #db4437;
                color: white;
                font-weight: bold;
                border-radius: 25px;
                padding: 10px 20px;
                margin-top: 20px;
                width: 100%;
                box-sizing: border-box;
                font-size: 16px;
                cursor: pointer;
            }

            .google-login:hover {
                background-color: #c62828;
            }

        </style>
    </head>

    <body>
        <header id="page-header">
            <div class="page-container">
                <nav class="navbar navbar-expand-lg" style="background-color: #9c27b0;">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="/home"
                           style="color: white; font-size: 25px;"><b>FIVESTORE.VN</b></a>
                        <button class="navbar-toggler" type="button" data-mdb-toggle="collapse"
                                data-mdb-target="#navbarText" aria-controls="navbarText" aria-expanded="false"
                                aria-label="Toggle navigation">
                            <i class="fas fa-bars"></i>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarText">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <li class="nav-item">
                                    <a class="nav-link" href="/home" aria-current="page" style="color: white;">Home</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/product" style="color: white;">Product</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </header>

    </body>

</html>
