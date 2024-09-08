package com.fashionkart.repositoryimpl;

import com.fashionkart.entities.Category;
import com.fashionkart.repository.CategoryRepository;
import com.fashionkart.utils.FactoryProvider;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;
import java.util.Optional;

@Slf4j
public class CategoryRepositoryImpl implements CategoryRepository {

    @Override
    public Category save(Category category) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            if (category.getId() == null) {
                session.persist(category);
            } else {
                session.merge(category);
            }
            tx.commit();
            return category;
        } catch (Exception e) {
            log.error("Error saving category: {}", e.getMessage(), e);
        }
        return null;
    }

    @Override
    public Optional<Category> findById(Long id) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return Optional.ofNullable(session.find(Category.class, id));
        } catch (Exception e) {
            log.error("Error finding category by id: {}", e.getMessage(), e);
        }
        return Optional.empty();
    }

    @Override
    public List<Category> findAll() {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            return session.createQuery("FROM Category", Category.class).list();
        } catch (Exception e) {
            log.error("Error finding all categories: {}", e.getMessage(), e);
        }
        return null;
    }

    @Override
    public List<Category> findCategories(int offset, int limit) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Query<Category> query = session.createQuery("from Category", Category.class);
            query.setFirstResult(offset);
            query.setMaxResults(limit);
            return query.list();
        }
    }

    @Override
    public void delete(Category category) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            Transaction tx = session.beginTransaction();
            session.remove(session.contains(category) ? category : session.merge(category)); // Remove or merge the category before removing
            tx.commit();
        } catch (Exception e) {
            log.error("Error deleting category: {}", e.getMessage(), e);
        }
    }

    @Override
    public boolean existsByName(String name) {
        try (Session session = FactoryProvider.getSessionFactory().openSession()) {
            String hql = "SELECT COUNT(c.id) FROM Category c WHERE c.name = :name";
            Query<Long> query = session.createQuery(hql, Long.class);
            query.setParameter("name", name);
            Long count = query.getSingleResult();
            return count > 0;
        } catch (Exception e) {
            log.error("Error checking if category exists by name: {}", e.getMessage(), e);
        }
        return true;
    }
}
