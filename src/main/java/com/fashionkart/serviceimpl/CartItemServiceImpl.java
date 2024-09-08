package com.fashionkart.serviceimpl;

import com.fashionkart.entities.Cart;
import com.fashionkart.entities.CartItem;
import com.fashionkart.entities.Product;
import com.fashionkart.entities.ProductSize;
import com.fashionkart.repository.CartItemRepository;
import com.fashionkart.repository.CartRepository;
import com.fashionkart.repository.ProductRepository;
import com.fashionkart.repository.UserRepository;
import com.fashionkart.repositoryimpl.CartItemRepositoryImpl;
import com.fashionkart.repositoryimpl.CartRepositoryImpl;
import com.fashionkart.repositoryimpl.ProductRepositoryImpl;
import com.fashionkart.repositoryimpl.UserRepositoryImpl;
import com.fashionkart.service.CartItemService;

import java.util.List;
import java.util.Optional;

public class CartItemServiceImpl implements CartItemService {

    private final CartItemRepository cartItemRepository = new CartItemRepositoryImpl();
    private final CartRepository cartRepository = new CartRepositoryImpl();


    @Override
    public CartItem saveCartItem(CartItem cartItem) {
        return cartItemRepository.save(cartItem);
    }

    @Override
    public void updateCartItem(Long userId, Long cartItemId, int requiredQuantity, ProductSize productSize) {
        Cart cart = cartRepository.findByUserId(userId)
                .orElseThrow(() -> new RuntimeException("Cart not found for user with ID: " + userId));
        CartItem cartItem = cartItemRepository.findById(cartItemId)
                .orElseThrow(() -> new RuntimeException("CartItem not found for cart with ID: " + cart.getId()));

        // cart item belongs to the user's cart
        if (!cartItem.getCart().getId().equals(cart.getId())) {
            throw new RuntimeException("Unauthorized access: User with ID " + userId + " does not own the cart item.");
        }

        // Get available stock
        int availableStock = cartItem.getProduct().getQuantityAvailable();

        if (requiredQuantity < 0 || requiredQuantity > availableStock) {
            throw new RuntimeException("Insufficient stock for product ID: " + cartItem.getProduct().getId());
        }

        if(requiredQuantity == 0){
            cartItemRepository.delete(cartItem);
        }else{
            //update cart item
            cartItem.setSelectedSize(productSize);
            cartItem.setQuantity(requiredQuantity);
            cartItemRepository.update(cartItem);
        }
    }

    @Override
    public Optional<CartItem> findCartItemById(Long id) {
        return cartItemRepository.findById(id);
    }

    @Override
    public List<CartItem> findAllCartItemsByCartId(Long cartId) {
        return cartItemRepository.findAllByCartId(cartId);
    }

    @Override
    public void deleteCartItem(CartItem cartItem) {
        cartItemRepository.delete(cartItem);
    }
}
