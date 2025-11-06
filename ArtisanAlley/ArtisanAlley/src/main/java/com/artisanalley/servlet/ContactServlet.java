package com.artisanalley.servlet;

import com.artisanalley.dao.ContactDAO;
import com.artisanalley.model.ContactMessage;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class ContactServlet extends HttpServlet {

    private ContactDAO contactDAO;

    @Override
    public void init() throws ServletException {
        contactDAO = new ContactDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        if (name != null && email != null && message != null) {
            ContactMessage contactMessage = new ContactMessage(name, email, message);

            try {
                contactDAO.saveContactMessage(contactMessage);
                // Redirect back to contact page with success message
                response.sendRedirect("contact.jsp?success=true");
            } catch (SQLException e) {
                e.printStackTrace();
                // Redirect back to contact page with error message
                response.sendRedirect("contact.jsp?error=true");
            }
        } else {
            response.sendRedirect("contact.jsp?error=true");
        }
    }
}
