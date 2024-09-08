package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.Seller;
import com.fashionkart.repository.SellerRepository;
import com.fashionkart.utils.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;
import java.util.Optional;

public class SellerRepositoryImpl implements SellerRepository {

    @Override
    public Seller save(Seller seller) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            if (seller.getId() == null) {
                session.persist(seller);
            } else {
                session.merge(seller);
            }
            tx.commit();
            return seller;
        }
    }

    @Override
    public Optional<Seller> findById(Long id) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return Optional.ofNullable(session.find(Seller.class, id));
        }
    }

    @Override
    public List<Seller> findAll() {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM Seller", Seller.class).list();
        }
    }

    @Override
    public void deleteById(Long id) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            Seller seller = session.find(Seller.class, id);
            if (seller != null) {
                session.remove(seller);
            }
            tx.commit();
        }
    }

    @Override
    public Optional<Seller> findByEmail(String email) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            String hql = "FROM Seller WHERE email = :email";
            Query<Seller> query = session.createQuery(hql, Seller.class);
            query.setParameter("email", email);
            return Optional.ofNullable(query.uniqueResult());
        }
    }
}
