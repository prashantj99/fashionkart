package com.fashionkart.service;

import com.fashionkart.entities.Payment;

import java.util.List;

public interface PaymentService {
    Payment processPayment(Payment payment);
    Payment getPaymentById(Long id);
    List<Payment> getAllPayments();
}
