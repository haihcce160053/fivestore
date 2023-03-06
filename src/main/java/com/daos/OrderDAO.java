package com.daos;

import com.db.DBConnection;
import com.models.Order;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 *
 *
 * @author Trung Kien Phat Quy Quang Qui
 */
public class OrderDAO {

    private Connection conn = null;

    /**
     *
     */
    public OrderDAO() {
        conn = DBConnection.getConnection();
    }

    /**
     * Phuong thuc nay dung de lay tat ca thong tin cua cac KH trong csdl
     *
     * @return mot ResultSet chua danh sach khach hang
     */
    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("Select * from OrderList");
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    /**
     *
     *
     * @param OrderID
     * @return
     */
    public Order getOrder(String OrderID) {
        Order ac = null;
        try {
            PreparedStatement pst = conn.prepareStatement("select * from OrderList where OrderID=?");
            pst.setString(1, OrderID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                ac = new Order(rs.getString("OrderID"),
                        rs.getString("Username"),
                        rs.getString("OrderStatusID"),
                        rs.getString("DeliveryAddress"),
                        Date.valueOf(rs.getDate("OrderTime").toString()),
                        rs.getString("TotalBill"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ac;
    }

    /**
     *
     * @param username
     * @return
     */
    public ResultSet getOrderByUsername(String username) {
        ResultSet rs = null;
        try {
            PreparedStatement pst = conn.prepareStatement("select * from [OrderList] where Username=? ORDER BY OrderID ASC");
            pst.setString(1, username);
            rs = pst.executeQuery();
            System.out.println(rs);
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getOrderByDay(String day) {
        ResultSet rs = null;
        try {
            PreparedStatement pst = conn.prepareStatement("SELECT OrderDetails.ProductID, OrderList.OrderTime, SUM(OrderDetails.Quantity) AS TotalQuantity, SUM(OrderDetails.TotalPrice) AS TotalPrice\n"
                    + "FROM OrderList \n"
                    + "LEFT OUTER JOIN OrderDetails ON OrderList.OrderID = OrderDetails.OrderID \n"
                    + "WHERE OrderList.OrderTime = ?\n"
                    + "GROUP BY OrderDetails.ProductID, OrderList.OrderTime;");
            pst.setString(1, day);
            rs = pst.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    public ResultSet getOrderByMonth(String month, String year) {
        ResultSet rs = null;
        try {
            PreparedStatement pst = conn.prepareStatement("SELECT OrderDetails.ProductID, OrderList.OrderTime, SUM(OrderDetails.Quantity) AS TotalQuantity, SUM(OrderDetails.TotalPrice) AS TotalPrice\n"
                    + "FROM OrderList \n"
                    + "LEFT OUTER JOIN OrderDetails ON OrderList.OrderID = OrderDetails.OrderID \n"
                    + "WHERE MONTH(OrderList.OrderTime) = ? AND YEAR(OrderList.OrderTime) = ?\n"
                    + "GROUP BY OrderDetails.ProductID, OrderList.OrderTime;");
            pst.setString(1, month);
            pst.setString(2, year);
            rs = pst.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    /**
     *
     * @param or
     * @return
     */
    public int addOrder(Order or) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("Insert into [OrderList] values(?,?,?,?,?,?)");
            pst.setString(1, or.getOrderID());
            pst.setString(3, or.getUsername());
            pst.setString(2, or.getOrderStatusID());

            pst.setString(4, or.getDeliveryAddress());
            pst.setDate(5, or.getOrderTime());
            pst.setString(6, or.getTotalBil());

            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    /**
     *
     * @param OrderID
     * @return
     */
    public int deleteOrder(String OrderID) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("delete from OrderList where OrderID=?");
            pst.setString(1, OrderID);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    /**
     *
     * @param Username
     * @return
     */
    public int deleteOrderByUsername(String Username) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("delete from OrderList where Username=?");
            pst.setString(1, Username);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    // Written by Quang Qui
    /**
     *
     * @param Username
     * @return
     */
    public int getNumberOrderByUsername(String Username) {
        int count = 0;
        ResultSet rs = null;
        try {
            PreparedStatement pst = conn.prepareStatement("select * from [OrderList] where Username=?");
            pst.setString(1, Username);
            rs = pst.executeQuery();
            while (rs.next()) {
                count++;
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    // Written by Quang Qui
    /**
     *
     * @param OrderStatusID
     * @return
     */
    public String getNameOfStatusOrder(String OrderStatusID) {
        ResultSet rs = null;
        String name = "";
        try {
            PreparedStatement pst = conn.prepareStatement("select OrderStatusName from OrderStatus Where OrderStatusID=?");
            pst.setString(1, OrderStatusID);
            rs = pst.executeQuery();
            while (rs.next()) {
                name = rs.getString("OrderStatusName");
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return name;
    }

    /**
     *
     * @param OrderID
     * @return
     */
    public int setStatusOrder(String OrderID, String OrderStatusID) {
        ResultSet rs = null;
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("update OrderList set OrderStatusID=? where OrderID=?");
            pst.setString(1, OrderStatusID);
            pst.setString(2, OrderID);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }
}
