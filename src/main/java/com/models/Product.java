/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.models;

/**
 *
 * @author HoangLiem
 */
public class Product {
    private String ProductID;
    private String ProductTypeID;
    private String ProductName;
    private String PictureLink;
    private String Description;
    private int Quantity;
    private int Price;
    private String EXP;
    private String Origin;
    private String SoleAmount;

    /**
     *
     */
    public Product() {
    }

    /**
     *
     * @param ProductID
     * @param ProductTypeID
     * @param ProductName
     * @param PictureLink
     * @param Description
     * @param Quantity
     * @param Price
     * @param EXP
     * @param Origin
     * @param SoleAmount
     */
    public Product(String ProductID, String ProductTypeID, String ProductName, String PictureLink, String Description, int Quantity, int Price, String EXP, String Origin, String SoleAmount) {
        this.ProductID = ProductID;
        this.ProductTypeID = ProductTypeID;
        this.ProductName = ProductName;
        this.PictureLink = PictureLink;
        this.Description = Description;
        this.Quantity = Quantity;
        this.Price = Price;
        this.EXP = EXP;
        this.Origin = Origin;
        this.SoleAmount = SoleAmount;
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
    public String getProductTypeID() {
        return ProductTypeID;
    }

    /**
     *
     * @param ProductTypeID
     */
    public void setProductTypeID(String ProductTypeID) {
        this.ProductTypeID = ProductTypeID;
    }

    /**
     *
     * @return
     */
    public String getProductName() {
        return ProductName;
    }

    /**
     *
     * @param ProductName
     */
    public void setProductName(String ProductName) {
        this.ProductName = ProductName;
    }

    /**
     *
     * @return
     */
    public String getPictureLink() {
        return PictureLink;
    }

    /**
     *
     * @param PictureLink
     */
    public void setPictureLink(String PictureLink) {
        this.PictureLink = PictureLink;
    }

    /**
     *
     * @return
     */
    public String getDescription() {
        return Description;
    }

    /**
     *
     * @param Description
     */
    public void setDescription(String Description) {
        this.Description = Description;
    }

    /**
     *
     * @return
     */
    public int getQuantity() {
        return Quantity;
    }

    /**
     *
     * @param Quantity
     */
    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    /**
     *
     * @return
     */
    public int getPrice() {
        return Price;
    }

    /**
     *
     * @param Price
     */
    public void setPrice(int Price) {
        this.Price = Price;
    }

    /**
     *
     * @return
     */
    public String getEXP() {
        return EXP;
    }

    /**
     *
     * @param EXP
     */
    public void setEXP(String EXP) {
        this.EXP = EXP;
    }

    /**
     *
     * @return
     */
    public String getOrigin() {
        return Origin;
    }

    /**
     *
     * @param Origin
     */
    public void setOrigin(String Origin) {
        this.Origin = Origin;
    }

    /**
     *
     * @return
     */
    public String getSoleAmount() {
        return SoleAmount;
    }

    /**
     *
     * @param SoleAmount
     */
    public void setSoleAmount(String SoleAmount) {
        this.SoleAmount = SoleAmount;
    }
    
}
