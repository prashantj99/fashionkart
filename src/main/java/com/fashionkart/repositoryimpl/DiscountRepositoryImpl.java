package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.Discount;
import com.fashionkart.repository.DiscountRepository;
import com.fashionkart.utils.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.time.LocalDateTime;
import java.util.List;

public class DiscountRepositoryImpl implements DiscountRepository {

    @Override
    public void save(Discount discount) {
        Transaction transaction = null;
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.persist(discount);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw e;
        }
    }

    @Override
    public Discount findById(Long id) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.get(Discount.class, id);
        }
    }

    @Override
    public List<Discount> findAll() {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM Discount", Discount.class).list();
        }
    }

    @Override
    public void update(Discount discount) {
        Transaction transaction = null;
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.merge(discount);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw e;
        }
    }

    @Override
    public void delete(Long id) {
        Transaction transaction = null;
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Discount discount = session.get(Discount.class, id);
            if (discount != null) {
                session.remove(discount);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            throw e;
        }
    }

    @Override
    public List<Discount> findBySellerId(Long sellerId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM Discount WHERE seller.id = :sellerId", Discount.class)
                    .setParameter("sellerId", sellerId)
                    .list();
        }
    }

    @Override
    public List<Discount> findByCategoryId(Long categoryId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            String hql = "from Discount where applicableProductCategory.id = :categoryId " +
                    "and startDate <= :currentDate and endDate >= :currentDate";
            return session.createQuery(hql, Discount.class)
                    .setParameter("categoryId", categoryId)
                    .setParameter("currentDate", LocalDateTime.now())
                    .list();
        }
    }
}
