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
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .header { background-color: #333; color: white; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .nav { background-color: #444; padding: 0.5rem; }
        .nav a { color: white; margin: 0 1rem; text-decoration: none; }
        .container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }
        .cart-item { background: white; padding: 1rem; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); margin-bottom: 1rem; display: flex; align-items: center; }
        .cart-item img { width: 100px; height: 100px; object-fit: cover; border-radius: 4px; margin-right: 1rem; }
        .item-details { flex-grow: 1; }
        .item-details h3 { margin: 0 0 0.5rem 0; }
        .price { font-weight: bold; color: #4CAF50; }
        .btn { background-color: #4CAF50; color: white; padding: 8px 16px; text-decoration: none; border-radius: 4px; display: inline-block; margin: 0.25rem; border: 1px solid #ccc; }
        .btn:hover { background-color: #45a049; }
        .btn-danger { background-color: #f44336; }
        .btn-danger:hover { background-color: #d32f2f; }
        .total { text-align: right; font-size: 1.2rem; font-weight: bold; margin-top: 2rem; }
        .checkout { text-align: center; margin-top: 2rem; }
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
        <a href="customerDashboard" style="color: white; text-decoration: none;"><h1>Artisan Alley</h1></a>
        <div>Welcome, <%= user.getName() %> | <a href="logout" style="color: white;">Logout</a></div>
    </div>

    <div class="nav">
        <a href="customerDashboard">Browse Products</a>
        <a href="order?action=cart">Cart</a>
        <a href="order?action=history">Order History</a>
    </div>

    <div class="container">
        <h2>Your Shopping Cart</h2>
        <% if (cartItems != null && !cartItems.isEmpty()) { %>
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
                            <img src="<%= product.getImageUrl() %>" alt="<%= product.getTitle() %>">
                        <% } else { %>
                            <div style="width: 100px; height: 100px; background: #ddd; border-radius: 4px; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">No Image</div>
                        <% } %>
                        <div class="item-details">
                            <h3><%= product.getTitle() %></h3>
                            <p><%= product.getDescription() %></p>
                            <div class="price">$<%= product.getPrice() %></div>
                        </div>
                        <div>
                            <button class="btn btn-danger" onclick="removeItem(<%= cartItem.getId() %>)">Remove</button>
                        </div>
                    </div>
                <% } %>
            <% } %>
            <div class="total">
                Total: $<%= String.format("%.2f", total) %>
            </div>
            <div class="checkout">
                <a href="checkout.jsp" class="btn">Proceed to Checkout</a>
            </div>
        <% } else { %>
            <p>Your cart is empty. <a href="customerDashboard">Start shopping</a></p>
        <% } %>
    </div>
</body>
</html>
