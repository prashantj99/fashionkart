package com.fashionkart.payload;

import com.fashionkart.entities.Seller;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@Builder
public class SellerDTO {
    private Long id;
    private String name;
    private String email;
    private String phoneNumber;
    private String businessName;
    public SellerDTO(Seller seller){
        this.id = seller.getId();
        this.name = seller.getName();
        this.email = seller.getEmail();
        this.businessName = seller.getBusinessName();
        this.phoneNumber = seller.getPhoneNumber();
    }
}
