package com.fashionkart.service;

import com.fashionkart.entities.Review;
import java.util.List;
import java.util.Map;

public interface ReviewService {
    Review addReview(String title, String content, int rating, long productId, long userId);
    List<Review> getReviewsByProductId(Long productId, int pageNumber, int pageSize);
    int getTotalReviewsCount(Long productId);
    List<Review> getReviewsByUserId(Long userId);
    Map<Integer, Long> getRatingBreakdownForProduct(Long productId);
    double calculateOverallRatingForProduct(Long productId);
    boolean isUserAllowedToGiveReview(long userId, long productId);
}
