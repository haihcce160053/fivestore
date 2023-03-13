/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.daos;

import com.db.DBConnection;
import com.models.OrderDetails;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author LEO
 */
public class OrderDetailsDAO {

    private Connection conn = null;

    /**
     *
     */
    public OrderDetailsDAO() {
        conn = DBConnection.getConnection();
    }

    /**
     *
     * @return
     */
    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("Select * from [OrderDetails]");
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    /**
     *
     * @param order
     * @return
     */
    public int addOrderDetails(OrderDetails order) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("Insert into [OrderDetails] values(?,?,?,?)");
            pst.setString(1, order.getOrderID());
            pst.setString(2, order.getProductID());
            pst.setInt(3, Integer.valueOf(order.getQuatity()));
            pst.setInt(4, Integer.valueOf(order.getTotalPrice()));
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    /**
     *
     * @param OrderID
     * @return
     */
    public int deleteOrderDetails(String OrderID) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("delete from [OrderDetails] where OrderID=?");
            pst.setString(1, OrderID);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public ResultSet getOrderDetails(String OrderID) {
        ResultSet ac = null;
        try {
            PreparedStatement pst = conn.prepareStatement("select * from [OrderDetails] where OrderID=?");
            pst.setString(1, OrderID);
            ac = pst.executeQuery();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ac;
    }
    
    public String getProductName(String ProductID) {
        ResultSet rs = null;
        String ProductName = "";
        try {
            PreparedStatement pst = conn.prepareStatement("select ProductName from Product where ProductID = ?");
            pst.setString(1, ProductID);
            rs = pst.executeQuery();
            while(rs.next()){
                ProductName = rs.getString("ProductName");
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return ProductName;
    }
}
