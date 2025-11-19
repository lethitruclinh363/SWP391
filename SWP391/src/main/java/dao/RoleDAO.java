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
import model.Role;
import utils.DBContext;

/**
 *
 * @author ADMIN
 */
public class RoleDAO extends DBContext {

    private Role map(ResultSet rs) throws SQLException {
        Role r = new Role();
        r.setId(rs.getInt("id"));
        r.setName(rs.getString("name"));
        r.setNote(rs.getString("note"));
        return r;
    }

    // ========== CRUD Role ===========
    /**
     * Create new role
     *
     * @param r new role
     * @return 1-create successfully, 2-error create
     * @throws SQLException
     */
    public int createRole(Role r) throws SQLException {
        String sql = "INSERT INTO roles(name, note) VALUES(?,?)";
        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setString(1, r.getName());
            ps.setString(2, r.getNote());
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
     * Update role
     *
     * @param r target role to be updated
     * @return true-update successfully, false- error update
     * @throws SQLException
     */
    public boolean updateRole(Role r) throws SQLException {
        String sql = "UPDATE roles SET name=?, note=? WHERE id=?";
        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setString(1, r.getName());
            ps.setString(2, r.getNote());
            ps.setInt(3, r.getId());
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Delete role from 'Role' table
     *
     * @param id role id deleted
     * @return true if delete successfully, false if error
     * @throws SQLException
     */
    public boolean deleteRole(int id) throws SQLException {
        String sql = "DELETE FROM roles WHERE id=?";
        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Find role by ID
     *
     * @param id role ID
     * @return Role if found and null value if not found
     * @throws SQLException
     */
    public Optional<Role> findById(int id) throws SQLException {
        String sql = "SELECT * FROM roles WHERE id=?";
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
     * Find role by its name
     *
     * @param name name role
     * @return found role
     * @throws SQLException
     */
    public Optional<Role> findByName(String name) throws SQLException {
        String sql = "SELECT * FROM roles WHERE name=?";
        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setString(1, name);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(map(rs));
                }
            }
        }
        return Optional.empty();
    }

    /**
     * Get list of role user
     *
     * @return list of rile
     * @throws SQLException
     */
    public List<Role> findAll() throws SQLException {
        String sql = "SELECT * FROM roles ORDER BY name";
        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ResultSet rs = ps.executeQuery();
            List<Role> list = new ArrayList<>();
            while (rs.next()) {
                list.add(map(rs));
            }
            return list;
        }
    }

    /**
     * Add role for non-role user into "user roles" table
     *
     * @param userId
     * @param roleId
     * @throws SQLException
     */
    public void addRoleToUser(int userId, int roleId) throws SQLException {
        String sql = "INSERT INTO user_roles(user_id, role_id) VALUES(?,?)";
        try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, userId);
            ps.setInt(2, roleId);
            ps.executeUpdate();
        }
    }
    
    /**
     * Remove Role from user in "user roles" table
     * @param userId
     * @param roleId
     * @throws SQLException 
     */
     public void removeRoleFromUser(int userId, int roleId) throws SQLException {
        String sql = "DELETE FROM user_roles WHERE user_id=? AND role_id=?";
          try ( PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, userId);
            ps.setInt(2, roleId);
            ps.executeUpdate();
        }
    }
    
    
}
