package com.fashionkart.servlets;

import com.fashionkart.entities.User;
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
@WebServlet("/controller/wishlist/remove")
public class RemoveFromWishlistServlet extends HttpServlet {
    private final WishlistService wishlistService = new WishlistServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Long productId = Long.parseLong(request.getParameter("productId"));
        User loggedInUser = (User) request.getSession().getAttribute("user");

        if (loggedInUser == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("User not logged in");
            return;
        }

        try {
            // Remove the product from the user's wishlist
            wishlistService.removeProductFromWishlist(loggedInUser.getId(), productId);
            response.sendRedirect("/user/wishlist");
        } catch (Exception e) {
            log.error("Error removing product from wishlist", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
