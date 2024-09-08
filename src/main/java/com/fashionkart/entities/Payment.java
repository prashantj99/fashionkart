package com.fashionkart.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Payment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_order_id", nullable = false)
    private UserOrder userOrder;

    private String paymentMethod; // "Credit Card", "Debit Card", "Net Banking", etc.
    private LocalDateTime paymentDate;
    private double amount;
    private String paymentStatus; // "Success", "Failed"
}
