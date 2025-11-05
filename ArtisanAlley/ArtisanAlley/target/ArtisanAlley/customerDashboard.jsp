<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.artisanalley.model.Product" %>
<%@ page import="com.artisanalley.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"CUSTOMER".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Dashboard - Artisan Alley</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; margin: 0; padding: 0; background-color: #F5F5DC; color: #8B4513; }
        .header { background-color: #D2B48C; color: #8B4513; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .nav { background-color: #D2B48C; padding: 0.5rem; }
        .nav a { color: #8B4513; margin: 0 1rem; text-decoration: none; }
        .container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }
        .products { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 1rem; }
        .product-card { background: white; padding: 1rem; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .product-card img { width: 100%; height: 200px; object-fit: cover; border-radius: 4px; }
        .product-card h3 { margin: 0.5rem 0; color: #4E342E; }
        .product-card p { color: #4E342E; }
        .price { font-weight: bold; color: #4E342E; }
        .btn { background-color: #A0522D; color: white; padding: 8px 16px; text-decoration: none; border-radius: 4px; display: inline-block; margin-top: 0.5rem; border: 1px solid #ccc; width: 120px; height: 40px; text-align: center; box-sizing: border-box; }
        .btn:hover { background-color: #8B4513; }
        .btn-primary { background-color: #007bff; }
        .btn-primary:hover { background-color: #0056b3; }
        .btn-success { background-color: #28a745; }
        .btn-success:hover { background-color: #1e7e34; }
        .button-group { display: flex; gap: 0.5rem; justify-content: center; margin-top: 0.5rem; }
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
        <h2>Available Products</h2>
        <% String currentShop = (String) request.getAttribute("currentShop"); %>
        <% if (currentShop != null) { %>
            <p>Showing products from: <strong><%= currentShop %></strong> | <a href="customerDashboard">Show All Products</a></p>
        <% } %>
        <form action="customerDashboard" method="get" style="margin-bottom: 1rem;">
            <input type="text" name="search" placeholder="Search products..." style="padding: 8px; width: 300px; border: 1px solid #ccc; border-radius: 4px;">
            <button type="submit" class="btn">Search</button>
        </form>
        <div class="products">
            <% if (products != null && !products.isEmpty()) { %>
                <% for (Product product : products) { %>
                    <div class="product-card">
                        <% if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) { %>
                            <img src="image?file=<%= product.getImageUrl() %>" alt="<%= product.getTitle() %>">
                        <% } else { %>
                            <div style="width: 100%; height: 200px; background: #ddd; border-radius: 4px; display: flex; align-items: center; justify-content: center;">No Image</div>
                        <% } %>
                            <h3><%= product.getTitle() %></h3>
                            <p><%= product.getDescription() %></p>
                            <div class="price">₹<%= product.getPrice() %></div>
                            <% if (product.getShopName() != null && !product.getShopName().isEmpty()) { %>
                                <p><a href="customerDashboard?shop=<%= java.net.URLEncoder.encode(product.getShopName(), "UTF-8") %>" style="color: #007bff; text-decoration: none;"><strong>by <%= product.getShopName() %></strong></a></p>
                            <% } %>
                        <div class="button-group">
                            <a href="product?action=view&id=<%= product.getId() %>" class="btn btn-primary">View Details</a>
                            <form action="order" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="addToCart">
                                <input type="hidden" name="productId" value="<%= product.getId() %>">
                                <button type="submit" class="btn btn-success">Add to Cart</button>
                            </form>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                <p>No products available at the moment.</p>
            <% } %>
        </div>
    </div>
</body>
</html>
