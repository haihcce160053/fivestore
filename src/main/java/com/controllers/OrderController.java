/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controllers;

import com.daos.OrderDAO;

import com.models.Account;
import com.daos.OrderDetailsDAO;
import com.models.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.http.HttpSession;

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
            ResultSet rs = dao.getOrderByUsername(username);
            try {
                String OrderID = "";
                if (rs.next()) {
                    while (rs.next()) {
                        OrderID = rs.getString("OrderID");
                    }
                    int NewID = Integer.parseInt(OrderID.substring(3));
                    System.out.println(prefixUser + String.format("%06d", NewID + 1));
                    String NewOrderID = prefixUser + String.format("%06d", NewID + 1);
                    request.setAttribute("OrderID", NewOrderID);
                    request.getRequestDispatcher("/newOrder.jsp").forward(request, response);
                } else {
                    request.setAttribute("OrderID", prefixUser + "000001");
                    request.getRequestDispatcher("/newOrder.jsp").forward(request, response);
                }

            } catch (SQLException ex) {
                Logger.getLogger(OrderController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        //phat quy
        if (path.endsWith("/Order/")) {
            request.getRequestDispatcher("/OrderManagement.jsp").forward(request, response);
        } else {
            if (path.startsWith("/Order/OrderDetails/")) {
                // split path to get username
                String[] s = path.split("/");
                String OrderID = s[s.length - 1];
                OrderDAO dao = new OrderDAO();
                Order ord = dao.getOrder(OrderID);
                if (ord != null) {
                    HttpSession session = (HttpSession) request.getSession();
                    session.setAttribute("Order", ord);
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
                }
            }
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

//        String orderID = null;
//        String username = null;
//        String orderStatusID = null;
//        String deliveryAddress = null;
//        Date orderTime = null;
//        int totalbill;
//        if (path.endsWith("/order")) {
//            if (request.getAttribute("submit") != null) {
//                orderID = request.getAttribute("OrderID").toString();
//                username = request.getAttribute("username").toString();
//                String province = request.getAttribute("city").toString();
//                String district = request.getAttribute("district").toString();
//                String ward = request.getAttribute("ward");
//                
//            }
//        }
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
