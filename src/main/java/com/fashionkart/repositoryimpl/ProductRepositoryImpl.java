package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.GenderType;
import com.fashionkart.entities.Product;
import com.fashionkart.repository.ProductRepository;
import com.fashionkart.utils.FactoryProvider;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.*;

@Slf4j
public class ProductRepositoryImpl implements ProductRepository {

    @Override
    public void save(Product product) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.persist(product);
            tx.commit();
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public void update(Product product) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.merge(product);
            tx.commit();
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public Optional<Product> findById(Long id) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return Optional.ofNullable(session.get(Product.class, id));
        }
    }

    @Override
    public List<Product> findAll() {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM Product", Product.class).list();
        }
    }

    @Override
    public List<Product> findPaginatedProducts(int offset, int limit) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM Product", Product.class)
                    .setFirstResult(offset)
                    .setMaxResults(limit)
                    .list();
        }
    }

    @Override
    public void delete(Product product) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.remove(product);
            tx.commit();
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public Map.Entry<List<Product>, Integer> findBySeller(Long sellerId, int offset, int pageSize) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            List<Product> products = session.createQuery("FROM Product WHERE seller.id = :sellerId", Product.class)
                    .setParameter("sellerId", sellerId)
                    .setFirstResult(offset)
                    .setMaxResults(pageSize)
                    .list();

            int totalRecords = session.createQuery("SELECT COUNT(*) FROM Product WHERE seller.id = :sellerId", Long.class)
                    .setParameter("sellerId", sellerId)
                    .uniqueResult().intValue();

            return Map.entry(products, totalRecords);
        }
    }

    @Override
    public Map.Entry<List<Product>, Integer> getSearchProductsAndCount(
            String searchQuery, List<Long> categories, List<Long> brands,
            GenderType genderType, double minPrice, double maxPrice,
            String sortBy, String sortingOrder, int offset, int limit) {

        List<Product> products = List.of();
        int totalItems = 0;

        try (Session session = FactoryProvider.getSessionFactory().openSession()) {

            StringBuilder hql = new StringBuilder("from Product where 1=1");
            StringBuilder countHql = new StringBuilder("select count(*) from Product where 1=1");

            buildQueryConditions(hql, countHql, searchQuery, categories, brands, genderType, minPrice, maxPrice);

            // Sorting
            if (sortBy != null && !sortBy.isEmpty()) {
                hql.append(" order by ").append(sortBy);
                if ("desc".equalsIgnoreCase(sortingOrder)) {
                    hql.append(" desc");
                } else {
                    hql.append(" asc");
                }
            }

            Query<Product> productQuery = session.createQuery(hql.toString(), Product.class);
            Query<Long> countQuery = session.createQuery(countHql.toString(), Long.class);

            setQueryParameters(productQuery, searchQuery, categories, brands, genderType, minPrice, maxPrice);
            setQueryParameters(countQuery, searchQuery, categories, brands, genderType, minPrice, maxPrice);

            // Set pagination for product query
            productQuery.setFirstResult(offset);
            productQuery.setMaxResults(limit);

            products = productQuery.list();
            totalItems = countQuery.uniqueResult().intValue();

        } catch (Exception e) {
            log.error("Error fetching products and count: ", e);
        }

        return Map.entry(products, totalItems);
    }

    private void buildQueryConditions(StringBuilder hql, StringBuilder countHql,
                                      String searchQuery, List<Long> categories, List<Long> brands,
                                      GenderType genderType, double minPrice, double maxPrice) {
        if (searchQuery != null && !searchQuery.isEmpty()) {
            hql.append(" and name like :searchQuery");
            countHql.append(" and name like :searchQuery");
        }

        if (minPrice >= 0 && maxPrice > 0) {
            hql.append(" and price between :minPrice and :maxPrice");
            countHql.append(" and price between :minPrice and :maxPrice");
        }

        if (genderType != null) {
            hql.append(" and genderType = :genderType");
            countHql.append(" and genderType = :genderType");
        }

        if (categories != null && !categories.isEmpty()) {
            hql.append(" and category.id in (:categories)");
            countHql.append(" and category.id in (:categories)");
        }

        if (brands != null && !brands.isEmpty()) {
            hql.append(" and brand.id in (:brands)");
            countHql.append(" and brand.id in (:brands)");
        }
    }

    private void setQueryParameters(Query<?> query, String searchQuery, List<Long> categories, List<Long> brands,
                                    GenderType genderType, double minPrice, double maxPrice) {
        if (searchQuery != null && !searchQuery.isEmpty()) {
            query.setParameter("searchQuery", "%" + searchQuery + "%");
        }

        if (minPrice >= 0 && maxPrice > 0) {
            query.setParameter("minPrice", minPrice);
            query.setParameter("maxPrice", maxPrice);
        }

        if (genderType != null) {
            query.setParameter("genderType", genderType);
        }

        if (categories != null && !categories.isEmpty()) {
            query.setParameterList("categories", categories);
        }

        if (brands != null && !brands.isEmpty()) {
            query.setParameterList("brands", brands);
        }
    }

    @Override
    public int countAllProducts() {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            String hql = "select count(*) from Product";
            Query<Long> query = session.createQuery(hql, Long.class);
            return query.uniqueResult().intValue();
        }
    }

    @Override
    public List<Product> getRelatedProducts(Product product) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            String hql = "FROM Product p WHERE (p.category.id = :categoryId OR p.brand.id = :brandId OR " +
                    "p.seller.id = :sellerId OR " +
                    "(p.price BETWEEN :minPrice AND :maxPrice)) " +
                    "AND p.id != :productId";

            Query<Product> query = session.createQuery(hql, Product.class);
            query.setParameter("categoryId", product.getCategory().getId());
            query.setParameter("brandId", product.getBrand().getId());
            query.setParameter("sellerId", product.getSeller().getId());
            query.setParameter("minPrice", product.getPrice() - 100);
            query.setParameter("maxPrice", product.getPrice() + 100);
            query.setParameter("productId", product.getId());

            return query.list();
        } catch (Exception e) {
            return List.of();
        }
    }
}
