package com.fashionkart.servlets;

import com.fashionkart.entities.Seller;
import com.fashionkart.service.SellerService;
import com.fashionkart.serviceimpl.SellerServiceImpl;
import com.fashionkart.utils.PasswordUtil;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.regex.Pattern;

@WebServlet("/controller/seller-register")
@Slf4j
public class SellerRegistrationServlet extends HttpServlet {

    private final SellerService sellerService = new SellerServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve parameters from request
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phoneNumber = request.getParameter("phoneNumber");
            String businessName = request.getParameter("businessName");
            String description = request.getParameter("description");
            String businessAddress = request.getParameter("businessAddress");
            String supportEmail = request.getParameter("supportEmail");
            String supportContact = request.getParameter("supportContact");

            // Validate input
            validateInput(name, email, password, phoneNumber, businessName, description, businessAddress, supportEmail, supportContact);

            // Create Seller object and set attributes
            Seller seller = new Seller();
            seller.setName(name);
            seller.setEmail(email);
            seller.setPassword(PasswordUtil.hashPassword(password));
            seller.setPhoneNumber(phoneNumber);
            seller.setBusinessName(businessName);
            seller.setDescription(description);
            seller.setBusinessAddress(businessAddress);
            seller.setSupportEmail(supportEmail);
            seller.setSupportContact(supportContact);
            seller.setRegisteredOn(LocalDateTime.now());

            // Save seller to the database
            sellerService.saveSeller(seller);

            // Redirect to login page
            response.sendRedirect("/auth/sellers/login");
        } catch (IllegalArgumentException e) {
            log.error("Validation error: {}", e.getMessage());
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/auth/sellers/register").forward(request, response);
        } catch (Exception e) {
            log.error("Error registering seller", e);
            request.setAttribute("errorMessage", "Failed to register seller. Please try again.");
            request.getRequestDispatcher("/auth/sellers/register").forward(request, response);
        }
    }

    private void validateInput(String name, String email, String password, String phoneNumber, String businessName,
                               String description, String businessAddress, String supportEmail, String supportContact) {
        if (name == null || name.isEmpty() ||
                email == null || email.isEmpty() || !isValidEmail(email) ||
                password == null || password.isEmpty() ||
                phoneNumber == null || phoneNumber.isEmpty() || !isValidPhoneNumber(phoneNumber) ||
                businessName == null || businessName.isEmpty() ||
                description == null || description.isEmpty() ||
                businessAddress == null || businessAddress.isEmpty() ||
                supportEmail == null || supportEmail.isEmpty() || !isValidEmail(supportEmail) ||
                supportContact == null || supportContact.isEmpty()) {
            throw new IllegalArgumentException("Please fill out all fields correctly.");
        }
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return Pattern.compile(emailRegex).matcher(email).matches();
    }

    private boolean isValidPhoneNumber(String phoneNumber) {
        String phoneRegex = "^\\+?[0-9]{10,15}$";
        return Pattern.compile(phoneRegex).matcher(phoneNumber).matches();
    }
}
