package com.fashionkart.repository;

import com.fashionkart.entities.GenderType;
import com.fashionkart.entities.Product;
import com.fashionkart.payload.ProductPageResponse;

import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface ProductRepository {
    void save(Product product);
    void update(Product product);
    Optional<Product> findById(Long id);
    List<Product> findAll();
    List<Product> findPaginatedProducts(int offset, int limit);
    void delete(Product product);
    Map.Entry<List<Product>, Integer> findBySeller(Long sellerId, int offset, int pageSize);

    Map.Entry<List<Product>, Integer> getSearchProductsAndCount(
            String searchQuery, List<Long> categories, List<Long> brands,
            GenderType genderType, double minPrice, double maxPrice,
            String sortBy, String sortingOrder, int offset, int limit);

    int countAllProducts();
    List<Product> getRelatedProducts(Product product);
}
