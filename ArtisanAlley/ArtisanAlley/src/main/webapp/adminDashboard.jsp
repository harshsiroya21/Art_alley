<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.artisanalley.model.User" %>
<%@ page import="com.artisanalley.model.Product" %>
<%@ page import="com.artisanalley.model.Order" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect("login");
        return;
    }
    List<User> users = (List<User>) request.getAttribute("users");
    List<Product> pendingProducts = (List<Product>) request.getAttribute("pendingProducts");
    List<Product> allProducts = (List<Product>) request.getAttribute("allProducts");
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Artisan Alley</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; margin: 0; padding: 0; background-color: #F5F5DC; color: #8B4513; }
        .header { background-color: #D2B48C; color: #8B4513; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .nav { background-color: #D2B48C; padding: 0.5rem; }
        .nav a { color: #8B4513; margin: 0 1rem; text-decoration: none; }
        .container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }
        .section { background: white; padding: 1rem; border-radius: 8px; margin-bottom: 2rem; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f2f2f2; }
        .status { padding: 4px 8px; border-radius: 4px; font-size: 0.8rem; }
        .status.ACTIVE { background-color: #4CAF50; color: white; }
        .status.PENDING { background-color: #ff9800; color: white; }
        .status.REJECTED { background-color: #f44336; color: white; }
        .status.NEW_ORDER { background-color: #2196F3; color: white; }
        .status.PROCESSING { background-color: #9C27B0; color: white; }
        .status.OUT_FOR_DELIVERY { background-color: #FF5722; color: white; }
        .status.COMPLETED { background-color: #4CAF50; color: white; }
        .status.CANCELED { background-color: #f44336; color: white; }
        .btn { background-color: #A0522D; color: white; padding: 6px 12px; text-decoration: none; border-radius: 4px; display: inline-block; margin: 2px; border: 1px solid #ccc; }
        .btn:hover { background-color: #8B4513; }
        .btn-success { background-color: #4CAF50; }
        .btn-success:hover { background-color: #45a049; }
        .btn-danger { background-color: #f44336; }
        .btn-danger:hover { background-color: #d32f2f; }
        .btn-warning { background-color: #ff9800; }
        .btn-warning:hover { background-color: #e68900; }
    </style>
    <script>
        function confirmAction(action, productId) {
            var message = action === 'approve' ? 'Are you sure you want to approve this product?' : 'Are you sure you want to reject this product?';
            if (confirm(message)) {
                // Create a form and submit it
                var form = document.createElement('form');
                form.method = 'post';
                form.action = 'adminDashboard';

                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = action === 'approve' ? 'approveProduct' : 'rejectProduct';
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

        function confirmDelete(productId) {
            if (confirm('Are you sure you want to delete this product?')) {
                var form = document.createElement('form');
                form.method = 'post';
                form.action = 'adminDashboard';

                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'deleteProduct';
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

        function confirmDeleteUser(userId) {
            if (confirm('Are you sure you want to delete this user?')) {
                var form = document.createElement('form');
                form.method = 'post';
                form.action = 'adminDashboard';

                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'deleteUser';
                form.appendChild(actionInput);

                var userIdInput = document.createElement('input');
                userIdInput.type = 'hidden';
                userIdInput.name = 'userId';
                userIdInput.value = userId;
                form.appendChild(userIdInput);

                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</head>
<body>
    <div class="header">
        <a href="adminDashboard" style="color: white; text-decoration: none;"><h1>Artisan Alley</h1></a>
        <div>Welcome, <%= user.getName() %> | <a href="logout" style="color: white;">Logout</a></div>
    </div>

    <div class="nav">
        <a href="adminDashboard">Dashboard</a>
    </div>

    <div class="container">
        <div class="section">
            <h2>Pending Product Approvals</h2>
            <% if (pendingProducts != null && !pendingProducts.isEmpty()) { %>
                <table>
                    <tr>
                        <th>Title</th>
                        <th>Seller</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Actions</th>
                    </tr>
                    <% for (Product product : pendingProducts) { %>
                        <tr>
                            <td><%= product.getTitle() %></td>
                            <td><%= product.getShopName() %></td>
                            <td><%= product.getDescription() %></td>
                            <td>₹<%= product.getPrice() %></td>
                            <td>
                                <button type="button" class="btn btn-success" onclick="confirmAction('approve', <%= product.getId() %>)">Approve</button>
                                <button type="button" class="btn btn-danger" onclick="confirmAction('reject', <%= product.getId() %>)">Reject</button>
                            </td>
                        </tr>
                    <% } %>
                </table>
            <% } else { %>
                <p>No pending products to approve.</p>
            <% } %>
        </div>

        <div class="section">
            <h2>Product Management</h2>
            <% if (allProducts != null && !allProducts.isEmpty()) { %>
                <table>
                    <tr>
                        <th>Title</th>
                        <th>Seller</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    <% for (Product product : allProducts) { %>
                        <tr>
                            <td><%= product.getTitle() %></td>
                            <td><%= product.getShopName() %></td>
                            <td><%= product.getDescription() %></td>
                            <td>₹<%= product.getPrice() %></td>
                            <td><span class="status <%= product.getStatus() %>"><%= product.getStatus() %></span></td>
                            <td>
                                <button type="button" class="btn btn-danger" onclick="confirmDelete(<%= product.getId() %>)">Delete</button>
                            </td>
                        </tr>
                    <% } %>
                </table>
            <% } else { %>
                <p>No products found.</p>
            <% } %>
        </div>

        <div class="section">
            <h2>Order Management</h2>
            <% if (orders != null && !orders.isEmpty()) { %>
                <table>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Product</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    <% for (Order order : orders) { %>
                        <tr>
                            <td><%= order.getId() %></td>
                            <td><%= order.getCustomerName() %></td>
                            <td><%= order.getProductTitle() %></td>
                            <td>₹<%= order.getTotalPrice() %></td>
                            <td><span class="status <%= order.getStatus() %>"><%= order.getStatus() %></span></td>
                            <td>
                                <form action="adminDashboard" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="updateOrderStatus">
                                    <input type="hidden" name="orderId" value="<%= order.getId() %>">
                                    <select name="status">
                                        <option value="PROCESSING" <%= "NEW_ORDER".equals(order.getStatus()) ? "" : "" %>>Processing</option>
                                        <option value="OUT_FOR_DELIVERY" <%= "PROCESSING".equals(order.getStatus()) ? "" : "" %>>Out for Delivery</option>
                                        <option value="COMPLETED" <%= "OUT_FOR_DELIVERY".equals(order.getStatus()) ? "" : "" %>>Completed</option>
                                        <option value="CANCELED">Cancel</option>
                                    </select>
                                    <button type="submit" class="btn btn-warning">Update</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </table>
            <% } else { %>
                <p>No orders to manage.</p>
            <% } %>
        </div>

        <div class="section">
            <h2>User Management</h2>
            <% if (users != null && !users.isEmpty()) { %>
                <table>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    <% for (User u : users) { %>
                        <tr>
                            <td><%= u.getName() %></td>
                            <td><%= u.getEmail() %></td>
                            <td><%= u.getRole() %></td>
                            <td><span class="status <%= u.getStatus() %>"><%= u.getStatus() %></span></td>
                            <td>
                                <button type="button" class="btn btn-danger" onclick="confirmDeleteUser(<%= u.getId() %>)">Delete</button>
                            </td>
                        </tr>
                    <% } %>
                </table>
            <% } else { %>
                <p>No users found.</p>
            <% } %>
        </div>
    </div>
</body>
</html>
