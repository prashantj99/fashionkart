package com.fashionkart.serviceimpl;

import com.fashionkart.entities.Seller;
import com.fashionkart.repository.SellerRepository;
import com.fashionkart.repositoryimpl.SellerRepositoryImpl;
import com.fashionkart.service.SellerService;
import com.fashionkart.utils.PasswordUtil;

import java.util.AbstractMap;
import java.util.List;
import java.util.Map;
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

    @Override
    public double calculateSellerGrowthPercentage() {
        long sellersLastMonth = sellerRepository.sellersRegisteredInMonth(1);
        long sellersMonthBeforeLast = sellerRepository.sellersRegisteredInMonth(2);
        System.out.println("S1 "+sellersLastMonth);
        System.out.println("S2 "+sellersMonthBeforeLast);

        if (sellersMonthBeforeLast == 0) {
            return sellersLastMonth > 0 ? 100.0 : 0.0;
        }

        return ((double) (sellersLastMonth - sellersMonthBeforeLast) / sellersMonthBeforeLast) * 100;
    }

    @Override
    public long totalSellers(){
        return sellerRepository.countSellers();
    }

    @Override
    public Map.Entry<List<Seller>, Long> getPaginatedSellers(int pageNumber, int pageSize) {
        int offset = (pageNumber - 1) * pageSize;
        List<Seller> sellers = sellerRepository.findPaginated(offset, pageSize);
        long totalItems = sellerRepository.countSellers();
        return new AbstractMap.SimpleEntry<>(sellers, totalItems);
    }

}
