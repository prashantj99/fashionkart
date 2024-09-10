package com.fashionkart.servlets;

import com.fashionkart.entities.User;
import com.fashionkart.service.UserService;
import com.fashionkart.serviceimpl.UserServiceImpl;
import com.fashionkart.utils.FirebaseStorageUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;

@WebServlet("/controller/update-avatar")
@MultipartConfig // Enables the servlet to handle file uploads
public class ProfileImageUploadServlet extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User loggedInUser = (User) request.getSession().getAttribute("user");

        // Get the uploaded image file
        Part filePart = request.getPart("profileImage");
        if (filePart == null || filePart.getSize() == 0) {
            request.getSession().setAttribute("errorMessage", "No file selected");
            response.sendRedirect("/user/account");
            return;
        }

        String fileName = filePart.getSubmittedFileName();
        String fileUrl = FirebaseStorageUtil.uploadFile(fileName, filePart.getInputStream());

        userService.updateProfileImage(loggedInUser.getId(), fileUrl);

        loggedInUser.setImage(fileUrl);
        request.getSession().setAttribute("user", loggedInUser);

        request.getSession().setAttribute("message", "Profile image updated successfully.");
        response.sendRedirect("/user/account");
    }
}
