package com.fashionkart.servlets;

import com.fashionkart.payload.ProductPageResponse;
import com.fashionkart.service.ProductService;
import com.fashionkart.serviceimpl.ProductServiceImpl;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/controller/products")
@Slf4j
public class ProductsServlet extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
            long sellerId = Long.parseLong(request.getParameter("sellerId"));
            int pageSize = 10;

            ProductPageResponse pageResponse = productService.getProductsPageBySeller(sellerId, pageNumber, pageSize);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(new Gson().toJson(pageResponse));
        } catch (NumberFormatException e) {
            log.error("Invalid page number format", e);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid page number format");
        } catch (Exception e) {
            log.error("Error fetching products", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching products");
        }
    }
}
