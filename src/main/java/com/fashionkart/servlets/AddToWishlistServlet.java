package com.fashionkart.servlets;

import com.fashionkart.entities.User;
import com.fashionkart.entities.Wishlist;
import com.fashionkart.service.WishlistService;
import com.fashionkart.serviceimpl.WishlistServiceImpl;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
@WebServlet("/controller/wishlist/add")
public class AddToWishlistServlet extends HttpServlet {
    private final WishlistService wishlistService = new WishlistServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long productId = Long.parseLong(request.getParameter("productId"));
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("User not logged in");
            return;
        }

        try {
            // Add the product to the user's wishlist
            wishlistService.addProductToWishlistofUser(user.getId(), productId);
            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write("Product added to wishlist");
        } catch (Exception e) {
            log.error("Error {}", e.getMessage());
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Error adding product to wishlist");
        }
    }
}
