package com.fashionkart.payload;

import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;

import java.util.List;

@AllArgsConstructor
public class BrandPageResponse {
    private List<BrandDTO> brands;
    private int pageNumber;
    private int pageSize;
    private int totalRecords;
    private boolean isLastPage;
}
