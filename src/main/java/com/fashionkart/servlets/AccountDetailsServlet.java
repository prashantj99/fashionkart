package com.fashionkart.servlets;

import com.fashionkart.entities.User;
import com.fashionkart.service.UserService;
import com.fashionkart.serviceimpl.UserServiceImpl;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/controller/account-details")
@Slf4j
public class AccountDetailsServlet extends HttpServlet {
    
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedInUser = (User) request.getSession().getAttribute("user");

        if (loggedInUser == null) {
            response.sendRedirect("/auth/user/login");
            return;
        }
        try{
            // Update account details
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String phoneNumber = request.getParameter("phoneNumber");

            loggedInUser.setFirstName(firstName);
            loggedInUser.setLastName(lastName);
            loggedInUser.setPhoneNumber(phoneNumber);

            userService.updateUser(loggedInUser);
            request.getSession().setAttribute("message", "Account updated successfully!");
        }catch (Exception e){
            log.error("Error {}", e.getMessage());
            request.getSession().setAttribute("errorMeaasge", "Failed to update account details!");
        }finally {
            response.sendRedirect("/user/account");
        }
    }
}
