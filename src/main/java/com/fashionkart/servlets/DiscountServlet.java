package com.fashionkart.servlets;

import com.fashionkart.entities.Discount;
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
import java.time.LocalDate;

@WebServlet("/controller/discount/add")
@Slf4j
public class DiscountServlet extends HttpServlet {

    private final DiscountService discountService = new DiscountServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Seller seller = (Seller)request.getSession().getAttribute("seller");
            if(seller == null){
                response.sendRedirect("/auth/sellers/login");
                return ;
            }

            // Retrieve categoryId from the form
            Long categoryId = Long.parseLong(request.getParameter("categoryId"));

            // Create new discount
            Discount discount = new Discount();
            discount.setCode(request.getParameter("code"));
            discount.setPercentage(Double.parseDouble(request.getParameter("percentage")));
            discount.setDescription(request.getParameter("description"));
            discount.setMinimumValue(Double.parseDouble(request.getParameter("minimumValue")));

            // Parse start and end dates using LocalDate.parse
            discount.setStartDate(LocalDate.parse(request.getParameter("startDate")).atStartOfDay());
            discount.setEndDate(LocalDate.parse(request.getParameter("endDate")).atStartOfDay());

            // Handle discount creation
            discountService.addDiscount(discount, seller.getId(), categoryId);

            // Redirect to a success page or the list of discounts
            response.sendRedirect("/sellers/dashboard?action=addDiscount");

        } catch (Exception e) {
            log.error("Error adding discount", e);
            request.setAttribute("errorMessage", "Failed to add discount. Please try again.");
            request.getRequestDispatcher("/sellers/dashboard?action=addDiscount").forward(request, response);
        }
    }
}
