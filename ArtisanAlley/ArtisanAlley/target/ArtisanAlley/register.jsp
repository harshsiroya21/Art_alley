<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Artisan Alley</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #F5F5DC; margin: 0; padding: 0; color: #8B4513; }
        .container { max-width: 500px; margin: 2rem auto; background: white; padding: 2rem; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #8B4513; }
        form { display: flex; flex-direction: column; }
        input, select { margin-bottom: 1rem; padding: 10px; border: 1px solid #ddd; border-radius: 4px; }
        button { background-color: #4CAF50; color: white; padding: 10px; border: 1px solid #ccc; border-radius: 4px; cursor: pointer; }
        button:hover { background-color: #45a049; }
        .error { color: red; text-align: center; margin-bottom: 1rem; }
        .success { color: green; text-align: center; margin-bottom: 1rem; }
        .link { text-align: center; margin-top: 1rem; }
        .link a { color: #4CAF50; text-decoration: none; }
        .role-section { display: none; }
    </style>
    <script>
        function showRoleFields() {
            var role = document.getElementById('role').value;
            document.getElementById('customer-fields').style.display = (role === 'CUSTOMER') ? 'block' : 'none';
            document.getElementById('seller-fields').style.display = (role === 'SELLER') ? 'block' : 'none';
        }

        function validateRegisterForm() {
            var name = document.getElementById('name').value.trim();
            var email = document.getElementById('email').value.trim();
            var password = document.getElementById('password').value.trim();
            var role = document.getElementById('role').value;

            if (name === '') {
                alert('Please enter your full name.');
                return false;
            }
            if (email === '') {
                alert('Please enter your email.');
                return false;
            }
            if (password === '') {
                alert('Please enter a password.');
                return false;
            }
            if (role === '') {
                alert('Please select a role.');
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>Register for Artisan Alley</h2>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <% if (request.getAttribute("success") != null) { %>
            <div class="success"><%= request.getAttribute("success") %></div>
        <% } %>

        <form action="register" method="post" onsubmit="return validateRegisterForm()">
            <input type="text" id="name" name="name" placeholder="Full Name" required>
            <input type="email" id="email" name="email" placeholder="Email" required>
            <input type="password" id="password" name="password" placeholder="Password" required>

            <select name="role" id="role" onchange="showRoleFields()" required>
                <option value="">Select Role</option>
                <option value="CUSTOMER">Customer</option>
                <option value="SELLER">Seller</option>
            </select>

            <div id="customer-fields" class="role-section">
                <input type="text" name="deliveryAddress" placeholder="Delivery Address">
            </div>

            <div id="seller-fields" class="role-section">
                <input type="text" name="shopName" placeholder="Shop Name">
                <input type="text" name="contactInfo" placeholder="Contact Information">
            </div>

            <button type="submit">Register</button>
        </form>

        <div class="link">
            <a href="login">Already have an account? Login here</a>
        </div>
    </div>
</body>
</html>
