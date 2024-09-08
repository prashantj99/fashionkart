package com.fashionkart.repository;

import com.fashionkart.entities.Cart;
import com.fashionkart.entities.CartItem;

import java.util.Optional;

public interface CartRepository {
    Cart save(Cart cart);
    Optional<Cart> findById(Long id);
    Optional<Cart> findByUserId(Long userId);
    void delete(Cart cart);

    void clearCart(Cart cart);
}
