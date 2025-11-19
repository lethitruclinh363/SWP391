package dao;

import java.sql.Connection;
import model.User;
import utils.DBContext;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import model.Role;

public class UserDAO extends DBContext {

    private User mapUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setPasswordHash(rs.getString("password_hash"));
        u.setFullName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPhone(rs.getString("phone"));
        u.setStatus((byte) rs.getInt("status"));
        Timestamp ts = rs.getTimestamp("created_at");
        u.setCreatedAt(ts != null ? ts.toLocalDateTime() : null);
        return u;
    }

    // ========= CRUD cơ bản =========
    /**
     * Creat user
     *
     * @param u user input
     * @return 1 - successfully creation, 0 - error create
     * @throws SQLException
     */
    public int create(User u) throws SQLException {
        String sql = " INSERT INTO users (username, password_hash, full_name, email, phone, status, created_at)\n"
                + "            VALUES (?, ?, ?, ?, ?, ?, GETDATE())";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getPasswordHash());
            ps.setString(3, u.getFullName());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getPhone());
            ps.setInt(6, u.getStatus());
            ps.executeUpdate();
            try ( ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    return keys.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error to create new user!");
        }
        return 0;
    }

    /**
     * Update user
     *
     * @param u user
     * @param updatePassword asked if forget password or not
     * @return true-update correct, false-error update
     * @throws SQLException
     */
    public boolean update(User u, boolean updatePassword) throws SQLException {
        String sql = updatePassword
                ? "UPDATE users SET username=?, password_hash=?, full_name=?, email=?, phone=?, status=? WHERE id=?"
                : "UPDATE users SET username=?, full_name=?, email=?, phone=?, status=? WHERE id=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
            int i = 1;
            ps.setString(i++, u.getUsername());
            if (updatePassword) {
                ps.setString(i++, u.getPasswordHash());
            }
            ps.setString(i++, u.getFullName());
            ps.setString(i++, u.getEmail());
            ps.setString(i++, u.getPhone());
            ps.setInt(i++, u.getStatus());
            ps.setInt(i, u.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error to uppdate user");
        }
        return false;

    }

    /**
     * Delete account out of table
     *
     * @param id ID user
     * @return true-delete successfully , false-error
     * @throws SQLException
     */
    public boolean deleteHard(int id) throws SQLException {
        String sql = "DELETE FROM users WHERE id=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error to delete account");
        }
        return false;
    }

    /**
     * Delete sort user account by change its status
     *
     * @param id user ID
     * @return true- delete successfully, false- error
     * @throws SQLException
     */
    public boolean deleteSoft(int id) throws SQLException {
        String sql = "UPDATE users SET status=0 WHERE id=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
//            ResultSet rs = ps.executeQuery();

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error to delete account");
        }
        return false;
    }

    /**
     * Find user by ID
     *
     * @param id user ID
     * @return found user by ID
     * @throws SQLException
     */
    public Optional<User> findById(int id) throws SQLException {
        String sql = "SELECT * FROM users WHERE id=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ps.setInt(1, id);

            if (rs.next()) {
                return Optional.of(mapUser(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error to find account by ID");
        }
        return Optional.empty();
    }

    /**
     * Find user by username
     *
     * @param username Username in 'users' table
     * @return found user by username
     * @throws SQLException
     */
    public Optional<User> findByUsername(String username) throws SQLException {
        String sql = "SELECT * FROM users WHERE username=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ps.setString(1, username);

            if (rs.next()) {
                return Optional.of(mapUser(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error to find account by Ussername");
        }
        return Optional.empty();
    }

    /**
     * Find user exist or not by USERNAME from 'users' table
     *
     * @param username username of user
     * @return true-exits, false-not exits
     * @throws SQLException
     */
    public boolean existsByUsername(String username) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE username=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            ps.setString(1, username);
            return rs.next();
        } catch (SQLException e) {
            System.err.println("Error to found user by username exits or not");
        }
        return false;
    }

    /**
     * Found user exist by email or not
     *
     * @param email user email
     * @return true-exits, false-not exits
     * @throws SQLException
     */
    public boolean existsByEmail(String email) throws SQLException {
        if (email == null || email.isEmpty()) {
            return false;
        }
        String sql = "SELECT 1 FROM users WHERE email=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.err.println("Error to found user by email exits or not");
        }
        return false;
    }

    /**
     * Find users by specific criteria
     *
     * @param status user activate or inactivate
     * @param roleId user role ID - admin, staff & customer
     * @param q username/email/full_name contains
     * @return list of user based on criteria
     * @throws SQLException
     */
    public List<User> findAll(Integer status, Integer roleId, String q) throws SQLException {
        // Lọc: status (nullable), roleId (nullable), q (username/email/full_name contains)
        StringBuilder sb = new StringBuilder(" SELECT DISTINCT u.* FROM users u LEFT JOIN user_roles ur ON ur.user_id = u.id WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (status != null) {
            sb.append(" AND u.status=?");
            params.add(status);
        }
        if (roleId != null) {
            sb.append(" AND ur.role_id=?");
            params.add(roleId);
        }
        if (q != null && !q.isEmpty()) {
            sb.append(" AND (u.username LIKE ? OR u.email LIKE ? OR u.full_name LIKE ?)");
            String like = "%" + q.trim() + "%";
            params.add(like);
            params.add(like);
            params.add(like);
        }
        sb.append(" ORDER BY u.created_at DESC");

        try ( PreparedStatement ps = conn.prepareStatement(sb.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            List<User> list = new ArrayList<>();
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapUser(rs));
                }
            }
            return list;
        }
    }

    //=================== User roles table ==================
    
    /**
     * Get roles by user id
     * @param userId 
     * @return list role and its user 
     * @throws SQLException 
     */
    public List<Role> getRolesByUserId(int userId) throws SQLException {
        String sql = "SELECT r.* FROM roles r JOIN user_roles ur ON ur.role_id = r.id WHERE ur.user_id = ? ORDER BY r.name";
          try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                List<Role> roles = new ArrayList<>();
                while (rs.next()) {
                    Role r = new Role();
                    r.setId(rs.getInt("id"));
                    r.setName(rs.getString("name"));
                    r.setNote(rs.getString("note"));
                    roles.add(r);
                }
                return roles;
            }
        } catch (SQLException e) {
             System.err.println("Error to get Roles By User Id ");
        }
          return null;
    }
    
    /**
     * Change role of user 
     * @param userId user ID
     * @param roleIds targeted role ID  
     * @throws SQLException 
     */
    public void replaceUserRoles(int userId, int roleIds) throws SQLException {
        String del = "DELETE FROM user_roles WHERE user_id=?";
        String ins = "INSERT INTO user_roles(user_id, role_id) VALUES (?, ?)";

        try {
            conn.setAutoCommit(false);
            
            try ( PreparedStatement psDel = conn.prepareStatement(del)) {
                psDel.setInt(1, userId);
                psDel.executeUpdate();
            }

            try ( PreparedStatement psIns = conn.prepareStatement(ins)) {
                psIns.setInt(1, userId);
                psIns.setInt(2, roleIds);
                psIns.executeUpdate();
            }
            conn.commit();
        } catch (SQLException e) {
            System.err.println("Error to replace User Roles");
        }
    }
    
    /**
     * Create user and set role for user inmediately
     * @param u new user
     * @param roleIds role user 
     * @return 1-successfully create, 0-error create
     * @throws SQLException 
     */
    public int createWithRoles(User u, int roleIds) throws SQLException {
        int newId = 0;
        String sql = " INSERT INTO users (username, password_hash, full_name, email, phone, status, created_at) VALUES (?, ?, ?, ?, ?, ?, GETDATE()) ";
        String insRole = "INSERT INTO user_roles(user_id, role_id) VALUES (?, ?)";

        try {
            conn.setAutoCommit(false);
            try ( PreparedStatement ps = conn.prepareStatement(sql);) {
                ps.setString(1, u.getUsername());
                ps.setString(2, u.getPasswordHash());
                ps.setString(3, u.getFullName());
                ps.setString(4, u.getEmail());
                ps.setString(5, u.getPhone());
                ps.setInt(6, u.getStatus());
                ps.executeUpdate();
                try ( ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        newId = keys.getInt(1);
                    }
                }
            }

            try ( PreparedStatement ps2 = conn.prepareStatement(insRole)) {

                ps2.setInt(1, newId);
                ps2.setInt(2, roleIds);
                ps2.executeUpdate();
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ignore) {
                }
            }
            throw e;  // ném ra cho tầng trên xử lý (log, báo lỗi, v.v.)
        } finally {
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException ignore) {
                }
            }
        }
        return newId;
    }

    /**
     * Get list user in Users table
     *
     * @return list user
     */
    public List<User> GetListUser() {
        List<User> listUser = new ArrayList<>();
        String sql = "SELECT id, username, password_hash, full_name, email, phone, status, created_at FROM users";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setPasswordHash(rs.getString("password_hash"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setStatus(rs.getByte("status"));
                u.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                listUser.add(u);
            }
        } catch (SQLException e) {
            System.err.println("Error to take list!");
        }
        return listUser;
    }

    public User GetUserDetails(int id) {
        User found = null;
        return found;
    }

    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        for (User u : dao.GetListUser()) {
            System.out.println(u.toString());
        }
    }
}
