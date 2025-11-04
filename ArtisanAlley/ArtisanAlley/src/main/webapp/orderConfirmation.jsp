<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.artisanalley.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"CUSTOMER".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation - Artisan Alley</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; text-align: center; }
        .header { background-color: #333; color: white; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .nav { background-color: #444; padding: 0.5rem; }
        .nav a { color: white; margin: 0 1rem; text-decoration: none; }
        .container { max-width: 600px; margin: 4rem auto; padding: 2rem; background: white; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .btn { background-color: #4CAF50; color: white; padding: 12px 24px; text-decoration: none; border-radius: 4px; display: inline-block; margin-top: 2rem; }
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
    </div>

    <div class="container">
        <h2>Order Placed!</h2>
        <p>Thank you for shopping with us. Your order has been successfully placed.</p>
        <a href="customerDashboard" class="btn">Continue Shopping</a>
    </div>
</body>
</html>
