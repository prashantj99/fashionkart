package com.fashionkart.service;

import com.fashionkart.entities.User;
import com.fashionkart.entities.UserOrder;
import org.apache.commons.lang3.tuple.Pair;

import java.util.List;
import java.util.Map;

public interface OrderService {
    UserOrder getOrderById(Long id);
    List<UserOrder> getAllOrders();
    void cancelOrder(Long userId, Long orderId);
    void processCheckout(User user, String street, String city, String state, String country, String zip);
    Map.Entry<List<UserOrder>, Long> getFilteredOrdersByUser(Long userId, String searchQuery, String status, Long monthsAgo, int pageNumber, int pageSize);
}
