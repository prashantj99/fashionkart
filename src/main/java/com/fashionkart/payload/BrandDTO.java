package com.fashionkart.payload;

import com.fashionkart.entities.Brand;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Setter
@Getter
@Builder
public class BrandDTO {
    private Long id;
    private String name;
    private String description;
    private String logoUrl;
    private String contactNumber;
    private String websiteUrl;
    private String facebookUrl;
    private String instagramUrl;
    private String twitterUrl;
    public BrandDTO(Brand brand){
        this.id = brand.getId();
        this.name = brand.getName();
        this.description = brand.getDescription();
        this.logoUrl = brand.getLogoUrl();
        this.contactNumber = brand.getContactNumber();
        this.websiteUrl = brand.getWebsiteUrl();
        this.facebookUrl = brand.getFacebookUrl();
        this.instagramUrl = brand.getInstagramUrl();
        this.twitterUrl = brand.getTwitterUrl();
    }
}
