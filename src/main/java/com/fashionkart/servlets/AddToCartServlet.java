package com.fashionkart.servlets;

import com.fashionkart.entities.ProductSize;
import com.fashionkart.entities.User;
import com.fashionkart.service.CartService;
import com.fashionkart.serviceimpl.CartServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cart/operation/add")
public class AddToCartServlet extends HttpServlet {

    private final CartService cartService = new CartServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long productId = Long.parseLong(request.getParameter("productId"));
        User user = (User) request.getSession().getAttribute("user");

        String selectedSizeStr = request.getParameter("selectedSize");
        ProductSize productSize = null;

        try {
            productSize = ProductSize.valueOf(selectedSizeStr);
        } catch (IllegalArgumentException | NullPointerException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid or missing product size!");
            return;
        }

        // Check if user is logged in
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("User not logged in");
            return;
        }

        // Add product to cart
        cartService.addProductToCart(user.getId(), productId, 1, productSize);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write("Product added to cart");
    }
}
