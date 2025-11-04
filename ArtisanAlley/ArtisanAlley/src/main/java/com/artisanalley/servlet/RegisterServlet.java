package com.artisanalley.servlet;

import com.artisanalley.dao.UserDAO;
import com.artisanalley.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String deliveryAddress = request.getParameter("deliveryAddress");
        String shopName = request.getParameter("shopName");
        String contactInfo = request.getParameter("contactInfo");

        User user = new User(name, email, password, role);
        user.setDeliveryAddress(deliveryAddress);
        user.setShopName(shopName);
        user.setContactInfo(contactInfo);

        if (userDAO.register(user)) {
            request.setAttribute("success", "Registration successful! Please login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Email might already exist.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}
