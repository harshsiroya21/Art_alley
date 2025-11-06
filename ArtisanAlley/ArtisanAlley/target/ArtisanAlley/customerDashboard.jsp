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
        body { font-family: 'Poppins', sans-serif; margin: 0; padding: 0; background-color: #F5F5DC; color: #8B4513; text-align: center; font-weight: bold; }
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
        .nav-links a { color: #8B4513; text-decoration: none; font-weight: bold; padding: 0.5rem; border-radius: 4px; transition: border 0.3s; }
        .nav-links a:hover { border: 2px solid #8B4513; }
        .container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; text-align: center; }
        .products { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 1rem; }
        .product-card { background: white; padding: 1rem; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .product-card img { width: 100%; height: 200px; object-fit: contain; border-radius: 4px; }
        .product-card h3 { margin: 0.5rem 0; color: #4E342E; font-weight: bold; }
        .product-card p { color: #4E342E; font-weight: bold; }
        .price { font-weight: bold; color: #4E342E; }
        .btn { background-color: #A0522D; color: white; padding: 8px 16px; text-decoration: none; border-radius: 4px; display: inline-block; margin-top: 0.5rem; border: 1px solid #ccc; width: 120px; height: 40px; text-align: center; box-sizing: border-box; font-weight: bold; }
        .btn:hover { background-color: #8B4513; }
        .btn-primary { background-color: #007bff; }
        .btn-primary:hover { background-color: #0056b3; }
        .btn-success { background-color: #28a745; }
        .btn-success:hover { background-color: #1e7e34; }
        .button-group { display: flex; gap: 0.5rem; justify-content: center; margin-top: 0.5rem; }
        .footer { background-color: #D2B48C; color: #8B4513; padding: 1rem; text-align: center; margin-top: 2rem; }
        .footer a { color: #8B4513; text-decoration: none; font-weight: bold; margin: 0 1rem; }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo-section">
            <a href="customerDashboard"><img src="logo.png" alt="Artisan Alley Logo"></a>
            <span>Artisan Alley</span>
        </div>
        <div>Welcome, <%= user.getName() %> | <a href="logout" style="color: white;">Logout</a></div>
    </div>

    <div class="nav">
        <form class="search-form" action="customerDashboard" method="get">
            <input type="text" name="search" placeholder="Search products...">
            <button type="submit">Search</button>
        </form>
        <div class="nav-links">
            <a href="customerDashboard">Browse Products</a>
            <a href="order?action=cart">Cart</a>
            <a href="order?action=history">Order History</a>
            <a href="profile">Profile</a>
        </div>
    </div>

        <div class="container">
        <h2>Available Products</h2>
        <% String currentShop = (String) request.getAttribute("currentShop"); %>
        <% if (currentShop != null) { %>
            <p>Showing products from: <strong><%= currentShop %></strong> | <a href="customerDashboard">Show All Products</a></p>
        <% } %>
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
    <div class="footer">
        &copy; 2025 Artisan Alley. All rights reserved. <a href="about.jsp">About Us</a> | <a href="contact.jsp">Contact</a> | <a href="privacy">Privacy Policy</a>
    </div>
</body>
</html>
