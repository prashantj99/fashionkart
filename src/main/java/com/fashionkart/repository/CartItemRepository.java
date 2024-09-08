package com.fashionkart.repository;

import com.fashionkart.entities.Cart;
import com.fashionkart.entities.CartItem;
import com.fashionkart.entities.Product;

import java.util.List;
import java.util.Optional;

public interface CartItemRepository {
    CartItem save(CartItem cartItem);
    void update(CartItem cartItem);
    Optional<CartItem> findById(Long id);
    List<CartItem> findAllByCartId(Long cartId);
    void delete(CartItem cartItem);
    Optional<CartItem> getByCartAndProduct(Long cartId, Long productId);
}
