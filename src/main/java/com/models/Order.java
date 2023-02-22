/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

import java.sql.Date;

/**
 *
 * @author QuangQui
 */
public class Order {
    private String OrderID;
    private String OrderStatusID;
    private String Username;
    private String DeliveyAddress;
    private Date OderTime;
    private int TotalBill;

    public Order(String OrderID, String OrderStatusID, String Username, String DeliveyAddress, Date OderTime, int TotalBill) {
        this.OrderID = OrderID;
        this.OrderStatusID = OrderStatusID;
        this.Username = Username;
        this.DeliveyAddress = DeliveyAddress;
        this.OderTime = OderTime;
        this.TotalBill = TotalBill;
    }

    public Order() {
    }

    public String getOrderID() {
        return OrderID;
    }

    public void setOrderID(String OrderID) {
        this.OrderID = OrderID;
    }

    public String getOrderStatusID() {
        return OrderStatusID;
    }

    public void setOrderStatusID(String OrderStatusID) {
        this.OrderStatusID = OrderStatusID;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getDeliveyAddress() {
        return DeliveyAddress;
    }

    public void setDeliveyAddress(String DeliveyAddress) {
        this.DeliveyAddress = DeliveyAddress;
    }

    public Date getOderTime() {
        return OderTime;
    }

    public void setOderTime(Date OderTime) {
        this.OderTime = OderTime;
    }

    public int getTotalBill() {
        return TotalBill;
    }

    public void setTotalBill(int TotalBill) {
        this.TotalBill = TotalBill;
    }

     
    
}
