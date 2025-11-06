<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.artisanalley.model.Cart" %>
<%@ page import="com.artisanalley.model.Product" %>
<%@ page import="com.artisanalley.model.User" %>
<%@ page import="com.artisanalley.dao.ProductDAO" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"CUSTOMER".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
    List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");
    ProductDAO productDAO = new ProductDAO();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Cart - Artisan Alley</title>
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
        .container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; text-align: center; }
        .cart-item { background: white; padding: 1rem; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); margin-bottom: 1rem; display: flex; align-items: center; }
        .cart-item img { width: 100px; height: 100px; object-fit: cover; border-radius: 4px; margin-right: 1rem; }
        .item-details { flex-grow: 1; }
        .item-details h3 { margin: 0 0 0.5rem 0; color: #4E342E; font-weight: bold; }
        .item-details p { color: #4E342E; font-weight: bold; }
        .price { font-weight: bold; color: #4E342E; }
        .btn { background-color: #A0522D; color: white; padding: 8px 16px; text-decoration: none; border-radius: 4px; display: inline-block; margin: 0.25rem; border: 1px solid #ccc; width: 120px; height: 40px; text-align: center; box-sizing: border-box; font-weight: bold; }
        .checkout-btn { width: 200px; height: 50px; font-size: 1.1rem; white-space: nowrap; }
        .btn:hover { background-color: #8B4513; }
        .btn-danger { background-color: #f44336; }
        .btn-danger:hover { background-color: #d32f2f; }
        .total { text-align: right; font-size: 1.2rem; font-weight: bold; margin-top: 2rem; }
        .checkout { text-align: center; margin-top: 2rem; }
        .footer { background-color: #D2B48C; color: #8B4513; padding: 1rem; text-align: center; margin-top: 2rem; }
        .footer a { color: #8B4513; text-decoration: none; font-weight: bold; margin: 0 1rem; }
    </style>
    <script>
        function removeItem(cartId) {
            if (confirm('Are you sure you want to remove this item from your cart?')) {
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = 'order';

                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'remove';
                form.appendChild(actionInput);

                var cartIdInput = document.createElement('input');
                cartIdInput.type = 'hidden';
                cartIdInput.name = 'cartId';
                cartIdInput.value = cartId;
                form.appendChild(cartIdInput);

                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
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
        <div class="nav-links">
            <a href="customerDashboard">Browse Products</a>
            <a href="order?action=history">Order History</a>
            <a href="profile">Profile</a>
        </div>
    </div>

    <div class="container">
        <% if (cartItems != null && !cartItems.isEmpty()) { %>
            <h2>Your Shopping Cart</h2>
            <% double total = 0; %>
            <% for (Cart cartItem : cartItems) { %>
                <%
                    // Fetch product details using productId from cartItem
                    Product product = productDAO.getProductById(cartItem.getProductId());
                    if (product != null) {
                        total += product.getPrice() * cartItem.getQuantity();
                %>
                    <div class="cart-item">
                        <% if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) { %>
                            <img src="image?file=<%= product.getImageUrl() %>" alt="<%= product.getTitle() %>">
                        <% } else { %>
                            <div style="width: 100px; height: 100px; background: #ddd; border-radius: 4px; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">No Image</div>
                        <% } %>
                        <div class="item-details">
                            <h3><%= product.getTitle() %></h3>
                            <p><%= product.getDescription() %></p>
                            <div class="price">₹<%= product.getPrice() %></div>
                        </div>
                        <div>
                            <button class="btn btn-danger" onclick="removeItem(<%= cartItem.getId() %>)">Remove</button>
                        </div>
                    </div>
                <% } %>
            <% } %>
            <div class="total">
                Total: ₹<%= String.format("%.2f", total) %>
            </div>
            <div class="checkout">
                <form action="order" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="checkout">
                    <button type="submit" class="btn checkout-btn">Proceed to Checkout</button>
                </form>
            </div>
        <% } else { %>
            <div style="text-align: center; font-size: 1.5rem; font-weight: bold; margin: 2rem 0;">
                <p>Your cart is empty.</p>
                <a href="customerDashboard" style="background-color: transparent; color: #8B4513; padding: 10px 20px; text-decoration: none; border: 2px solid #8B4513; border-radius: 4px; display: inline-block; margin-top: 1rem;">Start shopping</a>
            </div>
        <% } %>
    </div>
    <div class="footer" style="margin-top: auto;">
        &copy; 2025 Artisan Alley. All rights reserved. <a href="about.jsp">About Us</a> | <a href="contact.jsp">Contact</a>
    </div>
</body>
</html>
