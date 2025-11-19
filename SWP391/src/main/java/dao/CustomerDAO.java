/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import model.Customer;
import utils.DBContext;

/**
 *
 * @author ADMIN
 */
public class CustomerDAO extends DBContext {

    private Customer map(ResultSet rs) throws SQLException {
        Customer c = new Customer();
        c.setId(rs.getInt("id"));
        c.setUserId(rs.getInt("user_id"));
        c.setFullName(rs.getString("full_name"));
        c.setPhone(rs.getString("phone"));
        c.setEmail(rs.getString("email"));
        Timestamp ts = rs.getTimestamp("created_at");
        c.setCreatedAt(ts != null ? ts.toLocalDateTime() : null);
        return c;
    }

    /**
     * Create new Customer
     *
     * @param c customer information
     * @return 1-create successfully, 2-error create
     * @throws SQLException
     */
    public int createCustomer(Customer c) throws SQLException {
        String sql = "INSERT INTO customers(user_id, full_name, phone, email, created_at) VALUES (?, ?, ?, ?, GETDATE())";
        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, c.getUserId());
            ps.setString(2, c.getFullName());
            ps.setString(3, c.getPhone());
            ps.setString(4, c.getEmail());
            ps.executeUpdate();
            try ( ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
        }
        return 0;
    }

    /**
     * Update customer
     *
     * @param c
     * @return
     * @throws SQLException
     */
    public boolean updateCustomer(Customer c) throws SQLException {
        String sql = "UPDATE customers SET full_name=?, phone=?, email=? WHERE id=?";
        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setString(1, c.getFullName());
            ps.setString(2, c.getPhone());
            ps.setString(3, c.getEmail());
            ps.setInt(4, c.getId());
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Delete customer
     *
     * @param id
     * @return
     * @throws SQLException
     */
    public boolean deleteCustomer(int id) throws SQLException {
        String sql = "DELETE FROM customers WHERE id=?";
        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Find Customer by Customer ID
     *
     * @param id Customer ID
     * @return Customer or not
     * @throws SQLException
     */
    public Optional<Customer> findCustomerById(int id) throws SQLException {
        String sql = "SELECT * FROM customers WHERE id=?";
        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, id);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(map(rs));
                }
            }
        }
        return Optional.empty();
    }

    /**
     * Find Customer by Customer ID
     *
     * @param userId userID
     * @return found Customer by UserID
     * @throws SQLException
     */
    public Optional<Customer> findCustomerByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM customers WHERE user_id=?";
        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, userId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(map(rs));
                }
            }
        }
        return Optional.empty();
    }

    /**
     * Get list customer by q criteria
     *
     * @param q
     * @return
     * @throws SQLException
     */
    public List<Customer> findAllCustomer(String q) throws SQLException {
        StringBuilder sb = new StringBuilder("SELECT * FROM customers WHERE 1=1");
        List<Object> params = new ArrayList<>();
        if (q != null && !q.isEmpty()) {
            sb.append(" AND (full_name LIKE ? OR phone LIKE ? OR email LIKE ?)");
            String like = "%" + q.trim() + "%";
            params.add(like);
            params.add(like);
            params.add(like);
        }
        sb.append(" ORDER BY created_at DESC");

        try ( PreparedStatement ps = conn.prepareStatement(sb.toString());) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try ( ResultSet rs = ps.executeQuery()) {
                List<Customer> list = new ArrayList<>();
                while (rs.next()) {
                    list.add(map(rs));
                }
                return list;
            }
        }
    }
}
