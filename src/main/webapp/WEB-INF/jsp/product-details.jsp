<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionkart.utils.FirebaseStorageUtil" %>
<%@ page import="com.fashionkart.entities.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.fashionkart.service.*" %>
<%@ page import="com.fashionkart.serviceimpl.*" %>

<%
    User loggedInUser = session.getAttribute("user") == null ? null : ((User)(session.getAttribute("user")));
    ProductService productService = new ProductServiceImpl();
    DiscountService discountService = new DiscountServiceImpl();
    SellerService sellerService = new SellerServiceImpl();
    try {
        Long productId = Long.parseLong(request.getParameter("productId"));
        Product product = productService.getProductById(productId);
        Seller seller = sellerService.findById(product.getSeller().getId()).orElseThrow(() -> new RuntimeException("Seller not found!!!"));
        Discount discount = discountService.getBestDiscountForProduct(product.getId());

        request.setAttribute("product", product);
        request.setAttribute("seller", seller);
        request.setAttribute("discount", discount);

    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        return;
    }
%>
<%
    Product product = (Product) request.getAttribute("product");
    Seller seller = (Seller) request.getAttribute("seller");
    Discount discount = (Discount)request.getAttribute("discount");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product.getName() %> - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="/js/cart.js"></script>
    <style>
        /* Custom styles for the image gallery */
        .thumbnail:hover {
            border: 2px solid #1a202c;
        }

        .active-thumbnail {
            border: 2px solid #4a5568;
        }

        .size-chip {
            transition: background-color 0.3s, color 0.3s, box-shadow 0.3s;
        }

        .size-chip.selected {
            background-color: #34D399; /* Tailwind's emerald-400 */
            color: #ffffff;
            box-shadow: 0 0 8px rgba(52, 211, 153, 0.6); /* Glow effect */
        }

        .size-chip:hover {
            background-color: #D1D5DB; /* Tailwind's gray-300 */
        }
    </style>
</head>
<body class="bg-gray-100">

<%@include file="navbar.jsp"%>

<!-- Product Details Section -->
<main class="container mx-auto mt-8 h-screen pr-10 pl-10">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
        <!-- Image Gallery -->
        <div class="flex flex-row items-start space-x-4">
            <!-- Thumbnails -->
            <div class="flex flex-col space-y-4 overflow-y-auto ">
                <% int imgIndex = 0;
                    for (ProductImage image : product.getImages()) { %>
                <img src="<%= FirebaseStorageUtil.generateSignedUrl(image.getImageUrl()) %>"
                     alt="<%= product.getName() %>"
                     data-index="<%= imgIndex %>"
                     class="thumbnail w-20 h-20 object-contain rounded-lg cursor-pointer hover:opacity-80 transition-opacity duration-200" />
                <%
                        imgIndex++;
                    }
                %>
            </div>

            <!-- Main Image -->
            <div class="ml-5 relative h-300 w-200 md:h-[32rem] bg-gray-100 rounded-lg overflow-hidden shadow-md">
                <img id="main-image"
                     src="<%= FirebaseStorageUtil.generateSignedUrl(product.getImages().get(0).getImageUrl()) %>"
                     alt="<%= product.getName() %>"
                     class="w-full h-full object-contain">
            </div>
        </div>

        <!-- Product Information -->
        <div class="space-y-6">
            <h1 class="text-xl font-semibold text-gray-900"><%= product.getName() %>
            </h1>
            <p class="text-lg text-gray-600"><%= product.getBrand().getName() %>
                | <%= product.getCategory().getName() %>
            </p>

            <!-- Product Price Section -->
            <p class="text-2xl font-semibold text-gray-800">
                <!-- If discount is available, show original price with strike-through -->
                <% if (discount != null) {
                    // Calculate the discounted price
                    double discountedPrice = product.getPrice() - (product.getPrice() * discount.getPercentage() / 100);
                %>
                    <!-- Original Price with strike-through -->
                    <span class="line-through text-red-500">&#x20B9;<%= product.getPrice() %></span>
                    <!-- Discounted Price -->
                    <span class="ml-2 text-green-600">&#x20B9;<%= String.format("%.2f", discountedPrice) %></span>
                <% } else { %>
                    <!-- No discount, just show the original price -->
                    &#x20B9;<span id="product-price"><%= product.getPrice() %></span>
                <% } %>
            </p>

            <%-- Product Sizes Section --%>
            <div class="mt-6">
                <h2 class="text-lg font-semibold text-gray-800">Available Sizes</h2>
                <div class="flex flex-wrap gap-2 mt-2">
                    <% List<ProductSize> sizes = product.getAvailableSizes(); %>
                    <% for (ProductSize size : sizes) { %>
                    <button
                            type="button"
                            class="size-chip bg-gray-200 text-gray-800 px-4 py-2 rounded-full cursor-pointer transition-all duration-300 ease-in-out"
                            data-size="<%= size.name() %>">
                        <%= size.name() %>
                    </button>
                    <% } %>
                </div>
            </div>



            <% if (product.getQuantityAvailable() > 0) { %>
                <% if (product.getQuantityAvailable() < 20) { %>
                    <p class="text-red-700 font-medium">Only a few left in stock!</p>
                <% } else { %>
                    <p class="text-green-500 font-medium">In Stock</p>
                <% } %>
            <% } else { %>
                <p class="text-red-500 font-medium">Out of Stock</p>
            <% } %>


            <!-- Discount Information -->
            <% if (discount != null) { %>
                <div class="bg-gray-100 p-4 rounded-lg shadow-md mt-4">
                    <div class="bg-yellow-500 text-white px-4 py-3 rounded-lg flex justify-between items-center">
                        <div>
                            <span class="font-bold text-lg">
                                Discount Code <%=discount.getCode()%>
                            </span>
                            <p class="mt-1 text-sm">
                                <%=discount.getDescription()%>
                            </p>
                        </div>
                        <span class="bg-white text-yellow-500 px-3 py-1 rounded-full text-sm font-semibold hover:bg-yellow-600 hover:text-white transition-colors duration-200 ml-4">
                            Applied!
                        </span>
                    </div>
                    <p class="text-yellow-600 text-sm mt-2">You saved <%=discount.getPercentage()%>% on this product!</p>
                </div>
            <% } else { %>
                <div class="bg-red-50 p-4 rounded-lg shadow-md mt-4">
                    <p class="text-red-600 text-center font-semibold">No discounts available for this product.</p>
                </div>
            <% } %>


            <!-- Action Buttons -->
            <div class="flex space-x-4 mt-6">
                <button id="add-to-cart-btn"
                        class="flex-1 flex items-center justify-center bg-pink-500 text-white px-6 py-6 rounded-lg hover:bg-pink-600 transition-colors duration-200 text-lg font-semibold">
                    <img width="24" height="24" src="https://img.icons8.com/ios/50/shopping-bag--v1.png"
                         alt="shopping-bag--v1"/>&nbsp;&nbsp; Add to Cart
                </button>
                <button onclick="addToWishList(<%=product.getId()%>)" id="add-to-wishlist-btn"
                        class="flex-1 flex items-center justify-center bg-gray-400 text-gray-700 px-6 py-6 rounded-lg hover:bg-gray-500 transition-colors duration-200 text-lg font-semibold">
                    <img width="24" height="24" src="https://img.icons8.com/ios/50/like--v1.png" alt="like--v1"/>&nbsp;&nbsp;
                    Wishlist
                </button>
            </div>

            <!-- Seller Info -->
            <div class="relative mt-4">
                <h2 class="text-lg font-semibold text-gray-800 hover:text-blue-500 cursor-pointer flex items-center"
                    id="seller-name">
                    <span class="mr-2">Seller:</span>
                    <span class="underline decoration-dotted underline-offset-4 decoration-blue-500 transition-all duration-300">
                        <%= seller.getName() %>
                    </span>
                    <svg class="ml-2 w-4 h-4 text-blue-500 transform transition-transform duration-300"
                         xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 10l7 7 7-7"></path>
                    </svg>
                </h2>

                <!-- Popover -->
                <div id="popover"
                     class="hidden absolute z-10 w-80 p-4 bg-white border border-gray-200 rounded-xl shadow-2xl text-gray-700 mt-2 transition-opacity duration-300 opacity-0">
                    <div class="flex items-center mb-3">
                        <h3 class="text-lg font-semibold text-gray-900"><%= seller.getName() %></h3>
                    </div>
                    <p class="text-sm text-gray-700 mb-2">
                        <%= seller.getBusinessAddress() %>
                    </p>
                    <p class="text-sm mt-2 flex items-center justify-between w-full">
                        <img width="24" height="24" src="https://img.icons8.com/ios/50/apple-phone.png" alt="apple-phone"/>
                        <strong><%= seller.getSupportContact() %></strong>
                    </p>
                    <p class="text-sm mt-2 flex items-center justify-between w-full">
                        <img width="24" height="24" src="https://img.icons8.com/material-rounded/24/support.png" alt="support"/>
                        <strong><%= seller.getSupportEmail() %></strong>
                    </p>
                </div>
            </div>


            <!-- Description -->
            <div class="mt-6">
                <h2 class="text-lg font-semibold text-gray-800">Description</h2>
                <p class="text-gray-700 mt-2"><%= product.getDescription() %>
                </p>
            </div>
        </div>
    </div>
</main>
<%
    ReviewService reviewService = new ReviewServiceImpl();

    Map<Integer, Long> ratingBreakDown = reviewService.getRatingBreakdownForProduct(product.getId());

    long totalRatings = ratingBreakDown.values().stream().mapToLong(Long::longValue).sum();

    double overallRating = reviewService.calculateOverallRatingForProduct(product.getId());
    int fullStars = (int) overallRating;
    boolean hasHalfStar = (overallRating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
%>
<%--Product Review Start--%>
<div class="container mx-auto p-8 grid grid-cols-1 md:grid-cols-2 gap-8">
    <!-- Average Rating Section -->
    <div class="bg-white p-6 rounded-lg shadow-md">
        <h2 class="text-xl font-semibold mb-4">Average Rating</h2>
        <div class="flex items-center mb-4">
            <span class="text-4xl font-bold"><%= String.format("%.1f", overallRating) %></span>
            <div class="ml-2 flex items-center text-yellow-500 text-2xl relative">
                <!-- Full Stars -->
                <% for(int i=0; i<fullStars; i++){ %>
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
                        <path fill="#FFD700" d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.781 1.53 8.297L12 18.897l-7.466 4.487 1.53-8.297L.001 9.306l8.332-1.151z"></path>
                    </svg>
                <%}%>
                <% if (hasHalfStar) { %>
                <!-- Half Star -->
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
                    <defs>
                        <linearGradient id="halfGrad">
                            <stop offset="50%" stop-color="#FFD700"></stop>
                            <stop offset="50%" stop-color="#D3D3D3"></stop>
                        </linearGradient>
                    </defs>
                    <path fill="url(#halfGrad)" d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.781 1.53 8.297L12 18.897l-7.466 4.487 1.53-8.297L.001 9.306l8.332-1.151z"></path>
                </svg>

                <% } %>
                <!-- Empty Stars -->
                <% for(int i=0; i<emptyStars; i++){ %>
                    <svg width="24" height="24" xmlns="http://www.w3.org/2000/svg" fill-rule="evenodd" clip-rule="evenodd">
                        <path d="M15.668 8.626l8.332 1.159-6.065 5.874 1.48 8.341-7.416-3.997-7.416 3.997 1.481-8.341-6.064-5.874 8.331-1.159 3.668-7.626 3.669 7.626zm-6.67.925l-6.818.948 4.963 4.807-1.212 6.825 6.068-3.271 6.069 3.271-1.212-6.826 4.964-4.806-6.819-.948-3.002-6.241-3.001 6.241z"></path>
                    </svg>
                <%}%>
            </div>
        </div>

        <!-- Rating Breakdown -->
        <div class="space-y-1">
            <% for (int i = 5; i >= 1; i--) { %>
            <div class="flex items-center">
                <span class="w-8"><%= i %></span>
                <div class="flex-1 h-3 bg-gray-200 rounded-full ml-2">
                    <%
                        Long count = ratingBreakDown.getOrDefault(i, 5L);

                        // Calculate the percentage
                        String percentage = totalRatings == 0 ? "0%" : String.format("%.0f%%", (double) count / totalRatings * 100);
                    %>
                    <div class="h-3 bg-green-600 rounded-full" style=" width: <%= percentage %>;"></div>
                </div>
                <span class="ml-2 text-gray-600"><%= percentage %></span>
            </div>
            <% } %>
        </div>
    </div>
    <% if(loggedInUser != null && reviewService.isUserAllowedToGiveReview(loggedInUser.getId(), product.getId())){%>
        <!-- Submit Your Review Section -->
        <div class="bg-white p-6 rounded-lg shadow-md">
            <h2 class="text-xl font-semibold mb-4">Submit Your Review</h2>
            <form action="/controller/review/add" method="POST" class="space-y-4">
                <!-- Hidden Input for Product ID -->
                <input type="hidden" name="productId" value="<%= product.getId() %>">

                <!-- Rating Emojis -->
                <div>
                    <div id="emoji-rating" class="flex text-4xl space-x-3">
                        <!-- Emoji rating (radio inputs) -->
                        <input type="radio" id="emoji1" name="rating" value="1" class="hidden">
                        <label for="emoji1" class="cursor-pointer hover:scale-125 transition-transform">
                            &#x1F620;
                        </label>

                        <input type="radio" id="emoji2" name="rating" value="2" class="hidden">
                        <label for="emoji2" class="cursor-pointer hover:scale-125 transition-transform">
                            &#x1F615;
                        </label>

                        <input type="radio" id="emoji3" name="rating" value="3" class="hidden">
                        <label for="emoji3" class="cursor-pointer hover:scale-125 transition-transform">
                            &#x1F610;
                        </label>

                        <input type="radio" id="emoji4" name="rating" value="4" class="hidden">
                        <label for="emoji4" class="cursor-pointer hover:scale-125 transition-transform">
                            &#128512;
                        </label>

                        <input type="radio" id="emoji5" name="rating" value="5" class="hidden">
                        <label for="emoji5" class="cursor-pointer hover:scale-125 transition-transform">
                            &#128525;
                        </label>
                    </div>
                    <!-- Display selected rating -->
                    <div id="rating-result" class="mt-2 text-lg font-semibold text-gray-700"></div>
                </div>

                <!-- Title Input -->
                <div>
                    <label for="title" class="block mb-2 font-semibold">Review Title <span class="text-red-500">*</span></label>
                    <input type="text" id="title" name="title" class="w-full border border-gray-300 rounded-lg p-2" placeholder="Review title" required />
                </div>

                <!-- Review Content Input -->
                <div>
                    <label for="content" class="block mb-2 font-semibold">Write Your Review <span class="text-red-500">*</span></label>
                    <textarea id="content" name="content" rows="4" class="w-full border border-gray-300 rounded-lg p-2" placeholder="Write here..." required></textarea>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded-lg hover:bg-green-700">Submit Review</button>
            </form>
        </div>
    <%}%>
</div>

<!-- Customer Feedbacks Section -->
<div class="container mx-auto p-8 mt-8">
    <h2 class="text-xl font-semibold mb-4">Customer Feedbacks</h2>

    <div class="space-y-6">
        <%
            int currentPage = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
            int reviewsPerPage = 5;
            int totalReviews = reviewService.getTotalReviewsCount(product.getId());
            int totalPages = (int) Math.ceil((double) totalReviews / reviewsPerPage);

            List<Review> reviews = reviewService.getReviewsByProductId(product.getId(), currentPage, reviewsPerPage);
            for(Review review : reviews) {
        %>
        <!-- Single Feedback -->
        <div class="bg-white p-6 rounded-lg shadow-md">
            <div class="flex justify-between mb-2">
                <span class="font-semibold"><%=review.getUser().getFirstName() + " " + review.getUser().getLastName()%></span>
                <span class="text-gray-400 text-sm">
                    <%= java.time.temporal.ChronoUnit.DAYS.between(review.getReviewDate(), java.time.LocalDate.now()) %> days ago
                </span>
            </div>
            <div class="ml-2 flex items-center text-yellow-500 text-2xl">
                <!-- Star Ratings (Logic to render stars) -->
                <% for (int i = 0; i < review.getRating(); i++) { %>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" fill="#FFD700">
                    <path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.781 1.53 8.297L12 18.897l-7.466 4.487 1.53-8.297L.001 9.306l8.332-1.151z"></path>
                </svg>
                <% } %>
                <% for (int i = review.getRating(); i < 5; i++) { %>
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24" fill="#D3D3D3">
                    <path d="M12 .587l3.668 7.568 8.332 1.151-6.064 5.781 1.53 8.297L12 18.897l-7.466 4.487 1.53-8.297L.001 9.306l8.332-1.151z"></path>
                </svg>
                <% } %>
            </div>
            <p class="text-gray-700 mt-2"><%=review.getContent()%></p>
        </div>
        <% } %>
    </div>

    <!-- Pagination Controls -->
    <div class="flex justify-center mt-6">
        <nav aria-label="Pagination">
            <ul class="inline-flex items-center space-x-2">
                <!-- Previous Button -->
                <% if (currentPage > 1) { %>
                <li>
                    <a href="?page=<%= currentPage - 1 %>" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300">Previous</a>
                </li>
                <% } else { %>
                <li>
                    <span class="px-4 py-2 bg-gray-200 text-gray-400 rounded-lg">Previous</span>
                </li>
                <% } %>

                <!-- Page Numbers -->
                <% for (int i = 1; i <= totalPages; i++) { %>
                <% if (i == currentPage) { %>
                <li>
                    <span class="px-4 py-2 bg-green-600 text-white rounded-lg"><%= i %></span>
                </li>
                <% } else { %>
                <li>
                    <a href="?page=<%= i %>" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300"><%= i %></a>
                </li>
                <% } %>
                <% } %>

                <!-- Next Button -->
                <% if (currentPage < totalPages) { %>
                <li>
                    <a href="?page=<%= currentPage + 1 %>" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-lg hover:bg-gray-300">Next</a>
                </li>
                <% } else { %>
                <li>
                    <span class="px-4 py-2 bg-gray-200 text-gray-400 rounded-lg">Next</span>
                </li>
                <% } %>
            </ul>
        </nav>
    </div>
</div>


<%--Product Review End--%>
<!-- Related Products Section -->
<section class="container mx-auto mt-12 p-10">
    <h2 class="text-xl font-semibold text-gray-900 mb-4">Related Products</h2>
    <div class="grid grid-cols-3 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-3 gap-3">
    <%
            List<Product> relatedProducts = productService.getSimilarProducts(product);
            for (Product relatedProduct : relatedProducts) {
        %>
        <div class="relative w-full max-w-sm rounded-lg bg-white shadow-lg transition-transform transform hover:scale-105">
            <a href="/product/detail?productId=<%=relatedProduct.getId()%>">
                <img class="w-full h-auto object-cover rounded-t-lg lazyload" src="<%=FirebaseStorageUtil.generateSignedUrl(relatedProduct.getImages().get(0).getImageUrl())%>"
                     alt="product image"/>
            </a>
            <div class="p-5">
                <a href="#">
                    <h5 class="text-xl font-semibold text-gray-900 truncate"><%=relatedProduct.getName()%>
                    </h5>
                </a>
                <div class="mt-2.5 mb-4 flex items-center">
                    <span class="mr-2 rounded bg-yellow-200 px-2.5 py-0.5 text-xs font-semibold text-yellow-800">5.0</span>
                    <% for (int i = 0; i < 5; i++) {%>
                    <svg aria-hidden="true" class="h-5 w-5 text-yellow-300" fill="currentColor" viewBox="0 0 20 20"
                         xmlns="http://www.w3.org/2000/svg">
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                    </svg>
                    <%}%>
                </div>
                <div class="flex items-center justify-between mt-4">
                    <p class="text-2xl font-bold text-gray-900">&#x20B9;<%=relatedProduct.getPrice()%>
                    </p>
                    <div class="flex space-x-2">
                        <a href="#"
                           class="bg-blue-600 flex items-center rounded-md px-3 py-2 text-white text-sm font-medium hover:bg-blue-700 focus:outline-none focus:ring-4 focus:ring-blue-300 transition-colors">
                            <img width="20" height="20" src="https://img.icons8.com/ios-glyphs/30/shopping-cart--v1.png"
                                 alt="shopping-cart--v1" class="mr-1"/>
                        </a>
                        <a href="#"
                           class="bg-red-600 flex items-center rounded-md px-3 py-2 text-white text-sm font-medium hover:bg-red-700 focus:outline-none focus:ring-4 focus:ring-red-300 transition-colors">
                            <img width="20" height="20"
                                 src="https://img.icons8.com/external-tulpahn-flat-tulpahn/64/external-wishlist-online-shopping-tulpahn-flat-tulpahn.png"
                                 alt="wishlist" class="mr-1"/>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gray-800 text-white p-4 mt-8">
    <div class="container mx-auto text-center">
        <p>&copy; 2024 FashionKart. All Rights Reserved.</p>
    </div>
</footer>

<script>
    $(document).ready(function () {

        let selectedSize = null; // store the selected size

        $('input[name="rating"]').on('change', function() {
            $('#rating-result').text(`You gave: ${$(this).val()}`);
        });

        $(document).on('click', '.size-chip', function () {
            // Remove 'selected' class from all size chips
            $('.size-chip').removeClass('selected');

            // Add 'selected' class to the clicked size chip
            $(this).addClass('selected');

            // Store the selected size from the data-size attribute
            selectedSize = $(this).data('size');
            console.log('Selected size:', selectedSize); // Debug log
        });

        // Add to Cart Button Click
        $('#add-to-cart-btn').on('click', ()=>{
            addToCart(<%=product.getId()%>, selectedSize || "L");
        });

        // Thumbnail Click Event
        $('.thumbnail').on('click', function () {
            var imgSrc = $(this).attr('src');
            $('#main-image').attr('src', imgSrc);
            $('.thumbnail').removeClass('active-thumbnail');
            $(this).addClass('active-thumbnail');
        });

        let $sellerName = $('#seller-name');
        let $popover = $('#popover');

        // Show popover on hover
        $sellerName.hover(
            function () { // Mouse enter
                $popover.removeClass('hidden').addClass('opacity-100').css('transform', 'translateY(10px)');
                $sellerName.find('svg').addClass('rotate-180');
            },
            function () { // Mouse leave
                // Hide popover only if mouse is not over the popover itself
                setTimeout(function () {
                    if (!$popover.is(':hover')) {
                        $popover.addClass('opacity-0').css('transform', 'translateY(0)').addClass('hidden');
                        $sellerName.find('svg').removeClass('rotate-180');
                    }
                }, 100);
            }
        );

        // Keep popover visible if mouse enters the popover
        $popover.hover(
            function () { // Mouse enter
                $popover.removeClass('opacity-0').addClass('opacity-100');
            },
            function () { // Mouse leave
                $popover.addClass('opacity-0').css('transform', 'translateY(0)').addClass('hidden');
                $sellerName.find('svg').removeClass('rotate-180');
            }
        );
    });
</script>
</body>
</html>
