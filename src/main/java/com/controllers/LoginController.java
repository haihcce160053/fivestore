/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.controllers;

import com.daos.AccountDAO;
import com.models.Account;
import com.security.Encoding;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author QuangQui
 */
public class LoginController extends HttpServlet {

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
            out.println("<title>Servlet LoginController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginController at " + request.getContextPath() + "</h1>");
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
        if (path.endsWith("/login")) {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
        if (path.endsWith("/signup")) {
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
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
        if (request.getParameter("btnSignUp") != null) {
            HttpSession session = request.getSession();
            AccountDAO dao = new AccountDAO();
            String username = request.getParameter("username");
            Account ac = dao.getAccount(username);
            if (ac == null) {
                Encoding endcode = new Encoding();
                String password = endcode.getMd5(request.getParameter("password")); //Convert to MD5
                String securityanswer = request.getParameter("securityAnswer");
                String fullname = request.getParameter("fullname");
                String phonenumber = request.getParameter("phoneNumber");
                String gender = request.getParameter("gender");
                String email = request.getParameter("email");
                String accounttypeid = "CUS";
                Account st = new Account(username, password, securityanswer, fullname, phonenumber, gender, email, accounttypeid);
                int count = dao.addNew(st);
                int count2 = dao.addNewInformation(st);
                if (count > 0 && count2 > 0) {
                    request.setAttribute("mess", "Sign Up Successfully! You can sign in now!");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/login.jsp");
                    dispatcher.forward(request, response);
                } else {
                    request.setAttribute("mess", "Sign Up Failed! Please Sign Up again!");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/signup.jsp");
                    dispatcher.forward(request, response);
                }
            } else {
                request.setAttribute("mess", "Username already exists!");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/signup.jsp");
                dispatcher.forward(request, response);
            }
        } else if (request.getParameter("btnSignIn") != null) {
            HttpSession session = request.getSession();
            AccountDAO dao = new AccountDAO();
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            Account ac = dao.getAccount(username);
            if (ac != null) {
                Encoding endcode = new Encoding();
                if (endcode.getMd5(password).equals(ac.getPassword())) {
                    if (ac.getAccountTypeId().equals("AD")) {
                        session.setAttribute("informationAccount", ac);
                        response.sendRedirect(request.getContextPath() + "/homeAdmin");
                    } else {
                        session.setAttribute("informationAccount", ac);
                        response.sendRedirect(request.getContextPath() + "/home");
                    }
                } else {
                    request.setAttribute("mess", "Username or password is not correct!");
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("mess", "Username is not exist!");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } else if (request.getParameter("btnSignout") != null) {
            HttpSession session = request.getSession();
            session.setAttribute("informationAccount", null);
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("mess", "Not find button!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
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
