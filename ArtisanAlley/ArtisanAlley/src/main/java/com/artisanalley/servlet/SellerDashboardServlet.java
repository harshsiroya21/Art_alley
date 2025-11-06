package com.artisanalley.servlet;

import com.artisanalley.dao.OrderDAO;
import com.artisanalley.dao.ProductDAO;
import com.artisanalley.model.Order;
import com.artisanalley.model.Product;
import com.artisanalley.model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class SellerDashboardServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    private OrderDAO orderDAO = new OrderDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"SELLER".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }

        List<Product> products = productDAO.getProductsBySeller(user.getId());
        List<Order> orders = orderDAO.getOrdersBySeller(user.getId());
        request.setAttribute("products", products);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("sellerDashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"SELLER".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        String orderIdStr = request.getParameter("orderId");

        if (action != null && orderIdStr != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                if ("accept".equals(action)) {
                    orderDAO.updateOrderStatus(orderId, "PROCESSING");
                } else if ("reject".equals(action)) {
                    orderDAO.updateOrderStatus(orderId, "CANCELED");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("sellerDashboard");
    }
}
