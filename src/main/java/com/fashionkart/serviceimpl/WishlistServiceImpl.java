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
    public void addProductToWishlist(Long userId, Long productId) {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found"));
        if (!wishlistRepository.isProductInWishlist(userId, productId)) {
            wishlistRepository.addProductToWishlist(user, product);
        }
    }

    @Override
    public List<Product> getWishlistProductByUser(Long userId, int page, int itemsPerPage) {
        int offset = (page - 1) * itemsPerPage;
        return wishlistRepository.findProductsByUserId(userId, offset, itemsPerPage);
    }

    @Override
    public long countProductsInWishList(Long userId) {
        return wishlistRepository.countWishlistProductsByUserId(userId);
    }
}
