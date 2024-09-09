<%@ page import="com.fashionkart.entities.Product" isELIgnored="false" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionkart.service.WishlistService" %>
<%@ page import="com.fashionkart.serviceimpl.WishlistServiceImpl" %>
<%@ page import="com.fashionkart.entities.User" %>
<%@ page import="com.fashionkart.utils.FirebaseStorageUtil" %>
<%@ page import="com.fashionkart.entities.ProductSize" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    User loggedInUser = (User) request.getSession().getAttribute("user");
    if(loggedInUser == null){
        response.sendRedirect("/auth/user/login");
        return;
    }
    WishlistService wishlistService = new WishlistServiceImpl();
    int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    int itemsPerPage = 5;
    List<Product> wishlistItems = wishlistService.getWishlistProductByUser(loggedInUser.getId(), currentPage, itemsPerPage);
    int totalItems = (int) wishlistService.countProductsInWishList(loggedInUser.getId());
    int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Wishlist</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="/js/cart.js"></script>
</head>
<body class="bg-gray-100">

<%--nav bar--%>
<%@include file="navbar.jsp"%>

<div class="container mx-auto p-6">
    <div class="flex justify-between items-center py-6">
        <div class="text-sm text-gray-600">
            <a href="#" class="text-gray-400">Home</a> /
            <a href="#" class="text-gray-400">Products</a> /
            <span class="text-gray-800 font-medium">Favourites</span>
        </div>
        <div class="text-gray-500"><%=totalItems%> items</div>
    </div>
    <!-- Wishlist Items -->
    <div class="grid grid-cols-5 gap-6">
        <% if(!wishlistItems.isEmpty()){
            for(Product product : wishlistItems){%>
            <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                <div class="relative w-full h-auto overflow-hidden">
                    <img src="<%=FirebaseStorageUtil.generateSignedUrl(product.getImages().get(0).getImageUrl())%>"
                         alt="<%=product.getName()%>"
                         class="w-full h-64 object-cover object-center transition-transform duration-300 ease-in-out hover:scale-105">
                    <form action="/controller/wishlist/remove" method="post">
                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                        <button type="submit" class="absolute top-2 right-2 bg-white rounded-full p-2 shadow-md hover:bg-gray-100 transition ease-in-out duration-200">
                            <svg class="w-5 h-5 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                            </svg>
                        </button>
                    </form>

                    <!-- Button for closing or additional actions -->
                </div>
                <div class="p-4">
                    <h2 class="text-lg font-medium"><%=product.getName()%></h2>
                    <p class="text-gray-500">INR <%=product.getPrice()%></p>
                    <p class="text-gray-400"><%=product.getQuantityAvailable() > 0 ? "In Stock" : "Out of Stock"%></p>
                    <select class="w-full mt-2 p-2 border border-gray-300 rounded-md">
                        <option>Size</option>
                        <%
                            for(ProductSize size: product.getAvailableSizes()){
                        %>
                            <option value="<%=size.name()%>"><%=size.name()%></option>
                        <%}%>
                    </select>
                    <button onclick="addToCart(<%=product.getId()%>)" class="mt-4 w-full bg-gray-800 text-white py-2 rounded-md flex items-center justify-center">
                        <img width="24" height="24" src="https://img.icons8.com/windows/32/shopping-cart.png" alt="shopping-cart"/>
                        Add to cart
                    </button>
                </div>
            </div>
        <%}%>
        <%} else {%>
            <div class="bg-white rounded-lg shadow-md p-4">
                <p class="text-gray-600 text-center">Your wishlist is empty.</p>
            </div>
        <%}%>
    </div>

    <!-- Pagination -->
    <div class="mt-6">
        <nav aria-label="Pagination">
            <ul class="inline-flex space-x-2">
                <!-- Previous button -->
                <% if(currentPage > 1){%>
                    <li>
                        <a href="?page=<%=currentPage - 1%>" class="px-3 py-2 bg-indigo-500 text-white rounded-lg hover:bg-indigo-600">Previous</a>
                    </li>
                <%}%>

                <!-- Page numbers -->
                <%
                    for(int i=1; i<=totalPages; i++){
                %>
                    <li>
                        <a href="?page=<%=i%>" class="px-3 py-2 rounded-lg <%= i == currentPage ? "bg-indigo-500 text-white" : "bg-gray-200 text-gray-700 hover:bg-gray-300" %>>
                                <%=i%>
                        </a>
                    </li>
                <%}%>

                <!-- Next button -->
                <% if(currentPage < totalPages){%>
                    <li>
                        <a href="?page=<%=currentPage - 1%>" class="px-3 py-2 bg-indigo-500 text-white rounded-lg hover:bg-indigo-600 ">
                            Next
                        </a>
                    </li>
                <%}%>
            </ul>
        </nav>
    </div>
</div>
</body>
</html>
