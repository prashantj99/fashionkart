package com.fashionkart.servlets;

import com.fashionkart.entities.Brand;
import com.fashionkart.entities.Category;
import com.fashionkart.payload.BrandPageResponse;
import com.fashionkart.payload.CategoryDTO;
import com.fashionkart.service.BrandService;
import com.fashionkart.service.CategoryService;
import com.fashionkart.serviceimpl.BrandServiceImpl;
import com.fashionkart.serviceimpl.CategoryServiceImpl;
import com.fashionkart.utils.Constants;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/controller/brands")
public class BrandServlet extends HttpServlet {
    private final BrandService brandService = new BrandServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int pageNumber = request.getParameter("pageNumber") != null ? Integer.parseInt(request.getParameter("pageNumber")) : 1;
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        BrandPageResponse brandPageResponse = brandService.getBrands(pageNumber, Constants.DEFAULT_PAGE_SIZE);
        response.getWriter().print(new Gson().toJson(brandPageResponse));
    }
}
