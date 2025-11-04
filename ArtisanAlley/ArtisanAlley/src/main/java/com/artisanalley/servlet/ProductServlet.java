package com.artisanalley.servlet;

import com.artisanalley.dao.ProductDAO;
import com.artisanalley.model.Product;
import com.artisanalley.model.User;
import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@MultipartConfig
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("view".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(productId);
            request.setAttribute("product", product);
            request.getRequestDispatcher("productDetails.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.getProductById(productId);
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (product != null && product.getSellerId() == user.getId()) {
                request.setAttribute("product", product);
                request.getRequestDispatcher("editProduct.jsp").forward(request, response);
            } else {
                response.sendRedirect("sellerDashboard");
            }
        } else {
            // List all products
            request.getRequestDispatcher("productList.jsp").forward(request, response);
        }
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

        if ("add".equals(action)) {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));

            Product product = new Product(user.getId(), title, description, price);

            // Handle image upload if present
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                String fileName = imagePart.getSubmittedFileName();
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }
                String filePath = uploadPath + File.separator + fileName;
                imagePart.write(filePath);
                product.setImageUrl("uploads/" + fileName);
            }

            if (productDAO.addProduct(product)) {
                response.sendRedirect("sellerDashboard");
            } else {
                request.setAttribute("error", "Failed to add product");
                request.getRequestDispatcher("addProduct.jsp").forward(request, response);
            }
        } else if ("update".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            Product product = productDAO.getProductById(productId);

            if (product != null && product.getSellerId() == user.getId()) {
                product.setTitle(request.getParameter("title"));
                product.setDescription(request.getParameter("description"));
                product.setPrice(Double.parseDouble(request.getParameter("price")));

                // Handle image upload if present
                Part imagePart = request.getPart("image");
                if (imagePart != null && imagePart.getSize() > 0) {
                    String fileName = imagePart.getSubmittedFileName();
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdir();
                    }
                    String filePath = uploadPath + File.separator + fileName;
                    imagePart.write(filePath);
                    product.setImageUrl("uploads/" + fileName);
                } else {
                    // Keep existing image
                    product.setImageUrl(request.getParameter("currentImageUrl"));
                }

                productDAO.updateProduct(product);
                response.sendRedirect("sellerDashboard");
            }
        } else if ("delete".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            Product product = productDAO.getProductById(productId);

            if (product != null && product.getSellerId() == user.getId()) {
                productDAO.deleteProduct(productId);
                response.sendRedirect("sellerDashboard");
            }
        }
    }
}
