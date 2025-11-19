/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import model.Address;
import utils.DBContext;

/**
 *
 * @author ADMIN
 */
public class AddressDAO extends DBContext{
    
    private Address map(ResultSet rs) throws SQLException {
        Address a = new Address();
        a.setId(rs.getInt("id"));
        a.setCustomerId(rs.getInt("customer_id"));
        a.setReceiverName(rs.getString("receiver_name"));
        a.setReceiverPhone(rs.getString("receiver_phone"));
        a.setProvince(rs.getString("province"));
        a.setDistrict(rs.getString("district"));
        a.setWard(rs.getString("ward"));
        a.setAddressLine(rs.getString("address_line"));
        a.setIsDefault(rs.getInt("is_default"));
        return a;
    }
    
    /**
     * Create address 
     * @param a Address of customer
     * @return 1-create successfully, 2-false to create
     * @throws SQLException 
     */
     public int createAddress(Address a) throws SQLException {
        String sql = " INSERT INTO addresses(customer_id, receiver_name, receiver_phone, province, district, ward, address_line, is_default) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
         try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, a.getCustomerId());
            ps.setString(2, a.getReceiverName());
            ps.setString(3, a.getReceiverPhone());
            ps.setString(4, a.getProvince());
            ps.setString(5, a.getDistrict());
            ps.setString(6, a.getWard());
            ps.setString(7, a.getAddressLine());
            ps.setInt(8, a.getIsDefault());
            ps.executeUpdate();
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        return 0;
    }

     /**
      * Update customer address
      * @param a
      * @return
      * @throws SQLException 
      */
    public boolean updateAddress(Address a) throws SQLException {
        String sql = " UPDATE addresses SET receiver_name=?, receiver_phone=?, province=?, district=?, ward=?, address_line=?, is_default=? WHERE id=?";
         try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setString(1, a.getReceiverName());
            ps.setString(2, a.getReceiverPhone());
            ps.setString(3, a.getProvince());
            ps.setString(4, a.getDistrict());
            ps.setString(5, a.getWard());
            ps.setString(6, a.getAddressLine());
            ps.setInt(7, a.getIsDefault());
            ps.setInt(8, a.getId());
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Delete address customer
     * @param id address id
     * @return
     * @throws SQLException 
     */
    public boolean deleteAddress(int id) throws SQLException {
        String sql = "DELETE FROM addresses WHERE id=?";
       try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Find address by its id
     * @param id
     * @return
     * @throws SQLException 
     */
    public Optional<Address> findAddressById(int id) throws SQLException {
        String sql = "SELECT * FROM addresses WHERE id=?";
       try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return Optional.of(map(rs));
            }
        } catch (SQLException e){
             System.err.println("Error to find address by id");
        }
        return Optional.empty();
    }

    /**
     * Find address by customer id
     * @param customerId
     * @return
     * @throws SQLException 
     */
    public List<Address> findAddressByCustomerId(int customerId) throws SQLException {
        String sql = "SELECT * FROM addresses WHERE customer_id=? ORDER BY is_default DESC, id DESC";
        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                List<Address> list = new ArrayList<>();
                while (rs.next()) list.add(map(rs));
                return list;
            }
        } catch (SQLException e){
             System.err.println("Error to find address by customer id");
        }
        return null;
    }

    /**
     * Find address default by customer id
     * @param customerId
     * @return
     * @throws SQLException 
     */
    public Optional<Address> findDefaultByCustomer(int customerId) throws SQLException {
        String sql = "SELECT TOP 1 * FROM addresses WHERE customer_id=? AND is_default=1";
         try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return Optional.of(map(rs));
            }
        } catch (SQLException e){
             System.err.println("Error to find default address");
        }
        return Optional.empty();
    }

    /**
     * Set new address defalut for customer
     * @param customerId
     * @param addressId
     * @throws SQLException 
     */
    public void setDefault(int customerId, int addressId) throws SQLException {
        String clear = "UPDATE addresses SET is_default=0 WHERE customer_id=?";
        String set   = "UPDATE addresses SET is_default=1 WHERE id=? AND customer_id=?";
        try {
            conn.setAutoCommit(false);
            try (PreparedStatement ps1 = conn.prepareStatement(clear)) {
                ps1.setInt(1, customerId);
                ps1.executeUpdate();
            }
            try (PreparedStatement ps2 = conn.prepareStatement(set)) {
                ps2.setInt(1, addressId);
                ps2.setInt(2, customerId);
                ps2.executeUpdate();
            }
            conn.commit();
        } catch (SQLException e){
            System.err.println("Errror to set default address");
        }
    }
}
