package com.fashionkart.serviceimpl;

import com.fashionkart.entities.ProductImage;
import com.fashionkart.repository.ProductImageRepository;
import com.fashionkart.repositoryimpl.ProductImageRepositoryImpl;
import com.fashionkart.service.ProductImageService;

public class ProductImageServiceImpl implements ProductImageService {

    private final ProductImageRepository productImageRepository = new ProductImageRepositoryImpl();

    @Override
    public ProductImage saveProductImage(ProductImage productImage) {
        return productImageRepository.save(productImage);
    }
}
