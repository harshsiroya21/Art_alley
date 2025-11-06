package com.artisanalley.dao;

import com.artisanalley.model.Order;
import com.artisanalley.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public boolean placeOrder(Order order) {
        String sql = "INSERT INTO orders (customer_id, product_id, quantity, total_price, status, delivery_address, payment_method) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, order.getCustomerId());
            stmt.setInt(2, order.getProductId());
            stmt.setInt(3, order.getQuantity());
            stmt.setDouble(4, order.getTotalPrice());
            stmt.setString(5, order.getStatus());
            stmt.setString(6, order.getDeliveryAddress());
            stmt.setString(7, order.getPaymentMethod());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Order getOrderById(int id) {
        String sql = "SELECT * FROM orders WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setProductId(rs.getInt("product_id"));
                order.setQuantity(rs.getInt("quantity"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getString("status"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                return order;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Order> getOrdersByCustomer(int customerId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, p.title as product_title FROM orders o JOIN products p ON o.product_id = p.id WHERE o.customer_id = ? ORDER BY o.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setProductId(rs.getInt("product_id"));
                order.setQuantity(rs.getInt("quantity"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getString("status"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setProductTitle(rs.getString("product_title"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getOrdersBySeller(int sellerId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, p.title as product_title, u.name as customer_name FROM orders o JOIN products p ON o.product_id = p.id JOIN users u ON o.customer_id = u.id WHERE p.seller_id = ? ORDER BY o.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, sellerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setProductId(rs.getInt("product_id"));
                order.setQuantity(rs.getInt("quantity"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getString("status"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setProductTitle(rs.getString("product_title"));
                order.setCustomerName(rs.getString("customer_name"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, p.title as product_title, u.name as customer_name FROM orders o JOIN products p ON o.product_id = p.id JOIN users u ON o.customer_id = u.id ORDER BY o.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setProductId(rs.getInt("product_id"));
                order.setQuantity(rs.getInt("quantity"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getString("status"));
                order.setDeliveryAddress(rs.getString("delivery_address"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setProductTitle(rs.getString("product_title"));
                order.setCustomerName(rs.getString("customer_name"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteOrder(int id) {
        String sql = "DELETE FROM orders WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
