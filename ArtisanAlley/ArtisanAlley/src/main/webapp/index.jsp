<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Artisan Alley - Handcrafted Goods Marketplace</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; margin: 0; padding: 0; background-color: #F5F5DC; color: #8B4513; }
        .header { background-color: #D2B48C; color: #8B4513; padding: 1rem; text-align: center; }
        .nav { background-color: #D2B48C; padding: 0.5rem; }
        .nav a { color: #8B4513; margin: 0 1rem; text-decoration: none; }
        .container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }
        .hero { text-align: center; padding: 3rem 0; background-color: white; margin-bottom: 2rem; border-radius: 8px; }
        .button-group { display: flex; justify-content: center; gap: 1rem; margin-top: 1rem; }
        .btn { background-color: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Artisan Alley</h1>
        <p>Discover unique handcrafted goods from talented artisans</p>
    </div>

    <div class="nav">
        <a href="index.jsp">Home</a>
        <a href="login">Login</a>
        <a href="register">Register</a>
    </div>

    <div class="container">
        <div class="hero">
            <h2>Welcome to Artisan Alley</h2>
            <p>Connect with local artisans and find unique, handcrafted products that tell a story.</p>
            <div class="button-group">
                <a href="register" class="btn">Join as Customer</a>
                <a href="register" class="btn">Become a Seller</a>
            </div>
        </div>

        <div style="text-align: center; margin-top: 2rem;">
            <h3>Why Choose Artisan Alley?</h3>
            <div style="display: flex; justify-content: space-around; margin-top: 2rem;">
                <div style="background: white; padding: 1rem; border-radius: 8px; width: 30%;">
                    <h4>For Customers</h4>
                    <p>Discover unique handcrafted items from verified artisans.</p>
                </div>
                <div style="background: white; padding: 1rem; border-radius: 8px; width: 30%;">
                    <h4>For Sellers</h4>
                    <p>Showcase your craftsmanship and reach customers who appreciate quality.</p>
                </div>
                <div style="background: white; padding: 1rem; border-radius: 8px; width: 30%;">
                    <h4>Quality Assurance</h4>
                    <p>All products are reviewed and approved by our admin team.</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
