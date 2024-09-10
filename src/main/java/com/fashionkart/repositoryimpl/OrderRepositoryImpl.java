package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.User;
import com.fashionkart.entities.UserOrder;
import com.fashionkart.repository.OrderRepository;
import com.fashionkart.utils.FactoryProvider;
import org.apache.commons.lang3.tuple.Pair;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

public class OrderRepositoryImpl implements OrderRepository {

    @Override
    public UserOrder save(UserOrder userOrder) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.persist(userOrder);
            tx.commit();
            return userOrder;
        }
    }

    @Override
    public UserOrder update(UserOrder userOrder) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.merge(userOrder);
            tx.commit();
            return userOrder;
        }
    }

    @Override
    public Optional<UserOrder> findById(Long id) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return Optional.ofNullable(session.get(UserOrder.class, id));
        }
    }

    @Override
    public List<UserOrder> findAll() {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM UserOrder", UserOrder.class).list();
        }
    }

    @Override
    public List<UserOrder> findWhereUserEmailIs(String userEmail) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Query<UserOrder> query = session.createQuery(
                    "SELECT uo FROM UserOrder uo WHERE uo.user.email = :userEmail ORDER BY uo.orderDate DESC", UserOrder.class
            );
            query.setParameter("userEmail", userEmail);
            return query.list();
        }
    }

    @Override
    public List<UserOrder> findWhereStatusIs(String status) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Query<UserOrder> query = session.createQuery(
                    "SELECT uo FROM UserOrder uo WHERE uo.status = :status ORDER BY uo.orderDate DESC", UserOrder.class
            );
            query.setParameter("status", status);
            return query.list();
        }
    }

    @Override
    public List<UserOrder> findByMonthsAgo(int monthsAgo) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            LocalDate monthsAgoDate = LocalDate.now().minusMonths(monthsAgo);
            Query<UserOrder> query = session.createQuery(
                    "SELECT uo FROM UserOrder uo WHERE uo.orderDate >= :monthsAgoDate ORDER BY uo.orderDate DESC", UserOrder.class
            );
            query.setParameter("monthsAgoDate", monthsAgoDate.atStartOfDay());
            return query.list();
        }
    }

    @Override
    public void delete(UserOrder userOrder) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.remove(userOrder);
            tx.commit();
        }
    }

    @Override
    public Map.Entry<List<UserOrder>, Long> filteredOrders(Long userId, String searchQuery, String status, Long monthsAgo, int pageNumber, int pageSize) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            StringBuilder hql = new StringBuilder("FROM UserOrder uo JOIN uo.orderItems oi JOIN oi.product p WHERE uo.user.id = :userId");

            if (searchQuery != null && !searchQuery.isEmpty()) {
                hql.append(" AND (p.name LIKE :searchQuery")
                        .append(" OR p.description LIKE :searchQuery")
                        .append(" OR oi.quantity LIKE :searchQuery")
                        .append(" OR p.brand.name LIKE :searchQuery")
                        .append(" OR p.category.name LIKE :searchQuery)");
            }

            // Append status
            if (status != null && !status.isEmpty()) {
                hql.append(" AND uo.status = :status");
            }

            // Append monthsAgo
            if (monthsAgo != null) {
                hql.append(" AND uo.orderDate >= :fromDate");
            }

            Query<UserOrder> query = session.createQuery(hql.toString(), UserOrder.class);
            query.setParameter("userId", userId);

            // Set the search query parameter for multiple fields
            if (searchQuery != null && !searchQuery.isEmpty()) {
                query.setParameter("searchQuery", "%" + searchQuery + "%");
            }

            // Set the status filter parameter
            if (status != null && !status.isEmpty()) {
                query.setParameter("status", status);
            }

            // Set the monthsAgo filter parameter
            if (monthsAgo != null) {
                LocalDateTime fromDate = LocalDate.now().minusMonths(monthsAgo).atStartOfDay();
                query.setParameter("fromDate", fromDate);
            }

            // Set pagination
            query.setFirstResult((pageNumber - 1) * pageSize);
            query.setMaxResults(pageSize);

            // Fetch results
            List<UserOrder> orders = query.list();

            // Build count query for total order count
            StringBuilder countHql = new StringBuilder("SELECT COUNT(DISTINCT uo.id) FROM UserOrder uo JOIN uo.orderItems oi JOIN oi.product p WHERE uo.user.id = :userId");

            // Reuse search query for count
            if (searchQuery != null && !searchQuery.isEmpty()) {
                countHql.append(" AND (p.name LIKE :searchQuery")
                        .append(" OR p.description LIKE :searchQuery")
                        .append(" OR oi.quantity LIKE :searchQuery")
                        .append(" OR p.brand.name LIKE :searchQuery")
                        .append(" OR p.category.name LIKE :searchQuery)");
            }

            // Reuse status filter for count
            if (status != null && !status.isEmpty()) {
                countHql.append(" AND uo.status = :status");
            }

            // Reuse monthsAgo filter for count
            if (monthsAgo != null) {
                countHql.append(" AND uo.orderDate >= :fromDate");
            }

            Query<Long> countQuery = session.createQuery(countHql.toString(), Long.class);
            countQuery.setParameter("userId", userId);

            // Set search query for count
            if (searchQuery != null && !searchQuery.isEmpty()) {
                countQuery.setParameter("searchQuery", "%" + searchQuery + "%");
            }

            // Set status filter for count
            if (status != null && !status.isEmpty()) {
                countQuery.setParameter("status", status);
            }

            // Set monthsAgo filter for count
            if (monthsAgo != null) {
                countQuery.setParameter("fromDate", LocalDate.now().minusMonths(monthsAgo).atStartOfDay());
            }

            // Fetch total order count
            Long totalOrderCount = countQuery.uniqueResult();

            // Return result map
            return new AbstractMap.SimpleEntry<>(orders, totalOrderCount);
        }
    }


    @Override
    public boolean existsByUserIdAndProductId(long userId, long productId) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery(
                    "SELECT COUNT(oi) FROM UserOrder uo JOIN uo.orderItems oi WHERE uo.user.id = :userId AND oi.product.id = :productId", Long.class
            );
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);
            Long count = query.uniqueResult();
            return count != null && count > 0;
        }
    }
}
