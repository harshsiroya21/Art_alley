<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>About Us - Artisan Alley</title>
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
        .about { padding: 3rem 0; background-color: white; margin-bottom: 2rem; border-radius: 8px; font-weight: bold; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .about h2 { font-weight: bold; }
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
            <a href="index.jsp">Home</a>
            <a href="login">Login</a>
            <a href="register">Register</a>
        </div>
    </div>

    <div class="container">
        <div class="about">
            <h2>About Artisan Alley</h2>
            <p>Artisan Alley is a vibrant marketplace dedicated to connecting talented artisans with customers who appreciate unique, handcrafted goods. Our platform empowers local creators to showcase their craftsmanship and reach a wider audience.</p>
            <p>We believe in quality, authenticity, and supporting small businesses. Every product on our site is carefully reviewed to ensure it meets our high standards.</p>
            <p>Join our community of artisans and customers today!</p>
        </div>
    </div>

    <div class="footer">
        <p>&copy; 2025 Artisan Alley. All rights reserved.</p>
        <a href="contact.jsp">Contact</a>
    </div>
</body>
</html>
