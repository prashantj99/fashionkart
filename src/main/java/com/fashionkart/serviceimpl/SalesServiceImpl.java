package com.fashionkart.serviceimpl;

import com.fashionkart.repository.SalesRepository;
import com.fashionkart.repositoryimpl.SalesRepositoryImpl;
import com.fashionkart.service.SalesService;

import java.util.Map;

public class SalesServiceImpl implements SalesService {

    private final SalesRepository salesRepository = new SalesRepositoryImpl();

    @Override
    public Map<String, Integer> getProductsSoldPerMonth() {
        return salesRepository.getProductsSoldPerMonth();
    }
}