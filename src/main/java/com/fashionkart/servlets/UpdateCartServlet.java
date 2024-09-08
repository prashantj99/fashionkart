package com.fashionkart.servlets;

import com.fashionkart.entities.ProductSize;
import com.fashionkart.entities.User;
import com.fashionkart.service.CartItemService;
import com.fashionkart.serviceimpl.CartItemServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cart/operation/update")
public class UpdateCartServlet extends HttpServlet {

    private final CartItemService cartItemService = new CartItemServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Long cartItemId = Long.parseLong(request.getParameter("cartItemId"));
            int requiredQuantity = Integer.parseInt(request.getParameter("requiredQuantity"));
            String selectedSizeStr = request.getParameter("selectedSize");
            ProductSize productSize = null;

            try {
                productSize = ProductSize.valueOf(selectedSizeStr);
            } catch (IllegalArgumentException | NullPointerException e) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Invalid or missing product size!");
                return;
            }

            User loggedInUser = (User) request.getSession().getAttribute("user");
            if (loggedInUser == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in.");
                return;
            }

            System.out.println(cartItemId);
            System.out.println(requiredQuantity);
            System.out.println(productSize.name());

            cartItemService.updateCartItem(loggedInUser.getId(), cartItemId, requiredQuantity, productSize);

            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            response.getWriter().write(e.getMessage());
        }
    }
}
