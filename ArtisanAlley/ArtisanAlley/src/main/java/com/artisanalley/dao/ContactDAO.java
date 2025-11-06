package com.artisanalley.dao;

import com.artisanalley.model.ContactMessage;
import com.artisanalley.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactDAO {

    public void saveContactMessage(ContactMessage message) throws SQLException {
        String sql = "INSERT INTO contact_messages (name, email, message) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, message.getName());
            stmt.setString(2, message.getEmail());
            stmt.setString(3, message.getMessage());

            stmt.executeUpdate();
        }
    }

    public List<ContactMessage> getAllContactMessages() throws SQLException {
        List<ContactMessage> messages = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                ContactMessage message = new ContactMessage();
                message.setId(rs.getInt("id"));
                message.setName(rs.getString("name"));
                message.setEmail(rs.getString("email"));
                message.setMessage(rs.getString("message"));
                message.setCreatedAt(rs.getTimestamp("created_at"));
                messages.add(message);
            }
        }

        return messages;
    }

    public void deleteContactMessage(int id) throws SQLException {
        String sql = "DELETE FROM contact_messages WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
