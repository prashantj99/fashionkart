package com.fashionkart.service;

import com.fashionkart.entities.Category;

import java.util.List;
import java.util.Optional;

public interface CategoryService {
    void saveCategory(Category category) throws Exception;
    Optional<Category> findById(Long id);
    List<Category> findAll();
    void deleteCategory(Long id) throws Exception;

    boolean existsByName(String name);

    List<Category> getCategories(int offset, int limit);
}
