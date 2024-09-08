package com.fashionkart.service;

import com.fashionkart.entities.Category;
import com.fashionkart.entities.Discount;

import java.util.List;

public interface DiscountService {
    void saveDiscount(Discount discount);
    Discount getDiscountById(Long id);
    List<Discount> getAllDiscounts();
    void updateDiscount(Discount discount);
    void deleteDiscount(Long id);
    List<Discount> getDiscountsBySeller(Long sellerId);
    void addDiscount(Discount discount, Long sellerId, Long categoryId) throws Exception;
    boolean isDiscountOwnedBySeller(Long discountId, Long sellerId);
    Discount getBestDiscountForProduct(Long productId);
}
