package com.fashionkart.repository;

import com.fashionkart.entities.Address;
import com.fashionkart.entities.User;

import java.util.List;
import java.util.Optional;

public interface AddressRepository {
    void save(Address address);
    void update(Address address);
    Optional<Address> findById(Long addressId);
    List<Address> findByUserId(Long userId);
    void resetDefault(User user);
}
