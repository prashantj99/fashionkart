package com.fashionkart.service;

import com.fashionkart.entities.*;

import java.util.Optional;

public interface CartService {
    Cart addItemToCart(Cart cart, CartItem item);
    Cart getCartByUser(User user);
    Cart getCartByUser(Long userId);
    void addProductToCart(Long userId, Long productId, int quantity, ProductSize selectProductSize);
    double calculateCartTotalWithBestDiscount(Cart cart);
}
