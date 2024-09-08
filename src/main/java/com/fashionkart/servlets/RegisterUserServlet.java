package com.fashionkart.servlets;

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
import java.time.LocalDate;

@WebServlet("/controller/user-register")
public class RegisterUserServlet extends HttpServlet {
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phoneNumber = request.getParameter("phoneNumber");
        String gender = request.getParameter("gender");
        String dateOfBirthString = request.getParameter("dateOfBirth");

        LocalDate dateOfBirth = LocalDate.parse(dateOfBirthString);

        // Validate username
        if (userService.isUsernameTaken(username)) {
            request.setAttribute("errorMessage", "Username already taken. Please choose another.");
            request.getRequestDispatcher("/auth/user/register/details?email=" + email).forward(request, response);
            return;
        }

        // Create and save user
        User user = new User();
        user.setUsername(username);
        user.setPassword(PasswordUtil.hashPassword(password));
        user.setEmail(email);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setPhoneNumber(phoneNumber);
        user.setGender(gender);
        user.setDateOfBirth(dateOfBirth);

        userService.registerUser(user);

        // Redirect to a login page
        response.sendRedirect("/auth/user/login");
    }
}
