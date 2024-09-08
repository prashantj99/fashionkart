package com.fashionkart.repository;

import com.fashionkart.entities.Brand;

import java.util.List;
import java.util.Optional;

public interface BrandRepository {
    Brand save(Brand brand);
    Optional<Brand> findById(Long id);
    Optional<Brand> findByName(String name);
    Optional<Brand> findByEmail(String email);
    List<Brand> findAll();
    List<Brand> findBrands(int offset, int limit);

    int countTotalBrands();
}
