package com.fashionkart.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/controller/verify-otp")
public class VerifyOtpServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String enteredOtp = request.getParameter("otp");
        HttpSession session = request.getSession();
        String storedOtp = (String) session.getAttribute("otp");
        String email = request.getParameter("email");

        if (enteredOtp != null && !enteredOtp.equals(storedOtp)) {
            System.out.println(email);
            response.sendRedirect("/auth/user/register/details?email=" + email);
        } else {
            request.setAttribute("errorMessage", "Invalid OTP. Please try again.");
            request.getRequestDispatcher("/auth/user/register/verify-otp?email=" + email).forward(request, response);
        }
    }
}
