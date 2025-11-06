<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.artisanalley.model.Order" %>
<%@ page import="com.artisanalley.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"SELLER".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Orders - Artisan Alley</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; margin: 0; padding: 0; background-color: #F5F5DC; color: #8B4513; }
        .header { background-color: #D2B48C; color: #8B4513; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .nav { background-color: #D2B48C; padding: 0.5rem; }
        .nav a { color: #8B4513; margin: 0 1rem; text-decoration: none; }
        .container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }
        .status { padding: 4px 8px; border-radius: 4px; font-size: 0.8rem; }
        .status.NEW_ORDER { background-color: #2196F3; color: white; }
        .status.PROCESSING { background-color: #9C27B0; color: white; }
        .status.OUT_FOR_DELIVERY { background-color: #FF5722; color: white; }
        .status.COMPLETED { background-color: #4CAF50; color: white; }
        .status.CANCELED { background-color: #f44336; color: white; }
        .btn { background-color: #A0522D; color: white; padding: 8px 16px; text-decoration: none; border-radius: 4px; display: inline-block; margin: 0.25rem; border: 1px solid #ccc; }
        .btn:hover { background-color: #8B4513; }
        .btn-danger { background-color: #f44336; }
        .btn-danger:hover { background-color: #d32f2f; }
        .btn-success { background-color: #4CAF50; }
        .btn-success:hover { background-color: #45a049; }
        table { width: 100%; border-collapse: collapse; margin-top: 1rem; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f2f2f2; }
    </style>
    <script>
        function confirmAction(action, orderId) {
            var message = action === 'accept' ? 'Are you sure you want to accept this order?' : 'Are you sure you want to reject this order?';
            if (confirm(message)) {
                // Create a form and submit it
                var form = document.createElement('form');
                form.method = 'post';
                form.action = 'sellerOrders';

                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = action;
                form.appendChild(actionInput);

                var orderIdInput = document.createElement('input');
                orderIdInput.type = 'hidden';
                orderIdInput.name = 'orderId';
                orderIdInput.value = orderId;
                form.appendChild(orderIdInput);

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
        <a href="sellerOrders">My Orders</a>
        <a href="profile">Profile</a>
    </div>

    <div class="container">
        <h2>My Orders</h2>
        <% if (orders != null && !orders.isEmpty()) { %>
            <table>
                <tr>
                    <th>Order ID</th>
                    <th>Product</th>
                    <th>Customer</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                <% for (Order order : orders) { %>
                    <tr>
                        <td><%= order.getId() %></td>
                        <td><%= order.getProductTitle() %></td>
                        <td><%= order.getCustomerName() %></td>
                        <td><%= order.getQuantity() %></td>
                        <td>₹<%= order.getTotalPrice() %></td>
                        <td><span class="status <%= order.getStatus() %>"><%= order.getStatus() %></span></td>
                        <td>
                            <% if ("NEW_ORDER".equals(order.getStatus())) { %>
                                <button type="button" class="btn btn-success" onclick="confirmAction('accept', <%= order.getId() %>)">Accept</button>
                                <button type="button" class="btn btn-danger" onclick="confirmAction('reject', <%= order.getId() %>)">Reject</button>
                            <% } %>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } else { %>
            <p>No orders found.</p>
        <% } %>
    </div>
</body>
</html>
