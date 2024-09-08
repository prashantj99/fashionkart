package com.fashionkart.payload;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@AllArgsConstructor
@Builder
@Setter
@Getter
public class ProductPageResponse {
    private List<ProductDTO> products;
    private int pageNumber;
    private int pageSize;
    private int totalRecords;
    private boolean isLastPage;
}
