<%-- 
    Document   : productManagement
    Created on : Mar 2, 2023, 2:56:02 PM
    Author     : Hoang Liem
--%>

<%@page import="com.models.Account"%>
<%@page import="com.daos.AccountDAO"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.daos.ProductDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Management</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/index.js"></script>
        <link href="${pageContext.request.contextPath}/Resources/css/gototop.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/productManagement.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/Resources/css/toastMessage.css" rel="stylesheet" />

    </head>
    <body>
        <%
            String username = (String) session.getAttribute("username");
            AccountDAO daoAc = new AccountDAO();
            Account ac = daoAc.getAccount(username);
            //Init product dao
            ProductDAO dao = new ProductDAO();
            //Get message from controller
            String mess = (String) request.getAttribute("mess");
        %>
        <header id="page-header">
            <div class="page-container">
                <nav class="navbar navbar-expand-lg" id="navbar-main" style="background-color: #303C5F;">
                    <div class="container-fluid">
                        <a class="navbar-brand" href="/home" style="color: white; font-size: 25px;"><b>FIVESTORE.VN - Product Management</b></a>
                    </div>
                </nav>
            </div>
        </header>
        <main>
            <div class="container" style="margin-top: 20px;">
                <!-- User -->
                <div class="search-box">
                    <div class="search-input">
                        <input type="text" id="search" class="form-control" placeholder="Search by ID or Name Product">
                    </div>
                    <div class="search-buttons">
                        <div class="select-container">
                            <select class="form-control" id="AllSelect">
                                <option value="All">All</option>
                                <option value="Digestion">Digestion</option>
                                <option value="Eyes">Eyes</option>
                                <option value="HighBlood">HighBlood</option>
                                <option value="Liver">Liver</option>
                                <option value="Resistance">Resistance</option>
                                <option value="Skin">Skin</option>
                                <option value="Sleep Deprivation">Sleep Deprivation</option>
                                <option value="Weight">Weight</option>
                            </select>
                        </div>
                        <a href="/Product/Add/<%= ac.getUsername()%>"><button class="btn btn-primary">Add New Product</button></a>
                    </div>
                </div>
                <ul class="responsive-table">
                    <li class="table-header" style="color: white">
                        <div class="col col-1">Picture</div>
                        <div class="col col-2">ID</div>
                        <div class="col col-3">Name</div>
                        <div class="col col-4">Description</div>
                        <div class="col col-5">Type</div>
                        <div class="col col-6">Quantity</div>
                        <div class="col col-7">Price</div>
                        <div class="col col-8" >EXP</div>
                        <div class="col col-9">Origin</div>
                        <div class="col col-10">SoldAmount</div>
                        <div class="col col-11">Action</div>
                    </li>
                    <%
                        ResultSet rs = dao.getAll();
                        while (rs.next()) {
                    %>

                    <li class="table-row">
                        <div class="col col-1" data-label="Picture">
                            <img src="<%= rs.getString("PictureLink")%>" alt="Product image" width="100%">
                        </div>

                        <div class="col col-2" data-label="ID"><%= rs.getString("ProductID")%></div>
                        <div class="col col-3" data-label="Name"><%= rs.getString("ProductName")%></div>

                        <input id="title-<%= rs.getString("ProductID")%>" type="text" value="<%= rs.getString("ProductName")%>" hidden>
                        <input id="des-<%= rs.getString("ProductID")%>" type="text" value="<%= rs.getString("Description")%>" hidden>
                        <div class="col col-4" data-label="Description">
                            <button id="view-<%= rs.getString("ProductID")%>" class="btn" style="background-color: #303C5F; color: white" data-mdb-toggle="modal" data-mdb-target="#ProductDetailModal" onclick="ShowProductDetail(document.getElementById('title-<%= rs.getString("ProductID")%>').value, document.getElementById('des-<%= rs.getString("ProductID")%>').value)">View</button>
                        </div>

                        <%String nameOfTypeProduct = dao.nameOfTypeProduct(rs.getString("ProductTypeID"));%>
                        <div class="col col-5" data-label="Type"><%=nameOfTypeProduct%></div>

                        <div class="col col-6" data-label="Quantity"><%= rs.getString("Quantity")%></div>
                        <%
                            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
                            String formattedPrice = format.format(rs.getInt("Price")).replace("?", "VND").replaceAll("\\s", "");
                        %>
                        <div class="col col-7" data-label="Price"><%= formattedPrice%></div>
                        <div class="col col-8" data-label="EXP"><%= rs.getDate("EXP")%></div>
                        <div class="col col-9" data-label="Origin"><%= rs.getString("Origin")%></div>
                        <div class="col col-10" data-label="SoldAmount"><%= rs.getString("SoldAmount")%></div>
                        <div class="col col-11" data-label="Action">
                            <a href="/Product/Edit/<%= rs.getString("ProductID")%>" class="edit" title="Edit" data-toggle="tooltip"><i class="fas fa-edit"></i></a>
                            <a href="/Product/Delete/<%= rs.getString("ProductID")%>" class="delete" title="Delete" data-toggle="tooltip"><i class="fas fa-trash"></i></a>
                        </div>
                    </li>

                    <%
                        }
                    %>
                </ul>
            </div>
        </main>

        <!-- Modal -->
        <div class="modal fade" id="ProductDetailModal" tabindex="-1" aria-labelledby="ProductDetailModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modal-title">Modal title</h5>
                        <button type="button" class="btn-close" data-mdb-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body" id="modal-body">...</div>
                    <div class="modal-footer">
                        <button type="button" class="btn" style="background-color: #303C5F; color: white" data-mdb-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

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


        <!-- Toast Message  -->
        <div id="toast">

        </div>

        <!-- Confirm Box and Overlay -->
        <div class="overlay" id="overlay"> </div>
        <div class="confirm-box" id="confirm-box">
            <div class="box-header">
                <h2></h2>
            </div>
            <div class="box-content">
                <p></p>
            </div>
            <div class="button-container">
                <button id="yes-button"></button>
                <button id="no-button"></button>
            </div>
        </div>

        <div class="overlay" id="overlay1"></div>
        <div class="confirm-box" id="confirm-box1">
            <div class="box-header">
                <h2>Are you sure you want to remove this product?</h2>
            </div>
            <div class="box-content">
                <p>Product will be removed!</p>
            </div>
            <div class="button-container">
                <button id="yes-button1">Yes</button>
                <button id="no-button1">No</button>
            </div>
        </div>

        <!-- button go to top -->
        <button onclick="topFunction()" id="myBtn" title="Go to top"></button>

        <!-- JS Handler For Modal -->
        <script>
            function ShowProductDetail(title, description) {
                document.getElementById("modal-title").innerHTML = title;
                const productInfo = description.split(":");
                console.log(productInfo);
                document.getElementById("modal-body").innerHTML = description;
            }
        </script>
        <!-- JS Handler Searching -->
        <script>
            const searchInput = document.querySelector('#search');
            const tableRows = document.querySelectorAll('.table-row');

            searchInput.addEventListener('keyup', function (event) {
                const searchTerm = event.target.value.toLowerCase().trim();
                tableRows.forEach(function (row) {
                    const id = row.querySelector("[data-label='ID']").textContent.toLowerCase();
                    const name = row.querySelector("[data-label='Name']").textContent.toLowerCase();
                    const doesIdContainSearchTerm = id.includes(searchTerm);
                    const doesNameContainSearchTerm = name.includes(searchTerm);
                    if (doesIdContainSearchTerm || doesNameContainSearchTerm) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });

        </script>

        <script>
            const selectElement = document.getElementById("AllSelect");
            selectElement.addEventListener("change", (event) => {
                const selectedValue = event.target.value;
                tableRows.forEach((row) => {
                    const statusElement = row.querySelector("[data-label='Type']");
                    const statusValue = statusElement.textContent.trim();
                    if (selectedValue === "All" || selectedValue === statusValue) {
                        row.style.display = "flex";
                    } else {
                        row.style.display = "none";
                    }
                });
            });

        </script>
        <!-- JS -->
        <script src="${pageContext.request.contextPath}/Resources/js/gototop.js"></script>
        <script src="${pageContext.request.contextPath}/Resources/js/comfirmboxAc.js"></script>
        <script>
            const mySpan1 = document.getElementById('regError');
            const myAttribute1 = mySpan1.getAttribute('data-my-attribute');
            mainFunction();

            function mainFunction() {
                if (myAttribute1 == "Noo") {
                    showErrorDeleteAdToast();
                } else if (myAttribute1 == "YesD") {
                    showSuccessDeleteToast();
                } else if (myAttribute1 == "NoD") {
                    showErrorDeleteToast();
                } else if (myAttribute1 == "YesA") {
                    showSuccessAddToast();
                } else if (myAttribute1 == "YesU") {
                    showSuccessUpdateToast();
                } else {
                    return;
                }
            }

            function showErrorDeleteAdToast() {
                toast({
                    title: 'Failed!',
                    message: 'Not find Product!',
                    type: 'error',
                    duration: 3000
                });
            }

            function showSuccessDeleteToast() {
                toast({
                    title: 'Successfully!',
                    message: 'Delete Product Successfully!',
                    type: 'success',
                    duration: 3000
                });
            }
            function showErrorDeleteToast() {
                toast({
                    title: 'Failed!!',
                    message: 'Delete Product Unsuccessfully!',
                    type: 'error',
                    duration: 3000
                });
            }


            function showSuccessAddToast() {
                toast({
                    title: 'Successfully!',
                    message: 'Add Product Successfully!',
                    type: 'success',
                    duration: 3000
                });
            }

            function showSuccessUpdateToast() {
                toast({
                    title: 'Successfully!',
                    message: 'Update Product Successfully!',
                    type: 'success',
                    duration: 3000
                });
            }
        </script>
        <!-- Link ALL JS From URL -->
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/5.0.0/mdb.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.3/jquery.validate.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
    </body>
</html>
