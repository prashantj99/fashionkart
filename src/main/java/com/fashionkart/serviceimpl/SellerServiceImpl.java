package com.fashionkart.serviceimpl;

import com.fashionkart.entities.Seller;
import com.fashionkart.repository.SellerRepository;
import com.fashionkart.repositoryimpl.SellerRepositoryImpl;
import com.fashionkart.service.SellerService;
import com.fashionkart.utils.PasswordUtil;

import java.util.List;
import java.util.Optional;

public class SellerServiceImpl implements SellerService {

    private final SellerRepository sellerRepository = new SellerRepositoryImpl();

    @Override
    public Seller saveSeller(Seller seller) {
        return sellerRepository.save(seller);
    }

    @Override
    public Optional<Seller> findById(Long id) {
        return sellerRepository.findById(id);
    }

    @Override
    public List<Seller> findAll() {
        return sellerRepository.findAll();
    }

    @Override
    public void deleteSeller(Long id) {
        sellerRepository.deleteById(id);
    }

    @Override
    public boolean authenticate(String email, String password) {
        Seller seller = sellerRepository.findByEmail(email).orElse(null);
        if (seller != null && PasswordUtil.checkPassword(password, seller.getPassword())) {
            return true;
        }
        return false;
    }
    @Override
    public Seller getByEmail(String email) {
        return sellerRepository.findByEmail(email).orElse(null);
    }
}
