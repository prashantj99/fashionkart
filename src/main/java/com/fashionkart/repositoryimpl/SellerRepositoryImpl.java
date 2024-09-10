package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.Seller;
import com.fashionkart.repository.SellerRepository;
import com.fashionkart.utils.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.time.LocalDate;
import java.time.YearMonth;
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

    @Override
    public List<Seller> findPaginated(int offset, int pageSize) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Query<Seller> query = session.createQuery("FROM Seller", Seller.class);
            query.setFirstResult(offset * pageSize);
            query.setMaxResults(pageSize);
            return query.list();
        }
    }

    @Override
    public long countSellers() {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            String hql = "SELECT COUNT(*) FROM Seller";
            Query<Long> query = session.createQuery(hql, Long.class);
            return query.uniqueResult();
        }
    }
    @Override
    public long sellersRegisteredInMonth(int monthsAgo) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            YearMonth targetMonth = YearMonth.now().minusMonths(monthsAgo);
            LocalDate startOfMonth = targetMonth.atDay(1);
            LocalDate endOfMonth = targetMonth.atEndOfMonth();

            // Query to count sellers registered in the target month
            Long count = session.createQuery(
                            "SELECT COUNT(s) FROM Seller s WHERE s.registeredOn BETWEEN :start AND :end", Long.class)
                    .setParameter("start", startOfMonth.atStartOfDay())
                    .setParameter("end", endOfMonth.atStartOfDay())
                    .getSingleResult();

            return count != null ? count : 0;
        }
    }
}
