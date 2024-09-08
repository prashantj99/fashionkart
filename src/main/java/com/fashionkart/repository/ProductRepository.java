package com.fashionkart.repository;

import com.fashionkart.entities.GenderType;
import com.fashionkart.entities.Product;
import com.fashionkart.payload.ProductPageResponse;

import java.util.List;
import java.util.Optional;

public interface ProductRepository {
    void save(Product product);

    void update(Product product);

    Optional<Product> findById(Long id);

    List<Product> findAll();

    void delete(Product product);

    List<Product> findByBrandId(Long brandId);

    List<Product> findByCategoryId(Long categoryId);

    List<Product> findProducts(int offset, int limit);

    List<Product> getSearchProducts(String searchQuery, List<Long> categories, List<Long> brands, GenderType genderType, double minPrice, double maxPrice, String sortBy, String sortingOrder, int offset, int limit);

    int countProducts(String searchQuery, List<Long> categories, List<Long> brands, GenderType genderType, double minPrice, double maxPrice);
    int countAllProducts();
    List<Product> getRelatedProducts(Product product);
}
