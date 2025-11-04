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
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .nav { background-color: #444; padding: 0.5rem; }
        .nav a { color: white; margin: 0 1rem; text-decoration: none; }
        .container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }
        .products { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 1rem; }
        .product-card { background: white; padding: 1rem; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .product-card img { width: 100%; height: 200px; object-fit: cover; border-radius: 4px; }
        .product-card h3 { margin: 0.5rem 0; }
        .product-card p { color: #666; }
        .price { font-weight: bold; color: #4CAF50; }
        .btn { background-color: #4CAF50; color: white; padding: 8px 16px; text-decoration: none; border-radius: 4px; display: inline-block; margin-top: 0.5rem; border: 1px solid #ccc; }
        .btn:hover { background-color: #45a049; }
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
                            <img src="<%= product.getImageUrl() %>" alt="<%= product.getTitle() %>">
                        <% } else { %>
                            <div style="width: 100%; height: 200px; background: #ddd; border-radius: 4px; display: flex; align-items: center; justify-content: center;">No Image</div>
                        <% } %>
                            <h3><%= product.getTitle() %></h3>
                            <p><%= product.getDescription() %></p>
                            <div class="price">$<%= product.getPrice() %></div>
                            <% if (product.getShopName() != null && !product.getShopName().isEmpty()) { %>
                                <p><a href="customerDashboard?shop=<%= java.net.URLEncoder.encode(product.getShopName(), "UTF-8") %>" style="color: #007bff; text-decoration: none;"><strong>by <%= product.getShopName() %></strong></a></p>
                            <% } %>
                        <a href="product?action=view&id=<%= product.getId() %>" class="btn">View Details</a>
                        <form action="order" method="post" style="display: inline;">
                            <input type="hidden" name="action" value="addToCart">
                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                            <button type="submit" class="btn">Add to Cart</button>
                        </form>
                    </div>
                <% } %>
            <% } else { %>
                <p>No products available at the moment.</p>
            <% } %>
        </div>
    </div>
</body>
</html>
