<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Contact Us - Artisan Alley</title>
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
        .contact { padding: 3rem 0; background-color: white; margin-bottom: 2rem; border-radius: 8px; font-weight: bold; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .contact h2 { font-weight: bold; }
        form { display: flex; flex-direction: column; align-items: center; gap: 1rem; }
        input, textarea { width: 300px; padding: 10px; border: 1px solid #8B4513; border-radius: 4px; font-weight: bold; }
        button { background-color: #4CAF50; color: white; padding: 10px 20px; border: none; border-radius: 4px; font-weight: bold; cursor: pointer; }
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
        <div class="contact">
            <h2>Contact Us</h2>
            <p>We'd love to hear from you! Send us a message and we'll get back to you soon.</p>
            <form action="contact" method="post">
                <input type="text" name="name" placeholder="Your Name" required>
                <input type="email" name="email" placeholder="Your Email" required>
                <textarea name="message" rows="5" placeholder="Your Message" required></textarea>
                <button type="submit">Send Message</button>
            </form>
        </div>
    </div>

    <div class="footer">
        <p>&copy; 2025 Artisan Alley. All rights reserved.</p>
        <a href="about.jsp">About Us</a>
        <a href="privacy">Privacy Policy</a>
    </div>
</body>
</html>
