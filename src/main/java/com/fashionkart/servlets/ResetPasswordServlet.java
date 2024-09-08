package com.fashionkart.servlets;

import com.fashionkart.entities.Token;
import com.fashionkart.entities.User;
import com.fashionkart.service.UserService;
import com.fashionkart.serviceimpl.UserServiceImpl;
import com.fashionkart.utils.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Optional;

@WebServlet("/controller/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tokenValue = request.getParameter("token");
        String newPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (newPassword.equals(confirmPassword)) {
            Optional<Token> tokenOptional = userService.findTokenByValue(tokenValue);

            if (tokenOptional.isPresent()) {
                Token token = tokenOptional.get();
                if (token.getExpiryDate().isAfter(LocalDateTime.now())) {
                    User user = token.getUser();
                    user.setPassword(PasswordUtil.hashPassword(newPassword)); // store password in enc form
                    userService.registerUser(user);
                    userService.deleteToken(token); // Remove the token after use

                    request.setAttribute("message", "Password successfully reset. You can now log in with your new password.");
                    request.getRequestDispatcher("/auth/forgot-password/reset-password").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "The token has expired. Please request a new password reset.");
                    request.getRequestDispatcher("/auth/forgot-password/recover-password").forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "Invalid token. Please request a new password reset.");
                request.getRequestDispatcher("/auth/forgot-password/recover-password").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Passwords do not match. Please try again.");
            request.getRequestDispatcher("/auth/forgot-password/reset-password").forward(request, response);
        }
    }
}
