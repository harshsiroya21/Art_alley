package com.artisanalley.servlet;

import com.artisanalley.dao.ProductDAO;
import com.artisanalley.model.Product;
import com.artisanalley.model.User;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CustomerDashboardServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"CUSTOMER".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }

        String searchQuery = request.getParameter("search");
        String shopName = request.getParameter("shop");
        List<Product> products;

        if (shopName != null && !shopName.trim().isEmpty()) {
            products = productDAO.getProductsByShopName(shopName.trim());
            request.setAttribute("currentShop", shopName.trim());
        } else if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            products = productDAO.searchProducts(searchQuery.trim());
        } else {
            products = productDAO.getAllProducts();
        }
        request.setAttribute("products", products);
        request.getRequestDispatcher("customerDashboard.jsp").forward(request, response);
    }
}
