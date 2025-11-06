package com.artisanalley.servlet;

import com.artisanalley.dao.OrderDAO;
import com.artisanalley.model.Order;
import com.artisanalley.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/sellerOrders")
public class SellerOrdersServlet extends HttpServlet {
    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"SELLER".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }

        List<Order> orders = orderDAO.getOrdersBySeller(user.getId());
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("sellerOrders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"SELLER".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");
        int orderId = Integer.parseInt(request.getParameter("orderId"));

        if ("accept".equals(action)) {
            orderDAO.updateOrderStatus(orderId, "PROCESSING");
        } else if ("reject".equals(action)) {
            orderDAO.updateOrderStatus(orderId, "CANCELED");
        }

        response.sendRedirect("sellerOrders");
    }
}
