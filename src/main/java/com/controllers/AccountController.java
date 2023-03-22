package com.controllers;

import com.daos.AccountDAO;
import com.daos.OrderDAO;
import com.daos.OrderDetailsDAO;
import com.models.Account;
import com.security.Encoding;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author QuangQui
 */
public class AccountController extends HttpServlet {

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
            out.println("<title>Servlet AccountController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AccountController at " + request.getContextPath() + "</h1>");
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
        if (path.endsWith("/Account/")) {
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        } else {
            if (path.startsWith("/Account/information/")) {
                // split path to get username
                String[] s = path.split("/");
                String username = s[s.length - 1];
                if (username != null) {
                    request.setAttribute("username", username);
                    request.getRequestDispatcher("/accountInf.jsp").forward(request, response);
                } else {
                    request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
                }
            } else {
                if (path.startsWith("/Account/Delete/")) {
                    HttpSession session = request.getSession();
                    Account acc = (Account) session.getAttribute("informationAccount");
                    if ((acc != null) && (acc.getAccountTypeId().equalsIgnoreCase("AD"))) {
                        String[] s = path.split("/");
                        String username = s[s.length - 1];
                        AccountDAO dao = new AccountDAO();
                        Account ac = dao.getAccount(username);
                        if ((username.equalsIgnoreCase("Admin")) || (ac.getAccountTypeId().equalsIgnoreCase("AD"))) {
                            request.setAttribute("mess", "Noo");
                            request.getRequestDispatcher("/accountManagement.jsp").forward(request, response);
                        } else {
                            try {
                                OrderDAO daoorder = new OrderDAO();
                                OrderDetailsDAO daodetails = new OrderDetailsDAO();
                                int deleteDetails = 0;
                                ResultSet rs = daoorder.getOrderByUsername(username);
                                while (rs.next()) {
                                    deleteDetails = daodetails.deleteOrderDetails(rs.getString("OrderID"));
                                    if (deleteDetails <= 0) {
                                        break;
                                    }
                                }
                                int deleteList = daoorder.deleteOrderByUsername(username);
                                if (deleteList > 0) {
                                    int count = dao.deleteAccountInformation(username);
                                    int count2 = dao.deleteAccount(username);
                                    if (count > 0 && count2 > 0) {
                                        request.setAttribute("mess", "YesD");
                                        request.getRequestDispatcher("/accountManagement.jsp").forward(request, response);

                                    } else {
                                        request.setAttribute("mess", "NoD");
                                        request.getRequestDispatcher("/accountManagement.jsp").forward(request, response);
                                    }
                                } else {
                                    int count = dao.deleteAccountInformation(username);
                                    int count2 = dao.deleteAccount(username);
                                    if (count > 0 && count2 > 0) {
                                        request.setAttribute("mess", "YesD");
                                        request.getRequestDispatcher("/accountManagement.jsp").forward(request, response);

                                    } else {
                                        request.setAttribute("mess", "NoD");
                                        request.getRequestDispatcher("/accountManagement.jsp").forward(request, response);
                                    }
                                }

                            } catch (SQLException ex) {
                                Logger.getLogger(AccountController.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                    } else {
                        request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
                    }
                } else {
                    if (path.startsWith("/Account/Change/")) {
                        HttpSession session = request.getSession();
                        Account acc = (Account) session.getAttribute("informationAccount");
                        if ((acc != null) && (acc.getAccountTypeId().equalsIgnoreCase("AD"))) {
                            String[] s = path.split("/");
                            String username = s[s.length - 1];
                            AccountDAO dao = new AccountDAO();
                            Account ac = dao.getAccount(username);
                            if (ac.getUsername().equals("Admin")) {
                                request.setAttribute("mess", "Nooo");
                                request.getRequestDispatcher("/accountManagement.jsp").forward(request, response);
                            } else if (ac.getAccountTypeId().equals("CUS")) {

                                int count = dao.setTypeAdminAccount(ac);
                                if (count > 0) {
                                    request.setAttribute("mess", "YesA");
                                    request.getRequestDispatcher("/accountManagement.jsp").forward(request, response);
                                } else {
                                    request.setAttribute("mess", "NoA");
                                    request.getRequestDispatcher("/accountManagement.jsp").forward(request, response);
                                }
                            } else if (ac.getAccountTypeId().equals("AD")) {
                                int count = dao.setTypeCustomerAccount(ac);
                                if (count > 0) {
                                    request.setAttribute("mess", "YesC");
                                    request.getRequestDispatcher("/accountManagement.jsp").forward(request, response);
                                } else {
                                    request.setAttribute("mess", "NoC");
                                    request.getRequestDispatcher("/accountManagement.jsp").forward(request, response);
                                }
                            }
                        } else {
                            request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
                        }
                    } else {
                        if (path.startsWith("/Account/Management/")) {
                            HttpSession session = request.getSession();
                            Account acc = (Account) session.getAttribute("informationAccount");
                            if ((acc != null) && (acc.getAccountTypeId().equalsIgnoreCase("AD"))) {
                                request.getRequestDispatcher("/accountManagement.jsp").forward(request, response);
                            } else {
                                request.getRequestDispatcher("/errorPage.jsp").forward(request, response);
                            }
                        } else {
                            if (path.startsWith("/Account/Order/")) {
                                String[] s = path.split("/");
                                String username = s[s.length - 1];
                                AccountDAO dao = new AccountDAO();
                                Account ac = dao.getAccount(username);
                                HttpSession session = (HttpSession) request.getSession();
                                session.setAttribute("informationAccount", ac);
                                request.getRequestDispatcher("/myOrder.jsp").forward(request, response);
                            }
                        }
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
        if (request.getParameter("btnUpdate") != null) {
            String username = request.getParameter("username");
            String fullname = request.getParameter("fullname");
            String SecurityAnswer = request.getParameter("SecurityAnswer");
            String phonenumber = request.getParameter("phone");
            String gender = request.getParameter("gender");
            String email = request.getParameter("Email");
            AccountDAO dao = new AccountDAO();
            Account old = dao.getAccount(username);

            Account ac = new Account(old.getUsername(), old.getPassword(), SecurityAnswer, fullname, phonenumber, gender, email, old.getAccountTypeId());
            int count = dao.updateAccountInformation(ac);
            int count2 = dao.updateAccount(ac);
            if (count > 0 && count2 > 0) {
                request.setAttribute("username", username);
                request.setAttribute("mess1", "Yes");
                request.getRequestDispatcher("/accountInf.jsp").forward(request, response);

            } else {
                request.setAttribute("mess1", "No");
                request.setAttribute("username", username);
                request.getRequestDispatcher("/accountInf.jsp").forward(request, response);
            }
        } else {
            if (request.getParameter("btnChangePassword") != null) {
                Encoding endcode = new Encoding();
                String username = request.getParameter("username");
                String oldpassword = endcode.getMd5(request.getParameter("oldpassword"));
                String newpassword = endcode.getMd5(request.getParameter("confirmpassword"));

                AccountDAO dao = new AccountDAO();
                Account old = dao.getAccount(username);
                if (!old.getPassword().equals(oldpassword)) {
                    request.setAttribute("mess", "Noo");
                    request.setAttribute("username", username);
                    request.getRequestDispatcher("/accountInf.jsp").forward(request, response);
                } else {
                    Account ac = new Account(username, newpassword, old.getSecurityAnswer(), old.getFullname(), old.getPhoneNumber(), old.getGender(), old.getEmail(), old.getAccountTypeId());
                    int count = dao.updateAccount(ac);
                    if (count > 0) {
                        request.setAttribute("username", username);
                        request.setAttribute("mess", "Yes");
                        request.getRequestDispatcher("/accountInf.jsp").forward(request, response);

                    } else {
                        request.setAttribute("mess", "No");
                        request.setAttribute("username", username);
                        request.getRequestDispatcher("/accountInf.jsp").forward(request, response);
                    }
                }
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
