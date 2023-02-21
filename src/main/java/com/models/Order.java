/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

import java.sql.Date;

/**
 *
 * @author LEO
 */
public class Order {
    private String OrderID;
    private String Username;
    private String DeliveryAddress; 
    private String OrderTime;
    private String OrderStatusID;
    private String TotalBil;
    
    public Order() {
    }

    public Order(String OrderID, String Username, String DeliveryAddress, String OrderTime, String OrderStatusID, String TotalBil) {
        this.OrderID = OrderID;
        this.Username = Username;
        this.DeliveryAddress = DeliveryAddress;
        this.OrderTime = OrderTime;
        this.OrderStatusID = OrderStatusID;
        this.TotalBil = TotalBil;
    }

    public String getOrderID() {
        return OrderID;
    }

    public void setOrderID(String OrderID) {
        this.OrderID = OrderID;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getDeliveryAddress() {
        return DeliveryAddress;
    }

    public void setDeliveryAddress(String DeliveryAddress) {
        this.DeliveryAddress = DeliveryAddress;
    }

    public String getOrderTime() {
        return OrderTime;
    }

    public void setOrderTime(String OrderTime) {
        this.OrderTime = OrderTime;
    }

    public String getOrderStatusID() {
        return OrderStatusID;
    }

    public void setOrderStatusID(String OrderStatusID) {
        this.OrderStatusID = OrderStatusID;
    }

    public String getTotalBil() {
        return TotalBil;
    }

    public void setTotalBil(String TotalBil) {
        this.TotalBil = TotalBil;
    }

    
}