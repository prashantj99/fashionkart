package com.fashionkart.service;

public interface EmailService {
    boolean sendOtpEmail(String toEmail, String otp);

    boolean sendRecoveryEmail(String email, String recoveryLink);
}
