package com.fashionkart.service;

import com.fashionkart.entities.Seller;

import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface SellerService {
    Seller saveSeller(Seller seller);
    Optional<Seller> findById(Long id);
    List<Seller> findAll();
    void deleteSeller(Long id);
    boolean authenticate(String email, String password);

    Seller getByEmail(String email);

    double calculateSellerGrowthPercentage();

    long totalSellers();

    Map.Entry<List<Seller>, Long> getPaginatedSellers(int pageNumber, int pageSize);
}
