/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.daos;

import com.db.DBConnection;
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

    public OrderDetailsDAO() {
        conn = DBConnection.getConnection();
    }
    
     public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("Select * from OrderDetails");
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
     
    public int deleteOrderDetails(String OrderID) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("delete from OrderDetails where OrderID=?");
            pst.setString(1, OrderID);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDetailsDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }
}
