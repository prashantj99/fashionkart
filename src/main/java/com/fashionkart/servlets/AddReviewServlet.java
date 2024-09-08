package com.fashionkart.servlets;

import com.fashionkart.entities.User;
import com.fashionkart.service.ReviewService;
import com.fashionkart.serviceimpl.ReviewServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/controller/review/add")
public class AddReviewServlet extends HttpServlet {

    private final ReviewService reviewService = new ReviewServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedInUser = (User) request.getSession().getAttribute("user");

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        int rating = Integer.parseInt(request.getParameter("rating"));
        Long productId = Long.parseLong(request.getParameter("productId"));

        reviewService.addReview(title, content, rating, productId, loggedInUser.getId());

        response.sendRedirect("/product/detail?productId=8" + productId);
    }
}
