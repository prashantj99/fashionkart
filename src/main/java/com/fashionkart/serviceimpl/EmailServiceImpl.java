package com.fashionkart.serviceimpl;

import com.fashionkart.service.EmailService;
import com.fashionkart.utils.ConfigUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailServiceImpl implements EmailService {

    private static final Logger logger = LoggerFactory.getLogger(EmailServiceImpl.class);

    private final String fromEmail = ConfigUtil.getProperty("fashionkart.email");
    private final String password = ConfigUtil.getProperty("fashionkart.password");

    @Override
    public boolean sendOtpEmail(String toEmail, String otp) {
        String subject = "Your OTP Code";
        String message = "Your OTP code is: " + otp;

        Session session = configureMail();

        try {
            createMsg(toEmail, subject, message, session);
            logger.info("OTP sent successfully to {}", toEmail);
            return true;
        } catch (MessagingException e) {
            logger.error("Failed to send OTP to {}: {}", toEmail, e.getMessage());
            return false;
        }
    }

    public boolean sendRecoveryEmail(String toEmail, String recoveryLink) {
        String subject = "Password Recovery Request";
        String message = "Please click the following link to reset your password: " + recoveryLink;

        Session session = configureMail();

        try {
            createMsg(toEmail, subject, message, session);
            logger.info("Password recovery email sent successfully to {}", toEmail);
            return true;
        } catch (MessagingException e) {
            logger.error("Failed to send password recovery email to {}: {}", toEmail, e.getMessage());
            return false;
        }
    }

    private void createMsg(String toEmail, String subject, String message, Session session) throws MessagingException {
        MimeMessage mimeMessage = new MimeMessage(session);
        mimeMessage.setFrom(new InternetAddress(fromEmail));
        mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
        mimeMessage.setSubject(subject);
        mimeMessage.setText(message);

        Transport.send(mimeMessage);
    }

    private Session configureMail() {
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.ssl.trust", "smtp.gmail.com");

        return Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });
    }
}
