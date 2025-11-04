<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.artisanalley.model.Cart" %>
<%@ page import="com.artisanalley.model.Product" %>
<%@ page import="com.artisanalley.model.User" %>
<%@ page import="com.artisanalley.dao.ProductDAO" %>
<%@ page import="com.artisanalley.dao.CartDAO" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"CUSTOMER".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
    CartDAO cartDAO = new CartDAO();
    List<Cart> cartItems = cartDAO.getCartByCustomer(user.getId());
    double total = 0.0;
    if (cartItems != null) {
        for (Cart cart : cartItems) {
            Product product = new ProductDAO().getProductById(cart.getProductId());
            if (product != null) {
                total += product.getPrice() * cart.getQuantity();
            }
        }
    }
    ProductDAO productDAO = new ProductDAO();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Checkout - Artisan Alley</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .nav { background-color: #444; padding: 0.5rem; }
        .nav a { color: white; margin: 0 1rem; text-decoration: none; }
        .container { max-width: 800px; margin: 2rem auto; padding: 0 1rem; }
        .checkout-form { background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 1rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: bold; }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .order-summary { background: #f9f9f9; padding: 1rem; border-radius: 4px; margin-bottom: 2rem; }
        .order-item { display: flex; justify-content: space-between; margin-bottom: 0.5rem; }
        .total { font-size: 1.2rem; font-weight: bold; border-top: 1px solid #ddd; padding-top: 1rem; }
        .btn { background-color: #4CAF50; color: white; padding: 12px 24px; border: 1px solid #ccc; border-radius: 4px; cursor: pointer; font-size: 1rem; }
        .btn:hover { background-color: #45a049; }
    </style>
    <script>
        function validateForm() {
            var address = document.getElementById('deliveryAddress').value.trim();
            if (address === '') {
                alert('Please enter a delivery address.');
                return false;
            }
            return confirm('Are you sure you want to place this order?');
        }
    </script>
</head>
<body>
    <div class="header">
        <a href="customerDashboard" style="color: white; text-decoration: none;"><h1>Artisan Alley</h1></a>
        <div>Welcome, <%= user.getName() %> | <a href="logout" style="color: white;">Logout</a></div>
    </div>

    <div class="nav">
        <a href="customerDashboard">Browse Products</a>
        <a href="order?action=cart">Cart</a>
        <a href="order?action=history">Order History</a>
    </div>

    <div class="container">
        <h2>Checkout</h2>
        <div class="checkout-form">
            <div class="order-summary">
                <h3>Order Summary</h3>
                <% if (cartItems != null && !cartItems.isEmpty()) { %>
                    <% for (Cart cartItem : cartItems) { %>
                        <%
                            Product product = productDAO.getProductById(cartItem.getProductId());
                            if (product != null) {
                        %>
                            <div class="order-item">
                                <span><%= product.getTitle() %> (x<%= cartItem.getQuantity() %>)</span>
                                <span>$<%= String.format("%.2f", product.getPrice() * cartItem.getQuantity()) %></span>
                            </div>
                        <% } %>
                    <% } %>
                    <div class="total">
                        <span>Total: $<%= String.format("%.2f", total) %></span>
                    </div>
                <% } else { %>
                    <p>Your cart is empty.</p>
                <% } %>
            </div>

            <form action="order" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="checkout">
                <div class="form-group">
                    <label for="deliveryAddress">Delivery Address:</label>
                    <textarea id="deliveryAddress" name="deliveryAddress" rows="3" required><%= user.getDeliveryAddress() != null ? user.getDeliveryAddress() : "" %></textarea>
                </div>
                <div class="form-group">
                    <label for="paymentMethod">Payment Method:</label>
                    <select id="paymentMethod" name="paymentMethod" required>
                        <option value="CASH_ON_DELIVERY">Cash on Delivery</option>
                    </select>
                </div>
                <button type="submit" class="btn">Place Order</button>
            </form>
        </div>
    </div>
</body>
</html>
