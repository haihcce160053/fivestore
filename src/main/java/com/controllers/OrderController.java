package com.controllers;

import com.security.OTPSender;
import com.daos.OrderDAO;
import com.daos.OrderDetailsDAO;
import com.daos.ProductDAO;
import com.models.Order;
import com.models.OrderDetails;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.sql.Date;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.text.NumberFormat;
import java.util.Locale;
import java.util.Properties;

/**
 *
 * @author Tran Trung Kien
 */
public class OrderController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OrderController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI();
        //trung kien
        if (path.startsWith("/checkout/")) {
            String[] s = path.split("/");
            String username = null;
            username = s[s.length - 1];
            if (username.equals("null")) {
                request.setAttribute("non-ac", "Please Login or signup to buy!");
                response.sendRedirect("/login");
                return;
            }
            String prefixUser = username.substring(0, 2).toUpperCase();
            System.out.println(prefixUser);

            OrderDAO dao = new OrderDAO();
            String OrderID = prefixUser + String.format("%06d", 1);
            int NewID = Integer.parseInt(OrderID.substring(3));
            String NewOrderID;
            int i = 0;
            do {
                NewOrderID = prefixUser + String.format("%06d", NewID + i);
                i++;
            } while (dao.getOrder(NewOrderID) != null);

            request.setAttribute("OrderID", NewOrderID);
            request.getRequestDispatcher("/newOrder.jsp").forward(request, response);

        }
        //phat quy
        if (path.endsWith("/Order/")) {
            request.getRequestDispatcher("/OrderManagement.jsp").forward(request, response);
        } else {
            if (path.startsWith("/Order/Detail/")) {
                // split path to get username
                String[] s = path.split("/");
                String OrderID = s[s.length - 1];
                if (OrderID != null) {
                    request.setAttribute("Order", OrderID);
                    request.getRequestDispatcher("/OrderDetails.jsp").forward(request, response);
                }
            } else {
                if (path.startsWith("/Order/Delete/")) {
                    String[] s = path.split("/");
                    String OrderID = s[s.length - 1];
                    OrderDAO dao = new OrderDAO();
                    OrderDetailsDAO daos = new OrderDetailsDAO();
                    Order ord = dao.getOrder(OrderID);
                    if (ord.getOrderStatusID().equalsIgnoreCase("DHD") || ord.getOrderStatusID().equalsIgnoreCase("DHH")) {
                        int count = daos.deleteOrderDetails(OrderID);
                        int count2 = dao.deleteOrder(OrderID);
                        if (count > 0 && count2 > 0) {
                            request.setAttribute("mess", "YesD");
                            request.getRequestDispatcher("/OrderManagement.jsp").forward(request, response);

                        } else {
                            request.setAttribute("mess", "NoD");
                            request.getRequestDispatcher("/OrderManagement.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("mess", "Noo");
                        request.getRequestDispatcher("/OrderManagement.jsp").forward(request, response);
                    }
                } else {
                    if (path.startsWith("/Order/Change/")) {
                        String[] s = path.split("/");
                        String OrderID = s[3];
                        String OrderStatusID = s[4];
                        OrderDAO dao = new OrderDAO();
                        Order ord = dao.getOrder(OrderID);
                        if (!OrderStatusID.equals(ord.getOrderStatusID())) {
                            int count = dao.setStatusOrder(OrderID, OrderStatusID);
                            if (count > 0) {
                                request.setAttribute("mess", "YesC");
                                request.getRequestDispatcher("/OrderManagement.jsp").forward(request, response);
                            } else {
                                request.setAttribute("mess", "NoC");
                                request.getRequestDispatcher("/OrderManagement.jsp").forward(request, response);
                            }
                        } else {
                            request.getRequestDispatcher("/OrderManagement.jsp").forward(request, response);
                        }
                    } else {
                        //Quang QuiS
                        if (path.startsWith("/Order/Cancel/Delete/")) {
                            String[] s = path.split("/");
                            String OrderID = s[s.length - 1];
                            OrderDAO dao = new OrderDAO();
                            Order ord = dao.getOrder(OrderID);
                            if (ord.getOrderStatusID().equalsIgnoreCase("DXN")) {
                                String cancel = "DHD";
                                int count = dao.setStatusOrder(OrderID, cancel);
                                if (count > 0) {
                                    request.setAttribute("mess", "YesD");
                                    request.getRequestDispatcher("/myOrder.jsp").forward(request, response);

                                } else {
                                    request.setAttribute("mess", "NoD");
                                    request.getRequestDispatcher("/myOrder.jsp").forward(request, response);
                                }
                            } else if (ord.getOrderStatusID().equalsIgnoreCase("DHD")) {
                                request.setAttribute("mess", "NoC");
                                request.getRequestDispatcher("/myOrder.jsp").forward(request, response);
                            } else {
                                request.setAttribute("mess", "Noo");
                                request.getRequestDispatcher("/myOrder.jsp").forward(request, response);
                            }
                        } else {
                            if (path.startsWith("/Order/Reorder/Change/")) {
                                String[] s = path.split("/");
                                String OrderID = s[s.length - 1];
                                OrderDAO dao = new OrderDAO();
                                Order ord = dao.getOrder(OrderID);
                                if (ord.getOrderStatusID().equalsIgnoreCase("DHD")) {
                                    String cancel = "DXN";
                                    int count = dao.setStatusOrder(OrderID, cancel);
                                    if (count > 0) {
                                        request.setAttribute("mess", "YesR");
                                        request.getRequestDispatcher("/myOrder.jsp").forward(request, response);

                                    } else {
                                        request.setAttribute("mess", "NoR");
                                        request.getRequestDispatcher("/myOrder.jsp").forward(request, response);
                                    }
                                } else {
                                    request.setAttribute("mess", "NooR");
                                    request.getRequestDispatcher("/myOrder.jsp").forward(request, response);
                                }
                            }
                        }
                    }
                }
            }
        }
        if (path.endsWith("/Statistics")) {
            request.getRequestDispatcher("/statistics.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getRequestURI();
        if (path.endsWith("/Order/new")) {
            //init DAOS
            OrderDAO orderDao = new OrderDAO();
            OrderDetailsDAO orderDetailsDao = new OrderDetailsDAO();
            ProductDAO productDao = new ProductDAO();

            //get information account form post mothod
            String orderID = request.getParameter("txtOrderID");
            String username = request.getParameter("txtUsername");
            String email = request.getParameter("txtEmail");
            String name = request.getParameter("txtFullname");
            String phone = request.getParameter("txtPhone");

            //Get all input Address
            String province = request.getParameter("ls_province");
            String district = request.getParameter("ls_district");
            String ward = request.getParameter("ls_ward");
            String detailAddress = request.getParameter("txtDetailAddress");

            //Join Address
            String deliveryAddress = phone + ", " + detailAddress + ", " + ward + ", " + district + ", " + province;

            //Get Bill of Order
            String totalbill = request.getParameter("txtTotalBill");

            //Get payment method
            String paymentMethod = request.getParameter("paymentMethod");

            //Get list of product of order
            String Cart = request.getParameter("blind");

            //Set date of order
            java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
            Date orderTime = date;

            // Create Order in OrderList first
            Order ord;
            if (paymentMethod.equals("VietQR")) {
                ord = new Order(orderID, username, "DCK", deliveryAddress, orderTime, totalbill);
            } else {
                ord = new Order(orderID, username, "DXN", deliveryAddress, orderTime, totalbill);
            }

            //Add order in db table OrderList
            int check = orderDao.addOrder(ord);
            NumberFormat format = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
            //if add them orderList successfully
            if (check > 0) {
                //when order success create split the cart info into list
                String[] listProduct = Cart.split("/");
                int check1 = 0;
                //use loop to add them in OrderDetails
                for (String productOrder : listProduct) {
                    String ProductID = productOrder.substring(0, productOrder.indexOf(' ')); //get product id
                    int quantity = Integer.valueOf(productOrder.substring(productOrder.indexOf("<<") + 2, productOrder.indexOf(">>"))); //get quantity
                    int unitPrice = productDao.getUnitPrice(ProductID);
                    //Add them in db table OrderDetails
                    OrderDetails orderDetails = new OrderDetails(orderID, ProductID, Integer.toString(quantity), Integer.toString(unitPrice * quantity));
                    check1 = orderDetailsDao.addOrderDetails(orderDetails);
                    //If add unsuccessfull then exit loop
                    if (check1 <= 0) {
                        break;
                    }
                }
                if (check1 <= 0) {
                    orderDetailsDao.deleteOrderDetails(orderID);
                    orderDao.deleteOrder(orderID);
                    request.setAttribute("link", "http://localhost:8080/");
                    request.setAttribute("mess", "No");
                    request.getRequestDispatcher("/orderSuccessfull.jsp").forward(request, response);
                } else {
                    //Processing send email order to customer
                    //Processing CART
                    StringBuilder output = new StringBuilder();
                    for (String productOrder : listProduct) {
                        String ProductID = productOrder.substring(0, productOrder.indexOf(' ')).replaceAll("[^a-zA-Z0-9]", ""); // get product id and remove special characters
                        OrderDetailsDAO daoorder = new OrderDetailsDAO();
                        String ProductName = daoorder.getProductName(ProductID);
                        int quantity = 0;
                        String quantityString = productOrder.substring(productOrder.indexOf("<<") + 2, productOrder.indexOf(">>")).replaceAll("[^0-9]", ""); // get quantity and remove non-numeric characters
                        try {
                            quantity = Integer.valueOf(quantityString);
                        } catch (NumberFormatException e) {
                            // handle the exception here
                        }
                        int unitPrice = productDao.getUnitPrice(ProductID);
                        int totalPrice = quantity * unitPrice;

                        String formattedPrice = format.format(totalPrice).replaceAll("\\s", "");
                        output.append(" Tên: ").append(ProductName).append("\t Số Lượng: ").append(quantity).append("\t Tổng: ").append(formattedPrice).append(System.lineSeparator());
                    }
                    String result = output.toString().trim();
                    //Processing send email
                    final String usernameEmail = "fivestorecantho@gmail.com";
                    final String passwordEmail = "kpsmhoxyybmkwkio";
                    String from = "fivestorecantho@gmail.com";

                    String host = "smtp.gmail.com";
                    Properties props = new Properties();
                    props.put("mail.smtp.auth", "true");
                    props.put("mail.smtp.starttls.enable", "true");
                    props.put("mail.smtp.host", host);
                    props.put("mail.smtp.user", usernameEmail);
                    props.put("mail.smtp.pass", "kpsmhoxyybmkwkio");
                    props.put("mail.smtp.port", "587");
                    props.put("mail.smtp.charset", "utf-8");
                    //create the Session object
                    Session session = Session.getInstance(props,
                            new jakarta.mail.Authenticator() {
                        @Override
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(usernameEmail, passwordEmail);
                        }
                    });
                    phone = phone.replaceAll("[^0-9]", ""); // xóa bỏ ký tự không phải là số
                    phone = "+84" + phone.substring(1); // chuyển đổi thành định dạng +84945605514

                    String emailContent = "";
                    boolean isSent = false;
                    try {
                        // Tạo nội dung email
                        String formattedPrice = format.format(Integer.parseInt(totalbill)).replaceAll("\\s", "");
                        emailContent = "Thông tin đơn hàng:\n\n"
                                + "Mã đơn hàng: " + orderID + "\n\n"
                                + "Ngày mua: " + orderTime.toString() + "\n\n"
                                + "Khách hàng: " + name + "\n\n"
                                + "Số điện thoại: " + phone + "\n\n"
                                + "Địa chỉ giao hàng: " + deliveryAddress + "\n\n"
                                + "Tổng giá trị đơn hàng: " + formattedPrice + "\n\n"
                                + "Phương thức thanh toán: " + paymentMethod + "\n\n"
                                + "Danh sách sản phẩm:\n" + result;
                        // Tạo đối tượng Message
                        Message message = new MimeMessage(session);
                        message.setFrom(new InternetAddress(from));
                        message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
                        message.setSubject("Information Order " + orderID + " " + orderTime);

                        // Thêm nội dung email vào phần thân của Message
                        message.setContent(emailContent, "text/plain; charset=UTF-8");
                        Transport.send(message);
                        isSent = true;
                    } catch (MessagingException e) {
                        e.printStackTrace();
                    }
                    if (isSent) {
                        OTPSender otpSender = new OTPSender("AC47851346febff700998989a923642839", "f86d0d8fa25cd420f6f47fc50b304f89", "+15077055733");
                        otpSender.sendOTP(phone, emailContent);
                        request.setAttribute("link", "http://localhost:8080/");
                        request.setAttribute("mess", "Yes");
                        request.getRequestDispatcher("/orderSuccessfull.jsp").forward(request, response);
                    } else {
                        orderDetailsDao.deleteOrderDetails(orderID);
                        orderDao.deleteOrder(orderID);
                        request.setAttribute("link", "http://localhost:8080/");
                        request.setAttribute("mess", "Noo");
                        request.getRequestDispatcher("/orderSuccessfull.jsp").forward(request, response);
                    }
                }

            } else {
                request.setAttribute("link", "http://localhost:8080/");
                request.setAttribute("mess", "Noo");
                request.getRequestDispatcher("/orderSuccessfull.jsp").forward(request, response);
            }
        }

        if (request.getParameter("statistics-by-day") != null) {
            if (request.getParameter("choose-day") != null && request.getParameter("choose-day").length() != 0) {
                OrderDAO dao = new OrderDAO();
                ResultSet rs = dao.getOrderByDay(request.getParameter("choose-day"));
                request.setAttribute("statistics-by-day-attribute", rs);
                request.getRequestDispatcher("/statistics.jsp").forward(request, response);
                request.setAttribute("statistics-by-month-attribute", null);
            } else {
                request.setAttribute("statistics-by-day-attribute", null);
                request.setAttribute("statistics-by-month-attribute", null);
                response.sendRedirect(request.getContextPath() + "/statistics");
            }
        }

        if (request.getParameter("statistics-by-month") != null) {
            if (request.getParameter("choose-month") != null && request.getParameter("choose-month").length() != 0) {
                OrderDAO dao = new OrderDAO();
                String[] date = request.getParameter("choose-month").split("-");
                String month = date[1];
                String year = date[0];
                ResultSet rs = dao.getOrderByMonth(month, year);
                request.setAttribute("statistics-by-month-attribute", rs);
                request.getRequestDispatcher("/statistics.jsp").forward(request, response);
                request.setAttribute("statistics-by-day-attribute", null);
            } else {
                request.setAttribute("statistics-by-month-attribute", null);
                request.setAttribute("statistics-by-day-attribute", null);
                response.sendRedirect(request.getContextPath() + "/statistics");
            }
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
