package com.fashionkart.utils;

public interface Constants {
    int DEFAULT_PAGE_SIZE=10;
    // Actions
    String ACTION_ADD_PRODUCT = "/sellers/dashboard?action=addProduct";
    String ACTION_ADD_CATEGORY = "/sellers/dashboard?action=addCategory";
    String ACTION_MANAGE_PRODUCTS = "/sellers/dashboard?action=manageProducts";
    String ACTION_SALES_ANALYTICS = "/sellers/dashboard?action=salesAnalytics";
    String ACTION_ADD_DISCOUNT = "/sellers/dashboard?action=addDiscount";
    String ACTION_MANAGE_DISCOUNTS = "/sellers/dashboard?action=manageDiscounts";

    // URLs
    String URL_ADD_PRODUCT = "/sellers/add/product";
    String URL_ADD_CATEGORY = "/sellers/add/category";
    String URL_MANAGE_PRODUCTS = "/sellers/manage/products";
    String URL_MANAGE_CATEGORIES = "/sellers/manage/categories";
    String URL_SALES_ANALYTICS = "/sellers/sales/analytics";
    String URL_ADD_DISCOUNT = "/sellers/add/discount";
    String URL_MANAGE_DISCOUNTS = "/sellers/manage/discounts";
    double DEFAULT_MIN_CART_VALUE = 1000;
    double DEFAULT_SHIPPING_CHARGE = 275;
}
