package com.fashionkart.serviceimpl;

import com.fashionkart.entities.*;
import com.fashionkart.payload.ProductDTO;
import com.fashionkart.payload.ProductPageResponse;
import com.fashionkart.repository.BrandRepository;
import com.fashionkart.repository.CategoryRepository;
import com.fashionkart.repository.ProductRepository;
import com.fashionkart.repository.SellerRepository;
import com.fashionkart.repositoryimpl.BrandRepositoryImpl;
import com.fashionkart.repositoryimpl.CategoryRepositoryImpl;
import com.fashionkart.repositoryimpl.ProductRepositoryImpl;
import com.fashionkart.repositoryimpl.SellerRepositoryImpl;
import com.fashionkart.service.DiscountService;
import com.fashionkart.service.ProductImageService;
import com.fashionkart.service.ProductService;
import com.fashionkart.utils.FactoryProvider;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final SellerRepository sellerRepository;
    private final BrandRepository brandRepository;

    public ProductServiceImpl() {
        this.productRepository = new ProductRepositoryImpl();
        this.categoryRepository = new CategoryRepositoryImpl();
        this.sellerRepository = new SellerRepositoryImpl();
        this.brandRepository = new BrandRepositoryImpl();
    }

    @Override
    public void saveProduct(String name, String desc, double price, int quantityAvailable, GenderType genderType, List<ProductSize> productServices, List<String> imgUrls, Long categoryId, Long brandId, Long sellerId) {
        Category category = categoryRepository.findById(categoryId).orElseThrow(() -> new RuntimeException("Category not found!"));
        Seller seller = sellerRepository.findById(sellerId).orElseThrow(() -> new RuntimeException("seller not found!"));
        Brand brand = brandRepository.findById(brandId).orElseThrow(() -> new RuntimeException("brand not found!"));

        Product product = new Product();
        product.setName(name);
        product.setDescription(desc);
        product.setPrice(price);
        product.setQuantityAvailable(quantityAvailable);
        product.setCategory(category);
        product.setBrand(brand);
        product.setSeller(seller);
        product.setGenderType(genderType);
        product.setAvailableSizes(productServices);
        List<ProductImage> productImages=new ArrayList<>();

        for (String url : imgUrls) {
            ProductImage productImage = new ProductImage();
            productImage.setImageUrl(url);
            productImage.setProduct(product);
            productImages.add(productImage);
        }

        product.setImages(productImages);
        productRepository.save(product);
    }

    @Override
    public void updateProduct(Product product) {
        productRepository.update(product);
    }

    @Override
    public Product getProductById(Long id) {
        return productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));
    }

    @Override
    public void deleteProduct(Long id) {
        Product product = getProductById(id);
        productRepository.delete(product);
    }

    @Override
    public ProductPageResponse getSearchProducts(String searchQuery, List<Long> categories, List<Long> brands, GenderType genderType, double minPrice, double maxPrice, String sortBy, String sortingOrder, int pageNumber, int pageSize) {
        int offset = (pageNumber - 1) * pageSize;
        List<Product> products = productRepository.getSearchProducts(searchQuery, categories, brands, genderType, minPrice, maxPrice, sortBy, sortingOrder, offset, pageSize);
        List<ProductDTO> productDTOS = products.stream().map(ProductDTO::new).collect(Collectors.toList());
        int totalRecords = productRepository.countProducts(searchQuery, categories, brands, genderType, minPrice, maxPrice);
        boolean isLastPage = offset + pageSize >= totalRecords;
        return ProductPageResponse.builder()
                .products(productDTOS)
                .pageNumber(pageNumber)
                .totalRecords(totalRecords)
                .pageSize(pageSize)
                .isLastPage(isLastPage)
                .build();
    }

    @Override
    public ProductPageResponse getProductsPage(int pageNumber, int pageSize) {
        int offset = (pageNumber - 1) * pageSize;
        int totalRecords = productRepository.countAllProducts();
        List<Product> products = productRepository.findProducts(offset, pageSize);
        List<ProductDTO> productDTOS = products.stream().map(ProductDTO::new).collect(Collectors.toList());
        boolean isLastPage = offset + pageSize >= totalRecords;
        return ProductPageResponse.builder()
                .products(productDTOS)
                .pageNumber(pageNumber)
                .totalRecords(totalRecords)
                .pageSize(pageSize)
                .isLastPage(isLastPage)
                .build();
    }

    @Override
    public List<Product> getSimilarProducts(Product product) {
        return productRepository.getRelatedProducts(product);
    }
}
