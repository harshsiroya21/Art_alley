<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.artisanalley.model.Product" %>
<%@ page import="com.artisanalley.model.User" %>
<%
    Product product = (Product) request.getAttribute("product");
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= product != null ? product.getTitle() : "Product Details" %> - Artisan Alley</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .nav { background-color: #444; padding: 0.5rem; }
        .nav a { color: white; margin: 0 1rem; text-decoration: none; }
        .container { max-width: 800px; margin: 2rem auto; padding: 0 1rem; }
        .product-detail { background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .product-image { text-align: center; margin-bottom: 2rem; }
        .product-image img { max-width: 100%; height: 400px; object-fit: cover; border-radius: 8px; }
        .product-info h2 { color: #333; margin-bottom: 1rem; }
        .price { font-size: 1.5rem; font-weight: bold; color: #4CAF50; margin-bottom: 1rem; }
        .description { color: #666; line-height: 1.6; margin-bottom: 2rem; }
        .btn { background-color: #4CAF50; color: white; padding: 12px 24px; text-decoration: none; border-radius: 4px; display: inline-block; margin-right: 1rem; border: 1px solid #ccc; }
        .btn:hover { background-color: #45a049; }
        .quantity { margin-bottom: 1rem; }
        .quantity input { width: 60px; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="header">
        <% if (user != null) { %>
            <a href="<%= "CUSTOMER".equals(user.getRole()) ? "customerDashboard" : "SELLER".equals(user.getRole()) ? "sellerDashboard" : "adminDashboard" %>" style="color: white; text-decoration: none;"><h1>Artisan Alley</h1></a>
        <% } else { %>
            <a href="index.jsp" style="color: white; text-decoration: none;"><h1>Artisan Alley</h1></a>
        <% } %>
        <% if (user != null) { %>
            <div>Welcome, <%= user.getName() %> | <a href="logout" style="color: white;">Logout</a></div>
        <% } %>
    </div>

    <div class="nav">
        <% if (user != null) { %>
            <% if ("CUSTOMER".equals(user.getRole())) { %>
                <a href="customerDashboard">Browse Products</a>
                <a href="order?action=cart">Cart</a>
                <a href="order?action=history">Order History</a>
            <% } else if ("SELLER".equals(user.getRole())) { %>
                <a href="sellerDashboard">Dashboard</a>
            <% } else if ("ADMIN".equals(user.getRole())) { %>
                <a href="adminDashboard">Dashboard</a>
            <% } %>
        <% } else { %>
            <a href="index.jsp">Home</a>
            <a href="login">Login</a>
            <a href="register">Register</a>
        <% } %>
    </div>

    <div class="container">
        <% if (product != null) { %>
            <div class="product-detail">
                <div class="product-image">
                    <% if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) { %>
                        <img src="<%= product.getImageUrl() %>" alt="<%= product.getTitle() %>">
                    <% } else { %>
                        <div style="width: 100%; height: 400px; background: #ddd; border-radius: 8px; display: flex; align-items: center; justify-content: center;">No Image</div>
                    <% } %>
                </div>
                <div class="product-info">
                    <h2><%= product.getTitle() %></h2>
                    <div class="price">$<%= product.getPrice() %></div>
                    <p class="description"><%= product.getDescription() %></p>
                    <% if (product.getShopName() != null && !product.getShopName().isEmpty()) { %>
                        <p><a href="customerDashboard?shop=<%= java.net.URLEncoder.encode(product.getShopName(), "UTF-8") %>" style="color: #007bff; text-decoration: none;"><strong>by <%= product.getShopName() %></strong></a></p>
                    <% } %>
                    <p><strong>Available</strong></p>
                    <% if (user != null && "CUSTOMER".equals(user.getRole())) { %>
                        <form action="order" method="post">
                            <input type="hidden" name="action" value="addToCart">
                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                            <button type="submit" class="btn">Add to Cart</button>
                        </form>
                    <% } %>
                    <a href="customerDashboard" class="btn">Back to Products</a>
                </div>
            </div>
        <% } else { %>
            <p>Product not found.</p>
        <% } %>
    </div>
</body>
</html>
