package com.daos;

import com.db.DBConnection;
import com.models.Product;
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
 * @author HoangLiem
 */
public class ProductDAO {

    private Connection conn = null;

    /**
     *
     */
    public ProductDAO() {
        conn = DBConnection.getConnection();
    }

    /**
     *
     *
     * @return ResultSet contain all Product
     */
    public ResultSet getAll() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select t1.ProductID,t1.ProductName,t1.PictureLink,t1.Description,\n"
                    + "t2.ProductTypeID,t2.Quantity,t2.Price,t2.EXP,t2.Origin,t2.SoldAmount\n"
                    + "from Product t1 left outer join ProductInformation t2 on t1.ProductID = t2.ProductID");
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

    /**
     *
     * @author Trung Kien
     * @param ProductID
     * @return the price on this product
     */
    public int getUnitPrice(String ProductID) {
        int unitPrice = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("select Price from ProductInformation where ProductID=?");
            pst.setString(1, ProductID);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                unitPrice = rs.getInt("Price");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return unitPrice;
    }

    /**
     * Lay thong tin cua mot khach hang dua vao makh
     *
     * @param ProductID
     * @return mot doi tuong chua thong tin cua khach hang can tim
     */
    public Product getProduct(String ProductID) {
        Product st = null;
        try {
            PreparedStatement pst = conn.prepareStatement("select t1.ProductID,t1.ProductName,t1.PictureLink,t1.Description,\n"
                    + "t2.ProductTypeID,t2.Quantity,t2.Price,t2.EXP,t2.Origin,t2.SoldAmount\n"
                    + "from Product t1 left outer join ProductInformation t2 on t1.ProductID = t2.ProductID where t1.ProductID = ?");
            pst.setString(1, ProductID);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                String db_ProductID = rs.getString("ProductID");
                String db_ProductTypeID = rs.getString("ProductTypeID");
                String db_ProductName = rs.getString("ProductName");
                String db_PictureLink = rs.getString("PictureLink");
                String db_Description = rs.getString("Description");
                String db_Quantity = rs.getString("Quantity");
                String db_Price = rs.getString("Price");
                String db_EXP = rs.getString("EXP");
                String db_Origin = rs.getString("Origin");
                String db_SoldAmount = rs.getString("SoldAmount");
                Product pd = new Product(db_ProductID, db_ProductTypeID, db_ProductName, db_PictureLink, db_Description, Integer.parseInt(db_Quantity), Integer.parseInt(db_Price), db_EXP, db_Origin, db_SoldAmount);
                return pd;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return st;
    }

    /**
     *
     * @param pd
     * @return
     */
    public int addProduct(Product pd) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("Insert into Product values(?,?,?,?)");
            pst.setString(1, pd.getProductID());
            pst.setString(2, pd.getProductName());
            pst.setString(3, pd.getPictureLink());
            pst.setString(4, pd.getDescription());
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    /**
     *
     * @param pd
     * @return
     */
    public int addProductInformation(Product pd) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("Insert into ProductInformation values(?,?,?,?,?,?,?)");
            pst.setString(1, pd.getProductID());
            pst.setString(2, pd.getProductTypeID());
            pst.setInt(3, pd.getQuantity());
            pst.setInt(4, pd.getPrice());
            pst.setDate(5, Date.valueOf(pd.getEXP()));
            pst.setString(6, pd.getOrigin());
            pst.setInt(7, Integer.parseInt(pd.getSoleAmount()));
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    /**
     *
     * @param ProductID
     * @return
     */
    public int deleteProductInformation(String ProductID) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("delete from ProductInformation where ProductID=?");
            pst.setString(1, ProductID);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    /**
     *
     * @param ProductID
     * @return
     */
    public int deleteProduct(String ProductID) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("delete from Product where ProductID=?");
            pst.setString(1, ProductID);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    /**
     *
     * @param pd
     * @return
     */
    public int updateProduct(Product pd) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("update Product set ProductName=?, PictureLink=?, Description=? where ProductID=?");
            pst.setString(1, pd.getProductName());
            pst.setString(2, pd.getPictureLink());
            pst.setString(3, pd.getDescription());
            pst.setString(4, pd.getProductID());
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    /**
     *
     * @param pd
     * @return
     */
    public int updateProductInformation(Product pd) {
        int count = 0;
        try {
            PreparedStatement pst = conn.prepareStatement("update ProductInformation set ProductTypeID=?, Quantity=?, Price=?, EXP=?, Origin=?, SoldAmount=? where ProductID=?");
            pst.setString(1, pd.getProductTypeID());
            pst.setInt(2, pd.getQuantity());
            pst.setInt(3, pd.getPrice());
            pst.setDate(4, Date.valueOf(pd.getEXP()));
            pst.setString(5, pd.getOrigin());
            pst.setInt(6, Integer.parseInt(pd.getSoleAmount()));
            pst.setString(7, pd.getProductID());
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    /**
     *
     * @param ProductTypeID
     * @return
     */
    public String nameOfTypeProduct(String ProductTypeID) {
        ResultSet rs = null;
        String name = "";
        try {
            PreparedStatement pst = conn.prepareStatement("select ProductTypeName from ProductType Where ProductTypeID=?");
            pst.setString(1, ProductTypeID);
            rs = pst.executeQuery();
            while (rs.next()) {
                name = rs.getString("ProductTypeName");
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return name;
    }

    /**
     *
     *
     * @return ResultSet contain all Type Of Product
     */
    public ResultSet getAllTypeOfProduct() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select * from ProductType");
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    /**
     *
     * Written by Quang Qui
     * @return ResultSet Products Best Selling
     */
    public ResultSet getAllProductBestOrder() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("SELECT od.ProductID, COUNT(*) as TotalOrders\n"
                    + "FROM OrderDetails od\n"
                    + "INNER JOIN OrderList ol ON od.OrderID = ol.OrderID\n"
                    + "WHERE YEAR(ol.OrderTime) = YEAR(GETDATE()) AND MONTH(ol.OrderTime) = MONTH(GETDATE())\n"
                    + "GROUP BY od.ProductID\n"
                    + "HAVING COUNT(*) >= 4"
                    + "ORDER BY TotalOrders DESC");
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }
    
    /**
     *
     * Written by Quang Qui
     * @return ResultSet Products Best Selling
     */
    public ResultSet getAllProductBestSelling() {
        ResultSet rs = null;
        try {
            Statement st = conn.createStatement();
            rs = st.executeQuery("select t1.ProductID,t1.ProductName,t1.PictureLink,t1.Description,\n"
                    + "t2.ProductTypeID,t2.Quantity,t2.Price,t2.EXP,t2.Origin,t2.SoldAmount\n"
                    + "from Product t1 left outer join ProductInformation t2 on t1.ProductID = t2.ProductID where t2.SoldAmount >=4");
        } catch (SQLException ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rs;
    }

}
