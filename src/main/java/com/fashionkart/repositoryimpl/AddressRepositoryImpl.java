package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.Address;
import com.fashionkart.entities.User;
import com.fashionkart.repository.AddressRepository;
import com.fashionkart.utils.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;
import java.util.Optional;

public class AddressRepositoryImpl implements AddressRepository {
    @Override
    public void save(Address address) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.persist(address);
            tx.commit();
        }
    }

    @Override
    public void update(Address address) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.merge(address);
            tx.commit();
        }
    }

    @Override
    public Optional<Address> findById(Long addressId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return Optional.of(session.get(Address.class, addressId));
        }
    }

    @Override
    public List<Address> findByUserId(Long userId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Query<Address> query = session.createQuery("FROM Address WHERE user.id = :userId", Address.class);
            query.setParameter("userId", userId);
            return query.list();
        }
    }
    @Override
    public void resetDefault(User user) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            Query<?> query = session.createQuery("UPDATE Address SET isDefault = false WHERE user = :user AND isDefault = true");
            query.setParameter("user", user);
            query.executeUpdate();
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
