package com.artisanalley.servlet;

import com.artisanalley.dao.ContactDAO;
import com.artisanalley.dao.OrderDAO;
import com.artisanalley.dao.ProductDAO;
import com.artisanalley.dao.UserDAO;
import com.artisanalley.model.ContactMessage;
import com.artisanalley.model.Order;
import com.artisanalley.model.Product;
import com.artisanalley.model.User;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AdminDashboardServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private ProductDAO productDAO = new ProductDAO();
    private OrderDAO orderDAO = new OrderDAO();
    private ContactDAO contactDAO = new ContactDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }

        List<User> users = userDAO.getAllUsers();
        List<Product> pendingProducts = productDAO.getPendingProducts();
        List<Product> allProducts = productDAO.getAllProducts();
        List<Order> orders = orderDAO.getAllOrders();

        List<ContactMessage> contactMessages = null;
        try {
            contactMessages = contactDAO.getAllContactMessages();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle error, perhaps set to empty list
            contactMessages = new java.util.ArrayList<>();
        }

        request.setAttribute("users", users);
        request.setAttribute("pendingProducts", pendingProducts);
        request.setAttribute("allProducts", allProducts);
        request.setAttribute("orders", orders);
        request.setAttribute("contactMessages", contactMessages);
        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("approveProduct".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            Product product = productDAO.getProductById(productId);
            if (product != null) {
                product.setStatus("ACTIVE");
                productDAO.updateProduct(product);
            }
        } else if ("rejectProduct".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            Product product = productDAO.getProductById(productId);
            if (product != null) {
                product.setStatus("REJECTED");
                productDAO.updateProduct(product);
            }
        } else if ("updateOrderStatus".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");

            // Get the order to find the product
            Order order = orderDAO.getOrderById(orderId);
            if (order != null) {
                Product product = productDAO.getProductById(order.getProductId());
                if (product != null) {
                    if ("PROCESSING".equals(status) || "OUT_FOR_DELIVERY".equals(status)) {
                        // Mark product as not available
                        product.setStatus("SOLD_OUT");
                        productDAO.updateProduct(product);
                    } else if ("COMPLETED".equals(status)) {
                        // Remove product completely (delete from database)
                        productDAO.deleteProduct(product.getId());
                    } else if ("CANCELED".equals(status)) {
                        // Make product available again
                        product.setStatus("ACTIVE");
                        productDAO.updateProduct(product);
                    }
                }
            }

            orderDAO.updateOrderStatus(orderId, status);
        } else if ("deleteProduct".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            productDAO.deleteProduct(productId);
        } else if ("deleteUser".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            userDAO.deleteUser(userId);
        } else if ("deleteContactMessage".equals(action)) {
            int messageId = Integer.parseInt(request.getParameter("messageId"));
            try {
                contactDAO.deleteContactMessage(messageId);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("adminDashboard");
    }
}
