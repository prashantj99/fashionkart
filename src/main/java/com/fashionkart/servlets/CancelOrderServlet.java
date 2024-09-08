package com.fashionkart.servlets;

import com.fashionkart.entities.User;
import com.fashionkart.service.OrderService;
import com.fashionkart.serviceimpl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/controller/order/cancel")
public class CancelOrderServlet extends HttpServlet {
    private final OrderService orderService = new OrderServiceImpl();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            long orderId = Long.parseLong(req.getParameter("orderId"));
            User loggedInUser = (User) req.getSession().getAttribute("user");
            if(loggedInUser == null){
                resp.sendRedirect("/auth/user/login");
                return;
            }
            orderService.cancelOrder(loggedInUser.getId(), orderId);
            resp.sendRedirect("/user/orders");
        }catch (Exception e){
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
