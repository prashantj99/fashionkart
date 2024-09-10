package com.fashionkart.servlets;

import com.fashionkart.entities.Token;
import com.fashionkart.entities.User;
import com.fashionkart.service.EmailService;
import com.fashionkart.service.UserService;
import com.fashionkart.serviceimpl.EmailServiceImpl;
import com.fashionkart.serviceimpl.UserServiceImpl;
import com.fashionkart.utils.TokenGenerator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Optional;

@WebServlet("/controller/recover-password")
public class RecoverPasswordServlet extends HttpServlet {

    private final UserService userService = new UserServiceImpl();
    private final EmailService emailService = new EmailServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        System.out.println(email);

        Optional<User> userOptional = userService.findByEmail(email);
        if (userOptional.isPresent()) {
            User user = userOptional.get();
            String tokenValue = TokenGenerator.generateToken();
            Token token = new Token();
            token.setToken(tokenValue);
            token.setUser(user);
            token.setExpiryDate(LocalDateTime.now().plusMinutes(15)); // Token valid for 15 min

            userService.saveToken(token);

            String resetLink = "http://localhost:8080/auth/forgot-password/reset-password?token=" + tokenValue;
            String message = "To reset your password, please click the link below:\n" + resetLink;

            if (emailService.sendRecoveryEmail(email, message)) {
                request.setAttribute("message", "Password reset link sent to your email.");
            } else {
                request.setAttribute("errorMessage", "Failed to send reset link. Please try again.");
            }
        } else {
            request.setAttribute("errorMessage", "No account found with the provided email.");
        }

        request.getRequestDispatcher("/auth/forgot-password/recover-password").forward(request, response);
    }
}
