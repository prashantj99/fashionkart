package com.fashionkart.repository;

import com.fashionkart.entities.Category;

import java.util.List;
import java.util.Optional;

public interface CategoryRepository {
    Category save(Category category) throws Exception;
    Optional<Category> findById(Long id);
    List<Category> findAll();
    void delete(Category category) throws Exception;
    boolean existsByName(String name);
    List<Category> findCategories(int offset, int limit);
}
