<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.artisanalley.model.Product" %>
<%@ page import="com.artisanalley.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"SELLER".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
    List<Product> products = (List<Product>) request.getAttribute("products");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Seller Dashboard - Artisan Alley</title>
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
        .status { padding: 4px 8px; border-radius: 4px; font-size: 0.8rem; }
        .status.ACTIVE { background-color: #4CAF50; color: white; }
        .status.PENDING { background-color: #ff9800; color: white; }
        .status.REJECTED { background-color: #f44336; color: white; }
        .btn { background-color: #4CAF50; color: white; padding: 8px 16px; text-decoration: none; border-radius: 4px; display: inline-block; margin: 0.25rem; border: 1px solid #ccc; }
        .btn:hover { background-color: #45a049; }
        .btn-danger { background-color: #f44336; }
        .btn-danger:hover { background-color: #d32f2f; }
        .add-product { text-align: center; margin-bottom: 2rem; }
    </style>
    <script>
        function confirmDelete(productId) {
            if (confirm('Are you sure you want to delete this product?')) {
                // Create a form and submit it
                var form = document.createElement('form');
                form.method = 'post';
                form.action = 'product';

                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'delete';
                form.appendChild(actionInput);

                var productIdInput = document.createElement('input');
                productIdInput.type = 'hidden';
                productIdInput.name = 'productId';
                productIdInput.value = productId;
                form.appendChild(productIdInput);

                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</head>
<body>
    <div class="header">
        <a href="sellerDashboard" style="color: white; text-decoration: none;"><h1>Artisan Alley</h1></a>
        <div>Welcome, <%= user.getName() %> | <a href="logout" style="color: white;">Logout</a></div>
    </div>

    <div class="nav">
        <a href="sellerDashboard">My Products</a>
        <a href="addProduct.jsp">Add New Product</a>
        <a href="profile">Profile</a>
    </div>

    <div class="container">
        <div class="add-product">
            <a href="addProduct.jsp" class="btn">Add New Product</a>
        </div>

        <h2>My Products</h2>
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
                        <div>$<%= product.getPrice() %></div>
                        <div class="status <%= product.getStatus() %>"><%= product.getStatus() %></div>
                        <a href="product?action=edit&id=<%= product.getId() %>" class="btn">Edit</a>
                        <button type="button" class="btn btn-danger" onclick="confirmDelete(<%= product.getId() %>)">Delete</button>
                    </div>
                <% } %>
            <% } else { %>
                <p>You haven't added any products yet. <a href="addProduct.jsp">Add your first product</a></p>
            <% } %>
        </div>
    </div>
</body>
</html>
