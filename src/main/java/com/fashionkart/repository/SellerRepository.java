package com.fashionkart.repository;

import com.fashionkart.entities.Seller;

import java.util.List;
import java.util.Optional;

public interface SellerRepository {
    Seller save(Seller seller);
    Optional<Seller> findById(Long id);
    List<Seller> findAll();
    void deleteById(Long id);

    Optional<Seller> findByEmail(String email);

    List<Seller> findPaginated(int offset, int pageSize);

    long countSellers();

    long sellersRegisteredInMonth(int monthsAgo);
}
