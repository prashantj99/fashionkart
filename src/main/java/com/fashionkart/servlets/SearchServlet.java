package com.fashionkart.servlets;

import com.fashionkart.entities.GenderType;
import com.fashionkart.payload.ProductPageResponse;
import com.fashionkart.service.ProductService;
import com.fashionkart.serviceimpl.ProductServiceImpl;
import com.fashionkart.utils.Constants;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/controller/search")
public class SearchServlet extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String searchQuery = getParameterOrDefault(request, "search", "");
        List<Long> categories = parseIdsFromRequest(request, "categories");
        List<Long> brands = parseIdsFromRequest(request, "brands");
        String sortBy = getParameterOrDefault(request, "sortBy", "price");
        String sortingOrder = getParameterOrDefault(request, "sortingOrder", "asc");
        double minPrice = parseDoubleOrDefault(request, "minPrice", 0);
        double maxPrice = parseDoubleOrDefault(request, "maxPrice", Double.MAX_VALUE);
        int pageNumber = parseIntOrDefault(request, "pageNumber", 1);

        System.out.println(searchQuery);
        categories.forEach(System.out::println);
        brands.forEach(System.out::println);
        System.out.println(sortBy);
        System.out.println(sortingOrder);
        System.out.println(minPrice);
        System.out.println(maxPrice);
        System.out.println(pageNumber);

        GenderType genderType = null;
        if (request.getParameter("genderType") != null) {
            try {
                genderType = GenderType.valueOf(request.getParameter("genderType"));
            } catch (IllegalArgumentException e) {
            }
        }

        System.out.println(genderType);

        ProductPageResponse responseData = productService.getSearchProducts(
                searchQuery, categories, brands, genderType, minPrice, maxPrice, sortBy, sortingOrder, pageNumber, Constants.DEFAULT_PAGE_SIZE);

        response.getWriter().print(gson.toJson(responseData));
    }

    private String getParameterOrDefault(HttpServletRequest request, String param, String defaultValue) {
        return request.getParameter(param) != null ? request.getParameter(param) : defaultValue;
    }

    private List<Long> parseIdsFromRequest(HttpServletRequest request, String param) {
        return request.getParameterValues(param) != null ?
                Arrays.stream(request.getParameterValues(param))
                        .map(Long::parseLong)
                        .collect(Collectors.toList()) : List.of();
    }

    private double parseDoubleOrDefault(HttpServletRequest request, String param, double defaultValue) {
        return request.getParameter(param) != null ? Double.parseDouble(request.getParameter(param)) : defaultValue;
    }

    private int parseIntOrDefault(HttpServletRequest request, String param, int defaultValue) {
        return request.getParameter(param) != null ? Integer.parseInt(request.getParameter(param)) : defaultValue;
    }
}
