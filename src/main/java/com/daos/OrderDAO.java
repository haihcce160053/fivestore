/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.daos;

import com.db.DBConnection;
import com.models.Order;
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
public class OrderDAO {

    private Connection conn = null;

    public OrderDAO() {
        conn = DBConnection.getConnection();
    }

    public Order getOrder(String OrderID) {
        try {
            String query = "select * from OrderList where OrderID=?";
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, OrderID);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                String od_OrderID = rs.getString("OrderID");
                String od_Username = rs.getString("Username");
                String od_DeliveryAddress = rs.getString("DeliveryAddress");
                String od_OrderTime = rs.getString("OrderTime");
                String od_OrderStatusID = rs.getString("OrderStatusID");
                String od_TotalBill = rs.getString("TotalBill");
                Order ord = new Order(od_OrderID, od_Username, od_DeliveryAddress, od_OrderTime, od_OrderStatusID, od_TotalBill);
                return ord;
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from OrderList ");
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

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

}
