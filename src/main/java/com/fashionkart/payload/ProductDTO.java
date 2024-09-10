package com.fashionkart.payload;

import com.fashionkart.entities.Discount;
import com.fashionkart.entities.Product;
import com.fashionkart.entities.ProductImage;
import com.fashionkart.service.DiscountService;
import com.fashionkart.serviceimpl.DiscountServiceImpl;
import com.fashionkart.utils.FirebaseStorageUtil;
import lombok.Getter;
import lombok.Setter;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
public class ProductDTO {
    private Long id;
    private String name;
    private String description;
    private CategoryDTO category;
    private double price;
    private int quantityAvailable;
    private BrandDTO brand;
    private List<String> imagesUrls;
    private SellerDTO seller;
    private double discountPercentage;

    public ProductDTO(Product product) {
        //basic details
        this.id = product.getId();
        this.name = product.getName();
        this.description = product.getDescription();
        this.category = new CategoryDTO(product.getCategory());
        this.price = product.getPrice();
        this.quantityAvailable = product.getQuantityAvailable();

        //brand info
        this.brand = new BrandDTO(product.getBrand());

        //signed image urls
        this.imagesUrls = product.getImages().stream().map(productImage -> {
            try {
                return FirebaseStorageUtil.generateSignedUrl(productImage.getImageUrl());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }).collect(Collectors.toList());

        //sellers info
        this.seller = new SellerDTO(product.getSeller());

        //discount available
        DiscountService discountService = new DiscountServiceImpl();
        Discount discount = discountService.getBestDiscountForProduct(product.getId());
        discountPercentage = discount == null ? 0 : discount.getPercentage();
    }

}
