package com.fashionkart.servlets;

import com.fashionkart.entities.Product;
import com.fashionkart.payload.Response;
import com.fashionkart.service.ProductService;
import com.fashionkart.serviceimpl.ProductServiceImpl;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet("/controller/product/operation")
@Slf4j
public class ProductOperationServlet extends HttpServlet {

    private final ProductService productService = new ProductServiceImpl();
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Read JSON data from request body
            BufferedReader reader = request.getReader();
            StringBuilder jsonBuilder = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }
            String json = jsonBuilder.toString();

            // Parse JSON data manually
            JsonObject jsonObject = JsonParser.parseString(json).getAsJsonObject();

            // Extract and convert fields manually
            String action = jsonObject.get("action").getAsString();
            Long productId = jsonObject.has("productId") ? jsonObject.get("productId").getAsLong() : null;
            log.debug(String.valueOf(productId));

            if ("delete".equals(action)) {
                productService.deleteProduct(productId);
                sendResponse(response, true);
            } else if ("edit".equals(action)) {
                String name = jsonObject.get("name").getAsString();
                double price = jsonObject.get("price").getAsDouble();
                int quantityAvailable = jsonObject.get("quantityAvailable").getAsInt();

                Product product = productService.getProductById(productId);
                product.setName(name);
                product.setPrice(price);
                product.setQuantityAvailable(quantityAvailable);
                productService.updateProduct(product);
                sendResponse(response, true);
            } else {
                sendResponse(response, false); // Invalid action
            }
        } catch (Exception e) {
            log.error("Error processing product request", e);
            sendResponse(response, false);
        }
    }

    private void sendResponse(HttpServletResponse response, boolean success) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(new Response(success)));
    }
}
