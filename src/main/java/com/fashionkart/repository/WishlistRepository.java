package com.fashionkart.repository;

import com.fashionkart.entities.Product;
import com.fashionkart.entities.User;
import com.fashionkart.entities.Wishlist;

import java.util.List;
import java.util.Optional;

public interface WishlistRepository {
    void save(Wishlist wishlist);
    void update(Wishlist wishlist);
    Optional<Wishlist> findByUserId(Long userId);
    boolean isProductInWishlist(Long userId, Long productId);
    void addProductToWishlist(User user, Product product);
    List<Product> findProductsByUserId(Long userId, int offset, int limit);
    long countWishlistProductsByUserId(Long userId);
}
