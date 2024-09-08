package com.fashionkart.servlets;

import com.fashionkart.entities.Category;
import com.fashionkart.payload.CategoryDTO;
import com.fashionkart.service.CategoryService;
import com.fashionkart.serviceimpl.CategoryServiceImpl;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/controller/categories")
public class CategoryServlet extends HttpServlet {
    private final CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryService.findAll();

        // Convert entities to DTOs to avoid lazy loading issues
        List<CategoryDTO> categoryDTOs = categories.stream()
                .map(category -> CategoryDTO.builder().id(category.getId()).description(category.getDescription()).name(category.getName()).build())
                .collect(Collectors.toList());

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().print(new Gson().toJson(categoryDTOs));
    }
}
