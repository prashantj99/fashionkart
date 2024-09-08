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
import org.hibernate.query.Query;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

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
            return Optional.ofNullable(wishlist);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Optional.empty();
    }

    @Override
    public boolean isProductInWishlist(Long userId, Long productId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery(
                    "SELECT COUNT(p) FROM Wishlist w JOIN w.products p WHERE w.user.id = :userId AND p.id = :productId",
                    Long.class);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);
            return query.uniqueResult() > 0;
        }
    }

    @Override
    public void addProductToWishlist(User user, Product product) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction transaction = session.beginTransaction();

            // Find the user's wishlist or create a new one
            Wishlist wishlist = findByUserId(user.getId()).orElseGet(() -> {
                Wishlist newWishlist = new Wishlist();
                newWishlist.setUser(user);
                session.persist(newWishlist);
                return newWishlist;
            });

            // Add the product to the wishlist
            wishlist.getProducts().add(product);
            session.merge(wishlist);

            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    public List<Product> findProductsByUserId(Long userId, int offset, int limit) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            String hql = "SELECT p FROM Wishlist w JOIN Product p WHERE w.user.id = :userId";
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
}
