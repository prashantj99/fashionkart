package com.fashionkart.servlets;

import com.fashionkart.entities.User;
import com.fashionkart.service.UserService;
import com.fashionkart.serviceimpl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/controller/user-login")
public class LoginServlet extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginType = request.getParameter("loginType");
        String username_or_email = request.getParameter("usernameoremail");
        String password = request.getParameter("password");

        Optional<User> userOptional = findUser(loginType, username_or_email, password);

        if (userOptional.isPresent()) {
            request.getSession().setAttribute("user", userOptional.get());
            if(userOptional.get().isAdmin()){
                response.sendRedirect("/admin/dashboard");
            }else
                response.sendRedirect("/index");
        } else {
            request.setAttribute("errorMessage", "Invalid username/email or password.");
            request.getRequestDispatcher("/auth/user/login").forward(request, response);
        }
    }

    private Optional<User> findUser(String loginType, String username_or_email, String password) {
        if ("username".equals(loginType)) {
            return userService.findByUsernameAndPassword(username_or_email, password);
        } else {
            return userService.findByEmailAndPassword(username_or_email, password);
        }
    }
}
