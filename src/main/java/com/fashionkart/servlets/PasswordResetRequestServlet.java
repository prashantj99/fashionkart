package com.fashionkart.servlets;

import com.fashionkart.entities.Token;
import com.fashionkart.entities.User;
import com.fashionkart.service.EmailService;
import com.fashionkart.service.UserService;
import com.fashionkart.serviceimpl.EmailServiceImpl;
import com.fashionkart.serviceimpl.UserServiceImpl;
import com.fashionkart.utils.TokenGenerator;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/controller/request-password-reset")
@Slf4j
public class PasswordResetRequestServlet extends HttpServlet {

    private final EmailService emailService = new EmailServiceImpl();
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedInUser = (User) request.getSession().getAttribute("user");

        if (loggedInUser == null) {
            response.sendRedirect("/auth/user/login");
            return;
        }
        try{
            String tokenValue = TokenGenerator.generateToken();
            Token token = new Token();
            token.setToken(tokenValue);
            token.setUser(loggedInUser);
            token.setExpiryDate(LocalDateTime.now().plusMinutes(15)); // Token valid for 15 min
            userService.saveToken(token);

            String resetLink = "http://localhost:8080/auth/forgot-password/reset-password?token=" + tokenValue;
            String message = "To reset your password, please click the link below:\n" + resetLink;

            if (emailService.sendRecoveryEmail(loggedInUser.getEmail(), message)) {
                request.setAttribute("message", "Password reset link has been sent to your email.");
            } else {
                request.setAttribute("errorMessage", "Failed to send reset link. Please try again.");
            }
            request.getRequestDispatcher("/user/account").forward(request, response);
        }catch(Exception e){
            log.error("Error {}", e.getMessage());
            response.sendRedirect("/auth/user/login");
        }
    }
}
