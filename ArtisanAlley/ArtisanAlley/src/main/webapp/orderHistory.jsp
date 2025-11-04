<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.artisanalley.model.Order" %>
<%@ page import="com.artisanalley.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"CUSTOMER".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Order History - Artisan Alley</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .nav { background-color: #444; padding: 0.5rem; }
        .nav a { color: white; margin: 0 1rem; text-decoration: none; }
        .container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }
        .order-card { background: white; padding: 1rem; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); margin-bottom: 1rem; }
        .order-card h3 { margin: 0 0 0.5rem 0; }
        .status { padding: 4px 8px; border-radius: 4px; font-size: 0.8rem; }
        .status.NEW_ORDER { background-color: #2196F3; color: white; }
        .status.PROCESSING { background-color: #9C27B0; color: white; }
        .status.OUT_FOR_DELIVERY { background-color: #FF5722; color: white; }
        .status.COMPLETED { background-color: #4CAF50; color: white; }
        .status.CANCELED { background-color: #f44336; color: white; }
        .price { font-weight: bold; color: #4CAF50; }
    </style>
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
        <a href="profile">Profile</a>
    </div>

    <div class="container">
        <h2>Your Order History</h2>
        <% if (orders != null && !orders.isEmpty()) { %>
            <% for (Order order : orders) { %>
                <div class="order-card">
                    <h3>Product: <%= order.getProductTitle() %></h3>
                    <p>Total Price: <span class="price">$<%= order.getTotalPrice() %></span></p>
                    <p>Status: <span class="status <%= order.getStatus() %>"><%= order.getStatus() %></span></p>
                    <p>Order Date: <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(order.getCreatedAt()) %></p>
                    <p>Order Time: <%= new java.text.SimpleDateFormat("HH:mm:ss").format(order.getCreatedAt()) %></p>
                    <p>Delivery Address: <%= order.getDeliveryAddress() %></p>
                </div>
            <% } %>
        <% } else { %>
            <p>You haven't placed any orders yet. <a href="customerDashboard">Start shopping</a></p>
        <% } %>
    </div>
</body>
</html>
