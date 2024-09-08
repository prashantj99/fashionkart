package com.fashionkart.serviceimpl;

import com.fashionkart.entities.Product;
import com.fashionkart.entities.Review;
import com.fashionkart.entities.User;
import com.fashionkart.repository.OrderRepository;
import com.fashionkart.repository.ProductRepository;
import com.fashionkart.repository.ReviewRepository;
import com.fashionkart.repository.UserRepository;
import com.fashionkart.repositoryimpl.OrderRepositoryImpl;
import com.fashionkart.repositoryimpl.ProductRepositoryImpl;
import com.fashionkart.repositoryimpl.ReviewRepositoryImpl;
import com.fashionkart.repositoryimpl.UserRepositoryImpl;
import com.fashionkart.service.ReviewService;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

public class ReviewServiceImpl implements ReviewService {

    private final ReviewRepository reviewRepository = new ReviewRepositoryImpl();
    private final UserRepository userRepository = new UserRepositoryImpl();
    private final ProductRepository productRepository = new ProductRepositoryImpl();
    private final OrderRepository orderRepository = new OrderRepositoryImpl();

    @Override
    public Review addReview(String title, String content, int rating, long productId, long userId) {
        // Fetch the user
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User Not Found!!"));

        // Fetch the product
        Product product = productRepository.findById(productId).orElseThrow(() -> new RuntimeException("Product Not Found!!"));

        // Check if the user has purchased the product
        boolean hasPurchased = orderRepository.existsByUserIdAndProductId(userId, productId);
        if (!hasPurchased) {
            throw new RuntimeException("You can only review products that you have purchased.");
        }

        // Check if the user has already reviewed the product
        boolean alreadyReviewed = reviewRepository.existsByUserIdAndProductId(userId, productId);
        if (alreadyReviewed) {
            throw new RuntimeException("You have already reviewed this product.");
        }

        // Create and save the review
        Review review = new Review();
        review.setTitle(title);
        review.setContent(content);
        review.setRating(rating);
        review.setProduct(product);
        review.setUser(user);
        review.setReviewDate(LocalDate.now());

        return reviewRepository.save(review);
    }


    @Override
    public List<Review> getReviewsByProductId(Long productId, int pageNumber, int pageSize) {
        int offset = (pageNumber-1) * pageSize;
        return reviewRepository.findByProductId(productId, offset, pageSize);
    }

    @Override
    public int getTotalReviewsCount(Long productId) {
        return reviewRepository.totalReviewsByProduct(productId);
    }

    @Override
    public List<Review> getReviewsByUserId(Long userId) {
        return reviewRepository.findByUserId(userId);
    }

    @Override
    public Map<Integer, Long> getRatingBreakdownForProduct(Long productId) {
        return reviewRepository.getRatingBreakdownForProduct(productId);
    }

    @Override
    public double calculateOverallRatingForProduct(Long productId) {
        return reviewRepository.calculateOverallRatingForProduct(productId);
    }

    @Override
    public boolean isUserAllowedToGiveReview(long userId, long productId) {
        return !reviewRepository.existsByUserIdAndProductId(userId, productId)
                && orderRepository.existsByUserIdAndProductId(userId, productId);
    }
}
