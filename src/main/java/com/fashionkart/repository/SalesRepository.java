package com.fashionkart.repository;

import java.util.Map;

public interface SalesRepository {
    Map<String, Integer> getProductsSoldPerMonth();
}
