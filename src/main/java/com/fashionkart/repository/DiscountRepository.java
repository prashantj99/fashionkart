package com.fashionkart.repository;

import com.fashionkart.entities.Discount;

import java.util.List;
import java.util.Optional;

public interface DiscountRepository {
    void save(Discount discount);
    Discount findById(Long id);
    List<Discount> findAll();
    void update(Discount discount);
    void delete(Long id);
    List<Discount> findBySellerId(Long sellerId);
    List<Discount> findByCategoryId(Long categoryId);
}
