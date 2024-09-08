package com.fashionkart.repository;

import com.fashionkart.entities.Review;
import java.util.List;
import java.util.Map;

public interface ReviewRepository {
    Review save(Review review);
    List<Review> findByProductId(Long productId, int offset, int pageSize);
    int totalReviewsByProduct(Long productId);
    List<Review> findByUserId(Long userId);
    void delete(Review review);
    Map<Integer, Long> getRatingBreakdownForProduct(Long productId);
    double calculateOverallRatingForProduct(Long productId);
    boolean existsByUserIdAndProductId(long userId, long productId);
}
