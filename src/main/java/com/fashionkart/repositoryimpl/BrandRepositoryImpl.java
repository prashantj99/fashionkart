package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.Brand;
import com.fashionkart.repository.BrandRepository;
import com.fashionkart.utils.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;
import java.util.Optional;

public class BrandRepositoryImpl implements BrandRepository {

    @Override
    public Brand save(Brand brand) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            if (brand.getId() == null) {
                session.persist(brand);
            } else {
                session.merge(brand);
            }
            tx.commit();
            return brand;
        }
    }

    @Override
    public Optional<Brand> findById(Long id) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return Optional.ofNullable(session.find(Brand.class, id));
        }
    }

    @Override
    public Optional<Brand> findByName(String name) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM Brand WHERE name = :name", Brand.class)
                    .setParameter("name", name)
                    .uniqueResultOptional();
        }
    }

    @Override
    public Optional<Brand> findByEmail(String email) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM Brand WHERE email = :email", Brand.class)
                    .setParameter("email", email)
                    .uniqueResultOptional();
        }
    }

    @Override
    public List<Brand> findAll() {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("from Brand", Brand.class).list();
        }
    }

    @Override
    public List<Brand> findBrands(int offset, int limit) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Query<Brand> query = session.createQuery("from Brand", Brand.class);
            query.setFirstResult(offset);
            query.setMaxResults(limit);
            return query.list();
        }
    }

    @Override
    public int countTotalBrands() {
        try(Session session = FactoryProvider.getSessionFactory().openSession()){
            String hql = "select count(*) from Brand";
            Query<Long> query = session.createQuery(hql, Long.class);
            return query.uniqueResult().intValue();
        }
    }
}
