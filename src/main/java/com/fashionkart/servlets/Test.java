package com.fashionkart.servlets;

import com.fashionkart.serviceimpl.WishlistServiceImpl;

public class Test {
    public static void main(String[] args) {
//        new WishlistServiceImpl().removeProductFromWishlist(1L, 2L);
        new WishlistServiceImpl().addProductToWishlistofUser(1L, 1L);;
    }
}
