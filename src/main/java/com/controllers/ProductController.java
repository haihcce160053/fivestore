/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controllers;

import com.daos.ProductDAO;
import com.models.Product;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Hoang Liem
 */
public class ProductController extends HttpServlet {

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
            out.println("<title>Servlet ProductController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductController at " + request.getContextPath() + "</h1>");
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
        if (path.startsWith("/Product/Add/")) {
            String[] s = path.split("/");
            String username = s[s.length - 1];
            HttpSession session = (HttpSession) request.getSession();
            session.setAttribute("username", username);
            request.getRequestDispatcher("/addProduct.jsp").forward(request, response);
        } else {
            if (path.startsWith("/Product/Delete/")) {
                String[] s = path.split("/");
                String product = s[s.length - 1];
                ProductDAO dao = new ProductDAO();
                Product pd = dao.getProduct(product);
                if (pd != null) {
                    int count = dao.deleteProductInformation(product);
                    int count1 = dao.deleteProduct(product);
                    if (count > 0 && count1 > 0) {
                        request.setAttribute("mess", "YesD");
                        request.getRequestDispatcher("/productManagement.jsp").forward(request, response);
                    } else {
                        request.setAttribute("mess", "NoD");
                        request.getRequestDispatcher("/productManagement.jsp").forward(request, response);
                    }

                } else {
                    request.setAttribute("mess", "Noo");
                    request.getRequestDispatcher("/productManagement.jsp").forward(request, response);
                }

            } else {
                if (path.startsWith("/Product/Edit/")) {
                    String[] s = path.split("/");
                    String product = s[s.length - 1];
                    ProductDAO dao = new ProductDAO();
                    Product pd = dao.getProduct(product);
                    request.setAttribute("product", pd);
                    request.getRequestDispatcher("/editProduct.jsp").forward(request, response);
                } else {
                    if (path.startsWith("/Product/Management/")) {
                        String[] s = path.split("/");
                        String username = s[s.length - 1];
                        HttpSession session = (HttpSession) request.getSession();
                        session.setAttribute("username", username);
                        request.getRequestDispatcher("/productManagement.jsp").forward(request, response);
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
        if (request.getParameter("btnInsert") != null) {
            String username = request.getParameter("username");
            ProductDAO dao = new ProductDAO();
            String ProductID = request.getParameter("productID");
            Product pd = dao.getProduct(ProductID);
            if (pd != null) {
                request.setAttribute("mess", "Noo");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/addProduct.jsp");
                dispatcher.forward(request, response);
            } else {
                String ProductTypeID = request.getParameter("type");
                String ProductName = request.getParameter("productName");
                String PictureLink = request.getParameter("pictureLink");
                String Description = request.getParameter("description");
                String Quantity = request.getParameter("quantity");
                String Price = request.getParameter("price");
                String EXP = request.getParameter("exp");
                String Origin = request.getParameter("origin");
                String SoldAmount = request.getParameter("soldAmount");
                pd = new Product(ProductID, ProductTypeID, ProductName, PictureLink, Description, Integer.parseInt(Quantity), Integer.parseInt(Price), EXP, Origin, SoldAmount);
                int count = dao.addProduct(pd);
                int count1 = dao.addProductInformation(pd);
                if (count > 0 && count1 > 0) {
                    request.setAttribute("username", username);
                    request.setAttribute("mess", "YesA");
                    request.getRequestDispatcher("/productManagement.jsp").forward(request, response);
                } else {
                    request.setAttribute("username", username);
                    request.setAttribute("mess", "NoA");
                    request.getRequestDispatcher("/addProduct.jsp").forward(request, response);
                }
            }

        } else if (request.getParameter("btnUpdate") != null) {
            ProductDAO dao = new ProductDAO();
            String ProductID = request.getParameter("productID");
            String ProductTypeID = request.getParameter("type");
            String ProductName = request.getParameter("productName");
            String PictureLink = request.getParameter("pictureLink");
            String Description = request.getParameter("description");
            String Quantity = request.getParameter("quantity");
            String Price = request.getParameter("price");
            String EXP = request.getParameter("exp");
            String Origin = request.getParameter("origin");
            String SoldAmount = request.getParameter("soldAmount");
            Product pd = new Product(ProductID, ProductTypeID, ProductName, PictureLink, Description, Integer.parseInt(Quantity), Integer.parseInt(Price), EXP, Origin, SoldAmount);
            
            int count = dao.updateProductInformation(pd);
            int count1 = dao.updateProduct(pd);
            if (count > 0 && count1 > 0) {
                request.setAttribute("mess", "YesU");
                request.getRequestDispatcher("/productManagement.jsp").forward(request, response);
            } else {
                request.setAttribute("product", pd);
                request.setAttribute("mess", "NoU");
                request.getRequestDispatcher("/addProduct.jsp").forward(request, response);
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
