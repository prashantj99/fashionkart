package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.Cart;
import com.fashionkart.entities.CartItem;
import com.fashionkart.entities.Product;
import com.fashionkart.repository.CartItemRepository;
import com.fashionkart.utils.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;
import java.util.Optional;

public class CartItemRepositoryImpl implements CartItemRepository {

    @Override
    public CartItem save(CartItem cartItem) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.persist(cartItem);
            tx.commit();
            return cartItem;
        }
    }

    @Override
    public void update(CartItem cartItem) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.merge(cartItem);
            tx.commit();
        }
    }


    @Override
    public Optional<CartItem> findById(Long id) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return Optional.ofNullable(session.get(CartItem.class, id));
        }
    }

    @Override
    public List<CartItem> findAllByCartId(Long cartId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM CartItem WHERE cart.id = :cartId", CartItem.class)
                    .setParameter("cartId", cartId)
                    .list();
        }
    }

    @Override
    public void delete(CartItem cartItem) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.remove(cartItem);
            tx.commit();
        }
    }

    @Override
    public Optional<CartItem> getByCartAndProduct(Long cartId, Long productId) {
        try(Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction transaction = session.beginTransaction();
            Query<CartItem> query = session.createQuery(
                    "SELECT c FROM CartItem c WHERE c.product.id = :productId AND c.cart.id = :cartId",
                    CartItem.class
            );
            query.setParameter("productId", productId);
            query.setParameter("cartId", cartId);
            CartItem cartItem = query.uniqueResult();
            transaction.commit();
            return Optional.of(cartItem);
        }
    }
}
