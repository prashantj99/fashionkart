package com.fashionkart.servlets;

import com.fashionkart.entities.Brand;
import com.fashionkart.service.BrandService;
import com.fashionkart.serviceimpl.BrandServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/controller/brand-login")
public class LoginBrandServlet extends HttpServlet {

    private final BrandService brandService = new BrandServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        // Basic Validation
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            req.setAttribute("errorMessage", "Email and password are required.");
            req.getRequestDispatcher("/auth/brand/login").forward(req, resp);
            return;
        }

        try {
            Optional<Brand> brandOptional = brandService.authenticate(email, password);
            if (brandOptional.isPresent()) {
                req.getSession().setAttribute("brand", brandOptional.get());
                resp.sendRedirect("/auth/brand/dashboard");
            } else {
                req.setAttribute("errorMessage", "Invalid email or password");
                req.getRequestDispatcher("/auth/brand/login").forward(req, resp);
            }

        } catch (Exception e) {
            req.setAttribute("errorMessage", "An error occurred. Please try again.");
            req.getRequestDispatcher("/auth/brand/login").forward(req, resp);
        }
    }
}
