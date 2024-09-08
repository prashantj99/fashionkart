package com.fashionkart.service;

import com.fashionkart.entities.Brand;
import com.fashionkart.payload.BrandPageResponse;

import java.util.List;
import java.util.Optional;

public interface BrandService {
    Brand save(Brand brand);
    Optional<Brand> findById(Long id);
    Optional<Brand> findByName(String name);
    Optional<Brand> findByEmail(String brandEmail);
    Optional<Brand> authenticate(String email, String password);

    List<Brand> getAllBrands();

    BrandPageResponse getBrands(int pageNumber, int pageSize);
}
