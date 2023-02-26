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

    /**
     *
     */
    public OrderDetails() {
    }

    /**
     *
     * @param OrderID
     * @param ProductID
     * @param Quatity
     * @param TotalPrice
     */
    public OrderDetails(String OrderID, String ProductID, String Quatity, String TotalPrice) {
        this.OrderID = OrderID;
        this.ProductID = ProductID;
        this.Quatity = Quatity;
        this.TotalPrice = TotalPrice;
    }

    /**
     *
     * @return
     */
    public String getOrderID() {
        return OrderID;
    }

    /**
     *
     * @param OrderID
     */
    public void setOrderID(String OrderID) {
        this.OrderID = OrderID;
    }

    /**
     *
     * @return
     */
    public String getProductID() {
        return ProductID;
    }

    /**
     *
     * @param ProductID
     */
    public void setProductID(String ProductID) {
        this.ProductID = ProductID;
    }

    /**
     *
     * @return
     */
    public String getQuatity() {
        return Quatity;
    }

    /**
     *
     * @param Quatity
     */
    public void setQuatity(String Quatity) {
        this.Quatity = Quatity;
    }

    /**
     *
     * @return
     */
    public String getTotalPrice() {
        return TotalPrice;
    }

    /**
     *
     * @param TotalPrice
     */
    public void setTotalPrice(String TotalPrice) {
        this.TotalPrice = TotalPrice;
    }
    
    
}
