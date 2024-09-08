package com.fashionkart.repository;

import com.fashionkart.entities.Payment;

import java.util.List;
import java.util.Optional;

public interface PaymentRepository {
    Payment save(Payment payment);
    Optional<Payment> findById(Long id);
    List<Payment> findAll();
    void delete(Payment payment);
}
