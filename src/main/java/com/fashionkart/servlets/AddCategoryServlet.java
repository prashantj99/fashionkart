package com.fashionkart.servlets;

import com.fashionkart.entities.Category;
import com.fashionkart.service.CategoryService;
import com.fashionkart.serviceimpl.CategoryServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/controller/category/add")
public class AddCategoryServlet extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(AddCategoryServlet.class);
    private final CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryName = request.getParameter("categoryName");
        String description = request.getParameter("description");

        if (categoryName == null || categoryName.trim().isEmpty() || description == null || description.isEmpty()) {
            request.setAttribute("errorMessage", "Category name or description is required!");
            request.getRequestDispatcher("/sellers/dashboard?action=addCategory").forward(request, response);
            return;
        }

        try {
            // Check if the category already exists
            if (categoryService.existsByName(categoryName)) {
                request.setAttribute("errorMessage", "Category already exists!");
                request.getRequestDispatcher("/sellers/dashboard?action=addCategory").forward(request, response);
                return;
            }

            // Add the new category
            Category newCategory = new Category();
            newCategory.setName(categoryName);
            newCategory.setDescription(description);
            categoryService.saveCategory(newCategory);

            // Log success
            logger.info("Category added successfully: {}", categoryName);

            // Redirect to the same page for adding more categories
            response.sendRedirect(request.getContextPath() + "/sellers/dashboard?action=manageCategories");

        } catch (Exception e) {
            logger.error("Error while adding category: {}", e.getMessage());
            request.setAttribute("error", "An error occurred while adding the category.");
            request.getRequestDispatcher("/sellers/dashboard?action=addCategory").forward(request, response);
        }
    }
}
