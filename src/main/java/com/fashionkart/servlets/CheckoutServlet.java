package com.fashionkart.servlets;

import com.fashionkart.entities.Address;
import com.fashionkart.entities.Cart;
import com.fashionkart.entities.User;
import com.fashionkart.entities.UserOrder;
import com.fashionkart.service.AddressService;
import com.fashionkart.service.CartService;
import com.fashionkart.service.OrderService;
import com.fashionkart.serviceimpl.AddressServiceImpl;
import com.fashionkart.serviceimpl.CartServiceImpl;
import com.fashionkart.serviceimpl.OrderServiceImpl;
import com.razorpay.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;

@WebServlet("/user/order/process")
public class CheckoutServlet extends HttpServlet {
    private final OrderService orderService = new OrderServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try{
            User loggedInUser = (User) request.getSession().getAttribute("user");
            String street = request.getParameter("street");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String country = request.getParameter("country");
            String zip = request.getParameter("zip");

            orderService.processCheckout(loggedInUser, street, city, state, country, zip);

            response.sendRedirect("/user/orders");
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
