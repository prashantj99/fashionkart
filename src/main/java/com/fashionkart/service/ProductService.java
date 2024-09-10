package com.fashionkart.service;

import com.fashionkart.entities.GenderType;
import com.fashionkart.entities.Product;
import com.fashionkart.entities.ProductImage;
import com.fashionkart.entities.ProductSize;
import com.fashionkart.payload.ProductPageResponse;

import java.util.List;
import java.util.Optional;

public interface ProductService {
    void updateProduct(Product product);
    void saveProduct(String name, String desc, double price, int quantityAvailable, GenderType genderType, List<ProductSize> productServices, List<String> imgUrls, Long categoryId, Long brandId, Long sellerId);
    Product getProductById(Long id);
    void deleteProduct(Long id);
    ProductPageResponse getSearchProducts(String searchQuery, List<Long> categories, List<Long> brands, GenderType genderType, double minPrice, double maxPrice, String sortBy, String sortingOrder, int offset, int limit);
    ProductPageResponse getProductsPageBySeller(Long sellerId, int pageNumber, int pageSize);
    List<Product> getSimilarProducts(Product product);
}
