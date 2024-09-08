package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.Payment;
import com.fashionkart.repository.PaymentRepository;
import com.fashionkart.utils.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;
import java.util.Optional;

public class PaymentRepositoryImpl implements PaymentRepository {
    @Override
    public Payment save(Payment payment) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.saveOrUpdate(payment);
            tx.commit();
            return payment;
        }
    }

    @Override
    public Optional<Payment> findById(Long id) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return Optional.ofNullable(session.get(Payment.class, id));
        }
    }

    @Override
    public List<Payment> findAll() {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM Payment", Payment.class).list();
        }
    }

    @Override
    public void delete(Payment payment) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.delete(payment);
            tx.commit();
        }
    }
}
