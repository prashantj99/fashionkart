package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.Product;
import com.fashionkart.entities.User;
import com.fashionkart.entities.Wishlist;
import com.fashionkart.repository.WishlistRepository;
import com.fashionkart.utils.FactoryProvider;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;
import org.hibernate.query.Query;

import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
public class WishlistRepositoryImpl implements WishlistRepository {

    @Override
    public void save(Wishlist wishlist) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            session.persist(wishlist);
            transaction.commit();
        }
    }

    @Override
    public void update(Wishlist wishlist) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            session.merge(wishlist);
            transaction.commit();
        }
    }

    @Override
    public Optional<Wishlist> findByUserId(Long userId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Wishlist wishlist = session.createQuery("FROM Wishlist w WHERE w.user.id = :userId", Wishlist.class)
                    .setParameter("userId", userId)
                    .uniqueResult();
            Hibernate.initialize(wishlist.getProducts());
            return Optional.of(wishlist);
        }
    }

    @Override
    public void addProductToWishlist(Long wishlistId, Long productId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction transaction = session.beginTransaction();

            // Load or create the wishlist for the user
            Wishlist wishlist = session.get(Wishlist.class, wishlistId);
            Hibernate.initialize(wishlist.getProducts());

            Product product = session.get(Product.class, productId);
            Hibernate.initialize(product.getWishlists());

            // Check if the product is already in the wishlist to avoid duplicates
            boolean isAlreadyExist = wishlist.getProducts().stream().anyMatch(product1 -> product1.getId().equals(productId));
            if (!isAlreadyExist) {
                wishlist.getProducts().add(product);
                product.getWishlists().add(wishlist);
                session.merge(wishlist);
                session.merge(product);
            }
            transaction.commit();
        }
    }

    @Override
    public List<Product> findWishlistProductsByUserId(Long userId, int offset, int limit) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            String hql = "SELECT p FROM Wishlist w JOIN w.products p WHERE w.user.id = :userId";
            Query<Product> query = session.createQuery(hql, Product.class)
                    .setParameter("userId", userId)
                    .setFirstResult(offset)
                    .setMaxResults(limit);
            return query.list();
        }
    }

    @Override
    public long countWishlistProductsByUserId(Long userId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            String hql = "SELECT COUNT(w) FROM Wishlist w WHERE w.user.id = :userId";
            Query<Long> query = session.createQuery(hql, Long.class)
                    .setParameter("userId", userId);
            return query.uniqueResult();
        }
    }

    @Override
    public void removeProductFromWishlist(Long wishlistId, Long productId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction transaction = session.beginTransaction();

            Product product = session.get(Product.class, productId);
            Hibernate.initialize(product.getWishlists());

            Wishlist wishlist = session.get(Wishlist.class, wishlistId);
            Hibernate.initialize(wishlist.getProducts());

            product.getWishlists().remove(wishlist);
            wishlist.getProducts().remove(product);

            session.merge(product);
            session.merge(wishlist);

            session.flush();
            transaction.commit();
        }
    }





}
