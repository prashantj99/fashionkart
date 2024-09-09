package com.fashionkart.service;

import com.fashionkart.entities.Product;

import java.util.List;

public interface WishlistService {
    void addProductToWishlistofUser(Long userId, Long productId);
    List<Product> getWishlistProductByUser(Long userId, int pageNumber, int pageSize);
    long countProductsInWishList(Long userId);
    void removeProductFromWishlist(Long userId, Long productId);
}
