package com.fashionkart.filters;

import com.fashionkart.entities.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        ServletContext context = filterConfig.getServletContext();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestURI = httpRequest.getRequestURI();

        // Check if the request is for private areas
        if (requestURI.startsWith("/sellers")) {
            if (session == null || session.getAttribute("seller") == null) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/auth/sellers/login");
                return;
            }

        } else if (requestURI.startsWith("/brand")) {
            if (session == null || session.getAttribute("brand") == null) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/auth/brand/login");
                return;
            }

        } else if (requestURI.startsWith("/user")) {
            if (session == null || session.getAttribute("user") == null) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/auth/user/login");
                return;
            }
        } else if (requestURI.startsWith("/admin")) {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/auth/user/login");
                return;
            }
            if(!user.isAdmin()){
                httpResponse.sendError(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
