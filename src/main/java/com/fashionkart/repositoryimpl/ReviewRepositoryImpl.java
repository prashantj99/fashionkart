package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.Review;
import com.fashionkart.repository.ReviewRepository;
import com.fashionkart.utils.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReviewRepositoryImpl implements ReviewRepository {

    @Override
    public Review save(Review review) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            if (review.getId() == null) {
                session.persist(review);
            } else {
                session.merge(review);
            }
            tx.commit();
            return review;
        }
    }

    @Override
    public List<Review> findByProductId(Long productId, int offset, int pageSize) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("SELECT r FROM Review r WHERE r.product.id = :productId", Review.class)
                    .setParameter("productId", productId)
                    .setFirstResult(offset)
                    .setMaxResults(pageSize)
                    .list();
        }
    }

    @Override
    public int totalReviewsByProduct(Long productId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Long count = session.createQuery("SELECT COUNT(r) FROM Review r WHERE r.product.id = :productId", Long.class)
                    .setParameter("productId", productId)
                    .uniqueResult();
            return count != null ? count.intValue() : 0;
        }
    }


    @Override
    public List<Review> findByUserId(Long userId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM Review WHERE user.id = :userId", Review.class)
                    .setParameter("userId", userId)
                    .list();
        }
    }

    @Override
    public void delete(Review review) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.remove(session.contains(review) ? review : session.merge(review));
            tx.commit();
        }
    }

    @Override
    public Map<Integer, Long> getRatingBreakdownForProduct(Long productId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Map<Integer, Long> ratingBreakdown = new HashMap<>();

            for (int i = 1; i <= 5; i++) {
                Query<Long> query = session.createQuery(
                        "SELECT COUNT(r) FROM Review r WHERE r.product.id = :productId AND r.rating = :rating", Long.class
                );
                query.setParameter("productId", productId);
                query.setParameter("rating", i);
                ratingBreakdown.put(i, query.uniqueResult());
            }

            return ratingBreakdown;
        }
    }

    @Override
    public double calculateOverallRatingForProduct(Long productId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Query<Double> query = session.createQuery(
                    "SELECT AVG(r.rating) FROM Review r WHERE r.product.id = :productId", Double.class
            );
            query.setParameter("productId", productId);
            Double avgRating = query.uniqueResult();
            return avgRating != null ? avgRating : 0.0;  // Handle null if no reviews exist
        }
    }

    @Override
    public boolean existsByUserIdAndProductId(long userId, long productId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery(
                    "SELECT COUNT(r) FROM Review r WHERE r.user.id = :userId AND r.product.id = :productId", Long.class
            );
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);
            Long count = query.uniqueResult();
            return count != null && count > 0;
        }
    }
}
