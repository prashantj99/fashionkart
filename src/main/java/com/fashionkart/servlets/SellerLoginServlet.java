package com.fashionkart.servlets;

import com.fashionkart.service.SellerService;
import com.fashionkart.serviceimpl.SellerServiceImpl;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/controller/seller-login")
@Slf4j
public class SellerLoginServlet extends HttpServlet {

    private final SellerService sellerService = new SellerServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            if (email == null || password == null) {
                throw new IllegalArgumentException("Email and password must be provided.");
            }

            boolean isAuthenticated = sellerService.authenticate(email, password);

            if (isAuthenticated) {
                HttpSession session = request.getSession();
                session.setAttribute("sellerEmail", email);
                response.sendRedirect("/sellers/dashboard");
                session.setAttribute("seller", sellerService.getByEmail(email));
            } else {
                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher("/auth/sellers/login").forward(request, response);
            }
        } catch (Exception e) {
            log.error("Error during login", e);
            request.setAttribute("errorMessage", "Login failed. Please try again.");
            request.getRequestDispatcher("/auth/sellers/login").forward(request, response);
        }
    }
}
