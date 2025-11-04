package com.artisanalley.servlet;

import com.artisanalley.dao.UserDAO;
import com.artisanalley.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        // Update user profile
        String name = request.getParameter("name");
        String deliveryAddress = request.getParameter("deliveryAddress");
        String shopName = request.getParameter("shopName");
        String contactInfo = request.getParameter("contactInfo");

        if (name != null && !name.trim().isEmpty()) {
            user.setName(name.trim());
        }
        if (deliveryAddress != null) {
            user.setDeliveryAddress(deliveryAddress);
        }
        if (shopName != null) {
            user.setShopName(shopName);
        }
        if (contactInfo != null) {
            user.setContactInfo(contactInfo);
        }

        boolean updated = userDAO.updateUser(user);
        if (updated) {
            session.setAttribute("user", user);
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile.");
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
