package com.fashionkart.serviceimpl;

import com.fashionkart.entities.Address;
import com.fashionkart.repository.AddressRepository;
import com.fashionkart.repositoryimpl.AddressRepositoryImpl;
import com.fashionkart.service.AddressService;

import java.util.List;

public class AddressServiceImpl implements AddressService {

    private final AddressRepository addressRepository = new AddressRepositoryImpl();

    @Override
    public void saveAddress(Address address) {
        addressRepository.save(address);
    }

    @Override
    public void updateAddress(Address address) {
        addressRepository.update(address);
    }

    @Override
    public Address getAddressById(Long id) {
        return addressRepository.findById(id).orElseThrow(()-> new RuntimeException("Address not found"));
    }

    @Override
    public List<Address> getAddressesByUserId(Long userId) {
        return addressRepository.findByUserId(userId);
    }
}
