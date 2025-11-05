<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.artisanalley.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"SELLER".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Product - Artisan Alley</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; margin: 0; padding: 0; background-color: #F5F5DC; color: #8B4513; }
        .header { background-color: #D2B48C; color: #8B4513; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .nav { background-color: #D2B48C; padding: 0.5rem; }
        .nav a { color: #8B4513; margin: 0 1rem; text-decoration: none; }
        .container { max-width: 600px; margin: 2rem auto; padding: 0 1rem; }
        .form-container { background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 1rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: bold; }
        .form-group input, .form-group textarea { width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; }
        .form-group textarea { resize: vertical; min-height: 100px; }
        .btn { background-color: #A0522D; color: white; padding: 12px 24px; border: 1px solid #ccc; border-radius: 4px; cursor: pointer; font-size: 1rem; }
        .btn:hover { background-color: #8B4513; }
        .error { color: red; margin-bottom: 1rem; }
        .image-preview { position: relative; display: inline-block; margin-top: 0.5rem; }
        .image-preview img { max-width: 200px; max-height: 200px; border-radius: 4px; }
        .remove-image { position: absolute; top: 5px; right: 5px; background: red; color: white; border: none; border-radius: 50%; width: 25px; height: 25px; cursor: pointer; font-size: 14px; }
    </style>
    <script>
        function validateForm() {
            var title = document.getElementById('title').value.trim();
            var description = document.getElementById('description').value.trim();
            var price = document.getElementById('price').value;

            if (title === '') {
                alert('Please enter a product title.');
                return false;
            }
            if (description === '') {
                alert('Please enter a product description.');
                return false;
            }
            if (price === '' || price <= 0) {
                alert('Please enter a valid price.');
                return false;
            }
            return true;
        }

        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function() {
                var preview = document.getElementById('image-preview');
                preview.innerHTML = '<img src="' + reader.result + '" alt="Image Preview"><button type="button" class="remove-image" onclick="removeImage()">×</button>';
            };
            reader.readAsDataURL(event.target.files[0]);
        }

        function removeImage() {
            document.getElementById('image').value = '';
            document.getElementById('image-preview').innerHTML = '';
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
        <div class="form-container">
            <h2>Add New Product</h2>
            <% if (request.getAttribute("error") != null) { %>
                <div class="error"><%= request.getAttribute("error") %></div>
            <% } %>
            <form action="product" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                <input type="hidden" name="action" value="add">
                <div class="form-group">
                    <label for="title">Product Title:</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" required></textarea>
                </div>
                <div class="form-group">
                    <label for="price">Price (₹):</label>
                    <input type="number" id="price" name="price" step="0.01" min="0" required>
                </div>
                <div class="form-group">
                    <label for="image">Product Image:</label>
                    <input type="file" id="image" name="image" accept="image/*" onchange="previewImage(event)">
                    <div id="image-preview" class="image-preview"></div>
                </div>
                <button type="submit" class="btn">Add Product</button>
            </form>
        </div>
    </div>
</body>
</html>
