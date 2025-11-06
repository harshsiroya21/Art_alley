<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.artisanalley.model.Product" %>
<%@ page import="com.artisanalley.model.Order" %>
<%@ page import="com.artisanalley.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"SELLER".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Seller Dashboard - Artisan Alley</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; margin: 0; padding: 0; background-color: #F5F5DC; color: #8B4513; text-align: center; font-weight: bold; }
        .header { background-color: #D2B48C; color: #8B4513; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .logo-section { display: flex; align-items: center; gap: 0.5rem; }
        .logo-section img { height: 60px; margin: 0; }
        .logo-section span { font-weight: bold; font-size: 1.5rem; }
        .nav { background-color: #D2B48C; padding: 0.5rem; display: flex; justify-content: space-between; align-items: center; }
        .nav-links { display: flex; gap: 1rem; }
        .nav-links a { color: #8B4513; text-decoration: none; font-weight: bold; padding: 0.5rem; border-radius: 4px; transition: border 0.3s; position: relative; }
        .nav-links a:hover { border: 2px solid #8B4513; }
        .container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }
        .products { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 1rem; }
        .product-card { background: white; padding: 1rem; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .product-card img { width: 100%; height: 200px; object-fit: contain; border-radius: 4px; }
        .product-card h3 { margin: 0.5rem 0; }
        .product-card p { color: #8B4513; }
        .status { padding: 4px 8px; border-radius: 4px; font-size: 0.8rem; }
        .status.ACTIVE { background-color: #4CAF50; color: white; }
        .status.PENDING { background-color: #ff9800; color: white; }
        .status.REJECTED { background-color: #f44336; color: white; }
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
        .add-product { text-align: center; margin-bottom: 2rem; }
        table { width: 100%; border-collapse: collapse; margin-top: 1rem; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f2f2f2; }
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

        function confirmAction(action, orderId) {
            var message = action === 'accept' ? 'Are you sure you want to accept this order?' : 'Are you sure you want to reject this order?';
            if (confirm(message)) {
                // Create a form and submit it
                var form = document.createElement('form');
                form.method = 'post';
                form.action = 'sellerDashboard';

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
        <div class="logo-section">
            <a href="sellerDashboard"><img src="logo.png" alt="Artisan Alley Logo"></a>
            <span>Artisan Alley</span>
        </div>
        <div>Welcome, <%= user.getName() %> | <a href="logout" style="color: white;">Logout</a></div>
    </div>

    <div class="nav">
        <div class="nav-links">
            <a href="sellerDashboard">My Products</a>
            <a href="addProduct.jsp">Add New Product</a>
            <a href="profile">Profile</a>
        </div>
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
                        <div>₹<%= product.getPrice() %></div>
                        <div class="status <%= product.getStatus() %>"><%= product.getStatus() %></div>
                        <a href="product?action=edit&id=<%= product.getId() %>" class="btn">Edit</a>
                        <button type="button" class="btn btn-danger" onclick="confirmDelete(<%= product.getId() %>)">Delete</button>
                    </div>
                <% } %>
            <% } else { %>
                <p>You haven't added any products yet. <a href="addProduct.jsp">Add your first product</a></p>
            <% } %>
        </div>

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
