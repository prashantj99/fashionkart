package com.fashionkart.servlets;

import com.fashionkart.service.EmailService;
import com.fashionkart.serviceimpl.EmailServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Random;

@WebServlet("/controller/send-otp")
public class SendOtpServlet extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(SendOtpServlet.class);
    private final EmailService emailService = new EmailServiceImpl();
    private static final String OTP_SESSION_ATTRIBUTE = "otp";
    private static final String EMAIL_SESSION_ATTRIBUTE = "email";
    private static final String VERIFY_OTP_PAGE = "/WEB-INF/jsp/verify-otp.jsp";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        if (email == null || email.isEmpty()) {
            logger.error("Email address is missing in the request.");
            response.sendRedirect("/auth/forgot-password/recover-password");
            return;
        }

        String otp = generateOtp();
        logger.info("Generated OTP: {} for email: {}", otp, email);

        // Store OTP for verification
        request.getSession().setAttribute(OTP_SESSION_ATTRIBUTE, otp);
        request.getSession().setAttribute(EMAIL_SESSION_ATTRIBUTE, email);

        // Send OTP email
        try {
            emailService.sendOtpEmail(email, otp);
            logger.info("OTP email sent successfully to {}", email);
        } catch (Exception e) {
            logger.error("Failed to send OTP email to {}", email, e);
            response.sendRedirect("/error");
            return;
        }

        // Forward to OTP verification page
        request.getRequestDispatcher(VERIFY_OTP_PAGE).forward(request, response);
    }

    private String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // 6-digit OTP
        return String.valueOf(otp);
    }
}
