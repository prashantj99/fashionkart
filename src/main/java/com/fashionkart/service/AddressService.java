package com.fashionkart.service;

import com.fashionkart.entities.Address;

import java.util.List;

public interface AddressService {
    void saveAddress(Address address);
    void updateAddress(Address address);
    Address getAddressById(Long id);
    List<Address> getAddressesByUserId(Long userId);
}
