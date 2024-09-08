package com.fashionkart.payload;

import com.fashionkart.entities.Product;
import com.fashionkart.entities.ProductImage;
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
    public ProductDTO(Product product){
        id = product.getId();
        name = product.getName();
        description = product.getDescription();
        category = new CategoryDTO(product.getCategory());
        price = product.getPrice();
        quantityAvailable = product.getQuantityAvailable();
        brand = new BrandDTO(product.getBrand());
        imagesUrls = product.getImages().stream().map(productImage -> {
            try {
                return FirebaseStorageUtil.generateSignedUrl(productImage.getImageUrl());
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }).collect(Collectors.toList());
        seller = new SellerDTO(product.getSeller());
    }

}
