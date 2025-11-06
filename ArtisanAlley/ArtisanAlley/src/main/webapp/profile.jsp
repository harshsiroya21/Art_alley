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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; margin: 0; padding: 0; background-color: #F5F5DC; color: #8B4513; text-align: center; font-weight: bold; min-height: 100vh; display: flex; flex-direction: column; }
        .header { background-color: #D2B48C; color: #8B4513; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .logo-section { display: flex; align-items: center; gap: 0.5rem; }
        .logo-section img { height: 60px; margin: 0; }
        .logo-section span { font-weight: bold; font-size: 1.5rem; }
        .search-form { display: flex; align-items: center; gap: 0.5rem; }
        .search-form input { padding: 8px; border: 1px solid #ccc; border-radius: 4px; width: 300px; }
        .search-form button { background-color: #4CAF50; color: white; padding: 8px 16px; border: none; border-radius: 4px; cursor: pointer; font-weight: bold; }
        .search-form button:hover { background-color: #45a049; }
        .nav { background-color: #D2B48C; padding: 0.5rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-links { display: flex; gap: 1rem; }
        .nav-links a { color: #8B4513; text-decoration: none; font-weight: bold; padding: 0.5rem; border-radius: 4px; transition: border 0.3s; position: relative; }
        .nav-links a:hover { border: 2px solid #8B4513; }
        .cart-badge { position: absolute; top: -10px; right: -10px; background-color: #FF0000; color: white; border-radius: 50%; padding: 2px 6px; font-size: 0.8rem; font-weight: bold; }
        .container { max-width: 2000px; margin: 2rem auto; padding: 0 1rem; text-align: center; }
        .profile-card { background: white; padding: 3rem 4rem; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); max-width: 2000px; margin: 0 auto; }
        .profile-field { margin-bottom: 1rem; }
        .profile-field label { display: block; margin-bottom: 0.5rem; font-weight: bold; color: #4E342E; }
        .profile-field input, .profile-field select { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .btn { background-color: #A0522D; color: white; padding: 12px 24px; border: 1px solid #ccc; border-radius: 4px; cursor: pointer; font-size: 1rem; font-weight: bold; }
        .btn:hover { background-color: #8B4513; }
        .footer { background-color: #D2B48C; color: #8B4513; padding: 1rem; text-align: center; margin-top: auto; }
        .footer a { color: #8B4513; text-decoration: none; font-weight: bold; margin: 0 1rem; }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo-section">
            <a href="<%= "CUSTOMER".equals(user.getRole()) ? "customerDashboard" : "SELLER".equals(user.getRole()) ? "sellerDashboard" : "adminDashboard" %>"><img src="logo.png" alt="Artisan Alley Logo"></a>
            <span>Artisan Alley</span>
        </div>
        <div>Welcome, <%= user.getName() %> | <a href="logout" style="color: white;">Logout</a></div>
    </div>

    <div class="nav">
        <% if ("CUSTOMER".equals(user.getRole())) { %>
            <div class="nav-links">
                <a href="customerDashboard">Browse Products</a>
                <a href="order?action=cart">Cart</a>
                <a href="order?action=history">Order History</a>
            </div>
        <% } else if ("SELLER".equals(user.getRole())) { %>
            <div class="nav-links">
                <a href="sellerDashboard">My Products</a>
                <a href="addProduct.jsp">Add New Product</a>
            </div>
        <% } else if ("ADMIN".equals(user.getRole())) { %>
            <div class="nav-links">
                <a href="adminDashboard">Dashboard</a>
            </div>
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
    <div class="footer">
        &copy; 2025 Artisan Alley. All rights reserved. <a href="about.jsp">About Us</a> | <a href="contact.jsp">Contact</a>
    </div>
</body>
</html>
