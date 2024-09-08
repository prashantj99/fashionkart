package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.Cart;
import com.fashionkart.entities.CartItem;
import com.fashionkart.repository.CartRepository;
import com.fashionkart.utils.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.Optional;

public class CartRepositoryImpl implements CartRepository {
    @Override
    public Cart save(Cart cart) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.saveOrUpdate(cart);
            tx.commit();
            return cart;
        }
    }

    @Override
    public Optional<Cart> findById(Long id) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return Optional.ofNullable(session.get(Cart.class, id));
        }
    }

    @Override
    public Optional<Cart> findByUserId(Long userId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM Cart WHERE user.id = :userId", Cart.class)
                    .setParameter("userId", userId)
                    .uniqueResultOptional();
        }
    }

    @Override
    public void delete(Cart cart) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.remove(cart);
            tx.commit();
        }
    }

    @Override
    public void clearCart(Cart cart) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            Query<?> query = session.createQuery("DELETE FROM CartItem WHERE cart.id = :cartId");
            query.setParameter("cartId", cart.getId());
            query.executeUpdate();
            tx.commit();
        }
    }
}
