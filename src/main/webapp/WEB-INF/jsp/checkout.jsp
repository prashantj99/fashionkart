<%@ page import="com.fashionkart.service.CartService" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionkart.entities.*" %>
<%@ page import="com.fashionkart.serviceimpl.CartServiceImpl" %>
<%@ page import="com.fashionkart.service.DiscountService" %>
<%@ page import="com.fashionkart.serviceimpl.DiscountServiceImpl" %>
<%@ page import="com.fashionkart.serviceimpl.CartItemServiceImpl" %>
<%@ page import="com.fashionkart.service.CartItemService" %>
<%@ page import="com.fashionkart.utils.FirebaseStorageUtil" %>
<%@ page import="com.fashionkart.utils.Constants" %>
<%@ page isELIgnored="false" %>

<%
    User loggedInUser = (User) session.getAttribute("user");
    CartService cartService = new CartServiceImpl();
    CartItemService cartItemService = new CartItemServiceImpl();
    Cart cart = cartService.getCartByUser(loggedInUser.getId());
    List<CartItem> cartItems = cartItemService.findAllCartItemsByCartId(cart.getId());
    DiscountService discountService = new DiscountServiceImpl();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/razorpay@2.1.3/dist/checkout.js"></script>
</head>
<body class="bg-gray-100">

<!-- Header -->
<%@include file="navbar.jsp"%>
<!-- Checkout Section -->
<section class="container mx-auto p-2">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
        <!-- Product List -->
        <div class="bg-white p-2 rounded-xl shadow-md border border-gray-200">
            <h3 class="text-xl font-semibold mb-2 text-gray-900">Your Cart Items</h3>

            <!-- Cart Items -->
            <div class="space-y-3">
                <ul>
                    <% if (!cartItems.isEmpty()) { %>
                    <% for (CartItem cartItem : cartItems) {
                        List<String> imageUrls = cartItem.getProduct().getImages().stream().map(ProductImage::getImageUrl).toList();
                        String imageUrl = !imageUrls.isEmpty() ? FirebaseStorageUtil.generateSignedUrl(imageUrls.get(0)) : "#";
                    %>
                        <li class="flex py-6 border-b border-gray-300">
                            <!-- Product Image -->
                            <div class="flex-shrink-0">
                                <img class="h-24 w-24 rounded-lg object-cover" src="<%= imageUrl %>"
                                     alt="<%= cartItem.getProduct().getName() %>"/>
                            </div>

                            <!-- Product Details -->
                            <div class="ml-6 flex-1">
                                <div class="flex justify-between items-start">
                                    <div>
                                        <h3 class="text-xl font-semibold text-gray-800">
                                            <a href="/product/detail?productId=<%= cartItem.getProduct().getId() %>"
                                               target="_blank" class="hover:underline">
                                                <%= cartItem.getProduct().getName() %>
                                            </a>
                                        </h3>
                                        <p class="text-sm text-gray-600">Selected Size:
                                            <strong><%=cartItem.getSelectedSize()%>
                                            </strong></p>
                                        <p class="text-sm text-gray-600">Quantity: <strong><%=cartItem.getQuantity()%>
                                        </strong></p>
                                    </div>
                                    <div class="text-right">
                                        <%
                                            Discount bestDiscount = discountService.getBestDiscountForProduct(cartItem.getProduct().getId());
                                            double originalPrice = cartItem.getProduct().getPrice();
                                            double discountValue = bestDiscount != null ? originalPrice * bestDiscount.getPercentage() / 100.0 : 0;
                                            double discountedPrice = originalPrice - discountValue;
                                        %>
                                        <p class="text-lg font-semibold text-gray-800 mb-1">
                                            <span class="text-gray-500 line-through">&#x20B9;<%= String.format("%.2f", originalPrice) %></span>
                                        </p>
                                        <%
                                            if (bestDiscount != null) {
                                        %>
                                        <p class="text-sm text-gray-600 mb-1">
                                            <span class="text-red-600">-&#x20B9;<%= String.format("%.2f", discountValue) %></span>
                                        </p>
                                        <%
                                            }
                                        %>
                                        <p class="text-xl font-bold text-green-600">
                                            &#x20B9;<%= String.format("%.2f", discountedPrice) %>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <% } %>
                    <% } %>
                </ul>
            </div>

            <!-- Order Summary -->
            <h3 class="text-xl font-semibold mt-8 mb-6 text-gray-900">Order Summary</h3>
            <div class="bg-gray-50 p-6 rounded-lg shadow-inner">
                <div class="flex justify-between text-lg font-semibold text-gray-900 mb-4">
                    <span>Subtotal</span>
                    <span>&#x20B9;<%= String.format("%.2f", cartService.calculateCartTotalWithBestDiscount(cart)) %></span>
                </div>
                <div class="flex justify-between text-lg font-semibold text-gray-900 mb-4">
                    <span>Shipping</span>
                    <%
                        boolean isFreeShippingApplicable = cartService.calculateCartTotalWithBestDiscount(cart) >= Constants.DEFAULT_MIN_CART_VALUE;
                    %>
                    <span><%= isFreeShippingApplicable ? "Free" : "&#x20B9; " + Constants.DEFAULT_SHIPPING_CHARGE %></span>
                </div>
                <div class="flex justify-between text-lg font-semibold text-gray-900">
                    <span>Total</span>
                    <%
                        double total = cartService.calculateCartTotalWithBestDiscount(cart) + (isFreeShippingApplicable ? 0 : Constants.DEFAULT_SHIPPING_CHARGE);
                    %>
                    <span>&#x20B9;<%= String.format("%.2f", total) %></span>
                </div>
            </div>
        </div>

<%--        Shipping Address Form ---%>
        <div class="bg-white p-8 rounded-xl shadow-md border border-gray-200">
            <h3 class="text-3xl font-semibold mb-8 text-gray-900">Shipping Address</h3>
            <form action="/user/order/process" method="post" class="space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <label for="street" class="block text-sm font-medium text-gray-700 mb-1">Street Address</label>
                        <input type="text" id="street" name="street" required
                               class="block w-full border-gray-300 rounded-md shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm py-2 px-3"/>
                    </div>
                    <div>
                        <label for="city" class="block text-sm font-medium text-gray-700 mb-1">City</label>
                        <input type="text" id="city" name="city" required
                               class="block w-full border-gray-300 rounded-md shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm py-2 px-3"/>
                    </div>
                    <div>
                        <label for="state" class="block text-sm font-medium text-gray-700 mb-1">State</label>
                        <input type="text" id="state" name="state" required
                               class="block w-full border-gray-300 rounded-md shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm py-2 px-3"/>
                    </div>
                    <div>
                        <label for="country" class="block text-sm font-medium text-gray-700 mb-1">Country</label>
                        <input type="text" id="country" name="country" required
                               class="block w-full border-gray-300 rounded-md shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm py-2 px-3"/>
                    </div>
                    <div>
                        <label for="zip" class="block text-sm font-medium text-gray-700 mb-1">Zip Code</label>
                        <input type="text" id="zip" name="zip" required
                               class="block w-full border-gray-300 rounded-md shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm py-2 px-3"/>
                    </div>
                </div>
                <button type="submit"
                        class="w-full py-3 px-4 bg-gray-700 text-white font-semibold rounded-md shadow-md hover:bg-gray-500 transition duration-300">
                    Proceed To pay
                </button>
            </form>
        </div>
    </div>
</section>
<script>
    $(document).ready(function () {
        $('#rzp-button').click(function (e) {
            e.preventDefault();

            var options = {
                "key": "YOUR_RAZORPAY_KEY", // Your Razorpay key
                "amount": <%= Math.round(total * 100) %>, // Amount in paise
                "currency": "INR",
                "name": "FashionKart",
                "description": "Test Transaction",
                "handler": function (response) {
                    window.location.href = "/processCheckout?paymentId=" + response.razorpay_payment_id;
                },
                "prefill": {
                    "name": "<%= loggedInUser.getFirstName() + loggedInUser.getLastName() %>",
                    "email": "<%= loggedInUser.getEmail() %>",
                    "phone": "<%= loggedInUser.getPhoneNumber() %>",
                }
            };

            var rzp = new Razorpay(options);
            rzp.open();
        });
    });
</script>

</body>
</html>
