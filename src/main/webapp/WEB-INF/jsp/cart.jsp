<%@ page import="com.fashionkart.service.CartService" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionkart.utils.FirebaseStorageUtil" %>
<%@ page import="com.fashionkart.entities.*" %>
<%@ page import="com.fashionkart.service.DiscountService" %>
<%@ page import="com.fashionkart.serviceimpl.DiscountServiceImpl" %>
<%@ page import="com.fashionkart.utils.Constants" %>
<%@ page import="com.fashionkart.service.CartItemService" %>
<%@ page import="com.fashionkart.serviceimpl.CartItemServiceImpl" %>
<%@ page import="com.fashionkart.serviceimpl.CartServiceImpl" %>
<%@ page isELIgnored="false" %>

<%
    User loggedInUser = (User) session.getAttribute("user");
    CartService cartService = new CartServiceImpl();
    CartItemService cartItemService = new CartItemServiceImpl();

    Cart cart = cartService.getCartByUser(loggedInUser);
    List<CartItem> cartItems = cartItemService.findAllCartItemsByCartId(cart.getId());
    DiscountService discountService = new DiscountServiceImpl();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        body {
            background-color: #f9fafb;
        }
        .sticky-nav {
            backdrop-filter: blur(10px);
            background-color: rgba(255, 255, 255, 0.8);
        }
        .cart-empty-icon {
            animation: pulse 2s infinite;
        }
        @keyframes pulse {
            0% {
                opacity: 0.7;
            }
            100% {
                opacity: 1;
            }
        }
        .quantity-btn:hover {
            background-color: #4f46e5;
            color: white;
        }
        .checkout-btn {
            background-color: #34d399;
            transition: all 0.3s ease;
        }
        .checkout-btn:hover {
            background-color: #10b981;
        }
    </style>
</head>
<body>

<%--Header--%>
<%@include file="navbar.jsp"%>
<!-- Cart Section -->
<section class="py-12">
    <div class="container mx-auto px-4">
        <h1 class="text-center text-4xl font-bold text-gray-900 mb-10">Your Shopping Cart</h1>

        <!-- Cart Items -->
        <div class="max-w-4xl mx-auto bg-white shadow-lg rounded-xl">
            <div class="p-6">
                <ul>
                    <%
                        if (!cartItems.isEmpty()) {
                            for (CartItem cartItem : cartItems) {
                                List<String> imageUrls = cartItem.getProduct().getImages().stream().map(ProductImage::getImageUrl).toList();
                                String imageUrl = !imageUrls.isEmpty() ? FirebaseStorageUtil.generateSignedUrl(imageUrls.get(0)) : "#";
                    %>
                    <li class="flex py-6 border-b border-gray-200">
                        <!-- Product Image -->
                        <div class="flex-shrink-0">
                            <img class="h-28 w-28 rounded-lg object-cover" src="<%= imageUrl %>" alt="<%= cartItem.getProduct().getName() %>" />
                        </div>

                        <!-- Product Details -->
                        <div class="ml-6 flex-1">
                            <div class="flex justify-between items-center">
                                <div>
                                    <h3 class="text-lg font-semibold text-gray-900">
                                        <a href="/product/detail?productId=<%=cartItem.getProduct().getId()%>" target="_blank" class="text-xl no-underline cursor-pointer">
                                            <%= cartItem.getProduct().getName() %>
                                        </a>
                                    </h3>
                                    <label for="product-<%=cartItem.getId()%>-size" class="text-sm text-gray-500">Size</label>
                                    <select class="size-select ml-2 text-sm bg-gray-100 p-2 rounded-md"
                                            id="product-<%=cartItem.getId()%>-size"
                                            onchange="updateCart(<%= cartItem.getId() %>)">

                                        <% for (ProductSize size : ProductSize.values()) { %>
                                            <option value="<%= size %>" <%= size.equals(cartItem.getSelectedSize()) ? "selected" : "" %>>
                                                <%= size %>
                                            </option>
                                        <% } %>
                                    </select>
                                </div>

                                <!-- Pricing with Discount -->
                                <%
                                    Discount bestDiscount = discountService.getBestDiscountForProduct(cartItem.getProduct().getId());
                                    double discountedPrice = bestDiscount != null ? cartItem.getProduct().getPrice() - (cartItem.getProduct().getPrice() * bestDiscount.getPercentage() / 100) : cartItem.getProduct().getPrice();
                                %>
                                <p class="text-2xl font-bold text-green-600">&#x20B9;<span id="product-price"><%= discountedPrice %></span></p>
                            </div>

                            <!-- Quantity and Remove -->
                            <div class="flex justify-between items-end mt-4">
                                <div class="flex items-center space-x-2">
                                    <button class="px-4 py-2 bg-gray-200 rounded-l-lg quantity-btn"
                                            onclick="updateCart(<%= cartItem.getId() %>, -1)">-</button>
                                    <input type="text" class="w-12 h-9 text-center bg-gray-100 border rounded-md text-xl" id="cart-item-<%=cartItem.getId()%>-quantity" value="<%= cartItem.getQuantity() %>" readonly />
                                    <button class="px-4 py-2 bg-gray-200 rounded-r-lg quantity-btn"
                                            onclick="updateCart(<%= cartItem.getId() %>, 1)">+</button>
                                </div>
                                <button type="button" class="text-gray-500 hover:text-red-600"
                                        onclick="removeFromCart(<%= cartItem.getId() %>)">
                                    <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </li>
                    <%
                        }
                    } else {
                    %>
                    <div class="flex flex-col items-center justify-center h-96">
                        <img width="100" height="100" src="https://img.icons8.com/bubbles/100/shopping-cart.png" alt="shopping-cart"/>
                        <div class="text-center">
                            <h4 class="text-2xl font-semibold text-gray-700">Your Cart is Empty</h4>
                            <a href="/index"
                               class="mt-4 outline inline-block px-6 py-3 bg-gradient-to-r from-blue-500 to-blue-600 text-white font-semibold rounded-lg shadow-lg transition-all duration-300 ease-in-out hover:bg-gradient-to-r hover:from-blue-600 hover:to-blue-700 hover:shadow-xl focus:outline-none focus:ring-4 focus:ring-blue-300">
                                Continue Shopping
                            </a>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </ul>
            </div>

            <% if (!cartItems.isEmpty()) { %>
            <div class="flex flex-col justify-between items-center p-6 border-t border-gray-200 bg-gray-50">
                <%
                    // Calculate the total cart value including the best discount
                    double totalCartValue = cartService.calculateCartTotalWithBestDiscount(cart);
                    // Check if free shipping is applicable
                    boolean isFreeShippingApplicable = totalCartValue >= Constants.DEFAULT_MIN_CART_VALUE;
                %>

                <!-- Cart Summary Section -->
                <div class="flex justify-between text-lg font-semibold text-gray-900 mb-6 w-full">
                    <span>Cart Total</span>
                    <p>&#x20B9;
                        <span id="cart-total">
                            <%= String.format("%.2f", totalCartValue + (isFreeShippingApplicable ? 0 : Constants.DEFAULT_SHIPPING_CHARGE)) %>
                            </span>
                    </p>
                </div>
                <div class="flex justify-between w-full">
                    <!-- Free Shipping Message -->
                    <div class="text-sm text-gray-600">
                        <% if (!isFreeShippingApplicable) { %>
                            <p class="text-red-600">
                                Add more items to be eligible for free shipping! Free shipping on orders above &#x20B9; <%= Constants.DEFAULT_MIN_CART_VALUE %>.
                            </p>
                        <% } else { %>
                            <p class=" text-green-600">
                                Free shipping applied!
                            </p>
                        <% } %>
                    </div>
                    <%--   Checkout Button--%>
                    <a href="/user/checkout" class="checkout-btn px-6 py-3 text-white text-lg rounded-md font-semibold hover:bg-green-600">
                        Checkout
                    </a>
                </div>
            </div>
            <% } %>

        </div>
    </div>
</section>

<script src="/js/cart.js" defer></script>

</body>
</html>
