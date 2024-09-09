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
    void addProductToWishlist(Long wishlistId, Long productId);
    List<Product> findWishlistProductsByUserId(Long userId, int offset, int limit);
    long countWishlistProductsByUserId(Long userId);
    void removeProductFromWishlist(Long wishlistId, Long productId);
}
