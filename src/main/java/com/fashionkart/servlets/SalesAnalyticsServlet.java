package com.fashionkart.servlets;

import com.fashionkart.service.SalesService;
import com.fashionkart.serviceimpl.SalesServiceImpl;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/controller/sales-analytics")
@Slf4j
public class SalesAnalyticsServlet extends HttpServlet {

    private final SalesService salesService = new SalesServiceImpl();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Fetch sales data
            Map<String, Integer> productsSoldPerMonth = salesService.getProductsSoldPerMonth();

            // Convert data to JSON and send it as the response
            String json = gson.toJson(productsSoldPerMonth);
            response.getWriter().write(json);
        } catch (Exception e) {
            log.error("Error fetching sales analytics", e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Failed to fetch sales analytics.\"}");
        }
    }
}
