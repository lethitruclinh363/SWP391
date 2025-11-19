package model;

import java.time.LocalDateTime;

public class User {

    private int id;
    private String username;
    private String passwordHash;
    private String fullName;
    private String email;
    private String phone;
    private byte status;           // 0 = inactive, 1 = active
    private LocalDateTime createdAt;

    public User() {
        this.id=-1;
        this.username= "guest";
        this.passwordHash = "";
        this.fullName="";
        this.email ="";
        this.phone="";
        this.status=0;
        this.createdAt=null;
        
    }

    public User(int id, String username, String passwordHash,
                String fullName, String email, String phone,
                byte status, LocalDateTime createdAt) {
        this.id = id;
        this.username = username;
        this.passwordHash = passwordHash;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.status = status;
        this.createdAt = createdAt;
    }

    // Getter & Setter

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public byte getStatus() {
        return status;
    }

    public void setStatus(byte status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", passwordHash='" + passwordHash + '\'' +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", status=" + status +
                ", createdAt=" + createdAt +
                '}';
    }
}

