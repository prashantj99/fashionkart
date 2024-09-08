package com.fashionkart.servlets;

import com.fashionkart.entities.Seller;
import com.fashionkart.service.DiscountService;
import com.fashionkart.serviceimpl.DiscountServiceImpl;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/controller/discount/delete")
@Slf4j
public class DiscountManageServlet extends HttpServlet {

    private final DiscountService discountService = new DiscountServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Seller seller = (Seller) request.getSession().getAttribute("seller");
            if (seller == null) {
                response.sendRedirect("/auth/sellers/login");
                return;
            }

            Long discountId = Long.parseLong(request.getParameter("id"));

            if (discountService.isDiscountOwnedBySeller(discountId, seller.getId())) {
                discountService.deleteDiscount(discountId);
                request.setAttribute("successMessage", "Discount successfully deleted.");
            } else {
                request.setAttribute("errorMessage", "You do not have permission to delete this discount.");
            }

            request.getRequestDispatcher("/sellers/dashboard?action=manageDiscounts").forward(request, response);

        } catch (Exception e) {
            log.error("Error deleting discount", e);
            request.setAttribute("errorMessage", "Failed to delete discount. Please try again.");
            request.getRequestDispatcher("/sellers/dashboard?action=manageDiscounts").forward(request, response);
        }
    }
}
