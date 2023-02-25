/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

/**
 *
 * @author LEO
 */
public class OrderDetails {
    private String OrderID;
    private String ProductID;
    private String Quatity;
    private String TotalPrice;

    public OrderDetails() {
    }

    public OrderDetails(String OrderID, String ProductID, String Quatity, String TotalPrice) {
        this.OrderID = OrderID;
        this.ProductID = ProductID;
        this.Quatity = Quatity;
        this.TotalPrice = TotalPrice;
    }
    
}
