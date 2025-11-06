<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Artisan Alley - Handcrafted Goods Marketplace</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; margin: 0; padding: 0; background-color: #F5F5DC; color: #8B4513; text-align: center; font-weight: bold; }
        .header { background-color: #D2B48C; color: #8B4513; padding: 1rem; display: flex; justify-content: space-between; align-items: center; }
        .logo-section { display: flex; align-items: center; gap: 0.5rem; }
        .logo-section img { height: 60px; margin: 0; }
        .logo-section span { font-weight: bold; font-size: 1.5rem; }
        .nav { display: flex; gap: 1rem; align-items: center; }
        .nav a { color: #8B4513; text-decoration: none; font-weight: bold; }
        .container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; text-align: center; }
        .hero { padding: 3rem 0; background-color: white; margin-bottom: 2rem; border-radius: 8px; font-weight: bold; }
        .hero h2 { font-weight: bold; }
        .button-group { display: flex; justify-content: center; gap: 1rem; margin-top: 1rem; }
        .btn { background-color: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; font-weight: bold; }
        h3, h4, p { font-weight: bold; }
        .footer { background-color: #D2B48C; color: #8B4513; padding: 1rem; text-align: center; margin-top: 2rem; }
        .footer a { color: #8B4513; text-decoration: none; font-weight: bold; margin: 0 1rem; }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo-section">
            <img src="logo.png" alt="Artisan Alley Logo">
            <span>Artisan Alley</span>
        </div>
        <div class="nav">
            <a href="login">Login</a>
            <a href="register">Register</a>
        </div>
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
                <div style="background: white; padding: 1rem; border-radius: 8px; width: 30%; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                    <h4>For Customers</h4>
                    <p>Discover unique handcrafted items from verified artisans.</p>
                </div>
                <div style="background: white; padding: 1rem; border-radius: 8px; width: 30%; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                    <h4>For Sellers</h4>
                    <p>Showcase your craftsmanship and reach customers who appreciate quality.</p>
                </div>
                <div style="background: white; padding: 1rem; border-radius: 8px; width: 30%; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                    <h4>Quality Assurance</h4>
                    <p>All products are reviewed and approved by our admin team.</p>
                </div>
            </div>
        </div>
    </div>

    <div class="footer">
        <p>&copy; 2025 Artisan Alley. All rights reserved.</p>
        <a href="about.jsp">About Us</a>
        <a href="contact.jsp">Contact</a>
    </div>
</body>
</html>
