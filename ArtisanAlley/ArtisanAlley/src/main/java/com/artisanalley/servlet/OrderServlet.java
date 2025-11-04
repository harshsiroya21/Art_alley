package com.artisanalley.servlet;

import com.artisanalley.dao.CartDAO;
import com.artisanalley.dao.OrderDAO;
import com.artisanalley.dao.ProductDAO;
import com.artisanalley.model.Cart;
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

public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    private CartDAO cartDAO = new CartDAO();
    private ProductDAO productDAO = new ProductDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        if ("history".equals(action)) {
            List<Order> orders = orderDAO.getOrdersByCustomer(user.getId());
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("orderHistory.jsp").forward(request, response);
        } else if ("cart".equals(action)) {
            List<Cart> cartItems = cartDAO.getCartByCustomer(user.getId());
            request.setAttribute("cartItems", cartItems);
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !"CUSTOMER".equals(user.getRole())) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        if ("addToCart".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));

            Cart cart = new Cart(user.getId(), productId, 1);
            cartDAO.addToCart(cart);
            response.sendRedirect(request.getContextPath() + "/customerDashboard");
        } else if ("placeOrder".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            Product product = productDAO.getProductById(productId);

            if (product != null) {
                double totalPrice = product.getPrice() * quantity;
                Order order = new Order(user.getId(), productId, quantity, totalPrice, user.getDeliveryAddress());

                if (orderDAO.placeOrder(order)) {
                    // Remove from cart if ordered from cart
                    Cart cartItem = cartDAO.getCartItem(user.getId(), productId);
                    if (cartItem != null) {
                        cartDAO.removeFromCart(cartItem.getId());
                    }
                    response.sendRedirect(request.getContextPath() + "/order?action=history");
                } else {
                    request.setAttribute("error", "Failed to place order");
                    request.getRequestDispatcher("customerDashboard").forward(request, response);
                }
            }
        } else if ("checkout".equals(action)) {
            // Checkout all items in cart
            List<Cart> cartItems = cartDAO.getCartByCustomer(user.getId());
            boolean allSuccess = true;

            for (Cart cart : cartItems) {
                Product product = productDAO.getProductById(cart.getProductId());
                if (product != null) {
                    double totalPrice = product.getPrice() * cart.getQuantity();
                    Order order = new Order(user.getId(), cart.getProductId(), cart.getQuantity(), totalPrice, user.getDeliveryAddress());
                    if (!orderDAO.placeOrder(order)) {
                        allSuccess = false;
                        break;
                    }
                }
            }

            if (allSuccess) {
                cartDAO.clearCart(user.getId());
                response.sendRedirect(request.getContextPath() + "/orderConfirmation.jsp");
            } else {
                request.setAttribute("error", "Failed to checkout some items");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            }
        } else if ("remove".equals(action)) {
            int cartId = Integer.parseInt(request.getParameter("cartId"));
            cartDAO.removeFromCart(cartId);
            response.sendRedirect(request.getContextPath() + "/order?action=cart");
        }
    }
}
