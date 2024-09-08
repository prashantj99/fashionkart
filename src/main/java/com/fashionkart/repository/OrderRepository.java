package com.fashionkart.repository;

import com.fashionkart.entities.UserOrder;
import org.apache.commons.lang3.tuple.Pair;

import java.util.List;
import java.util.Map;
import java.util.Optional;

public interface OrderRepository {
    UserOrder save(UserOrder userOrder);
    UserOrder update(UserOrder userOrder);
    Optional<UserOrder> findById(Long id);
    List<UserOrder> findAll();
    void delete(UserOrder userOrder);
    Map.Entry<List<UserOrder>, Long> filteredOrders(Long userId, String searchQuery, String status, Long monthsAgo, int pageNumber, int pageSize);
    int getTotalOrdersByUserId(Long userId);
    boolean existsByUserIdAndProductId(long userId, long productId);
}
