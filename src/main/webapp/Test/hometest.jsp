<%-- 
    Document   : hometest
    Created on : Feb 15, 2023, 7:22:51 AM
    Author     : Huynh Chi Hai
--%>

<!--THIS PAGE USING FOR TESTING !!!-->

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FIVESTORE - Home page</title>
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
                                <li class="nav-item">
                                    <a class="nav-link" href="/home" aria-current="page" style="color: white;">Home</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="/product" style="color: white;">Product</a>
                                </li>
                            </ul>
                        </div>
                        <div>
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
                        </div>
                    </div>
                </nav>
                <div style="container">
                    <div class="row justify-content-center" style="margin-top: 20px;">
                        <div class="col-md-7 col-lg-5">
                            <div style="margin-bottom: 20px">
                                <h5>SEARCH PRODUCT</h5>
                            </div>
                            <form class="d-flex input-group w-auto">
                                <input
                                    type="search"
                                    class="form-control rounded"
                                    placeholder="Search"
                                    aria-label="Search"
                                    />
                                <span class="input-group-text border-0" id="search-addon">
                                    <i class="fas fa-search"></i>
                                </span>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <main>
            <div style="padding: 50px">
                <div style="margin-bottom: 40px">
                    <h5>DIGESTION</h5>
                    <div class="row">
                        <div class="col-md-2">Sản phẩm 1</div>
                        <div class="col-md-2">Sản phẩm 2</div>
                        <div class="col-md-2">Sản phẩm 3</div>
                        <div class="col-md-2">Sản phẩm 4</div>
                        <div class="col-md-2">Sản phẩm 5</div>
                        <div class="col-md-2">Sản phẩm 6</div>
                    </div>
                </div>

                <div style="margin-bottom: 30px">
                    <h5>EYES</h5>
                    <div class="row">
                        <div class="col-md-2">Sản phẩm 7</div>
                        <div class="col-md-2">Sản phẩm 8</div>
                        <div class="col-md-2">Sản phẩm 9</div>
                        <div class="col-md-2">Sản phẩm 10</div>
                        <div class="col-md-2">Sản phẩm 11</div>
                        <div class="col-md-2">Sản phẩm 12</div>
                    </div>
                </div>

                <div style="margin-bottom: 30px">
                    <h5>HIGHBLOOD</h5>
                    <div class="row">
                        <div class="col-md-2">Sản phẩm 7</div>
                        <div class="col-md-2">Sản phẩm 8</div>
                        <div class="col-md-2">Sản phẩm 9</div>
                        <div class="col-md-2">Sản phẩm 10</div>
                        <div class="col-md-2">Sản phẩm 11</div>
                        <div class="col-md-2">Sản phẩm 12</div>
                    </div>
                </div>

                <div style="margin-bottom: 30px">
                    <h5>LIVER</h5>
                    <div class="row">
                        <div class="col-md-2">Sản phẩm 7</div>
                        <div class="col-md-2">Sản phẩm 8</div>
                        <div class="col-md-2">Sản phẩm 9</div>
                        <div class="col-md-2">Sản phẩm 10</div>
                        <div class="col-md-2">Sản phẩm 11</div>
                        <div class="col-md-2">Sản phẩm 12</div>
                    </div>
                </div>

                <div style="margin-bottom: 30px">
                    <h5>RESISTANCE</h5>
                    <div class="row">
                        <div class="col-md-2">Sản phẩm 7</div>
                        <div class="col-md-2">Sản phẩm 8</div>
                        <div class="col-md-2">Sản phẩm 9</div>
                        <div class="col-md-2">Sản phẩm 10</div>
                        <div class="col-md-2">Sản phẩm 11</div>
                        <div class="col-md-2">Sản phẩm 12</div>
                    </div>
                </div>

                <div style="margin-bottom: 30px">
                    <h5>SKIN</h5>
                    <div class="row">
                        <div class="col-md-2">Sản phẩm 7</div>
                        <div class="col-md-2">Sản phẩm 8</div>
                        <div class="col-md-2">Sản phẩm 9</div>
                        <div class="col-md-2">Sản phẩm 10</div>
                        <div class="col-md-2">Sản phẩm 11</div>
                        <div class="col-md-2">Sản phẩm 12</div>
                    </div>
                </div>

                <div style="margin-bottom: 30px">
                    <h5>SLEEP DEPRIVATION</h5>
                    <div class="row">
                        <div class="col-md-2">Sản phẩm 7</div>
                        <div class="col-md-2">Sản phẩm 8</div>
                        <div class="col-md-2">Sản phẩm 9</div>
                        <div class="col-md-2">Sản phẩm 10</div>
                        <div class="col-md-2">Sản phẩm 11</div>
                        <div class="col-md-2">Sản phẩm 12</div>
                    </div>
                </div>
                
                <div style="margin-bottom: 30px">
                    <h5>WEIGHT</h5>
                    <div class="row">
                        <div class="col-md-2">Sản phẩm 7</div>
                        <div class="col-md-2">Sản phẩm 8</div>
                        <div class="col-md-2">Sản phẩm 9</div>
                        <div class="col-md-2">Sản phẩm 10</div>
                        <div class="col-md-2">Sản phẩm 11</div>
                        <div class="col-md-2">Sản phẩm 12</div>
                    </div>
                </div>
            </div>
        </main>

        <!-- MDB -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.js"></script>
        <!-- Jquery -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    </body>
</html>
