<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.artisanalley.model.Product" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Product List - Artisan Alley</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 1rem; text-align: center; }
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
        <h1>Artisan Alley</h1>
        <p>Discover unique handcrafted goods</p>
    </div>

    <div class="nav">
        <a href="index.jsp">Home</a>
        <a href="login">Login</a>
        <a href="register">Register</a>
    </div>

    <div class="container">
        <h2>All Products</h2>
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
                        <div class="price">$<%= product.getPrice() %></div>
                        <a href="product?action=view&id=<%= product.getId() %>" class="btn">View Details</a>
                    </div>
                <% } %>
            <% } else { %>
                <p>No products available at the moment.</p>
            <% } %>
        </div>
    </div>
</body>
</html>
