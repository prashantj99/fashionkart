package com.fashionkart.serviceimpl;

import com.fashionkart.entities.Category;
import com.fashionkart.entities.Discount;
import com.fashionkart.entities.Product;
import com.fashionkart.entities.Seller;
import com.fashionkart.repository.CategoryRepository;
import com.fashionkart.repository.DiscountRepository;
import com.fashionkart.repository.ProductRepository;
import com.fashionkart.repository.SellerRepository;
import com.fashionkart.repositoryimpl.CategoryRepositoryImpl;
import com.fashionkart.repositoryimpl.DiscountRepositoryImpl;
import com.fashionkart.repositoryimpl.ProductRepositoryImpl;
import com.fashionkart.repositoryimpl.SellerRepositoryImpl;
import com.fashionkart.service.DiscountService;

import java.time.LocalDateTime;
import java.util.List;

public class DiscountServiceImpl implements DiscountService {

    private final DiscountRepository discountRepository = new DiscountRepositoryImpl();
    private final SellerRepository sellerRepository = new SellerRepositoryImpl();
    private final CategoryRepository categoryRepository = new CategoryRepositoryImpl();
    private final ProductRepository productRepository = new ProductRepositoryImpl();

    @Override
    public void saveDiscount(Discount discount) {
        discountRepository.save(discount);
    }

    @Override
    public Discount getDiscountById(Long id) {
        return discountRepository.findById(id);
    }

    @Override
    public List<Discount> getAllDiscounts() {
        return discountRepository.findAll();
    }

    @Override
    public void updateDiscount(Discount discount) {
        discountRepository.update(discount);
    }

    @Override
    public void deleteDiscount(Long id) {
        discountRepository.delete(id);
    }

    @Override
    public List<Discount> getDiscountsBySeller(Long sellerId) {
        return discountRepository.findBySellerId(sellerId);
    }

    @Override
    public void addDiscount(Discount discount, Long sellerId, Long categoryId) throws Exception {
        Seller seller = sellerRepository.findById(sellerId)
                .orElseThrow(() -> new Exception("Seller not found"));
        Category category = categoryRepository.findById(categoryId)
                .orElseThrow(() -> new Exception("Category not found"));
        discount.setSeller(seller);
        discount.setApplicableProductCategory(category);
        discountRepository.save(discount);
    }

    @Override
    public boolean isDiscountOwnedBySeller(Long discountId, Long sellerId) {
        Discount discount = discountRepository.findById(discountId);
        return discount != null && discount.getSeller().getId().equals(sellerId);
    }

    public Discount getBestDiscountForProduct(Long productId) {
        Product product = productRepository.findById(productId).orElseThrow(()-> new RuntimeException("Product not found!!"+productId));
        List<Discount> discounts = discountRepository.findByCategoryId(product.getCategory().getId());
        Discount bestDiscount = null;
        for (Discount discount : discounts) {
            // Check if the product's price is greater than or equal to the minimum value for this discount
            if (product.getPrice() >= discount.getMinimumValue()) {
                if (bestDiscount == null || discount.getPercentage() > bestDiscount.getPercentage()) {
                    bestDiscount = discount;
                }
            }
        }
        return bestDiscount;
    }
}
