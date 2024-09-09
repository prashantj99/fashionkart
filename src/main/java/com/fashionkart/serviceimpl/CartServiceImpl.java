package com.fashionkart.serviceimpl;

import com.fashionkart.entities.*;
import com.fashionkart.repository.CartItemRepository;
import com.fashionkart.repository.CartRepository;
import com.fashionkart.repository.ProductRepository;
import com.fashionkart.repository.UserRepository;
import com.fashionkart.repositoryimpl.CartItemRepositoryImpl;
import com.fashionkart.repositoryimpl.CartRepositoryImpl;
import com.fashionkart.repositoryimpl.ProductRepositoryImpl;
import com.fashionkart.repositoryimpl.UserRepositoryImpl;
import com.fashionkart.service.CartService;
import com.fashionkart.service.DiscountService;

import java.util.List;
import java.util.Optional;

public class CartServiceImpl implements CartService {

    private final CartRepository cartRepository;
    private final UserRepository userRepository;
    private final ProductRepository productRepository;
    private final CartItemRepository cartItemRepository;
    private final DiscountService discountService;

    public CartServiceImpl() {
        this.cartRepository = new CartRepositoryImpl();
        this.userRepository = new UserRepositoryImpl();
        this.productRepository = new ProductRepositoryImpl();
        this.cartItemRepository = new CartItemRepositoryImpl();
        this.discountService = new DiscountServiceImpl();
    }

    @Override
    public Cart addItemToCart(Cart cart, CartItem item) {
        cart.getItems().add(item);
        return cartRepository.save(cart);
    }

    @Override
    public Cart getCartByUser(User user) {
        return cartRepository.findByUserId(user.getId())
                .orElseGet(() -> {
                    Cart newCart = new Cart();
                    newCart.setUser(user);
                    cartRepository.save(newCart);
                    return newCart;
                });
    }

    @Override
    public Cart getCartByUser(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("user not found!!"));
        return cartRepository.findByUserId(user.getId()).orElseGet(() -> {
            Cart newCart = new Cart();
            newCart.setUser(user);
            return cartRepository.save(newCart);
        });
    }

    @Override
    public void addProductToCart(Long userId, Long productId, int quantity, ProductSize selectProductSize) {
        Product product = productRepository.findById(productId).orElseThrow(() -> new RuntimeException("product not found!!"));
        Cart cart = getCartByUser(userId);
        Optional<CartItem> existingItem = cartItemRepository.findAllByCartId(cart.getId()).stream()
                .filter(item -> item.getProduct().getId().equals(productId))
                .findFirst();
        if (existingItem.isPresent()) {
            CartItem cartItem = existingItem.get();
            cartItem.setSelectedSize(selectProductSize);
            cartItem.setQuantity(cartItem.getQuantity() + quantity);
            cartItemRepository.update(cartItem);
        } else {
            CartItem newCartItem = new CartItem();
            newCartItem.setCart(cart);
            newCartItem.setSelectedSize(selectProductSize);
            newCartItem.setProduct(product);
            newCartItem.setQuantity(quantity);
            cartItemRepository.save(newCartItem);
        }
    }

    @Override
    public double calculateCartTotalWithBestDiscount(Cart cart) {
        double totalCartValue = 0.0;
        List<CartItem> cartItems = cartItemRepository.findAllByCartId(cart.getId());
        //calculate cart total
        for (CartItem cartItem : cartItems) {
            Product product = cartItem.getProduct();
            Discount bestDiscount = discountService.getBestDiscountForProduct(product.getId());
            double netPrice = bestDiscount != null ? product.getPrice() * (1 - bestDiscount.getPercentage() / 100.0) : product.getPrice();
            totalCartValue += netPrice*cartItem.getQuantity();
        }

        return totalCartValue;
    }
}
