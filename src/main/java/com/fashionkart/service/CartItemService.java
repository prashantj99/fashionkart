package com.fashionkart.service;

import com.fashionkart.entities.CartItem;
import com.fashionkart.entities.ProductSize;
import com.fashionkart.entities.User;

import java.util.List;
import java.util.Optional;

public interface CartItemService {
    CartItem saveCartItem(CartItem cartItem);
    void updateCartItem(Long userId, Long cartItemId, int requiredQuantity, ProductSize productSize);
    Optional<CartItem> findCartItemById(Long id);
    List<CartItem> findAllCartItemsByCartId(Long cartId);
    void deleteCartItem(CartItem cartItem);
}
