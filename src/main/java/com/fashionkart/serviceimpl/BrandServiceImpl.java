package com.fashionkart.serviceimpl;

import com.fashionkart.entities.Brand;
import com.fashionkart.payload.BrandDTO;
import com.fashionkart.payload.BrandPageResponse;
import com.fashionkart.repository.BrandRepository;
import com.fashionkart.repositoryimpl.BrandRepositoryImpl;
import com.fashionkart.service.BrandService;
import com.fashionkart.utils.PasswordUtil;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class BrandServiceImpl implements BrandService {
    private final BrandRepository brandRepository;

    public BrandServiceImpl() {
        this.brandRepository = new BrandRepositoryImpl();
    }

    @Override
    public Brand save(Brand brand) {
        return brandRepository.save(brand);
    }

    @Override
    public Optional<Brand> findById(Long id) {
        return brandRepository.findById(id);
    }

    @Override
    public Optional<Brand> findByName(String name) {
        return brandRepository.findByName(name);
    }
    @Override
    public Optional<Brand> findByEmail(String email) {
        return brandRepository.findByEmail(email);
    }

    @Override
    public List<Brand> getAllBrands() {
        return brandRepository.findAll();
    }

    @Override
    public BrandPageResponse getBrands(int pageNumber, int pageSize) {
        int offset = (pageNumber-1)*pageSize;
        List<Brand> brands = brandRepository.findBrands(offset, pageSize);
        int totalRecords = brandRepository.countTotalBrands();
        boolean isLastPage = offset + pageSize >= totalRecords;
        return new BrandPageResponse(
                brands.stream().map(BrandDTO::new).collect(Collectors.toList()),
                pageNumber,
                pageSize,
                totalRecords,
                isLastPage
        );
    }

    @Override
    public Optional<Brand> authenticate(String email, String password) {
        Optional<Brand> brandOptional = brandRepository.findByEmail(email);

        if (brandOptional.isPresent()) {
            Brand brand = brandOptional.get();
            if (PasswordUtil.checkPassword(password, brand.getPassword())) {
                return Optional.of(brand);
            }
        }

        return Optional.empty();
    }
}
