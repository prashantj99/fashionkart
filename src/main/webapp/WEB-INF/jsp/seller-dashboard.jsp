<%@ page import="com.fashionkart.utils.Constants" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Dashboard - FashionKart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        /* Active tab styling */
        .active-tab {
            background-color: #1d4ed8; /* Tailwind's blue-700 */
            color: white;
        }

        /* Custom styles for rounded buttons and transition effects */
        .btn-primary {
            background-color: #1d4ed8; /* Tailwind's blue-700 */
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 9999px; /* Fully rounded */
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #2563eb; /* Tailwind's blue-600 */
        }

        .hover-tab:hover {
            background-color: #e5e7eb; /* Tailwind's gray-200 */
            color: #1d4ed8; /* Tailwind's blue-700 */
        }
    </style>
</head>
<body class="bg-gray-50">

<!-- Header -->
<header class="sticky top-0 bg-white shadow-md z-50">
    <div class="flex justify-between items-center p-4 md:px-10">
        <div class="flex items-center space-x-4">
            <img src="/images/logo.png" alt="FashionKart Logo" class="h-8 w-auto">
            <h3 class="text-xl font-bold text-gray-800">FashionKart</h3>
        </div>
        <div class="flex items-center space-x-4">
            <img src="/images/user.png" alt="User Profile" class="h-8 w-8 rounded-full">
            <form action="/controller/logout" method="post">
                <button type="submit" class="btn-primary">Logout</button>
            </form>
        </div>

    </div>
</header>

<!-- Main Layout -->
<div class="flex w-full h-screen">
    <!-- Sidebar -->
    <aside class="w-64 h-full bg-white border-r border-gray-200 fixed top-0 left-0 pt-20 shadow-lg">
        <div class="p-4">
            <ul class="space-y-2">
                <li><a href="<%= Constants.ACTION_ADD_PRODUCT %>"
                       class="block p-3 rounded-md transition duration-300 hover-tab <% if (Constants.ACTION_ADD_PRODUCT.equals(request.getParameter("action"))) { %>active-tab<% } %>">Add Product</a></li>
                <li><a href="<%= Constants.ACTION_ADD_CATEGORY %>"
                       class="block p-3 rounded-md transition duration-300 hover-tab <% if (Constants.ACTION_ADD_CATEGORY.equals(request.getParameter("action"))) { %>active-tab<% } %>">Add Category</a></li>
                <li><a href="<%= Constants.ACTION_MANAGE_PRODUCTS %>"
                       class="block p-3 rounded-md transition duration-300 hover-tab <% if (Constants.ACTION_MANAGE_PRODUCTS.equals(request.getParameter("action"))) { %>active-tab<% } %>">Manage Products</a></li>
                <li><a href="<%= Constants.ACTION_SALES_ANALYTICS %>"
                       class="block p-3 rounded-md transition duration-300 hover-tab <% if (Constants.ACTION_SALES_ANALYTICS.equals(request.getParameter("action"))) { %>active-tab<% } %>">Sales Analytics</a></li>
                <li><a href="<%= Constants.ACTION_ADD_DISCOUNT %>"
                       class="block p-3 rounded-md transition duration-300 hover-tab <% if (Constants.ACTION_ADD_DISCOUNT.equals(request.getParameter("action"))) { %>active-tab<% } %>">Add Discount</a></li>
                <li><a href="<%= Constants.ACTION_MANAGE_DISCOUNTS %>"
                       class="block p-3 rounded-md transition duration-300 hover-tab <% if (Constants.ACTION_MANAGE_DISCOUNTS.equals(request.getParameter("action"))) { %>active-tab<% } %>">Manage Discounts</a></li>
            </ul>
        </div>
    </aside>

    <!-- Main Content Area -->
    <div class="flex-grow ml-64 p-10">
        <!-- Dynamically include JSP based on action -->
        <%
            String action = request.getParameter("action");
            String includePage = "/sellers/add/product";

            if ("addProduct".equals(action)) {
                includePage = Constants.URL_ADD_PRODUCT;
            } else if ("addCategory".equals(action)) {
                includePage = Constants.URL_ADD_CATEGORY;
            } else if ("manageProducts".equals(action)) {
                includePage = Constants.URL_MANAGE_PRODUCTS;
            } else if ("salesAnalytics".equals(action)) {
                includePage = Constants.URL_SALES_ANALYTICS;
            } else if ("addDiscount".equals(action)) {
                includePage = Constants.URL_ADD_DISCOUNT;
            } else if ("manageDiscounts".equals(action)) {
                includePage = Constants.URL_MANAGE_DISCOUNTS;
            }
        %>

        <jsp:include page="<%= includePage %>" />
    </div>
</div>

</body>
</html>
