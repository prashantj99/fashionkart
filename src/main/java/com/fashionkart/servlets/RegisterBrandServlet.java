package com.fashionkart.servlets;

import com.fashionkart.entities.Brand;
import com.fashionkart.service.BrandService;
import com.fashionkart.serviceimpl.BrandServiceImpl;
import com.fashionkart.utils.PasswordUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/controller/brand-register")
public class RegisterBrandServlet extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(RegisterBrandServlet.class);
    private final BrandService brandService = new BrandServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("brandName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String description = request.getParameter("description");
        String logoUrl = request.getParameter("logoUrl");
        String contactNumber = request.getParameter("contactNumber");
        String websiteUrl = request.getParameter("websiteUrl");
        String facebookUrl = request.getParameter("facebookUrl");
        String instagramUrl = request.getParameter("instagramUrl");
        String twitterUrl = request.getParameter("twitterUrl");

        // Basic Validation
        if (name == null || name.isEmpty() ||
                email == null || email.isEmpty() ||
                password == null || password.isEmpty()) {
            request.setAttribute("errorMessage", "Brand name, email, and password are required.");
            request.getRequestDispatcher("/auth/brand/register").forward(request, response);
            return;
        }

        // Check if email already exists
        if (this.brandService.findByEmail(email).isPresent()) {
            request.setAttribute("errorMessage", "Email is already registered.");
            request.getRequestDispatcher("/auth/brand/register").forward(request, response);
            return;
        }

        // Create and populate Brand object
        Brand brand = new Brand();
        brand.setName(name);
        brand.setEmail(email);
        brand.setPassword(PasswordUtil.hashPassword(password));
        brand.setDescription(description);
        brand.setLogoUrl(logoUrl);
        brand.setContactNumber(contactNumber);
        brand.setWebsiteUrl(websiteUrl);
        brand.setFacebookUrl(facebookUrl);
        brand.setInstagramUrl(instagramUrl);
        brand.setTwitterUrl(twitterUrl);

        try {
            brandService.save(brand);
            response.sendRedirect("/auth/brand/dashboard");
        } catch (Exception e) {
            logger.error("An error occurred while registering the brand.", e);
            request.setAttribute("errorMessage", "An error occurred while registering the brand. Please try again.");
            request.getRequestDispatcher("/auth/brand/register").forward(request, response);
        }
    }
}
