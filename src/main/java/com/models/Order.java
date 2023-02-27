package com.models;
import java.sql.Date;

/**
 *
 * @author Phat Qui Trung Kien
 */
public class Order {

    private String OrderID;
    private String Username;
    private String DeliveryAddress;
    private Date OrderTime;
    private String OrderStatusID;
    private String TotalBil;

    /**
     *
     */
    public Order() {
    }

    /**
     *
     * @param OrderID
     * @param Username
     * @param OrderStatusID
     * @param DeliveryAddress
     * @param OrderTime
     * @param TotalBil
     */
    public Order(String OrderID, String Username, String OrderStatusID ,String DeliveryAddress, Date OrderTime, String TotalBil) {
        this.OrderID = OrderID;
        this.Username = Username;
        this.DeliveryAddress = DeliveryAddress;
        this.OrderTime = OrderTime;
        this.OrderStatusID = OrderStatusID;
        this.TotalBil = TotalBil;
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
    public String getUsername() {
        return Username;
    }

    /**
     *
     * @param Username
     */
    public void setUsername(String Username) {
        this.Username = Username;
    }

    /**
     *
     * @return
     */
    public String getDeliveryAddress() {
        return DeliveryAddress;
    }

    /**
     *
     * @param DeliveryAddress
     */
    public void setDeliveryAddress(String DeliveryAddress) {
        this.DeliveryAddress = DeliveryAddress;
    }

    /**
     *
     * @return
     */
    public Date getOrderTime() {
        return OrderTime;
    }

    /**
     *
     * @param OrderTime
     */
    public void setOrderTime(Date OrderTime) {
        this.OrderTime = OrderTime;
    }

    /**
     *
     * @return
     */
    public String getOrderStatusID() {
        return OrderStatusID;
    }

    /**
     *
     * @param OrderStatusID
     */
    public void setOrderStatusID(String OrderStatusID) {
        this.OrderStatusID = OrderStatusID;
    }

    /**
     *
     * @return
     */
    public String getTotalBil() {
        return TotalBil;
    }

    /**
     *
     * @param TotalBil
     */
    public void setTotalBil(String TotalBil) {
        this.TotalBil = TotalBil;
    }

}
