package com.fashionkart.serviceimpl;

import com.fashionkart.entities.*;
import com.fashionkart.repository.*;
import com.fashionkart.repositoryimpl.*;
import com.fashionkart.service.CartItemService;
import com.fashionkart.service.CartService;
import com.fashionkart.service.DiscountService;
import com.fashionkart.service.OrderService;
import com.fashionkart.utils.Constants;
import org.apache.commons.lang3.tuple.Pair;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository = new OrderRepositoryImpl();
    private final CartRepository cartRepository = new CartRepositoryImpl();
    private final CartService cartService = new CartServiceImpl();
    private final DiscountService discountService = new DiscountServiceImpl();
    private final AddressRepository addressRepository = new AddressRepositoryImpl();
    private final CartItemService cartItemService = new CartItemServiceImpl();
    private final ProductRepository productRepository = new ProductRepositoryImpl();

    @Override
    public UserOrder getOrderById(Long id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("UserOrder not found"));
    }

    @Override
    public List<UserOrder> getAllOrders() {
        return orderRepository.findAll();
    }

    @Override
    public void cancelOrder(Long userId, Long orderId) {
        UserOrder userOrder = orderRepository.findById(orderId).orElseThrow(()-> new RuntimeException("Order not Found"));
        if(!userOrder.getUser().getId().equals(userId)){
            throw new RuntimeException("Unauthorized");
        }
        userOrder.setStatus("CANCELLED");
        orderRepository.update(userOrder);
    }

    @Override
    public void processCheckout(User user, String street, String city, String state, String country, String zip) {
        Cart cart = cartRepository.findByUserId(user.getId()).orElseThrow(()-> new RuntimeException("Cart No found"));
        addressRepository.resetDefault(user);

        UserOrder userOrder = new UserOrder();

        userOrder.setUser(user);

        userOrder.setStreet(street);
        userOrder.setCity(city);
        userOrder.setZip(zip);
        userOrder.setCountry(country);

        userOrder.setOrderDate(LocalDateTime.now());
        userOrder.setExpectedDelivery(LocalDateTime.now().plusDays(7));

        userOrder.setStatus("PENDING");


        // Calculate totalAmount and set it in userOrder
        double totalAmount = cartService.calculateCartTotalWithBestDiscount(cart);
        userOrder.setTotalAmount(totalAmount + (totalAmount >= Constants.DEFAULT_MIN_CART_VALUE ? 0 : Constants.DEFAULT_SHIPPING_CHARGE));

        // Convert CartItems to OrderItems
        List<OrderItem> orderItems = cartItemService.findAllCartItemsByCartId(cart.getId()).stream().map(cartItem -> {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(userOrder);
            orderItem.setProduct(cartItem.getProduct());
            orderItem.setQuantity(cartItem.getQuantity());
            Discount bestDiscount = discountService.getBestDiscountForProduct(cartItem.getProduct().getId());
            double discountValue = bestDiscount != null ? cartItem.getProduct().getPrice() * bestDiscount.getPercentage() / 100.0 : 0;
            double discountedPrice = cartItem.getProduct().getPrice() - discountValue;
            orderItem.setPriceAtOrderTime(discountedPrice);
            return orderItem;
        }).collect(Collectors.toList());

        //set order items
        userOrder.setOrderItems(orderItems);
        orderRepository.save(userOrder);

        orderItems.forEach(orderItem -> {
            Product p = orderItem.getProduct();
            p.setQuantityAvailable(p.getQuantityAvailable()-orderItem.getQuantity());
            productRepository.update(p);
        });

        //clear cart
        cartRepository.clearCart(cart);
    }

    @Override
    public Map.Entry<List<UserOrder>, Long> getFilteredOrdersByUser(Long userId, String searchQuery, String status, Long monthsAgo, int pageNumber, int pageSize){
        return orderRepository.filteredOrders(userId, searchQuery, status, monthsAgo, pageNumber, pageSize);
    }
}
