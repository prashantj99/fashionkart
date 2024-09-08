package com.fashionkart.serviceimpl;

import com.fashionkart.entities.Category;
import com.fashionkart.repository.CategoryRepository;
import com.fashionkart.repositoryimpl.CategoryRepositoryImpl;
import com.fashionkart.service.CategoryService;
import lombok.extern.slf4j.Slf4j;

import java.util.List;
import java.util.Optional;

@Slf4j
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository = new CategoryRepositoryImpl();

    @Override
    public void saveCategory(Category category) throws Exception {
        try {
            categoryRepository.save(category);
        } catch (Exception e) {
            log.error("Error saving category: {}", category.getName(), e);
            throw e;
        }
    }

    @Override
    public Optional<Category> findById(Long id) {
        return categoryRepository.findById(id);
    }

    @Override
    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    @Override
    public List<Category> getCategories(int offset, int limit) {
        return categoryRepository.findCategories(offset, limit);
    }

    @Override
    public void deleteCategory(Long id) throws Exception {
        try {
            Optional<Category> categoryOptional = findById(id);
            if (categoryOptional.isPresent()) {
                categoryRepository.delete(categoryOptional.get());
            } else {
                throw new Exception("Category not found");
            }
        } catch (Exception e) {
            log.error("Error deleting category with ID: {}", id, e);
            throw e;
        }
    }

    @Override
    public boolean existsByName(String name) {
        return categoryRepository.existsByName(name);
    }
}
