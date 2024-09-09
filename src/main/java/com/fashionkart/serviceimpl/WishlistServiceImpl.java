package com.fashionkart.serviceimpl;

import com.fashionkart.entities.Product;
import com.fashionkart.entities.User;
import com.fashionkart.entities.Wishlist;
import com.fashionkart.repository.ProductRepository;
import com.fashionkart.repository.UserRepository;
import com.fashionkart.repository.WishlistRepository;
import com.fashionkart.repositoryimpl.ProductRepositoryImpl;
import com.fashionkart.repositoryimpl.UserRepositoryImpl;
import com.fashionkart.repositoryimpl.WishlistRepositoryImpl;
import com.fashionkart.service.WishlistService;
import org.hibernate.Hibernate;

import java.util.List;
import java.util.Optional;

public class WishlistServiceImpl implements WishlistService {
    private final WishlistRepository wishlistRepository = new WishlistRepositoryImpl();
    private final ProductRepository productRepository = new ProductRepositoryImpl();
    private final UserRepository userRepository = new UserRepositoryImpl();

    @Override
    public void addProductToWishlistofUser(Long userId, Long productId) {
       Wishlist wishlist = wishlistRepository.findByUserId(userId).orElseThrow(()-> new RuntimeException("Wishlist Not found for user with ID "+userId));
       wishlistRepository.addProductToWishlist(wishlist.getId(), productId);
    }

    @Override
    public List<Product> getWishlistProductByUser(Long userId, int page, int itemsPerPage) {
        int offset = (page - 1) * itemsPerPage;
        return wishlistRepository.findWishlistProductsByUserId(userId, offset, itemsPerPage);
    }

    @Override
    public long countProductsInWishList(Long userId) {
        return wishlistRepository.countWishlistProductsByUserId(userId);
    }
    @Override
    public void removeProductFromWishlist(Long wishlistId, Long productId) {
        wishlistRepository.removeProductFromWishlist(wishlistId, productId);
    }
}
