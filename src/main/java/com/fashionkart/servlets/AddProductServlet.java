package com.fashionkart.servlets;

import com.fashionkart.entities.*;
import com.fashionkart.service.BrandService;
import com.fashionkart.service.CategoryService;
import com.fashionkart.service.FileService;
import com.fashionkart.service.ProductService;
import com.fashionkart.serviceimpl.BrandServiceImpl;
import com.fashionkart.serviceimpl.CategoryServiceImpl;
import com.fashionkart.serviceimpl.FileServiceImpl;
import com.fashionkart.serviceimpl.ProductServiceImpl;
import com.fashionkart.utils.FirebaseStorageUtil;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@WebServlet("/controller/add-product")
@Slf4j
@MultipartConfig
public class AddProductServlet extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();
    private final FileService fileService = new FileServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantityAvailable = Integer.parseInt(request.getParameter("quantityAvailable"));
            Long categoryId = Long.parseLong(request.getParameter("category"));
            Long brandId = Long.parseLong(request.getParameter("brand"));
            GenderType genderType = GenderType.valueOf(request.getParameter("genderType"));

            // Handle available product sizes
            String[] selectedSizeValues = request.getParameterValues("productSizes");
            List<ProductSize> productSizes = new ArrayList<>();
            if (selectedSizeValues != null) {
                for (String sizeValue : selectedSizeValues) {
                    try {
                        productSizes.add(ProductSize.valueOf(sizeValue));
                    } catch (IllegalArgumentException e) {
                        log.error("Invalid product size value: {}", sizeValue);
                    }
                }
            }

            validateInput(name, description, price, quantityAvailable, genderType, productSizes);

            Seller seller = (Seller) request.getSession().getAttribute("seller");
            if (seller == null) {
                response.sendRedirect("/auth/sellers/login");
                return;
            }

            // Handle file uploads
            List<String> imageUrls = handleFileUploads(request.getParts());

            // Save product
            productService.saveProduct(name, description, price, quantityAvailable, genderType, productSizes, imageUrls, categoryId, brandId, seller.getId());

            response.sendRedirect("/sellers/dashboard?action=manageProducts");
        } catch (IllegalArgumentException e) {
            log.error("Validation error: {}", e.getMessage());
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/sellers/dashboard?action=addProduct").forward(request, response);
        } catch (Exception e) {
            log.error("Error adding product", e);
            request.setAttribute("errorMessage", "Failed to add product. Please try again.");
            request.getRequestDispatcher("/sellers/dashboard?action=addProduct").forward(request, response);
        }
    }

    private void validateInput(String name, String description, double price, int quantityAvailable, GenderType genderType, List<ProductSize> productSizes) {
        if (name == null || name.isEmpty() ||
                description == null || description.isEmpty() ||
                price <= 0 ||
                quantityAvailable < 0 ||
                genderType == null ||
                productSizes.isEmpty()
        ) {
            throw new IllegalArgumentException("Please fill out all fields correctly.");
        }
    }

    private List<String> handleFileUploads(Collection<Part> fileParts) throws IOException {
        List<String> imageUrls = new ArrayList<>();
        for (Part filePart : fileParts) {
            if (filePart.getContentType() != null && filePart.getContentType().startsWith("image/")) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                try (InputStream inputStream = filePart.getInputStream()) {
                    String imageUrl = FirebaseStorageUtil.uploadFile(fileName, inputStream);
                    imageUrls.add(imageUrl);
                }
            }
        }
        return imageUrls;
    }
}
