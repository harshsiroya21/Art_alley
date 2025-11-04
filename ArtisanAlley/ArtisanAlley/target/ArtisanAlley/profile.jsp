<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.artisanalley.model.User" %>
<%
    User user = (User) request.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Profile - Artisan Alley</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .nav { background-color: #444; padding: 0.5rem; }
        .nav a { color: white; margin: 0 1rem; text-decoration: none; }
        .container { max-width: 600px; margin: 2rem auto; padding: 0 1rem; }
        .profile-card { background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .profile-field { margin-bottom: 1rem; }
        .profile-field label { display: block; margin-bottom: 0.5rem; font-weight: bold; }
        .profile-field input, .profile-field select { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .btn { background-color: #4CAF50; color: white; padding: 12px 24px; border: 1px solid #ccc; border-radius: 4px; cursor: pointer; font-size: 1rem; }
        .btn:hover { background-color: #45a049; }
    </style>
</head>
<body>
    <div class="header">
        <a href="<%= "CUSTOMER".equals(user.getRole()) ? "customerDashboard" : "SELLER".equals(user.getRole()) ? "sellerDashboard" : "adminDashboard" %>" style="color: white; text-decoration: none;"><h1>Artisan Alley</h1></a>
        <div>Welcome, <%= user.getName() %> | <a href="logout" style="color: white;">Logout</a></div>
    </div>

    <div class="nav">
        <% if ("CUSTOMER".equals(user.getRole())) { %>
            <a href="customerDashboard">Browse Products</a>
            <a href="order?action=cart">Cart</a>
            <a href="order?action=history">Order History</a>
            <a href="profile">Profile</a>
        <% } else if ("SELLER".equals(user.getRole())) { %>
            <a href="sellerDashboard">My Products</a>
            <a href="addProduct.jsp">Add New Product</a>
            <a href="profile">Profile</a>
        <% } else if ("ADMIN".equals(user.getRole())) { %>
            <a href="adminDashboard">Dashboard</a>
            <a href="profile">Profile</a>
        <% } %>
    </div>

    <div class="container">
        <div class="profile-card">
            <h2>Your Profile</h2>
            <form action="profile" method="post">
                <div class="profile-field">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" value="<%= user.getName() %>">
                </div>
                <div class="profile-field">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= user.getEmail() %>" readonly>
                </div>
                <div class="profile-field">
                    <label for="role">Role:</label>
                    <input type="text" id="role" name="role" value="<%= user.getRole() %>" readonly>
                </div>
                <div class="profile-field">
                    <label for="status">Status:</label>
                    <input type="text" id="status" name="status" value="<%= user.getStatus() %>" readonly>
                </div>
                <% if ("CUSTOMER".equals(user.getRole())) { %>
                <div class="profile-field">
                    <label for="deliveryAddress">Delivery Address:</label>
                    <input type="text" id="deliveryAddress" name="deliveryAddress" value="<%= user.getDeliveryAddress() != null ? user.getDeliveryAddress() : "" %>">
                </div>
                <% } %>
                <% if ("SELLER".equals(user.getRole())) { %>
                <div class="profile-field">
                    <label for="shopName">Shop Name:</label>
                    <input type="text" id="shopName" name="shopName" value="<%= user.getShopName() != null ? user.getShopName() : "" %>">
                </div>
                <div class="profile-field">
                    <label for="contactInfo">Contact Info:</label>
                    <input type="text" id="contactInfo" name="contactInfo" value="<%= user.getContactInfo() != null ? user.getContactInfo() : "" %>">
                </div>
                <% } %>
                <!-- Add more fields as needed -->
                <% if (request.getAttribute("success") != null) { %>
                    <p style="color: green;"><%= request.getAttribute("success") %></p>
                <% } %>
                <% if (request.getAttribute("error") != null) { %>
                    <p style="color: red;"><%= request.getAttribute("error") %></p>
                <% } %>
                <button type="submit" class="btn">Update Profile</button>
            </form>
        </div>
    </div>
</body>
</html>
