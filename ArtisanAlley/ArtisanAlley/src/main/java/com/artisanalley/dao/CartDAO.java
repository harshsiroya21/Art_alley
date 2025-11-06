package com.artisanalley.dao;

import com.artisanalley.model.Cart;
import com.artisanalley.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public boolean addToCart(Cart cart) {
        String sql = "INSERT INTO cart (customer_id, product_id, quantity) VALUES (?, ?, 1) ON DUPLICATE KEY UPDATE quantity = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cart.getCustomerId());
            stmt.setInt(2, cart.getProductId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Cart> getCartByCustomer(int customerId) {
        List<Cart> cartItems = new ArrayList<>();
        String sql = "SELECT * FROM cart WHERE customer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setCustomerId(rs.getInt("customer_id"));
                cart.setProductId(rs.getInt("product_id"));
                cart.setQuantity(rs.getInt("quantity"));
                cart.setAddedAt(rs.getTimestamp("added_at"));
                cartItems.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    public boolean updateCartQuantity(int cartId, int quantity) {
        String sql = "UPDATE cart SET quantity=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, cartId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeFromCart(int cartId) {
        String sql = "DELETE FROM cart WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean clearCart(int customerId) {
        String sql = "DELETE FROM cart WHERE customer_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Cart getCartItem(int customerId, int productId) {
        String sql = "SELECT * FROM cart WHERE customer_id = ? AND product_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            stmt.setInt(2, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Cart cart = new Cart();
                cart.setId(rs.getInt("id"));
                cart.setCustomerId(rs.getInt("customer_id"));
                cart.setProductId(rs.getInt("product_id"));
                cart.setQuantity(rs.getInt("quantity"));
                cart.setAddedAt(rs.getTimestamp("added_at"));
                return cart;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getCartItemCount(int customerId) {
        String sql = "SELECT SUM(quantity) AS total FROM cart WHERE customer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
